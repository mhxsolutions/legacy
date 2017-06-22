using System;
using BopsBusinessLogicPlanning;
using BopsDataConnector;

public partial class Planning_DriverPlannerEdit2 : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        if (Request.QueryString["PlanId"] == null) Response.Redirect("DriverPlanner.aspx");

        _DeleteLastStepHyperlink.Visible = _PlanGridview.Rows.Count > 0;
        _PostTripLabel.Visible = _PlanGridview.Rows.Count > 0;
        _PostTripDestinationsDropdownlist.Visible = _PlanGridview.Rows.Count > 0;
        _PostTripButton.Visible = _PlanGridview.Rows.Count > 0;
        _DeleteLastStepHyperlink.NavigateUrl = string.Format("DriverPlannerDeleteLastStep.aspx?PlanId={0}", Request.QueryString["PlanId"]);
        _BucketGridview.PageSize = Math.Max(10, 20 - _PlanGridview.Rows.Count);

        IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);

        try
        {
            IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
            DriverPlanningDetails Dpd = DriverPlanner.GetDriverPlanningDetails(PlanId, QueryDriverPlanningDetails.DriverAndPlan);
            if (Dpd == null) throw new ArgumentNullException(string.Format("Driver planning details could not be retrieved for plan {0}", PlanId));
            string PlanHeader = string.Format("{0} on {1} Starting at {2}", Dpd.Driver,
                                              Dpd.Plan.PlanDate.Value.ToShortDateString(),
                                              Dpd.Plan.StartTime.Value.ToShortTimeString());
            _PlanHeaderLabel.Text = PlanHeader;

            // Block all editing operations if the plan is today's or earlier; we only allow web planning
            // on plans in the future.

            if (Dpd.Plan.PlanDate.Value.Date <= DateTime.Now)
            {
                _PlanGridview.Columns[10].Visible = false;
                _DeleteLastStepHyperlink.Visible = false;
                _BucketGridview.Columns[6].Visible = false;
            }
        }
        finally
        {
            DataConnector.CloseSessions();
        }
    }

    protected void _PostTripButton_Click(object Sender, EventArgs E)
    {
        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);
        if (DriverPlanner.CreatePostTrip(PlanId, Convert.ToInt32(_PostTripDestinationsDropdownlist.SelectedValue)))
            Response.Redirect("DriverPlannerEdit2.aspx");
    }
}
