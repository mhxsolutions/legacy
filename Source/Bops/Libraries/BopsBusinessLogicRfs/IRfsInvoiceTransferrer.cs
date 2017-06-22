namespace BopsBusinessLogicRfs
{
    /// <summary>
    /// The interface provided by the RFS system for handling invoice transferring.
    /// </summary>
    public interface IRfsInvoiceTransferrer
    {
        /// <summary>
        /// Takes a collection of invoice IDs and validates that an invoice export is possible for the given
        /// invoices. If the collection is not valid, detailed error messages are returned.
        /// </summary>
        /// <param name="invoiceIds">Enumerable collection of invoice IDs to be included in the export.</param>
        /// <returns>Null if the invoices may be exported or a one-error-per-line set of messages
        /// in the event that something is wrong.</returns>
        string ValidateTransferInvoices(int[] invoiceIds);

        bool TransferInvoices(int[] invoiceIds);

        string ValidatePostBatches(int[] batchIds);
        bool PostTransferBatch(int[] batchIds);
    }
}
