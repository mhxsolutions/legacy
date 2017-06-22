using System;
using BopsBusinessLogicPlanning;

public partial class Planning_DriverPlannerDeleteStep : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return; // Postbacks should never occur, but what the heck.

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);
        int DetailId = Convert.ToInt32(Request.QueryString["DetailId"]);

        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        if (DriverPlanner.DeletePlanDetail(PlanId, DetailId))
            Response.Redirect(string.Format("DriverPlannerEdit.aspx?PlanId={0}", PlanId));
    }
}
