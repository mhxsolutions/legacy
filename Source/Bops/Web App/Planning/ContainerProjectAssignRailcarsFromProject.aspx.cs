using System;
using BopsBusinessLogicPlanning;

public partial class Planning_ContainerProjectAssignRailcarsFromProject : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return; // Postbacks should never occur, but what the heck.

        int SourceProjectId = Convert.ToInt32(Request.QueryString["SourceProjectId"]);
        int DestinationProjectId = Convert.ToInt32(Request.QueryString["DestinationProjectId"]);

        IContainerProjectPlanner Planner = PlanningFactory.GetContainerProjectPlanner();
        if (Planner.CopyRailcars(SourceProjectId, DestinationProjectId))
            Response.Redirect(string.Format("ContainerProjectRailcars.aspx?ProjectId={0}", DestinationProjectId));
    }
}
