using System.Collections;
using System.Collections.Generic;
using System.DirectoryServices;

namespace BopsAuthentication
{
    /// <summary>
    /// Supplies helper methods for dealing with Active Directory via LDAP.
    /// </summary>
    class LdapDirectoryUtility
    {
        private class UserDetails
        {
            private readonly string _UserId;
            private readonly string _UserRecord;
            private readonly List<string> _UserGroupRecords;

            public string UserId
            {
                get { return _UserId; }
            }

            public string UserRecord
            {
                get { return _UserRecord; }
            }

            public List<string> UserGroupRecords
            {
                get { return new List<string>(_UserGroupRecords); }
            }

            public UserDetails(string _UserId, string _UserRecord, IEnumerator _UserGroupRecords)
            {
                this._UserId = _UserId;
                this._UserRecord = _UserRecord;
                this._UserGroupRecords = new List<string>();

                while (_UserGroupRecords.Current != null)
                {
                    this._UserGroupRecords.Add(_UserGroupRecords.Current.ToString());
                    _UserGroupRecords.MoveNext();
                }
            }
        }

        private const string _LdapPrefix = "LDAP://";

        private readonly string _DomainName;
        private readonly string _LdapServer;

        /// <summary>
        /// The name of the domain to which the machine is joined or the empty string if not joined to a domain.
        /// </summary>
        public string DomainName
        {
            get { return _DomainName; }
        }

        /// <summary>
        /// The LDAP server used for Active Directory operations.
        /// </summary>
        public string LdapServer
        {
            get { return _LdapServer; }
        }

        /// <summary>
        /// Default constructor. May take several seconds to instantiate to query the domain name to which
        /// the machine is joined.
        /// </summary>
        /// <param name="LdapServerName">
        /// For example, internal to the Budway network (at this time) the LDAP server name is LDAP://FON-DATA
        /// </param>
        public LdapDirectoryUtility(string LdapServerName)
        {
            if (LdapServerName.Substring(0, _LdapPrefix.Length).ToUpper() != _LdapPrefix)
                _LdapServer = _LdapPrefix + LdapServerName;
            else
                _LdapServer = LdapServerName;

            try
            {
                // Domain name is in the format "DC=DomainName", so we just want the portion of the string that
                // begins at offset three.

                DirectoryEntry de = new DirectoryEntry();
                _DomainName = de.Name.Substring(3);
            }
            catch (System.Runtime.InteropServices.COMException)
            {
                // This particular exception occurs reliably when the machine isn't joined to a domain. Any other
                // exception will throw out of the constructor.

                _DomainName = string.Empty;
            }
        }

        private UserDetails UserAuthenticationCore(string Domain, string UserId, string UserPassword)
        {
            string DomainAndUserId = Domain + @"\" + UserId;
            DirectoryEntry entry = new DirectoryEntry(_LdapServer, DomainAndUserId, UserPassword);

            // Bind to the native AdsObject to force authentication.
            //Object obj = entry.NativeObject;
            DirectorySearcher search = new DirectorySearcher(entry);
            search.Filter = "(SAMAccountName=" + UserId + ")";
            search.PropertiesToLoad.Add("cn");
            search.PropertiesToLoad.Add("memberOf");
            SearchResult result = search.FindOne();

            if (result != null)
                return new UserDetails(UserId, result.Path, result.Properties["memberOf"].GetEnumerator());

            return null;
        }

        /// <summary>
        /// Authenticates the user is a member of the specified domain via the supplied credentials.
        /// </summary>
        /// <param name="Domain">Name of the domain to be searched for the user.</param>
        /// <param name="UserId">User ID to be authenticated.</param>
        /// <param name="UserPassword"></param>
        /// <returns></returns>
        public bool AuthenticateUser(string Domain, string UserId, string UserPassword)
        {
            UserDetails Ud = UserAuthenticationCore(Domain, UserId, UserPassword);
            return Ud != null;
        }

        public bool AuthenticateUserInGroup(string Domain, string UserId, string UserPassword, string Group)
        {
            UserDetails Ud = UserAuthenticationCore(Domain, UserId, UserPassword);

            if (Ud != null)
            {
                foreach (string s in Ud.UserGroupRecords)
                {
                    if (string.Compare(Group, s, true) == 0)
                        return true;
                }
            }

            return false;
        }
    }
}
