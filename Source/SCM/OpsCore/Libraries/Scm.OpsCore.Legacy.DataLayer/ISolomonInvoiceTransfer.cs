using System.Collections.Generic;
using BopsDataAccess;

namespace Scm.OpsCore.Legacy.DataLayer
{
    /// <summary>
    /// Interface for transferring invoices and their detail lines to the Solomon accounting system.
    /// </summary>
    /// <remarks>
    /// This code was extracted from multiple methods across which it spanned. It has been migrated
    /// as-is with only the minimal changes necessary to better handle the connection and transaction 
    /// management in a more reliable way.
    /// </remarks>
    public interface ISolomonInvoiceTransfer
    {
        /// <summary>
        /// Opens the invoice transfer.
        /// </summary>
        /// <param name="rfsDataContext">The RFS data context for data access.</param>
        /// <param name="connectionString">The connection string for the external Solomon database.</param>
        void Open(IRfsDataContext rfsDataContext, string connectionString);
        /// <summary>
        /// Switches to the specified database.
        /// </summary>
        /// <param name="databaseName">Name of the database.</param>
        void SwitchToDatabase(string databaseName);
        /// <summary>
        /// Transfers the accounts-receivable document.
        /// </summary>
        /// <remarks>
        /// The code appears to be dealing with top-level invoice "document", thus the name of the method.
        /// This has been inferred after the fact, however, and could be misleading.
        /// </remarks>
        /// <param name="invoice">The invoice.</param>
        /// <param name="location">The location.</param>
        /// <param name="mas90ClientCode">The MAS90 client code.</param>
        /// <param name="details">The details.</param>
        void TransferArDoc(BopsRfsInvoice invoice, BopsRfsLocation location, string mas90ClientCode, List<BopsRfsInvoiceDetail> details);
        /// <summary>
        /// Transfers the accounts-receivable transaction.
        /// </summary>
        /// <remarks>
        /// The code appears to be dealing with lower-level invoice "transactions", or detail lines, thus 
        /// the name of the method. This has been inferred after the fact, however, and could be misleading.
        /// </remarks>
        /// <param name="invoice">The invoice.</param>
        /// <param name="detail">The detail.</param>
        /// <param name="account">The account.</param>
        /// <param name="subAccount">The sub account.</param>
        /// <param name="itemTotal">The item total.</param>
        /// <returns>An integer value presumed to be the Solomon transaction ID.</returns>
        int TransferArTran(BopsRfsInvoice invoice, BopsRfsInvoiceDetail detail, string account, string subAccount, double itemTotal);
        /// <summary>
        /// Validates the invoice transfer batches.
        /// </summary>
        /// <param name="batchIds">The batch IDs.</param>
        /// <returns>Null in case of success, an error message otherwise.</returns>
        string ValidateInvoiceTransferBatches(int[] batchIds);
        /// <summary>
        /// Posts the transfer batch.
        /// </summary>
        /// <param name="batchIds">The batch IDs.</param>
        /// <returns><c>true</c> if successful, <c>false</c> otherwise.</returns>
        bool PostTransferBatch(int[] batchIds);
        /// <summary>
        /// Opens the invoice transfer.
        /// </summary>
        /// <param name="commitTransaction">Whether the transaction should be committed (true) or rolled back (false).</param>
        void Close(bool commitTransaction);
    }
}
