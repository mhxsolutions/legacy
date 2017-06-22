using System;
using System.Web.UI.WebControls;

namespace Web_App.Administration
{
    public partial class AdministerUserReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ReportsGridview_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            Master.TreeViewControl.DataBind();
        }
    }
}