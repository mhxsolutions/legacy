using System;
using System.Web.UI.WebControls;
using BopsBusinessLogicPlanning;
using BopsDataAccess;

public partial class Planning_DriverPlannerCreate : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        Page.Form.DefaultButton = _CreateButton.UniqueID;
        _StartTimeTextbox.Focus();

        int DriverId = Convert.ToInt32(Request.QueryString["DriverId"]);
        DateTime PlanDate = Convert.ToDateTime(Request.QueryString["PlanDate"]);

        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        BopsDriver Driver = DriverPlanner.GetDriver(DriverId);
        if (Driver == null) return;
        _DriverNameLabel.Text = string.Format("{0} {1}", Driver.FirstName, Driver.LastName);
        _PlanDateLabel.Text = PlanDate.ToShortDateString();
    }

    protected void ServerValidateStartTime(object Sender, ServerValidateEventArgs E)
    {
        // TODO: Change the start time handling to support using a period in place of a colon. Shelly says that makes it easier.

        TimeSpan StartOffset;
        E.IsValid = TimeSpan.TryParse(_StartTimeTextbox.Text, out StartOffset);
    }

    protected void _CreateButton_Click(object Sender, EventArgs E)
    {
        if (!Page.IsValid) return;

        int DriverRef = Convert.ToInt32(Request.QueryString["DriverId"]);
        DateTime PlanDate = Convert.ToDateTime(Request.QueryString["PlanDate"]);
        TimeSpan StartOffset;
        if (!TimeSpan.TryParse(_StartTimeTextbox.Text, out StartOffset)) return;
        DateTime StartTime = PlanDate + StartOffset;

        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        BopsDriverPlan NewPlan = DriverPlanner.CreatePlan(DriverRef, PlanDate, StartTime);
        if (NewPlan != null)
            Response.Redirect(string.Format("DriverPlannerEdit2.aspx?PlanId={0}", NewPlan.PlanId));
    }
}
