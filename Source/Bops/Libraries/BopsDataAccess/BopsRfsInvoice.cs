using System;

namespace BopsDataAccess
{
    /// <summary>
    /// Defines the statuses through which an RFS invoice passes throughout its lifetime.
    /// </summary>
    public enum RfsInvoiceStatus
    {
        /// <summary>
        /// The default value, which should never occur outside of in-memory instantiation.
        /// </summary>
        None,

        /// <summary>
        /// The invoice has been created but is still being edited.
        /// </summary>
        Open,

        /// <summary>
        /// The invoice has finished being edited and is ready for review.
        /// </summary>
        PendingReview,

        /// <summary>
        /// The invoice was reviewed favorably and has been finalized, including the 
        /// generation of a PDF ready to send to the client.
        /// </summary>
        Closed,

        /// <summary>
        /// The invoice has been included in an export batch for import into MAS90.
        /// </summary>
        Exported
    }

    /// <summary>
    /// Models an RFS invoice.
    /// </summary>
    public class BopsRfsInvoice
    {
        private double _InvoiceTotal;

        /// <summary>
        /// Unique ID of the invoice.
        /// </summary>
        public int InvoiceId { get; set; }

        /// <summary>
        /// Reference to the shipper client.
        /// </summary>
        public int ShipperRef { get; set; }

        /// <summary>
        /// Reference to the bill-to client.
        /// </summary>
        public int BillToRef { get; set; }

        /// <summary>
        /// Current status of the invoice.
        /// </summary>
        public RfsInvoiceStatus InvoiceStatus { get; set; }

        /// <summary>
        /// Total amount of the invoice.
        /// </summary>
        public double InvoiceTotal
        {
            get { return _InvoiceTotal; }
            set { _InvoiceTotal = Math.Round(value, 2); }
        }

        /// <summary>
        /// Date of the invoice.
        /// </summary>
        public DateTime InvoiceDate { get; set; }

        /// <summary>
        /// Date the invoice was initially created.
        /// </summary>
        public DateTime DateCreated { get; set; }

        /// <summary>
        /// Date the invoice was finalized.
        /// </summary>
        public DateTime? DateClosed { get; set; }

        /// <summary>
        /// Public notes to be included on the invoice for the client's use.
        /// </summary>
        public string PublicNotes { get; set; }

        /// <summary>
        /// Private notes only to be displayed to Budway personnel for internal purposes.
        /// </summary>
        public string PrivateNotes { get; set; }

        /// <summary>
        /// The folder in which the corresponding invoice document is stored. The file name is given by <see cref="DocumentFileName"/>.
        /// </summary>
        public string DocumentFolder { get; set; }

        /// <summary>
        /// The file name of the corresponding invoice document in the <see cref="DocumentFolder"/>.
        /// </summary>
        public string DocumentFileName { get; set; }

        /// <summary>
        /// True if the invoice is for internal use only and should be hidden from clients.
        /// </summary>
        public bool HideFromClients { get; set; }

        /// <summary>
        /// A string code indicating the type of invoice.
        /// </summary>
        public string InvoiceType { get; set; }

        public int? BatchId { get; set; }

        public int? ARDocRecId { get; set; }

        public DateTime? TransferredDate { get; set; }

        public int CompanyRef { get; set; }

        public string UserCreated { get; set; }

        public string UserFinalized { get; set; }
    }
}
