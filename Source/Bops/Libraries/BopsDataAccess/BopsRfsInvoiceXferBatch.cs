using System;

namespace BopsDataAccess
{
    /// <summary>
    /// Models data associated with an invoice transfer batch.
    /// </summary>
    public class BopsRfsInvoiceXferBatch
    {
        /// <summary>
        /// The batch Id will be identity and it will be used as batch number
        /// </summary>
        public int BatchId { get; set; }

        public string LocationCode { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime? PostedDate { get; set; }
    }
}
