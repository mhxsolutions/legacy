using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using BopsDataAccess;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    internal class RfsInvoiceTransferrer : IRfsInvoiceTransferrer
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof (RfsInvoiceExporter));

        private readonly IRfsDataContext _rfsDataContext;
        private Dictionary<string, BopsRfsLocation> _rfsLocations;
        private Dictionary<int, BopsRfsServicesOffered> _servicesOfferedMap;
        private Dictionary<int, BopsMas90ClientCode> _mas90ClientCodes;

        public RfsInvoiceTransferrer(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;
            CacheData();
        }

        private void CacheData()
        {
            // TODO: Update this to use user company detail if appropriate.

            _rfsLocations = _rfsDataContext.GetLocations(0).ToDictionary(l => l.LocationCode, l => l);
            _rfsDataContext.GetInvoiceTypeData().ToDictionary(i => i.InvoiceType.ToLower(), i => i);
            _servicesOfferedMap = _rfsDataContext.GetServicesOffered(0).ToDictionary(s => s.Id, s => s);
            _mas90ClientCodes = _rfsDataContext.GetMas90ClientCodes().ToDictionary(c => c.ClientRef, c => c);
        }

        public string ValidateTransferInvoices(int[] invoiceIds)
        {
            // Fail if we cannot get the current user ID.

            var currentIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (currentIdentity == null || string.IsNullOrEmpty(currentIdentity.Name))
                return "Cannot obtain current user ID.";

            // Fail if the caller didn't provide any invoice IDs.

            if (invoiceIds == null || invoiceIds.Length < 1)
                throw new ArgumentException("Must provide at least one invoice ID", "invoiceIds");

            // Fail if any of the desired invoice records cannot be found.

            var invoices = _rfsDataContext.GetInvoicesByIds(invoiceIds);
            if (invoices.Count != invoiceIds.Length)
            {
                return string.Format("Of the {0} invoice IDs selected for transferring, only {1} could be found.",
                    invoiceIds.Length, invoices.Count);
            }

            // Process each of the invoices, checking it for failure conditions.

            var returnValue = new StringBuilder();
            var invoiceDetailsMap = GetInvoiceDetailsMap(invoiceIds);

            foreach (var invoice in invoices)
            {
                // Add failure for the invoice not being finalized.

                if (invoice.InvoiceStatus != RfsInvoiceStatus.Closed)
                {
                    returnValue.AppendFormat("Invoice {0} status is not closed.", invoice.InvoiceId);
                    returnValue.AppendLine();
                }

                // Add failure if the invoice has no detail lines.

                if (!invoiceDetailsMap.ContainsKey(invoice.InvoiceId))
                {
                    returnValue.AppendFormat("Invoice {0} has no detail lines.", invoice.InvoiceId);
                    returnValue.AppendLine();
                }

                if (!_mas90ClientCodes.ContainsKey(invoice.BillToRef))
                {
                    returnValue.AppendFormat("Invoice {0} bill-to client does not have a corresponding MAS90 client code.", invoice.InvoiceId);
                    returnValue.AppendLine();
                }

                var detailLines = invoiceDetailsMap[invoice.InvoiceId];
                foreach (var line in detailLines)
                {
                    if (!_servicesOfferedMap.ContainsKey(line.ServiceOfferedRef))
                    {
                        returnValue.AppendFormat(
                            "Invoice {0}, line {1} references a service ({2}) that is no longer offered.",
                            invoice.InvoiceId, line.LineNumberDisplayed, line.ServiceOfferedRef);
                        returnValue.AppendLine();
                    }
                }

                foreach (var line in detailLines)
                {
                    //if (Line.IsServiceBill)
                    //{
                    //    if (!_ServiceResultsMap.ContainsKey(Line.ServiceCalculationResultRef.Value))
                    //    {
                    //        ReturnValue.AppendFormat(
                    //            "Invoice {0}, line {1} references a calculation result ({2}) that no longer exists.",
                    //            Invoice.InvoiceId, Line.LineNumberDisplayed, Line.ServiceCalculationResultRef.Value);
                    //        ReturnValue.AppendLine();
                    //    }
                    //}
                }
            }

            return returnValue.Length > 0 ? returnValue.ToString() : null;
        }

        private Dictionary<int, List<BopsRfsInvoiceDetail>> GetInvoiceDetailsMap(int[] invoiceIds)
        {
            var details = _rfsDataContext.GetInvoiceDetailsByInvoiceIds(invoiceIds);
            var returnValue = new Dictionary<int, List<BopsRfsInvoiceDetail>>();

            foreach (var detail in details)
            {
                List<BopsRfsInvoiceDetail> targetList;

                if (returnValue.ContainsKey(detail.InvoiceRef))
                {
                    targetList = returnValue[detail.InvoiceRef];
                }
                else
                {
                    targetList = new List<BopsRfsInvoiceDetail>();
                    returnValue.Add(detail.InvoiceRef, targetList);
                }

                targetList.Add(detail);
            }

            return returnValue;
        }

        public bool TransferInvoices(int[] invoiceIds)
        {
            var errors = ValidateTransferInvoices(invoiceIds);
            if (errors != null)
                return false;

            var createDate = DateTime.Now;
            var invoices = _rfsDataContext.GetInvoicesByIds(invoiceIds);
            var invoiceDetailsMap = GetInvoiceDetailsMap(invoiceIds);

            // Initialize the Solomon invoice transfer by retrieving the relevant interface through the kernel.

            var solomonInvoiceTransfer = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<ISolomonInvoiceTransfer>();

            var connectionString = ConfigurationManager.ConnectionStrings["SolomonConnectionString"].ConnectionString;
            solomonInvoiceTransfer.Open(_rfsDataContext, connectionString);

            try
            {
                foreach (var invoice in invoices)
                {
                    var details = invoiceDetailsMap[invoice.InvoiceId];
                    var locationCode = details.First().LocationCode;

                    var batch = _rfsDataContext.GetInvoiceTransferBatchNotPostedByLocation(locationCode);
                    if (batch == null)
                    {
                        batch = new BopsRfsInvoiceXferBatch {CreatedDate = createDate, LocationCode = locationCode};
                        _rfsDataContext.AddInvoiceTransferBatch(batch);
                    }

                    invoice.BatchId = batch.BatchId;
                    invoice.TransferredDate = createDate;
                    invoice.InvoiceStatus = RfsInvoiceStatus.Exported;

                    // Only post to Solomon if Invoice Amount is not equal to 0
                    if (!invoice.InvoiceTotal.Equals(0))
                    {
                        var location = _rfsLocations[locationCode];
                        var mas90ClientCode = _mas90ClientCodes[invoice.BillToRef].Mas90Code;
                        solomonInvoiceTransfer.SwitchToDatabase(location.DatabaseName);
                        solomonInvoiceTransfer.TransferArDoc(invoice, location, mas90ClientCode, details);
                    }

                    // TODO: make sure this gets saved
                    //_DwsNoRepSession.Save(invoice);
                    _rfsDataContext.SaveChanges();
                }

                solomonInvoiceTransfer.Close(true);
                return true;
            }
            catch (Exception E)
            {
                Log.Error("An exception occurred exporting invoices. Details follow.", E);
                solomonInvoiceTransfer.Close(false);
            }

            return false;
        }

        public bool PostTransferBatch(int[] batchIds)
        {
            // Initialize the Solomon invoice transfer by retrieving the relevant interface through the kernel.

            var solomonInvoiceTransfer = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<ISolomonInvoiceTransfer>();
            return solomonInvoiceTransfer.PostTransferBatch(batchIds);
        }

        public string ValidatePostBatches(int[] batchIds)
        {
            // Initialize the Solomon invoice transfer by retrieving the relevant interface through the kernel.

            var solomonInvoiceTransfer = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<ISolomonInvoiceTransfer>();
            return solomonInvoiceTransfer.ValidateInvoiceTransferBatches(batchIds);
        }
    }
}
