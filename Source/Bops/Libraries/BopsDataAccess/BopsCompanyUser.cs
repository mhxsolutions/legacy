namespace BopsDataAccess
{
    /// <summary>
    /// Represents a user within the combined DWS/Bops/Cops systems
    /// </summary>
    public class BopsCompanyUser
    {
        /// <summary>
        /// Unique ID of the user
        /// </summary>
        public int CompanyUserId { get; set; }
        /// <summary>
        /// User ID within the system?
        /// </summary>
        public string CurrentUserId { get; set; }
        /// <summary>
        /// Reference to the company table
        /// </summary>
        public int CompanyRef { get; set; }
        /// <summary>
        /// Reference to the user permission table
        /// </summary>
        public int UserPermissionRef { get; set; }
        /// <summary>
        /// Windows user ID to be used for lookup
        /// </summary>
        public string WindowsUserId { get; set; }
    }
}
