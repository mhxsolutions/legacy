using System;
using System.Collections.Generic;
using System.Web.Security;
using BopsDataAccess;
using BopsDataConnector;

// ReSharper disable CheckNamespace
public partial class Administration_BudwayUsers : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    private class BudwayUser : IComparable
    {
        private string _userName;
        private string _email;
        private DateTime _lastLoginDate;

        public string UserName
        {
            get { return _userName; }
            set { _userName = value; }
        }

        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }

        public DateTime LastLoginDate
        {
            get { return _lastLoginDate; }
            set { _lastLoginDate = value; }
        }

        public BudwayUser(string UserName, string Email, DateTime LastLoginDate)
        {
            _userName = UserName;
            _email = Email;
            _lastLoginDate = LastLoginDate;
        }

        public int CompareTo(object obj)
        {
            BudwayUser rhs = (BudwayUser) obj;
            return string.Compare(UserName, rhs.UserName);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;

        IBopsDataConnector Connector = BopsDataConnectorFactory.GetDataConnector();

        try
        {
            IList<CopsUserDetails> copsUsers = Connector.DwsNoRepData.CreateCriteria(typeof(CopsUserDetails)).List<CopsUserDetails>();
            IDictionary<string, CopsUserDetails> copsUsersMap = new Dictionary<string, CopsUserDetails>();
            foreach (CopsUserDetails user in copsUsers)
                copsUsersMap.Add(user.UserId, user);

            List<BudwayUser> budwayUsers = new List<BudwayUser>();
            foreach (MembershipUser user in Membership.GetAllUsers())
            {
                if (copsUsersMap.ContainsKey(user.UserName))
                    continue;
                budwayUsers.Add(new BudwayUser(user.UserName, user.Email, user.LastLoginDate));
            }

            budwayUsers.Sort();

            UsersGridview.DataSource = budwayUsers;
            UsersGridview.DataBind();
        }
        finally
        {
            Connector.CloseSessions();
        }
    }
}
