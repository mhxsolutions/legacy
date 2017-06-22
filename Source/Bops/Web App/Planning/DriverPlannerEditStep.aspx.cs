using System;
using System.Web.UI.WebControls;
using BopsBusinessLogicPlanning;
using BopsDataAccess;

public partial class Planning_DriverPlannerEditStep : System.Web.UI.Page
{
    private static void SelectDropdownIntValue(DropDownList TheList, int DestinationId)
    {
        foreach (ListItem Item in TheList.Items)
        {
            int CurrentId = Convert.ToInt32(Item.Value);
            if (CurrentId != DestinationId) continue;

            Item.Selected = true;
            break;
        }
    }

    private static void SelectDropdownText(DropDownList TheList, string Text)
    {
        foreach (ListItem Item in TheList.Items)
        {
            if (string.Compare(Item.Text, Text, true) != 0) continue;
            Item.Selected = true;
            break;
        }
    }

    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        Page.Form.DefaultButton = _UpdateButton.UniqueID;

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);
        int DetailId = Convert.ToInt32(Request.QueryString["DetailId"]);
        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        DriverPlanningDetails Dpd = DriverPlanner.GetDriverPlanningDetails(PlanId, QueryDriverPlanningDetails.DriverAndPlan | QueryDriverPlanningDetails.Details);
        if (Dpd == null) throw new ArgumentNullException(string.Format("Driver planning details could not be retrieved for plan {0}", PlanId));

        BopsDriverPlanDetail EditDetail = null;
        foreach (BopsDriverPlanDetail Detail in Dpd.Details)
        {
            if (Detail.PlanDetailId != DetailId) continue;
            EditDetail = Detail;
            break;
        }

        if (EditDetail == null) throw new ArgumentNullException(string.Format("Driver planning detail could not be retrieved for detail ID {0}", DetailId));

        string PlanHeader = string.Format("{0} on {1} Starting at {2}", Dpd.Driver,
                                          Dpd.Plan.PlanDate.Value.ToShortDateString(),
                                          Dpd.Plan.StartTime.Value.ToShortTimeString());
        _PlanHeaderLabel.Text = PlanHeader;

        _OriginDropdownlist.DataBind();
        SelectDropdownIntValue(_OriginDropdownlist, EditDetail.OriginRef);
        _DestinationDropdownlist.DataBind();

        if (!string.IsNullOrEmpty(EditDetail.LoadRef))
        {
            _LoadDropdownlist.DataBind();
            SelectDropdownText(_LoadDropdownlist, EditDetail.LoadRef);
        }

        SelectDropdownIntValue(_DestinationDropdownlist, EditDetail.DestinationRef);
        SelectDropdownIntValue(_ActionDropdownlist, EditDetail.ActionRef);
        _NotesTextbox.Text = EditDetail.Notes;
    }

    protected void _UpdateButton_Click(object Sender, EventArgs E)
    {
        if (!Page.IsValid) return;

        int PlanId = Convert.ToInt32(Request.QueryString["PlanId"]);
        int DetailId = Convert.ToInt32(Request.QueryString["DetailId"]);
        int OriginRef = Convert.ToInt32(_OriginDropdownlist.SelectedValue);
        int DestinationRef = Convert.ToInt32(_DestinationDropdownlist.SelectedValue);
        int ActionRef = Convert.ToInt32(_ActionDropdownlist.SelectedValue);
        string LoadRef = _LoadDropdownlist.SelectedValue == string.Empty ? null : _LoadDropdownlist.SelectedValue;

        IDriverPlanner DriverPlanner = PlanningFactory.GetDriverPlanner();
        if (DriverPlanner.UpdatePlanDetail(PlanId, DetailId, OriginRef, DestinationRef, LoadRef, ActionRef, _NotesTextbox.Text))
            Response.Redirect(string.Format("DriverPlannerEdit.aspx?PlanId={0}", PlanId));
    }
}
