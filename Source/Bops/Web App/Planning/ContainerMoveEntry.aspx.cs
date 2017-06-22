using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using BopsBusinessLogicPlanning;
using BopsDataAccess;

public partial class Planning_ContainerMoveEntry : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        // If there are no active container projects, we can't enter data for them. In such a case, bail to 
        // the page that displays an error.

        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
        int ActiveProjectCount = ContainerPlanner.GetActiveProjectCount();
        if (ActiveProjectCount < 1)
            Response.Redirect("ContainerMoveEntryFailureNoProjects.aspx");

        bool ProjectSetViaQueryString = false;

        if (!IsPostBack)
        {
            // If we were given a project ID to start with via a query string, select it. Otherwise, select the
            // first project in the list.

            _ProjectDropdownlist.DataBind();
            if (Request.QueryString["ProjectId"] != null)
            {
                int ProjectId = Convert.ToInt32(Request.QueryString["ProjectId"]);
                SelectByIntValue(_ProjectDropdownlist, ProjectId);
                ProjectSetViaQueryString = true;
            }
            else
            {
                _ProjectDropdownlist.Items[0].Selected = true;
            }

            _MoveTypeRadiobuttonlist.SelectedIndex = 0;
            _DepartedDateTextbox.Text = _ArrivedDateTextbox.Text = DateTime.Now.ToShortDateString();
        }

        _MoveTypeRadiobuttonlist.Attributes.Add("onClick", "javascript:SetOdPair()");
        int SelectedProjectId = Convert.ToInt32(_ProjectDropdownlist.SelectedValue);
        _OriginDropdownlist.DataBind();
        _DestinationDropdownlist.DataBind();
        SelectOriginAndDestinationFromProject(SelectedProjectId);

        // If we set the project ID from the query string, then we assume the user wants to start right in
        // with the pickup request ID instead.

        if (ProjectSetViaQueryString)
            _PickupRequestIdTextbox.Focus();
        else
            _ProjectDropdownlist.Focus();

        Page.Form.DefaultButton = _EnterMoveButton.UniqueID;
    }

    private static void SelectByIntValue(DropDownList TheList, int ValueToSelect)
    {
        TheList.ClearSelection();

        foreach (ListItem Item in TheList.Items)
        {
            int ItemValue = Convert.ToInt32(Item.Value);
            if (ItemValue != ValueToSelect) continue;

            Item.Selected = true;
            break;
        }
    }

    protected void ServerValidateContainerId(object Sender, ServerValidateEventArgs E)
    {
        // This was originally done via a regular expression validator, but it kept rejecting
        // perfectly valid input data, so I moved it here. I've subsequently added Javascript
        // regular expression validation that actually works on the client side, but I see no
        // reason not to leave the back-end check as well.

        string InputData = _ContainerIdTextbox.Text.ToUpper();
        Regex Rx = new Regex("[A-Z]{4}[0-9]{7}");
        if (string.IsNullOrEmpty(_ContainerIdTextbox.Text) || !Rx.Match(InputData).Success)
        {
            _ContainerIdCustomValidator.ErrorMessage = "Must be four letters and seven numbers";
            E.IsValid = false;
            return;
        }

        // If the ID looks to be of a valid form, then we assume it's good and validate against
        // the type of move as possible.

        E.IsValid = true;
        int ProjectId = Convert.ToInt32(_ProjectDropdownlist.SelectedValue);
        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();

        switch (_MoveTypeRadiobuttonlist.SelectedIndex)
        {
            case 0:     // Pickup and deliver
                DemurrageDetails NullDemurrage = ContainerPlanner.GetDemurrageDetails(ProjectId, InputData, false);
                if (NullDemurrage != null)
                {
                    _ContainerIdCustomValidator.ErrorMessage = "Container has already been picked up";
                    E.IsValid = false;
                }
                break;
            case 1:     // Return container
                DemurrageDetails RequiredDemurrage = ContainerPlanner.GetDemurrageDetails(ProjectId, InputData, false);
                if (RequiredDemurrage == null)
                {
                    _ContainerIdCustomValidator.ErrorMessage = "Not picked up";
                    E.IsValid = false;
                    return;
                }
                if (RequiredDemurrage.Demurrage.ClockEnd.HasValue)
                {
                    _ContainerIdCustomValidator.ErrorMessage = "Already returned";
                    E.IsValid = false;
                    return;
                }
                break;
            default:    // Custom move
                break;
        }
    }

    protected void ServerValidatePickupRequestId(object Sender, ServerValidateEventArgs E)
    {
        bool Valid = false;
        int PickupRequestId;

        if (int.TryParse(_PickupRequestIdTextbox.Text, out PickupRequestId))
        {
            IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
            BopsPickupRequest Pur = ContainerPlanner.GetPickupRequest(PickupRequestId);
            Valid = (Pur != null);
        }

        E.IsValid = Valid;
    }

    protected void ServerValidateDepartedDate(object Sender, ServerValidateEventArgs E)
    {
        DateTime ParseTarget;
        E.IsValid = DateTime.TryParse(_DepartedDateTextbox.Text, out ParseTarget);
    }

    protected void ServerValidateDepartedTime(object Sender, ServerValidateEventArgs E)
    {
        DateTime ParseTarget;
        E.IsValid = !string.IsNullOrEmpty(_DepartedTimeTextbox.Text) &&
            DateTime.TryParse(_DepartedTimeTextbox.Text, out ParseTarget);
    }

    protected void ServerValidateArrivedDate(object Sender, ServerValidateEventArgs E)
    {
        DateTime ParseTarget;
        E.IsValid = DateTime.TryParse(_ArrivedDateTextbox.Text, out ParseTarget);
    }

    protected void ServerValidateArrivedTime(object Sender, ServerValidateEventArgs E)
    {
        E.IsValid = false;
        _ArriveTimeCustomValidator.ErrorMessage = "Arrived time is invalid";

        // If we can't parse the arrived time itself, then we've failed.

        DateTime ArrivedTime;
        if (!DateTime.TryParse(_ArrivedTimeTextbox.Text, out ArrivedTime))
            return;

        // If we have values for the other fields that may be parsed, then we check them to make
        // sure we're not arriving before we depart or entering times in the future.

        DateTime DepartedDate, DepartedTime, ArrivedDate;
        DateTime? FinalDepart = null, FinalArrive = null;

        if (DateTime.TryParse(_DepartedDateTextbox.Text, out DepartedDate) && 
            DateTime.TryParse(_DepartedTimeTextbox.Text, out DepartedTime) &&
            DateTime.TryParse(_ArrivedDateTextbox.Text, out ArrivedDate))
        {
            FinalDepart = DepartedDate.Date + (DepartedTime - DepartedTime.Date);
            FinalArrive = ArrivedDate.Date + (ArrivedTime - ArrivedTime.Date);
            if (FinalDepart.Value >= DateTime.Now || FinalArrive.Value >= DateTime.Now || FinalArrive.Value <= FinalDepart.Value)
                return;
        }

        // Finally, if we've made it this far we need to do a final check if we're returning a
        // container to make sure we're not returning it before it was picked up.

        if (_MoveTypeRadiobuttonlist.SelectedIndex == 1)
        {
            int ProjectId = Convert.ToInt32(_ProjectDropdownlist.SelectedValue);
            IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
            IList<BopsCpsMovement> Movements = ContainerPlanner.GetContainerMovements(ProjectId, _ContainerIdTextbox.Text);

            if (Movements != null && FinalDepart != null && FinalArrive != null)
            {
                foreach (BopsCpsMovement Movement in Movements)
                {
                    if (Movement.OverlapsInterval(FinalDepart.Value, FinalArrive.Value))
                    {
                        _ArriveTimeCustomValidator.ErrorMessage = "Times overlap previous moves";
                        return;
                    }
                }
            }
        }

        E.IsValid = true;
    }

    private void SelectOriginAndDestinationFromProject(int ProjectId)
    {
        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();
        BopsCpsProject Project = ContainerPlanner.GetProject(ProjectId);
        if (Project == null) throw new ArgumentException(string.Format("Invalid project ID value {0}", Project), "ProjectId");

        switch (_MoveTypeRadiobuttonlist.SelectedIndex)
        {
            case 0:     // Pickup and deliver
                SelectByIntValue(_OriginDropdownlist, Project.DefaultOriginRef);
                SelectByIntValue(_DestinationDropdownlist, Project.DefaultDestinationRef);
                break;
            case 1:     // Return container
                SelectByIntValue(_OriginDropdownlist, Project.DefaultDestinationRef);
                SelectByIntValue(_DestinationDropdownlist, Project.DefaultOriginRef);
                break;
            default:    // Custom move
                break;
        }

        // Any time we set the values from the project ID, we make sure the JavaScript variables are
        // defined for use by client script.

        StringBuilder S = new StringBuilder(
            "<script type=\"text/javascript\">" + Environment.NewLine +
            "var origRef = " + Project.DefaultOriginRef + ";" + Environment.NewLine +
            "var destRef = " + Project.DefaultDestinationRef + ";" + Environment.NewLine +
            "</script>");
        ClientScript.RegisterClientScriptBlock(GetType(), "OdVariables", S.ToString());
    }

    protected void _EnterMoveButton_Click(object Sender, EventArgs E)
    {
        if (!Page.IsValid) return;

        int ProjectId = Convert.ToInt32(_ProjectDropdownlist.SelectedValue);
        int PickupRequestId = Convert.ToInt32(_PickupRequestIdTextbox.Text);

        DemurrageClockOperationType ClockOperation;
        switch (_MoveTypeRadiobuttonlist.SelectedIndex)
        {
            case 0:     // Pickup and deliver
                ClockOperation = DemurrageClockOperationType.StartClock;
                break;
            case 1:     // Return container
                ClockOperation = DemurrageClockOperationType.StopClock;
                break;
            default:    // Custom move
                ClockOperation = DemurrageClockOperationType.None;
                break;
        }

        int OriginRef = Convert.ToInt32(_OriginDropdownlist.SelectedValue);
        int DestinationRef = Convert.ToInt32(_DestinationDropdownlist.SelectedValue);

        DateTime DepartedDate = DateTime.Parse(_DepartedDateTextbox.Text);
        DateTime DepartedTime = DateTime.Parse(_DepartedTimeTextbox.Text);
        DateTime ArrivedDate = DateTime.Parse(_ArrivedDateTextbox.Text);
        DateTime ArrivedTime = DateTime.Parse(_ArrivedTimeTextbox.Text);
        DateTime FinalDepart = DepartedDate.Date + (DepartedTime - DepartedTime.Date);
        DateTime FinalArrive = ArrivedDate.Date + (ArrivedTime - ArrivedTime.Date);

        IContainerProjectPlanner ContainerPlanner = PlanningFactory.GetContainerProjectPlanner();

        if (ContainerPlanner.CreateContainerMove(ProjectId, PickupRequestId, _ContainerIdTextbox.Text.ToUpper(), OriginRef, FinalDepart, DestinationRef, FinalArrive, ClockOperation))
            Response.Redirect(string.Format("ContainerMoveEntry.aspx?ProjectId={0}", ProjectId));
    }

    protected void _ProjectDropdownlist_SelectedIndexChanged(object Sender, EventArgs E)
    {
        int SelectedProjectId = Convert.ToInt32(_ProjectDropdownlist.SelectedValue);
        _MoveTypeRadiobuttonlist.SelectedIndex = 0;
        SelectOriginAndDestinationFromProject(SelectedProjectId);
    }
}
