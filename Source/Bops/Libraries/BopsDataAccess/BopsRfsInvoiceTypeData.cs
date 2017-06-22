namespace BopsDataAccess
{
    /// <summary>
    /// Models data associated with an invoice type.
    /// </summary>
    public class BopsRfsInvoiceTypeData
    {
        private string _InvoiceType;
        private string _Carsub;

        /// <summary>
        /// The unique ID for an invoice type, all of which may be found in the RFS Invoice Utility's App.config file.
        /// </summary>
        public string InvoiceType
        {
            get { return _InvoiceType; }
            set { _InvoiceType = value; }
        }

        /// <summary>
        /// Some "magic number" invented by former CFO Jim B. Its meaning is not for mere software developers.
        /// </summary>
        public string Carsub
        {
            get { return _Carsub; }
            set { _Carsub = value; }
        }
    }
}
