using System;
using System.Web;
using System.Web.UI.WebControls;
using BopsBusinessLogicPlanning;
using BopsDataAccess;
using CopsUtilities;

public partial class Planning_ContainerMoveHistory : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        if (Request.QueryString["ProjectId"] == null)
            Response.Redirect("ContainerPlanner.aspx");

        int ProjectId = Convert.ToInt32(Request.QueryString["ProjectId"]);
        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
        BopsCpsProject Project = ContainerPlanner.GetProject(ProjectId);
        _ProjectInformationLabel.Text = string.Format("Project ID {0}: booking number <b>{1}</b> for shipping line <b>{2}</b> at berth <b>{3}</b>   ",
            Project.ProjectId, Project.BookingId, Project.ShippingLine, Project.Berth);

        _MovesGridview.Sort("MoveId", SortDirection.Ascending);
    }

    protected void _ExportToExcelButton_Click(object Sender, EventArgs E)
    {
        GridViewExporter.Export("BopsWeb_ContainerMoveHistory.xls", _MovesGridview);
    }
}
