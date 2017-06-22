using System;
using System.Web.UI.WebControls;

public partial class RFS_RfsStorageBillingRateAssignments : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (!IsPostBack)
        {
            _AssignmentsGridview.Sort("AssignmentId", SortDirection.Ascending);
        }

        if (Request.QueryString["RateId"] != null)
        {
            int RateId = Convert.ToInt32(Request.QueryString["RateId"]);
            AssignmentsDatasource.FilterExpression = string.Format("ID={0}", RateId);
        }
    }
}
