using System;
using System.Configuration;
using System.Web.UI.WebControls;
using BopsBusinessLogicPlanning;
using BopsDataAccess;

public partial class Planning_DriverPlannerCreateStep : System.Web.UI.Page
{
    private void SelectOrigin(int OriginToSelect)
    {
        foreach (ListItem Item in _OriginDropdownlist.Items)
        {
            int OriginRef = Convert.ToInt32(Item.Value);
            if (OriginRef != OriginToSelect) continue;

            Item.Selected = true;
            break;
        }
    }

    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        Page.Form.DefaultButton = _CreateButton.UniqueID;

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);
        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        DriverPlanningDetails Dpd = DriverPlanner.GetDriverPlanningDetails(PlanId, QueryDriverPlanningDetails.DriverAndPlan | QueryDriverPlanningDetails.Details);
        if (Dpd == null) throw new ArgumentNullException(string.Format("Driver planning details could not be retrieved for plan {0}", PlanId));

        string PlanHeader = string.Format("{0} on {1} Starting at {2}", Dpd.Driver,
                                          Dpd.Plan.PlanDate.Value.ToShortDateString(),
                                          Dpd.Plan.StartTime.Value.ToShortTimeString());
        _PlanHeaderLabel.Text = PlanHeader;

        _OriginDropdownlist.DataBind();

        if (Dpd.Details.Count == 0)
        {
            int BudwayId = Convert.ToInt32(ConfigurationManager.AppSettings["BudwayDestinationId"]);
            SelectOrigin(BudwayId);
            _OriginDropdownlist.Focus();
        }
        else
        {
            SelectOrigin(Dpd.Details[Dpd.Details.Count - 1].DestinationRef);
            _DestinationDropdownlist.Focus();
        }
    }

    protected void _CreateButton_Click(object Sender, EventArgs E)
    {
        if (!Page.IsValid) return;

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);
        int InsertBeforeDetailId = Convert.ToInt32(Request.QueryString["InsertBefore"] ?? "0");
        int OriginRef = Convert.ToInt32(_OriginDropdownlist.SelectedValue);
        int DestinationRef = Convert.ToInt32(_DestinationDropdownlist.SelectedValue);
        int ActionRef = Convert.ToInt32(_ActionDropdownlist.SelectedValue);
        string LoadRef = _LoadDropdownlist.SelectedValue == string.Empty ? null : _LoadDropdownlist.SelectedValue;

        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        BopsDriverPlanDetail NewDetail = DriverPlanner.CreatePlanDetail(PlanId, InsertBeforeDetailId, OriginRef, DestinationRef, LoadRef, ActionRef, _NotesTextbox.Text);
        if (NewDetail != null)
            Response.Redirect(string.Format("DriverPlannerEdit.aspx?PlanId={0}", PlanId));
    }
}
