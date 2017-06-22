using System.Collections.Generic;

namespace BopsBusinessLogicRfs
{
    #region Helper Classes

    /// <summary>
    /// Holds the results of an invoice export operation.
    /// </summary>
    public class InvoiceExportResults
    {
        private readonly int _ExportId;
        private readonly int _InvoiceCount;
        private readonly double _TotalAmount;
        private string _FileName;
        private readonly Dictionary<string, double> _AccountDetails;

        /// <summary>
        /// The ID of the resulting export.
        /// </summary>
        public int ExportId
        {
            get { return _ExportId; }
        }

        /// <summary>
        /// The total number of invoices exported.
        /// </summary>
        public int InvoiceCount
        {
            get { return _InvoiceCount; }
        }

        /// <summary>
        /// The total amount of revenue summed from all invoices.
        /// </summary>
        public double TotalAmount
        {
            get { return _TotalAmount; }
        }

        /// <summary>
        /// The file name to which the details have been exported.
        /// </summary>
        public string FileName
        {
            get { return _FileName; }
            set { _FileName = value; }
        }

        /// <summary>
        /// Constructs an object from the supplied parameters.
        /// </summary>
        /// <param name="_ExportId">The ID of the export.</param>
        /// <param name="_InvoiceCount">The total number of invoices exported.</param>
        /// <param name="_TotalAmount">The total amount of revenue summed from all invoices.</param>
        public InvoiceExportResults(int _ExportId, int _InvoiceCount, double _TotalAmount)
        {
            this._ExportId = _ExportId;
            this._InvoiceCount = _InvoiceCount;
            this._TotalAmount = _TotalAmount;

            _AccountDetails = new Dictionary<string, double>();
        }

        /// <summary>
        /// Retrieves the particular sort of iterator necessary to retrieve the account details 
        /// from the export.
        /// </summary>
        /// <returns>An enumerator that allows account details to be retrieved.</returns>
        public Dictionary<string, double>.Enumerator GetAccountDetailsEnumerator()
        {
            return _AccountDetails.GetEnumerator();
        }

        /// <summary>
        /// Adds a GL code and amount pair to the dictionary if it doesn't exist, or sums the supplied amount
        /// to the existing value.
        /// </summary>
        /// <param name="GeneralLedgerCode">The general ledger code to which the amount should be applied.</param>
        /// <param name="Amount">The amount to apply to the general ledger code.</param>
        public void AddTransaction(string GeneralLedgerCode, double Amount)
        {
            if (_AccountDetails.ContainsKey(GeneralLedgerCode))
                _AccountDetails[GeneralLedgerCode] += Amount;
            else
                _AccountDetails.Add(GeneralLedgerCode, Amount);
        }
    }

    #endregion

    /// <summary>
    /// The interface provided by the RFS system for handling invoice exporting.
    /// </summary>
    public interface IRfsInvoiceExporter
    {
        /// <summary>
        /// Takes a collection of invoice IDs and validates that an invoice export is possible for the given
        /// invoices. If the collection is not valid, detailed error messages are returned.
        /// </summary>
        /// <param name="invoiceIds">Enumerable collection of invoice IDs to be included in the export.</param>
        /// <returns>Null if the invoices may be exported or a one-error-per-line set of messages
        /// in the event that something is wrong.</returns>
        string ValidateExportInvoices(int[] invoiceIds);

        /// <summary>
        /// Takes a collection of invoice IDs and generates an invoice export based on the invoice contents.
        /// The results include one detail line for each general ledger code found on a particular invoice,
        /// each line amount being the sum of all bills falling under that code. Users interested in providing
        /// detailed error messages should pre-qualify the operation via <see cref="ValidateExportInvoices"/>.
        /// </summary>
        /// <param name="invoiceIds">Enumerable collection of invoice IDs to be included in the export.</param>
        /// <returns>The invoice export results if successful or zero in case of failure.</returns>
        InvoiceExportResults ExportInvoices(int[] invoiceIds);

        /// <summary>
        /// Creates a string containing one line for each detail item in the specified invoice export. The
        /// overall contents are in a comma-separated value format with a header line at the top. The format
        /// mirrors the format defined and used by the DWS invoice export feature.
        /// </summary>
        /// <param name="exportId">The ID of the invoice export to be used to generate the string.</param>
        /// <returns>The string with MAS90 CSV import contents if successfull or null in case of failure.</returns>
        string CreateMas90CsvImportText(int exportId);

        /// <summary>
        /// Creates a string containing data in the Solomon import format.
        /// </summary>
        /// <param name="exportId">The ID of the invoice export to be used to generate the string.</param>
        /// <returns>The string with the Solomon CSV import contents if successful or null in case of failure.</returns>
        string CreateSolomonCsvImportText(int exportId);
    }
}
