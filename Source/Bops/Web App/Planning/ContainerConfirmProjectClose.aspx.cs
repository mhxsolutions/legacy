using System;
using BopsBusinessLogicPlanning;
using BopsDataAccess;

public partial class Planning_ContainerConfirmProjectClose : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (Request.QueryString["ProjectId"] == null)
            goto FailAndRedirect;

        int ProjectId = Convert.ToInt32(Request.QueryString["ProjectId"]);
        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
        BopsCpsFullProjectDetails Details = ContainerPlanner.GetFullProjectDetails(ProjectId);
        if (Details == null)
            goto FailAndRedirect;

        _ProjectInformationLabel.Text = string.Format("Project ID {0}: booking number <b>{1}</b> for shipping line <b>{2}</b> at berth <b>{3}</b>   ",
            Details.Project.ProjectId, Details.Project.BookingId, Details.Project.ShippingLine, Details.Project.Berth);

        const string SuccessImage = "~/Images/Icon - Check Mark.gif";
        const string FailureImage = "~/Images/Icon - Cross Mark.gif";

        int OpenDemurrage = 0;
        foreach (BopsCpsDemurrage Demurrage in Details.Demurrage)
        {
            if (!Demurrage.ClockEnd.HasValue || !Demurrage.ClockEndMovementRef.HasValue)
                OpenDemurrage++;
        }

        _PickupsEqualReturnsImage.ImageUrl = (Details.Pickups == Details.Returns) ? SuccessImage : FailureImage;
        _OpenDemurrageImage.ImageUrl = (OpenDemurrage == 0) ? SuccessImage : FailureImage;
        _TotalMatchesImage.ImageUrl = (Details.Pickups == Details.Returns && Details.Pickups == Details.Project.TotalContainers) ? SuccessImage : FailureImage;

        if (_PickupsEqualReturnsImage.ImageUrl == SuccessImage && _OpenDemurrageImage.ImageUrl == SuccessImage)
        {
            _ConclusionLabel.Text = "All required criteria are met. The project may be closed by clicking the button below.";
            _CloseButton.Visible = true;
            _CloseButton.Enabled = true;
        }
        else
        {
            _ConclusionLabel.Text = "One or more required criteria are not met. The project may not be closed at this time.";
            _CloseButton.Visible = false;
        }

        return;

    FailAndRedirect:
        RedirectToSummary();
    }

    private void RedirectToSummary()
    {
        Response.Redirect("ContainerProjectsSummary.aspx");
    }

    protected void _CloseButton_Click(object Sender, EventArgs E)
    {
        int ProjectId = Convert.ToInt32(Request.QueryString["ProjectId"]);
        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
        ContainerPlanner.CloseProject(ProjectId);
        RedirectToSummary();
    }
}
