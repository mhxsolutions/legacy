using System;
using System.Data;
using System.Drawing;
using System.Web.Security;
using System.Web.UI.WebControls;
using BopsBusinessLogicBis;
using BopsDataAccess;

public partial class Inventory_BisWithdrawToContainer : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _SourceGridview.Sort("Id", SortDirection.Ascending);
        _ContainerGridview.Sort("Project Id", SortDirection.Ascending);
    }

    protected void _WithdrawButton_Click(object Sender, EventArgs E)
    {
        _SourceErrorLabel.Visible = (_SourceGridview.SelectedValue == null);
        _ContainerErrorLabel.Visible = (_ContainerGridview.SelectedValue == null);

        // Fail if we don't have a selection for storage source or cargo container.

        if (_SourceGridview.SelectedValue == null || _ContainerGridview.SelectedValue == null)
            return;

        // Fail if we can't get a valid user ID to record for the transaction.

        MembershipUser CurrentUser = Membership.GetUser();
        if (CurrentUser == null || string.IsNullOrEmpty(CurrentUser.UserName))
            return;

        BopsBisCpsContainerData FinalData = null;
        if (!_PartialCheckbox.Checked)
        {
            FinalData = new BopsBisCpsContainerData();
            FinalData.SealId = _SealNumberTextbox.Text;
            FinalData.TestId = _TestNumberTextbox.Text;
            FinalData.BillOfLading = _BolTextbox.Text;
        }

        IBisStorage Storage = BisFactory.GetBisStorage();
        bool Success = Storage.LoadContainer(CurrentUser.UserName, Convert.ToInt32(_SourceGridview.SelectedValue),
                                             _ContainerGridview.SelectedValue.ToString(),
                                             Convert.ToDouble(_QuantityTextbox.Text), FinalData);

        _WithrawErrorLabel.Visible = !Success;
        if (!Success) return;

        Response.Redirect("BisWithdrawToContainer.aspx");
    }

    protected void _PartialCheckbox_CheckedChanged(object Sender, EventArgs E)
    {
        _ContainerDetailsPanel.Visible = !_PartialCheckbox.Checked;
        _QuantityTextbox.Focus();
    }
    
    protected void _ContainerGridview_RowDataBound(object Sender, GridViewRowEventArgs E)
    {
        if (E.Row.RowType == DataControlRowType.DataRow)
        {
            // Abort if we can't get the stuff we need for processing.

            DataRowView RowData = E.Row.DataItem as DataRowView;
            if (RowData == null) return;

            int TxCount = Convert.ToInt32(RowData["Tx Count"]);
            if (TxCount < 1) return;

            E.Row.BackColor = Color.Yellow;
        }
    }

    protected void _SourceGridview_SelectedIndexChanged(object Sender, EventArgs E)
    {
        if (_SourceGridview.SelectedValue == null)
        {
            _BookingsPanel.Visible = false;
        }
        else
        {
            _BookingsPanel.Visible = true;
            _BookingsGridview.DataBind();    
        }
    }
}
