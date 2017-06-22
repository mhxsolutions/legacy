using System;
using BopsBusinessLogicPlanning;

public partial class Planning_DriverPlannerPlanStep : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return; // Postbacks should never occur, but what the heck.

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);
        string LoadRef = Request.QueryString["LoadRef"];

        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        if (DriverPlanner.CreateLoadPlanDetails(PlanId, LoadRef))
            Response.Redirect(string.Format("DriverPlannerEdit2.aspx?PlanId={0}", PlanId));
    }
}
