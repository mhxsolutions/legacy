using System;
using BopsBusinessLogicPlanning;
using BopsDataConnector;

public partial class Planning_DriverPlannerEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;

        IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);

        try
        {
            IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
            DriverPlanningDetails Dpd = DriverPlanner.GetDriverPlanningDetails(PlanId, QueryDriverPlanningDetails.DriverAndPlan | QueryDriverPlanningDetails.Details);
            if (Dpd == null) throw new ArgumentNullException(string.Format("Driver planning details could not be retrieved for plan {0}", PlanId));

            string PlanHeader = string.Format("{0} on {1} Starting at {2}", Dpd.Driver,
                                              Dpd.Plan.PlanDate.Value.ToShortDateString(),
                                              Dpd.Plan.StartTime.Value.ToShortTimeString());
            _PlanHeaderLabel.Text = PlanHeader;

            _NewStepHyperlink.NavigateUrl = string.Format("DriverPlannerCreateStep.aspx?PlanId={0}&Order=-1", PlanId);

            _WarningLabel.Visible = !Dpd.IsContiguous;
        }
        finally
        {
            DataConnector.CloseSessions();
        }
    }
}
