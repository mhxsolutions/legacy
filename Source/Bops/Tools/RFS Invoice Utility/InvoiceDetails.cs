using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    /// <summary>
    /// Helper class for maintaining details relevant to an invoice. Intended primarily for use
    /// in displaying invoices in listview (and other) controls.
    /// </summary>
    internal class InvoiceDetails
    {
        private readonly BopsRfsInvoice _Invoice;
        private readonly BopsDestination _ShipperClient;
        private readonly BopsDestination _BillToClient;

        /// <summary>
        /// The invoice whose details are to be maintained.
        /// </summary>
        public BopsRfsInvoice Invoice
        {
            get { return _Invoice; }
        }

        /// <summary>
        /// Shipper client for the invoice.
        /// </summary>
        public BopsDestination ShipperClient
        {
            get { return _ShipperClient; }
        }

        /// <summary>
        /// Bill-to client for the invoice.
        /// </summary>
        public BopsDestination BillToClient
        {
            get { return _BillToClient; }
        }

        /// <summary>
        /// Constructs the object from an invoice and shipper/bill-to clients.
        /// </summary>
        /// <param name="_Invoice">The invoice to be referenced.</param>
        /// <param name="_ShipperClient">The shipper client for the invoice.</param>
        /// <param name="_BillToClient">The bill-to client for the invoice.</param>
        public InvoiceDetails(BopsRfsInvoice _Invoice, BopsDestination _ShipperClient, BopsDestination _BillToClient)
        {
            this._Invoice = _Invoice;
            this._ShipperClient = _ShipperClient;
            this._BillToClient = _BillToClient;
        }
    }
}
