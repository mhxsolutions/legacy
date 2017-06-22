using System;
using System.Web.UI.HtmlControls;

namespace Web_App.Administration
{
    public partial class AdministerError : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Add a refresh meta-tag to redirect in a few seconds.

            var refreshTag = new HtmlMeta { HttpEquiv = "refresh", Content = "10; URL=AdministerUsers.aspx" };
            Header.Controls.Add(refreshTag);
        }
    }
}