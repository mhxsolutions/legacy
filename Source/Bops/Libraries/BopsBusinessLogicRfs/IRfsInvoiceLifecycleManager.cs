using System;
using System.Collections.Generic;
using BopsDataAccess;
using BopsUtilities;

namespace BopsBusinessLogicRfs
{
    public enum InvoiceErrorType
    {
        None,
        DetailsAlreadyInvoiced,
        BillingError,
        UnknownException,
    }

    public class BopsRfsInvoicePackage
    {
        private InvoiceErrorType _ErrorType;
        private BopsRfsInvoice _Invoice;
        private List<BopsRfsInvoiceDetail> _Details;

        public InvoiceErrorType ErrorType
        {
            get { return _ErrorType; }
        }

        public BopsRfsInvoice Invoice
        {
            get { return _Invoice; }
        }

        public IEnumerable<BopsRfsInvoiceDetail> Details
        {
            get { return _Details; }
        }

        public BopsRfsInvoicePackage(InvoiceErrorType ErrorCode)
        {
            _ErrorType = ErrorCode;
        }


        public BopsRfsInvoicePackage(InvoiceErrorType errorType, List<BopsRfsInvoiceDetail> details)
        {
            _ErrorType = errorType;
            _Details = details;
        }

        public BopsRfsInvoicePackage(BopsRfsInvoice Invoice)
        {
            _Invoice = Invoice;
            _Details = new List<BopsRfsInvoiceDetail>();
        }

        public void AddDetail(BopsRfsInvoiceDetail Detail)
        {
            _Details.Add(Detail);
        }
    }

    /// <summary>
    /// The interface defined by the RFS system for managing invoice lifecycle.
    /// </summary>
    public interface IRfsInvoiceLifecycleManager
    {
        BopsRfsInvoicePackage CreateInvoice(string invoiceType, DateTime invoiceDate, string publicNotes,
                                            string privateNotes, IList<BopsRfsBillDetail> details, 
                                            RfsInvoiceDescriptionGenerator descriptionGenerator,
                                            int companyId);

        List<BopsRfsInvoicePackage> CreateInvoiceFromStorageBilling(int billingId, int serviceOfferedRef, 
            DateTime invoiceDate, string locationCode, string invoiceType);

        BopsRfsInvoicePackage CreateInvoiceFromStorageBillingDetails(IEnumerable<BopsRfsStorageBillingDetail> details, int serviceOfferedRef,
                                                                     DateTime invoiceDate, string locationCode, string invoiceType);

        /// <summary>
        /// Voids an invoice.
        /// </summary>
        /// <param name="invoiceId">The ID of the invoice to be voided.</param>
        /// <returns>A null or empty string if successful, an error message describing the cause of failure otherwise.</returns>
        string VoidInvoice(int invoiceId);
    }
}
