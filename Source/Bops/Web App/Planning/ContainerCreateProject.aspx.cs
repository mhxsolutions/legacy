using System;
using BopsBusinessLogicPlanning;
using BopsDataAccess;

public partial class Planning_ContainerCreateProject : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        Page.Form.DefaultButton = _CreateButton.UniqueID;
        _BookingIdTextbox.Focus();
        _BeginDateTextbox.Text = DateTime.Now.Date.ToShortDateString();
    }

    protected void _CreateButton_Click(object Sender, EventArgs E)
    {
        if (!Page.IsValid) return;

        DateTime BeginDate = Convert.ToDateTime(_BeginDateTextbox.Text);
        int DemurrageDays = Convert.ToInt32(_DemurrageDaysTextbox.Text);
        int TotalContainers = Convert.ToInt32(_TotalContainersTextbox.Text);
        int BillToClientRef = Convert.ToInt32(_BillToClientDropdownlist.SelectedValue);
        int DefaultOriginRef = Convert.ToInt32(_OriginDropdownlist.SelectedValue);
        int DefaultDestinationRef = Convert.ToInt32(_DestinationDropdownlist.SelectedValue);

        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
        BopsCpsProject NewProject = ContainerPlanner.CreateProject(_BookingIdTextbox.Text, _BerthTextbox.Text,
                                                                   _ShippingLineTextbox.Text, BeginDate,
                                                                   DemurrageDays, TotalContainers,
                                                                   _DescriptionTextbox.Text, BillToClientRef,
                                                                   DefaultOriginRef, DefaultDestinationRef,
                                                                   _NotesTextbox.Text);
        if (NewProject != null)
            Response.Redirect("ContainerPlanner.aspx");
    }
}
