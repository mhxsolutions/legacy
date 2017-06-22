namespace BopsDataAccess
{
    /// <summary>
    /// Models a company that uses the RFS system
    /// </summary>
    public class BopsCompany
    {
        /// <summary>
        /// Unique ID of the company.
        /// </summary>
        public int CompanyId { get; set; }
        /// <summary>
        /// Name of the company.
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// City in which the company is located.
        /// </summary>
        public string City { get; set; }
        /// <summary>
        /// Gets or sets the type of the invoice.
        /// </summary>
        public string InvoiceType { get; set; }
    }
}
