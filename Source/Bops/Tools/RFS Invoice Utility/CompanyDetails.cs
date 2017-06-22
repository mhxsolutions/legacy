using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    /// <summary>
    /// Maintains company related details for the current user.
    /// </summary>
    public class CompanyDetails 
    {
        /// <summary>
        /// Gets or sets a value indicating whether the user has multiple login options.
        /// </summary>
        /// <value><c>true</c> if the user has multiple login options; otherwise, <c>false</c>.</value>
        public bool MultipleOptions { get; set; }
        /// <summary>
        /// Gets or sets the company.
        /// </summary>
        /// <value>The company.</value>
        public BopsCompany Company { get; set; }
        /// <summary>
        /// Gets or sets the user.
        /// </summary>
        /// <value>The user.</value>
        public BopsCompanyUser User { get; set; }
        /// <summary>
        /// Gets or sets the permission level.
        /// </summary>
        /// <value>The permission.</value>
        public BopsCompanyUserPermission Permission { get; set; }

        /// <summary>
        /// Returns a <see cref="System.String" /> that represents this instance.
        /// </summary>
        /// <returns>A <see cref="System.String" /> that represents this instance.</returns>
         public override string ToString()
        {
            // Using the typical "Company (Location)" approach.

            return string.Format("{0} ({1})", Company.Name, Company.City);
        }
    }
}
