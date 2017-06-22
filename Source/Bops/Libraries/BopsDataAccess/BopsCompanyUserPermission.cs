namespace BopsDataAccess
{
    /// <summary>
    /// Models a permission for a company user
    /// </summary>
    public class BopsCompanyUserPermission
    {
        /// <summary>
        /// Unique ID of the permission.
        /// </summary>
        public int PermissionId { get; set; }
        /// <summary>
        ///  Title of the permission.
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// Description of the permission.
        /// </summary>
        public string Description { get; set; }
    }
}
