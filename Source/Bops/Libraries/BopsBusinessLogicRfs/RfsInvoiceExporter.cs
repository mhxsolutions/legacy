using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security;
using System.Text;
using BopsDataAccess;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    internal class RfsInvoiceExporter : IRfsInvoiceExporter
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(RfsInvoiceExporter));

        private const string GlCodeFsc = "5015-010-00";   // TODO: move this to somewhere more mutable
        private const double TolerableError = 0.01;

        private readonly IRfsDataContext _rfsDataContext;

        private Dictionary<int, BopsMas90ClientCode> _mas90ClientCodes;
        private Dictionary<int, BopsRfsServicesRequested> _servicesRequestedMap;
        private Dictionary<int, BopsRfsServicesOffered> _servicesOfferedMap;
        private Dictionary<int, BopsRfs> _rfsMap;
        private Dictionary<string, BopsRfsLocation> _rfsLocations;
        private Dictionary<string, BopsRfsInvoiceTypeData> _invoiceTypeDataMap;

        public RfsInvoiceExporter(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;

            CacheData();
        }

        private void CacheData()
        {
            // TODO: Update this to use user company detail if appropriate.

            _servicesOfferedMap = _rfsDataContext.GetServicesOffered(0)
                .ToDictionary(s => s.Id, s => s);
            _servicesRequestedMap = _rfsDataContext.GetServicesRequested(0, 0, 0)
                .ToDictionary(s => s.ServiceRequestedId, s => s);
            _mas90ClientCodes = _rfsDataContext.GetMas90ClientCodes()
                .ToDictionary(c => c.ClientRef, c => c);
            _rfsMap = _rfsDataContext.GetRfs(0, 0, 0)
                .ToDictionary(r => r.RfsId, r => r);
            _rfsLocations = _rfsDataContext.GetLocations(0)
                .ToDictionary(l => l.LocationCode, l => l);
            _invoiceTypeDataMap = _rfsDataContext.GetInvoiceTypeData()
                .ToDictionary(i => i.InvoiceType.ToLower(), i => i);
        }

        private void UpdateResultAndBillStatus(BopsRfsServiceCalculationResult serviceResult, RfsBillingStatus newStatus)
        {
            if (serviceResult.IsReceiver)
            {
                var receiverRecord = _rfsDataContext.GetReceiverById(serviceResult.DocumentId.Value);
                receiverRecord.BillingStatus = newStatus;
            }
            else if (serviceResult.IsBillOfLading)
            {
                var shipperRecord = _rfsDataContext.GetShipperById(serviceResult.DocumentId.Value);
                shipperRecord.BillingStatus = newStatus;
            }
            else
            {
                var load = _rfsDataContext.GetLoadByReference(serviceResult.LoadRef);
                load.BillingStatus = newStatus;
            }

            // Just as we get a fresh copy of the original receiver, BOL, or load, we need to get
            // a fresh copy of the service calculation result as well to force it to be attached
            // to the data context. It's more work, but it's necessary for the data-layer approach.

            var freshServiceResult = _rfsDataContext.GetServiceCalculationResultById(serviceResult.ResultId);
            freshServiceResult.BillingStatus = serviceResult.BillingStatus = newStatus;
        }

        private void UpdateResultAndBillStatus(BopsRfsStorageBillingDetail storageDetail, RfsBillingStatus newStatus)
        {
            storageDetail.BillingStatus = newStatus;
        }

        public string ValidateExportInvoices(int[] invoiceIds)
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
                return string.Format("Of the {0} invoice IDs selected for export, only {1} could be found.",
                                     invoiceIds.Length, invoices.Count);
            }

            // Process each of the invoices, checking it for failure conditions.

            var returnValue = new StringBuilder();
            var invoiceDetailsMap = GetInvoiceDetailsMap(invoiceIds);

            foreach (var invoice in invoices)
            {
                // Add failure for the invoice bill-to not having a valid client code.

                if (!_mas90ClientCodes.ContainsKey(invoice.BillToRef))
                {
                    returnValue.AppendFormat("Invoice {0} bill-to client does not have a corresponding MAS90 client code.", invoice.InvoiceId);
                    returnValue.AppendLine();
                }

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

                // Add failure if the sum of the invoice lines differs from the invoice total by more than
                // the tolerable error value.

                var lineTotal = 0.0;
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

                    lineTotal += line.ItemTotal;
                }

                if (Math.Abs(lineTotal - invoice.InvoiceTotal) > TolerableError)
                {
                    returnValue.AppendFormat("Invoice {0} total ({1}) differs from calculated line total ({2})",
                                             invoice.InvoiceId, invoice.InvoiceTotal, lineTotal);
                    returnValue.AppendLine();
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

        public InvoiceExportResults ExportInvoices(int[] invoiceIds)
        {
            var errors = ValidateExportInvoices(invoiceIds);
            if (errors != null)
                return null;

            var totalExportRevenue = 0.0;
            var totalInvoiceRevenue = 0.0;
            var exportDate = DateTime.Now;

            var invoices = _rfsDataContext.GetInvoicesByIds(invoiceIds);
            var invoiceDetailsMap = GetInvoiceDetailsMap(invoiceIds);
            var serviceResultsMap = GetServiceResultsMap(invoiceDetailsMap);
            var storageDetailMap = GetStorageDetailMap(invoiceDetailsMap);
            var exportDetails = new List<BopsRfsInvoiceExportDetail>();

            try
            {
                // For each invoice, determine the general ledger account totals, queue the export record,
                // and mark the invoice as exported.

                foreach (var invoice in invoices)
                {
                    totalInvoiceRevenue += invoice.InvoiceTotal;
                    var mas90ClientCode = _mas90ClientCodes[invoice.BillToRef].Mas90Code;
                    var accountTotals = new Dictionary<string, double>();

                    var details = invoiceDetailsMap[invoice.InvoiceId];

                    foreach (var detail in details)
                    {
                        var glCodes = GetGeneralLedgerCodes(detail, serviceResultsMap);
                        foreach (var pair in glCodes)
                        {
                            if (accountTotals.ContainsKey(pair.Key))
                                accountTotals[pair.Key] += pair.Value;
                            else
                                accountTotals.Add(pair.Key, pair.Value);
                        }

                        if (detail.IsServiceBill)
                        {
                            var result = serviceResultsMap[detail.ServiceCalculationResultRef.Value];
                            UpdateResultAndBillStatus(result, RfsBillingStatus.Exported);
                        }
                        else if (detail.IsStorageBill)
                        {
                            var storageDetail = storageDetailMap[detail.StorageBillingDetailRef.Value];
                            UpdateResultAndBillStatus(storageDetail, RfsBillingStatus.Exported);
                        }
                    }

                    foreach (var pair in accountTotals)
                    {
                        var newDetail = new BopsRfsInvoiceExportDetail
                        {
                            InvoiceRef = invoice.InvoiceId,
                            ClientAbbreviation = mas90ClientCode,
                            DetailAmount = pair.Value,
                            InvoiceDate = invoice.InvoiceDate,
                            DueDate = invoice.InvoiceDate.AddDays(30), // TODO: change this is we ever assign per-client due dates or something
                            GeneralLedgerCode = pair.Key
                        };
                        exportDetails.Add(newDetail);

                        totalExportRevenue += newDetail.DetailAmount;
                    }

                    invoice.InvoiceStatus = RfsInvoiceStatus.Exported;
                }

                // A double-check that the values attributed to the various GL accounts match the total revenue from all invoices.

                if (Math.Abs(totalExportRevenue - totalInvoiceRevenue) > TolerableError)
                    throw new ArithmeticException(string.Format("Invoice revenue total ({0}) does not match revenue to be exported ({1}).", 
                        totalInvoiceRevenue, totalExportRevenue));

                // Create the invoice export "header" record, so we have its ID to use for the detail records.

                var newExport = new BopsRfsInvoiceExport {ExportDate = exportDate};

                var currentIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();
                if (currentIdentity != null)
                    newExport.UserId = currentIdentity.Name;
                else 
                    throw new SecurityException("Could not obtain Windows identity.");

                newExport.InvoiceCount = invoices.Count;
                newExport.TotalRevenue = totalExportRevenue;
                _rfsDataContext.AddInvoiceExport(newExport);

                var returnValue = new InvoiceExportResults(newExport.ExportId, invoices.Count, newExport.TotalRevenue);

                foreach (var detail in exportDetails)
                {
                    returnValue.AddTransaction(detail.GeneralLedgerCode, detail.DetailAmount);
                    detail.ExportRef = newExport.ExportId;
                    _rfsDataContext.AddInvoiceExportDetail(detail);
                }

                _rfsDataContext.SaveChanges();
                return returnValue;
            }
            catch (Exception e)
            {
                Log.Error("An exception occurred exporting invoices. Details follow.", e);
            }

            return null;
        }

        private Dictionary<int, BopsRfsStorageBillingDetail> GetStorageDetailMap(Dictionary<int, List<BopsRfsInvoiceDetail>> invoiceDetailsMap)
        {
            var returnValue = new Dictionary<int, BopsRfsStorageBillingDetail>();

            foreach (var invoice in invoiceDetailsMap)
            {
                foreach (var detail in invoice.Value)
                {
                    if (detail.IsStorageBill && !returnValue.ContainsKey(detail.StorageBillingDetailRef.Value))
                        returnValue.Add(detail.StorageBillingDetailRef.Value, null);
                }
            }

            if (returnValue.Count > 0)
            {
                var index = 0;
                var resultIds = new int[returnValue.Count];
                foreach (var pair in returnValue)
                {
                    resultIds[index++] = pair.Key;
                }

                var storageBillingDetails = _rfsDataContext.GetStorageBillingDetailsByIds(resultIds);

                // If this assertion trips, it means we have a reference to a service calculation
                // result that doesn't exist.

                Debug.Assert(returnValue.Count == storageBillingDetails.Count);

                foreach (var detail in storageBillingDetails)
                {
                    returnValue[detail.DetailId] = detail;
                }
            }

            return returnValue;
        }

        private Dictionary<int, BopsRfsServiceCalculationResult> GetServiceResultsMap(Dictionary<int, List<BopsRfsInvoiceDetail>> invoiceDetailsMap)
        {
            var returnValue = new Dictionary<int, BopsRfsServiceCalculationResult>();

            foreach (var invoice in invoiceDetailsMap)
            {
                foreach (var detail in invoice.Value)
                {
                    if (detail.IsServiceBill && !returnValue.ContainsKey(detail.ServiceCalculationResultRef.Value))
                        returnValue.Add(detail.ServiceCalculationResultRef.Value, null);
                }
            }

            if (returnValue.Count > 0)
            {
                var index = 0;
                var resultIds = new int[returnValue.Count];
                foreach (var pair in returnValue)
                {
                    resultIds[index++] = pair.Key;
                }

                var serviceResults = _rfsDataContext.GetServiceCalculationResultsByIds(resultIds);

                // If this assertion trips, it means we have a reference to a service calculation 
                // result that doesn't exist.

                Debug.Assert(returnValue.Count == serviceResults.Count);

                foreach (var result in serviceResults)
                {
                    returnValue[result.ResultId] = result;
                }
            }

            return returnValue;
        }

        private Dictionary<string, double> GetGeneralLedgerCodes(BopsRfsInvoiceDetail detail, IDictionary<int, BopsRfsServiceCalculationResult> serviceResultsMap)
        {
            var returnValue = new Dictionary<string, double>();
            var serviceOffered = _servicesOfferedMap[detail.ServiceOfferedRef];

            // For transportation services, we break out the FSC as a separate GL code. 

            if (detail.IsServiceBill && (serviceOffered.CategoryRef == RfsServiceCategories.Transportation))
            {
                var result = serviceResultsMap[detail.ServiceCalculationResultRef.Value];

                if (result != null && result.PublicRate.FscRevenue != 0)
                {
                    returnValue.Add(GlCodeFsc, result.PublicRate.FscRevenue);
                    returnValue.Add(serviceOffered.GeneralLedgerCode, result.PublicRate.RfsRevenue);
                    goto Function_Exit_Point;
                }
            }

            returnValue.Add(serviceOffered.GeneralLedgerCode, detail.ItemTotal);

        Function_Exit_Point:

            return returnValue;
        }

        public string CreateMas90CsvImportText(int exportId)
        {
            var returnValue = new StringBuilder();

            var details = _rfsDataContext.GetInvoiceExportDetailsByExportId(exportId);

            returnValue.AppendLine("Division,Client,Invoice Number,Amount,Invoice Date,Due Date,GL Code,Invoice");
            foreach (var detail in details)
            {
                var exportGlCode = detail.GeneralLedgerCode.Replace("-", "");
                var currentLine = string.Format("1,{0},{1},{2:f},{3:MM/dd/yy},{4:MM/dd/yy},{5},IN", 
                    detail.ClientAbbreviation, detail.InvoiceRef, detail.DetailAmount, detail.InvoiceDate, 
                    detail.DueDate, exportGlCode);
                returnValue.AppendLine(currentLine);
            }

            return returnValue.ToString();
        }

        public string CreateSolomonCsvImportText(int exportId)
        {
            // First, we need to fetch the data, which includes the export record and the export
            // details records, from which we may get the invoice IDs and fetch those.

            var export = _rfsDataContext.GetInvoiceExportById(exportId);
            if (export == null)
                return null;

            var details = _rfsDataContext.GetInvoiceExportDetailsByExportId(exportId);
            if (details == null || details.Count < 1)
                return null;

            var invoiceIds = GetInvoiceIdsFromExportDetails(details);
            if (invoiceIds == null || invoiceIds.Length < 1)
                return null;

            var invoices = _rfsDataContext.GetInvoicesByIds(invoiceIds);
            if (invoices == null || invoices.Count < 1)
                return null;

            var invoiceDetailsMap = GetInvoiceDetails(invoiceIds);
            if (invoiceDetailsMap == null || invoiceDetailsMap.Count < 1)
                return null;
           
            // Sanity checking: make sure we have invoice detail lines and MAS90 client codes for all invoices.

            foreach (var invoice in invoices)
            {
                if (!_mas90ClientCodes.ContainsKey(invoice.BillToRef))
                    return null;
                if (!invoiceDetailsMap.ContainsKey(invoice.InvoiceId))
                    return null;
            }

            var serviceCalculationResultsMap = GetServiceCalculationResults(invoiceDetailsMap);
            if (serviceCalculationResultsMap == null)
                return null;

            // Sanity checking: make sure we have services requested, services offered, and RFS records for all results.

            foreach (var pair in serviceCalculationResultsMap)
            {
                if (!_servicesRequestedMap.ContainsKey(pair.Value.ServiceId))
                    return null;
                if (!_servicesOfferedMap.ContainsKey(_servicesRequestedMap[pair.Value.ServiceId].ServiceOfferedRef))
                    return null;
                if (!_rfsMap.ContainsKey(_servicesRequestedMap[pair.Value.ServiceId].RfsRef))
                    return null;
            }

            /*
                The following description is taken from an email dated 10/27/2009 from JimB to Dan on the subject:

                The import file consists of three line types of data: batch header, document header, transaction detail.  

                1) The first line of the file is the batch header and there’s only one per import file.  It has 5 components: 

                Batch,cbatnbr,cperpost,cbathandling,cctrltot

                Batch = “Level0”
                cbatnbr = blank since it will auto number
                cperpost = YYYYMM for the month the batch revenue will post against, i.e. 200910 will post the batch to October 2009.
                cbathandling = “H” , hold for now until we have some time through testing – later we will change it to auto release
                cctrltot = the control dollar amount which equals the sum of all invoice amounts in the batch

                2) The second line of the batch will be an invoice header and will be used as the first line for each new invoice in the batch.  It has 9 components:

                Invoice,cdoctype,crefnbr,ccustid,cdocdate,corigdocamt,cdocdesc,caracct,carsub

                Invoice = “Level1”
                cdoctype = “IN”
                crefnbr = equals the invoice number.  Normally, this is auto-populated, but since we want to capture the upstream system’s invoice number here, what we’ve done at Plastic Express is to add a “t” (for trucking invoice) in front of the upstream system number in order to keep the option of using auto invoicing in the future.
                ccustid = Customer ID
                cdocdate = Invoice Date
                corigdocamt = total invoice amount (equal to the sum of the transaction lines), the sum of these numbers should total to the batch control number
                cdocdesc = invoice alpha numeric title, currently blank in the Budway example – populated for PE
                caracct = “12000”
                carsub = “100000”

                3) The third line type is the transaction detail and follow each invoice header with all the line item details.  There are 6 (or 5) components:

                Transaction,cacct,csub,cqty,ctranamt,ctrandesc

                Transaction = “Transaction”
                cacct = the 5 digit account number for the type of revenue described ( see the “acct sub mapping” tab). From the data I’ve seen, Budway uses only three or four of the revenue accounts listed, but we can capture as granularly as we want.  I think I put down all we need, but there are more if I’ve missed any that you can identify. 
                Csub = the 6 digit cost center to which revenue is credited ( see the “acct sub mapping” tab).  I believe we should use the more granular cost centers  and the the general business unit ones, i.e. 201200 and 201100 rather than 201000.
                Cqty = this variable is optional, quantity, and Budway imports to data have not included the field since pounds or units have not been passed to me so far.  For PE, the number of pounds is captured in the AR information.
                Ctranamt = the line item dollar amount.  This is the dollar amount credited to the revenue account and cost center associated with the transaction line, and the sum of these amounts need to total the amount in the invoice header.
                Ctrandesc = line item alpha numeric description.  To date has been blank, but as shown in the PE example can be used for any info capture that you want in AR.
            */

            /*
             * Addendum: Credit Memos, 12/11/09
             * 
             * Apparently, invoices with a negative total amount cannot be imported correctly. The solution, as conveyed to me by
             * Dan/JimB on 12/11, is for me to do two things differently for such invoices: (1) change "IN" to "CM" in the invoice
             * header, and (2) flip the sign of the invoice total and all transaction lines. According to JimB, an invoice with a 
             * negative total is a contradiction in terms; such cases are "credit memos" instead.
             * 
             * Erica subsequently asked (12/23/09) me to calculate the "total" in accordance with the credit memo changes. I'm not
             * going to change our export table because that would be misleading ($100 of revenue and a $100 refund would make for
             * a $200 total), so instead I have to run a quick calculation here to determine the total to use.
             */

            /*
             * Addendum: Carsub, 02/12/11
             * 
             * For whatever reason, the magic "carsub" number Jim B. defined above is no longer sufficient. Dan asked me to use the following values
             * based on the type of invoice involved.
             * 
             *  Budway  100000
             *  SCLS    500000
             *  TTL     523000
             *  NewX    525000
             * 
             * So I've added a new [DWS No Rep Data].dbo.[RFS Invoice Type Data] table and am changing the code below to use the value in the table
             * instead of the magic number specified above.
             */

            var exportTotal = 0.0;
            foreach (var invoice in invoices)
            {
                exportTotal += invoice.InvoiceTotal < 0 ? -invoice.InvoiceTotal : invoice.InvoiceTotal;
            }

            var returnValue = new StringBuilder();
            var batchHeader = string.Format("Level0,,{0},H,{1:f}", details[0].InvoiceDate.ToString("yyyyMM"), Math.Round(exportTotal, 2));
            returnValue.AppendLine(batchHeader);

            foreach (var invoice in invoices)
            {
                var creditMemo = (invoice.InvoiceTotal < 0);
                var carsub = _invoiceTypeDataMap[invoice.InvoiceType.ToLower()].Carsub;
                string invoiceHeader;

                if (creditMemo)
                {
                    invoiceHeader = string.Format("Level1,CM,{0},{1},{2},{3:f},,12000,{4}", invoice.InvoiceId,
                                                  _mas90ClientCodes[invoice.BillToRef].Mas90Code, invoice.InvoiceDate.ToShortDateString(),
                                                  Math.Round(-invoice.InvoiceTotal, 2), carsub);
                }
                else
                {
                     invoiceHeader = string.Format("Level1,IN,{0},{1},{2},{3:f},,12000,{4}", invoice.InvoiceId,
                                                   _mas90ClientCodes[invoice.BillToRef].Mas90Code, invoice.InvoiceDate.ToShortDateString(), 
                                                   Math.Round(invoice.InvoiceTotal, 2), carsub);
                }
                returnValue.AppendLine(invoiceHeader);

                var invoiceDetails = invoiceDetailsMap[invoice.InvoiceId];
                foreach (var detail in invoiceDetails)
                {
                    string transactionDetails, accountCode, subaccountCode, amount, fscLine = null;

                    if (detail.IsServiceBill)
                    {
                        var result = serviceCalculationResultsMap[detail.ServiceCalculationResultRef.Value];
                        var location = _rfsLocations[detail.LocationCode];
                        var serviceRequested = _servicesRequestedMap[result.ServiceId];
                        var serviceOffered = _servicesOfferedMap[serviceRequested.ServiceOfferedRef];

                        transactionDetails = string.Format("Line {0}/{1}: {2}", detail.LineNumber, detail.LineNumberDisplayed, serviceOffered.Name);
                        accountCode = serviceOffered.SolomonAccountNumber;
                        subaccountCode = location.LocationCode + serviceOffered.SolomonCostCenterType;

                        if (result.PublicRate.FscRevenue != 0.0)
                        {
                            amount = string.Format("{0:f}", Math.Round(creditMemo ? -result.PublicRate.RfsRevenue : result.PublicRate.RfsRevenue, 2));
                            fscLine = string.Format("Transaction,{0},{1},{2:f},Line {3}/{4} FSC", location.FscAccount, location.FscSubAccount, 
                                creditMemo ? -result.PublicRate.FscRevenue : result.PublicRate.FscRevenue, detail.LineNumber, detail.LineNumberDisplayed);
                        }
                        else
                        {
                            amount = string.Format("{0:f}", Math.Round(creditMemo ? -detail.ItemTotal : detail.ItemTotal, 2));
                        }
                    }
                    else if (detail.IsStorageBill)
                    {
                        var serviceOffered = _servicesOfferedMap[detail.ServiceOfferedRef];

                        transactionDetails = string.Format("Line {0}/{1} Storage Bill {2}", detail.LineNumber, detail.LineNumberDisplayed, detail.StorageBillingDetailRef);
                        accountCode = serviceOffered.SolomonAccountNumber;
                        subaccountCode = detail.LocationCode + serviceOffered.SolomonCostCenterType;
                        amount = string.Format("{0:f}", Math.Round(creditMemo ? -detail.ItemTotal : detail.ItemTotal, 2));
                    }
                    else
                    {
                        var serviceOffered = _servicesOfferedMap[detail.ServiceOfferedRef];

                        transactionDetails = string.Format("Line {0}/{1} Manual Bill for {2}", detail.LineNumber, detail.LineNumberDisplayed, serviceOffered.Name);
                        accountCode = serviceOffered.SolomonAccountNumber;
                        subaccountCode = detail.LocationCode + serviceOffered.SolomonCostCenterType;
                        amount = string.Format("{0:f}", Math.Round(creditMemo ? -detail.ItemTotal : detail.ItemTotal, 2));
                    }

                    var detailLine = string.Format("Transaction,{0},{1},{2},{3}", accountCode, subaccountCode, amount, transactionDetails);
                    returnValue.AppendLine(detailLine);

                    if (fscLine != null)
                        returnValue.AppendLine(fscLine);
                }
            }

            return returnValue.ToString();
        }

        private IDictionary<int, BopsRfsServiceCalculationResult> GetServiceCalculationResults(IEnumerable<KeyValuePair<int, IList<BopsRfsInvoiceDetail>>> invoiceDetailsMap)
        {
            // First, build a list of the unique service calculation result IDs, so we know which results to fetch.

            var resultIds = new List<int>();

            foreach (var pair in invoiceDetailsMap)
            {
                foreach (var detail in pair.Value)
                {
                    if (!detail.IsServiceBill) 
                        continue;
                    if (resultIds.Contains(detail.ServiceCalculationResultRef.Value))
                        continue;
                    resultIds.Add(detail.ServiceCalculationResultRef.Value);
                }
            }

            // Now fetch the results into a dictionary and return them.

            return _rfsDataContext.GetServiceCalculationResultsByIds(resultIds.ToArray())
                .ToDictionary(r => r.ResultId, r => r);
        }

        private IDictionary<int, IList<BopsRfsInvoiceDetail>> GetInvoiceDetails(int[] invoiceIds)
        {
            var invoiceDetails = _rfsDataContext.GetInvoiceDetailsByInvoiceIds(invoiceIds);
            if (invoiceDetails == null || invoiceDetails.Count < 1)
                return null;

            var returnValue = new Dictionary<int, IList<BopsRfsInvoiceDetail>>();
            foreach (var detail in invoiceDetails)
            {
                if (returnValue.ContainsKey(detail.InvoiceRef))
                {
                    returnValue[detail.InvoiceRef].Add(detail);
                }
                else
                {
                    var newList = new List<BopsRfsInvoiceDetail> {detail};
                    returnValue.Add(detail.InvoiceRef, newList);
                }
            }

            return returnValue;
        }

        private static int[] GetInvoiceIdsFromExportDetails(IEnumerable<BopsRfsInvoiceExportDetail> details)
        {
            var ids = new List<int>();
            foreach (var detail in details)
            {
                if (ids.Contains(detail.InvoiceRef))
                    continue;
                ids.Add(detail.InvoiceRef);
            }

            ids.Sort();
            return ids.ToArray();
        }
    }
}
