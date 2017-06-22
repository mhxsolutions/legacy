using System;
using BopsBusinessLogicPlanning;

public partial class Planning_ContainerProjectAssignRailcar : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return; // Postbacks should never occur, but what the heck.

        int ProjectId = Convert.ToInt32(Request.QueryString["ProjectId"]);
        string RailcarUkey = Request.QueryString["Ukey"];
        if (string.IsNullOrEmpty(RailcarUkey)) return;

        IContainerProjectPlanner Planner = PlanningFactory.GetContainerProjectPlanner();
        if (Planner.AssignRailcar(ProjectId, RailcarUkey))
            Response.Redirect(string.Format("ContainerProjectRailcars.aspx?ProjectId={0}", ProjectId));
    }
}
