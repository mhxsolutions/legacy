using System.Collections.Generic;
using System.Linq;

namespace BopsAuthentication
{
    /// <summary>
    /// Supplies helper methods for dealing with Active Directory via standard .NET System.Security mechanisms.
    /// </summary>
    public class ActiveDirectoryUtility
    {
        public string DomainName { get; set; }

        /// <summary>
        /// Gets the name of the current user.
        /// </summary>
        /// <returns>
        /// The name of the current user in Domain\User format.
        /// </returns>
        public static string GetCurrentUserName()
        {
            var windowsIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();
            return windowsIdentity != null ? windowsIdentity.Name : null;
        }

        /// <summary>
        /// Gets the list of group names of which the current user is a member.
        /// </summary>
        /// <returns>The group names as a list of strings.</returns>
        public static List<string> GetCurrentUserGroupNames()
        {
            var wid = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (wid == null || wid.Groups == null)
                return null;
            return wid.Groups.Select(ir => ir.Translate(typeof (System.Security.Principal.NTAccount)).ToString()).ToList();
        }

        /// <summary>
        /// Validates that the current user is a member of at least one or all of the specified groups.
        /// </summary>
        /// <param name="groupNames">Group names to validate as a list of strings.</param>
        /// <param name="matchAll">If true then the current user is required to belong to all groups; otherwise, matching any group name is sufficient.</param>
        /// <returns>True if the current user is a member of at least one or all of the specified groups.</returns>
        public static bool ValidateCurrentUserIsGroupMember(List<string> groupNames, bool matchAll)
        {
            if (groupNames.Count < 1)
                return false;

            var wid = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (wid == null)
                return false;
            var wp = new System.Security.Principal.WindowsPrincipal(wid);

            var matchCount = groupNames.Count(wp.IsInRole);

            if (matchAll)
                return matchCount == groupNames.Count;
            return matchCount > 0;
        }

        /// <summary>
        /// Validates that the current user is a member of the specified group.
        /// </summary>
        /// <param name="group">Group name to validate.</param>
        /// <returns>True if the current user is a member of the specified group.</returns>
        public static bool ValidateCurrentUserIsGroupMember(string @group)
        {
            var wid = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (wid == null)
                return false;
            var wp = new System.Security.Principal.WindowsPrincipal(wid);
            return wp.IsInRole(@group);
        }
    }
}
