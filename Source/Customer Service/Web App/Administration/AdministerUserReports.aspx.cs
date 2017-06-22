using System;
using System.Web.UI.WebControls;

public partial class Administration_AdministerUserReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ReportsGridview_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        Master.TreeViewControl.DataBind();
    }
}
