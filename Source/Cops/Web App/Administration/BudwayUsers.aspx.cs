using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace Web_App.Administration
{
    public partial class BudwayUsers : System.Web.UI.Page
    {
        private class BudwayUser : IComparable
        {
            public string UserName { get; set; }

            public string Email { get; set; }

            public DateTime LastLoginDate { get; set; }

            public BudwayUser(string userName, string email, DateTime lastLoginDate)
            {
                UserName = userName;
                Email = email;
                LastLoginDate = lastLoginDate;
            }

            public int CompareTo(object obj)
            {
                var rhs = (BudwayUser)obj;
                return string.Compare(UserName, rhs.UserName);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            try
            {
                var rfsDataContext = TemporaryKernel.GetRfsDataContext();

                var copsUsers = rfsDataContext.GetCopsUserDetails();
                var copsUsersMap = copsUsers.ToDictionary(u => u.UserId, u => u);

                var budwayUsers = new List<BudwayUser>();
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
                // TODO: free the RFS data context
            }
        }
    }
}