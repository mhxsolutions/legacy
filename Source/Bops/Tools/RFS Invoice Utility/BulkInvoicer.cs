using System;
using System.Collections.Generic;
using System.Diagnostics;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUtilities;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public class BulkInvoicer
    {
        private readonly IRfsDataContext _rfsDataContext;
        private readonly string _invoiceType;
        private readonly DateTime _invoiceDate;
        private readonly string _publicNotes;
        private readonly string _privateNotes;

        private IList<BopsRfsServiceCalculationResult> _bills;
        private BopsRfsBillDetailMap _billDetailsMap;
        private RfsInvoiceDescriptionGenerator _descriptionGenerator;
        private BopsRfsInvoicePackage[] _invoiceResults;

        public int RfsNumber { get; private set; }

        public bool IncludeBillsOfLading { get; private set; }

        public bool IncludeLoads { get; private set; }

        public bool IncludeReceivers { get; private set; }

        public int TotalBillsCount
        {
            get { return _bills.Count; }
            set { throw new NotImplementedException(); }
        }

        public int BillsProcessedCount { get; private set; }

        public int BillsFailedCount { get; private set; }

        public int BillsInvoicedCount
        {
            get { return BillsProcessedCount - BillsFailedCount; }
            set { throw new NotImplementedException(); }
        }

        public BulkInvoicer(int rfsNumber, bool includeBillsOfLading, bool includeLoads, bool includeReceivers,
            string invoiceType, DateTime invoiceDate, string publicNotes, string privateNotes, 
            IRfsDataContext rfsDataContext)
        {
            RfsNumber = rfsNumber;
            IncludeBillsOfLading = includeBillsOfLading;
            IncludeLoads = includeLoads;
            IncludeReceivers = includeReceivers;
            _invoiceType = invoiceType;
            _invoiceDate = invoiceDate;
            _publicNotes = publicNotes;
            _privateNotes = privateNotes;
            _rfsDataContext = rfsDataContext;
        }

        public BopsRfsBillDetail GetBillDetail(int billIndex)
        {
            if (billIndex < 0 || _bills.Count <= billIndex)
                throw new ArgumentOutOfRangeException("billIndex");
            var result = _bills[billIndex];
            return _billDetailsMap.LookupBillDetail(result.ResultId);
        }

        public BopsRfsInvoicePackage GetInvoiceResult(int billIndex)
        {
            if (billIndex < 0 || _bills.Count <= billIndex)
                throw new ArgumentOutOfRangeException("billIndex");
            var result = _invoiceResults[billIndex];
            return result;
        }

        public int PrepareForBulkInvoicing()
        {
            _bills = GetBills();

            if (_bills.Count > 0)
            {
                _invoiceResults = new BopsRfsInvoicePackage[_bills.Count];

                var loadsToInvoice = new Dictionary<string, int>();
                foreach (var result in _bills)
                {
                    if (result.IsLoad && !loadsToInvoice.ContainsKey(result.LoadRef))
                        loadsToInvoice.Add(result.LoadRef, 0);
                }

                _descriptionGenerator = new RfsInvoiceDescriptionGenerator(_rfsDataContext, loadsToInvoice.Keys);
            }

            CacheBillDetails();

            return _bills.Count;
        }

        private void CacheBillDetails()
        {
            _billDetailsMap = new BopsRfsBillDetailMap(_rfsDataContext, _bills);
        }

        private IList<BopsRfsServiceCalculationResult> GetBills()
        {
            var allResults = _rfsDataContext.GetServiceCalculationResultsByRfsForBulkInvoice(RfsNumber);

            // Now create a second list that filters only the types of bills we're interested in processing.

            var returnValue = new List<BopsRfsServiceCalculationResult>();
            foreach (var result in allResults)
            {
                // Based on the type of the bill, skip it if we're not set to include it.

                if (result.IsLoad && !IncludeLoads)
                    continue;
                if (result.IsReceiver && !IncludeReceivers)
                    continue;
                if (result.IsBillOfLading && !IncludeBillsOfLading)
                    continue;

                // If it passed through the above filters, then add it to the list of return results.

                returnValue.Add(result);
            }

            return returnValue;
        }

        public BopsRfsInvoicePackage InvoiceBill(int billIndex, int companyId)
        {
            if (billIndex < 0 || _bills.Count <= billIndex)
                throw new ArgumentOutOfRangeException("billIndex");
            if (_invoiceResults[billIndex] != null)
                throw new InvalidOperationException(string.Format("Bill at index {0} has already been processed", billIndex));

            var lifecycleManager = RfsFactory.GetRfsInvoiceLifecycleManager(_rfsDataContext);
            var detail = _billDetailsMap.LookupBillDetail(_bills[billIndex].ResultId);

            BopsRfsInvoicePackage returnValue;

            if (detail == null)
            {
                returnValue = new BopsRfsInvoicePackage(InvoiceErrorType.BillingError);
            }
            else
            {
                var detailList = new List<BopsRfsBillDetail> {detail};
                returnValue = lifecycleManager.CreateInvoice(_invoiceType, _invoiceDate, _publicNotes, 
                    _privateNotes, detailList, _descriptionGenerator, companyId);
            }

            Debug.Assert(returnValue != null);

            if (returnValue.ErrorType != InvoiceErrorType.None)
                BillsFailedCount++;
            _invoiceResults[billIndex] = returnValue;
            BillsProcessedCount++;

            return returnValue;
        }
    }
}
