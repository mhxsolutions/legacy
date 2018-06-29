using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    public class RfsInvoiceLifecycleManager : IRfsInvoiceLifecycleManager
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(RfsInvoiceLifecycleManager));

        private readonly IRfsDataContext _rfsDataContext;

        public RfsInvoiceLifecycleManager(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;
        }

        private void UpdateResultAndBillStatus(BopsRfsServiceCalculationResult ServiceResult, RfsBillingStatus NewStatus)
        {
            if (ServiceResult.IsReceiver)
            {
                var receiverRecord = _rfsDataContext.GetReceiverById(ServiceResult.DocumentId.Value);
                receiverRecord.BillingStatus = NewStatus;
            }
            else if (ServiceResult.IsBillOfLading)
            {
                var shipperRecord = _rfsDataContext.GetShipperById(ServiceResult.DocumentId.Value);
                shipperRecord.BillingStatus = NewStatus;
            }
            else
            {
                var load = _rfsDataContext.GetLoadByReference(ServiceResult.LoadRef);
                load.BillingStatus = NewStatus;
            }

            // Just as we get a fresh copy of the original receiver, BOL, or load, we need to get
            // a fresh copy of the service calculation result as well to force it to be attached
            // to the data context. It's more work, but it's necessary for the data-layer approach.

            var freshServiceResult = _rfsDataContext.GetServiceCalculationResultById(ServiceResult.ResultId);
            freshServiceResult.BillingStatus = ServiceResult.BillingStatus = NewStatus;

            _rfsDataContext.SaveChanges();
        }

        private void UpdateResultAndBillStatus(BopsRfsStorageBillingDetail StorageDetail, RfsBillingStatus NewStatus)
        {
            StorageDetail.BillingStatus = NewStatus;
            _rfsDataContext.SaveChanges();
        }

        public BopsRfsInvoicePackage CreateInvoiceFromStorageBillingDetails(IEnumerable<BopsRfsStorageBillingDetail> details, int serviceOfferedRef, 
            DateTime invoiceDate, string locationCode, string invoiceType)
        {
            if (string.IsNullOrEmpty(invoiceType))
                throw new ArgumentNullException("invoiceType", "The invoice type must not be null");
            if (details == null || !details.Any())
                throw new ArgumentNullException("details", "The details list must not be null or empty");

            // Ensure that the details are all for the same bill-to client, are for only a single
            // company, calculate a total, gather the IDs for the storage billings that will be 
            // needed (for billed-through dates).

            var invoiceTotal = 0.0;
            var billToClient = 0;
            var storageBillingIds = new Dictionary<int, int>();
            var companyId = details.First().CompanyRef;
            foreach (var detail in details)
            {
                if (billToClient == 0)
                    billToClient = detail.BillToClientRef;
                else if (billToClient != detail.BillToClientRef)
                    throw new ArgumentException("All details must be for the same bill-to client", "details");
                else if (companyId != detail.CompanyRef)
                    throw new ArgumentException("Billing details are from multiple companies");

                if (!storageBillingIds.ContainsKey(detail.BillingRef))
                    storageBillingIds.Add(detail.BillingRef, 0);
                invoiceTotal += detail.Revenue;
            }

            // Now the real work begins, so fetch the time.

            var dateStamp = DateTime.Now;

            try
            {
                // Load up a map of the storage billings that "own" the details, thus making it easy to
                // get at the storage billing date billed through.

                var storageBillings = _rfsDataContext.GetStorageBillingsByIDs(storageBillingIds.Keys.ToArray());
                var storageBillingMap = storageBillings.ToDictionary(b => b.BillingId, b => b);

                // Create the new invoice and initialize the return value package from it.

                var newInvoice = new BopsRfsInvoice {InvoiceType = invoiceType};
                newInvoice.ShipperRef = newInvoice.BillToRef = billToClient;
                newInvoice.InvoiceStatus = RfsInvoiceStatus.Open;
                newInvoice.InvoiceTotal = invoiceTotal;
                newInvoice.InvoiceDate = invoiceDate;
                newInvoice.DateCreated = dateStamp;
                newInvoice.CompanyRef = companyId;

                var windowsUserId = Environment.UserName;
                newInvoice.UserCreated = windowsUserId;

                _rfsDataContext.AddInvoice(newInvoice);
                var returnValue = new BopsRfsInvoicePackage(newInvoice);

                // Create the detail lines for the new invoice, adding them to the return package as well.

                var lineNumber = 1;
                foreach (var detail in details)
                {
                    var newDetail = new BopsRfsInvoiceDetail {InvoiceRef = newInvoice.InvoiceId};
                    newDetail.LineNumber = newDetail.LineNumberDisplayed = lineNumber++;
                    newDetail.ItemDate = storageBillingMap[detail.BillingRef].DateBilledThrough;
                    newDetail.ItemDescription = detail.PublicDetails;
                    newDetail.ItemTotal = detail.Revenue;
                    newDetail.ServiceOfferedRef = serviceOfferedRef;
                    newDetail.LocationCode = locationCode;
                    newDetail.StorageBillingDetailRef = detail.DetailId;
                    _rfsDataContext.AddInvoiceDetail(newDetail);
                    var freshDetail = _rfsDataContext.GetStorageBillingDetailById(detail.DetailId);
                    freshDetail.BillingStatus = RfsBillingStatus.OnInvoice;
                    returnValue.AddDetail(newDetail);
                }

                _rfsDataContext.SaveChanges();
                return returnValue;
            }
            catch (Exception e)
            {
                _Log.Error("An exception occurred creating invoices from storage bills. Details follow.", e);
            }

            return null;
        }

        private Dictionary<int, BopsRfs> GetRfsMap()
        {
            // TODO: Update this to use user company detail if appropriate.

            var rfsList = _rfsDataContext.GetRfs(0, 0, 0);
            return rfsList.ToDictionary(r => r.RfsId, r => r);
        }

        public BopsRfsInvoicePackage CreateInvoice(string invoiceType, DateTime invoiceDate, string publicNotes, 
            string privateNotes, IList<BopsRfsBillDetail> details, RfsInvoiceDescriptionGenerator descriptionGenerator,
            int companyId)
        {
            if (string.IsNullOrEmpty(invoiceType) || details == null || details.Count < 1 || companyId == 0)
                return null;

            try
            {
                // Run through the detail items to calculate a total and compile a list of 
                // service IDs to check.

                var index = 0;
                var invoiceTotal = 0.0;
                var serviceIds = new int[details.Count];

                foreach (var bd in details)
                {
                    invoiceTotal += Math.Round(bd.ServiceResult.PublicRate.RfsRevenue, 2) + Math.Round(bd.ServiceResult.PublicRate.FscRevenue, 2);
                    serviceIds[index++] = bd.ServiceResult.ResultId;
                }

                // Check to ensure that none of the services being invoiced have already been invoiced.
                // If they are, show the user the errors and get out of here.

                var alreadyInvoiced = _rfsDataContext.GetInvoiceDetailsFromServiceCalculationResults(serviceIds);
                if (alreadyInvoiced.Count > 0)
                {
                    return new BopsRfsInvoicePackage(InvoiceErrorType.DetailsAlreadyInvoiced, 
                        new List<BopsRfsInvoiceDetail>(alreadyInvoiced));
                }

                // TODO: In the future this could be made more efficient by building a destinations map separately and using it
                //       here for the parent lookups and passing it to the RfsInvoiceDescriptionGenerator.

                var newInvoice = new BopsRfsInvoice {InvoiceType = invoiceType, CompanyRef = companyId};
                var billToParent = _rfsDataContext.GetParentDestination(details[0].BillToClient.DestinationId);
                newInvoice.BillToRef = billToParent.DestinationId;
                newInvoice.DateCreated = DateTime.Now;
                newInvoice.InvoiceDate = invoiceDate;
                newInvoice.InvoiceStatus = RfsInvoiceStatus.Open;
                var shipperParent = _rfsDataContext.GetParentDestination(details[0].ShipperClient.DestinationId);
                newInvoice.ShipperRef = shipperParent.DestinationId;
                newInvoice.InvoiceTotal = invoiceTotal;
                if (!string.IsNullOrEmpty(publicNotes))
                    newInvoice.PublicNotes = publicNotes;
                if (!string.IsNullOrEmpty(privateNotes))
                    newInvoice.PrivateNotes = privateNotes;

                var windowsUserId = Environment.UserName;
                newInvoice.UserCreated = windowsUserId;

                _rfsDataContext.AddInvoice(newInvoice);

                _Log.InfoFormat("Saved new invoice {0}, adding detail lines.", newInvoice.InvoiceId);

                var rfsMap = GetRfsMap();
                var returnValue = new BopsRfsInvoicePackage(newInvoice);

                var lineNumber = 0;
                foreach (var bd in details)
                {
                    var newDetail = new BopsRfsInvoiceDetail {InvoiceRef = newInvoice.InvoiceId};
                    newDetail.LineNumber = newDetail.LineNumberDisplayed = ++lineNumber;
                    newDetail.ItemDate = bd.ServiceResult.BillingDate.Value;
                    newDetail.ItemDescription = descriptionGenerator.GenerateDescription(bd);
                    newDetail.ItemTotal = Math.Round(bd.ServiceResult.PublicRate.RfsRevenue, 2) 
                        + Math.Round(bd.ServiceResult.PublicRate.FscRevenue, 2);
                    newDetail.ServiceCalculationResultRef = bd.ServiceResult.ResultId;
                    var serviceRequested = descriptionGenerator.LookupServiceRequested(bd.ServiceResult.ServiceId);
                    Debug.Assert(serviceRequested != null);
                    newDetail.ServiceOfferedRef = serviceRequested.ServiceOfferedRef;
                    Debug.Assert(rfsMap.ContainsKey(bd.RfsRef));
                    newDetail.LocationCode = rfsMap[bd.RfsRef].LocationCode;   // Will throw an exception if the RFS doesn't exist or has a bad code.

                    _rfsDataContext.AddInvoiceDetail(newDetail);
                    UpdateResultAndBillStatus(bd.ServiceResult, RfsBillingStatus.OnInvoice);

                    _Log.InfoFormat("Added line {0}: {1}", newDetail.LineNumber, bd.ServiceResult.ToString());
                    returnValue.AddDetail(newDetail);
                }

                _rfsDataContext.SaveChanges();

                return returnValue;
            }
            catch (Exception e)
            {
                _Log.Error("An exception occurred creating a new invoice. Details follow.", e);
            }

            return new BopsRfsInvoicePackage(InvoiceErrorType.UnknownException);
        }

        public List<BopsRfsInvoicePackage> CreateInvoiceFromStorageBilling(int billingId, int serviceOfferedRef, 
            DateTime invoiceDate, string locationCode, string invoiceType)
        {
            if (string.IsNullOrEmpty(invoiceType))
                throw new ArgumentNullException("invoiceType", "The invoice type must not be null");

            var returnValue = new List<BopsRfsInvoicePackage>();
            var dateStamp = DateTime.Now;

            try
            {
                // Get the storage billing and details (that aren't already on an invoice) and fail if there are none.

                var billing = _rfsDataContext.GetStorageBillingById(billingId);

                var details = _rfsDataContext.GetStorageBillingDetailsByBillingIdAndUpToBillingStatus(billingId,
                    RfsBillingStatus.OnInvoice);
                if (details.Count < 1)
                    throw new ArgumentException(string.Format("Billing ID {0} has no details", billingId));

                // The details must all be for the same company for this to work.

                var companyId = details[0].CompanyRef;
                if (details.Any(detail => companyId != detail.CompanyRef))
                {
                    throw new ArgumentException(string.Format("Billing ID {0} has detail from multiple companies", billingId));
                }

                // Group the details by bill-to client.

                var clientDetailsMap = new Dictionary<int, List<BopsRfsStorageBillingDetail>>();
                foreach (var detail in details)
                {
                    List<BopsRfsStorageBillingDetail> targetList;

                    if (clientDetailsMap.ContainsKey(detail.BillToClientRef))
                    {
                        targetList = clientDetailsMap[detail.BillToClientRef];
                    }
                        
                   else
                    {
                        targetList = new List<BopsRfsStorageBillingDetail>();
                        clientDetailsMap.Add(detail.BillToClientRef, targetList);
                    }

                    targetList.Add(detail);
                }

                // Generate the invoices.

                foreach (var pair in clientDetailsMap)
                {
                    if (pair.Value.Count < 1)
                        throw new ArgumentException(string.Format("Can't generate invoices for client {0} in storage billing {1} due to no items.", pair.Key, billingId));

                    var invoiceTotal = pair.Value.Sum(detail => detail.Revenue);

                    var newInvoice = new BopsRfsInvoice {InvoiceType = invoiceType};
                    newInvoice.ShipperRef = newInvoice.BillToRef = pair.Key;
                    newInvoice.InvoiceStatus = RfsInvoiceStatus.Open;
                    newInvoice.InvoiceTotal = invoiceTotal;
                    newInvoice.InvoiceDate = invoiceDate;
                    newInvoice.DateCreated = dateStamp;
                    newInvoice.CompanyRef = companyId;

                    var windowsUserId = Environment.UserName;
                    newInvoice.UserCreated = windowsUserId;

                    _rfsDataContext.AddInvoice(newInvoice);

                    var lineNumber = 1;
                    var newPackage = new BopsRfsInvoicePackage(newInvoice);

                    foreach (var detail in pair.Value)
                    {
                        var newDetail = new BopsRfsInvoiceDetail();
                        newDetail.InvoiceRef = newInvoice.InvoiceId;
                        newDetail.LineNumber = newDetail.LineNumberDisplayed = lineNumber++;
                        newDetail.ItemDate = billing.DateBilledThrough;
                        newDetail.ItemDescription = detail.PublicDetails;
                        newDetail.ItemTotal = detail.Revenue;
                        newDetail.ServiceOfferedRef = serviceOfferedRef;
                        newDetail.LocationCode = locationCode;
                        newDetail.StorageBillingDetailRef = detail.DetailId;

                        _rfsDataContext.AddInvoiceDetail(newDetail);
                        var freshDetail = _rfsDataContext.GetStorageBillingDetailById(detail.DetailId);
                        freshDetail.BillingStatus = RfsBillingStatus.OnInvoice;
                        newPackage.AddDetail(newDetail);
                    }

                    returnValue.Add(newPackage);
                }

                billing.DateInvoiced = dateStamp;

                var newEvent = new BopsRfsStorageBillingEvent(RfsStorageBillingEventType.StorageBillingInvoicesGenerated, billingId)
                {
                    Timestamp = dateStamp
                };

                _rfsDataContext.AddStorageBillingEvent(newEvent);
                _rfsDataContext.SaveChanges();

                return returnValue;
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("An exception occurred creating invoices from storage billing {0}. Details follow.", billingId);
                _Log.Error(e);
                return null;
            }
        }

        public string VoidInvoice(int invoiceId)
        {
            string returnValue = null;

            try
            {
                var invoice = _rfsDataContext.GetInvoiceById(invoiceId);

                if (invoice.InvoiceStatus >= RfsInvoiceStatus.Exported)
                {
                    returnValue = string.Format("Invoice {0} has already been exported and cannot be voided.", invoiceId);
                    _Log.Error(returnValue);
                }
                else
                {
                    _Log.InfoFormat("Voiding invoice {0}: Shipper({1}), BillTo({2}), Status({3}), Total({4}), Date({5}).", invoiceId,
                        invoice.ShipperRef, invoice.BillToRef, invoice.InvoiceStatus, invoice.InvoiceTotal, invoice.InvoiceDate);

                    // The process of voiding an invoice is:
                    //
                    //  1.  Clean up the invoice PDF (if any).
                    //  2.  Revert the various billing statuses:
                    //      a. Send any service bill back to the pending review stage.
                    //      b. Send any storage bill back to the approved stage.
                    //  3.  Delete all the invoice detail records.
                    //  4.  Delete the invoice itself.

                    if (invoice.DocumentFolder != null && invoice.DocumentFileName != null)
                    {
                        var doomedFile = Path.Combine(invoice.DocumentFolder, invoice.DocumentFileName);
                        _Log.InfoFormat("Deleting invoice document: '{0}'.", doomedFile);
                        File.Delete(doomedFile);
                    }

                    var details = _rfsDataContext.GetInvoiceDetailsByInvoiceId(invoiceId);
                    foreach (var detail in details)
                    {
                        if (detail.IsServiceBill)
                        {
                            var serviceResult = _rfsDataContext.GetServiceCalculationResultById(detail.ServiceCalculationResultRef.Value);
                            _Log.InfoFormat("Resetting {0} to pending review.", serviceResult);
                            UpdateResultAndBillStatus(serviceResult, RfsBillingStatus.PendingReview);
                        }
                        else if (detail.IsStorageBill)
                        {
                            var storageDetail =
                                _rfsDataContext.GetStorageBillingDetailById(detail.StorageBillingDetailRef.Value);
                            _Log.InfoFormat("Resetting {0} to approved.", storageDetail);
                            UpdateResultAndBillStatus(storageDetail, RfsBillingStatus.Approved);
                        }
                    }

                    _rfsDataContext.RemoveInvoiceAndDetails(invoiceId);
                    _rfsDataContext.SaveChanges();

                    _Log.InfoFormat("Invoice {0} voided successfully.", invoiceId);
                }
            }
            catch(Exception E)
            {
                returnValue = string.Format("An exception occurred while trying to void invoice {0}. Contact IT support.", invoiceId);
                _Log.Error("An exception occurred while attempting to void an invoice. Details follow.", E);
            }

            return returnValue;
        }
    }
}
