using System;
using System.Web.Security;
using BopsBusinessLogicBis;
using BopsDataAccess;

public partial class Inventory_BisAdjustStorageAssetQuantity : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
    }

    protected void _AdjustTypeRadiobuttonlist_SelectedIndexChanged(object Sender, EventArgs E)
    {
        bool ShowAmount;

        switch (_AdjustTypeRadiobuttonlist.SelectedIndex)
        {
            case 1:     // Deposit
                ShowAmount = true;
                _QuantityLabel.Text = "Amount to Deposit:";
                break;
            case 2:     // Withdraw
                ShowAmount = true;
                _QuantityLabel.Text = "Amount to Withdraw:";
                break;

            default:
                ShowAmount = false;
                break;
        }

        _AmountPanel.Visible = ShowAmount;
        _QuantityTextbox.CausesValidation = ShowAmount;
    }

    protected void _AdjustButton_Click(object Sender, EventArgs E)
    {
        if (_SourceGridview.SelectedValue == null)
        {
            _SourceErrorLabel.Visible = true;
            return;
        }

        // Fail if we can't get a valid user ID to record for the transaction.

        MembershipUser CurrentUser = Membership.GetUser();
        if (CurrentUser == null || string.IsNullOrEmpty(CurrentUser.UserName))
            return;

        double Amount;

        switch (_AdjustTypeRadiobuttonlist.SelectedIndex)
        {
            case 1:     // Deposit
                Amount = Convert.ToDouble(_QuantityTextbox.Text);
                break;
            case 2:     // Withdraw
                Amount = -Convert.ToDouble(_QuantityTextbox.Text);
                break;

            default:
                Amount = 0;
                break;
        }

        IBisStorage Storage = BisFactory.GetBisStorage();
        bool Success = Storage.AdjustStorageAsset(CurrentUser.UserName, Convert.ToInt32(_SourceGridview.SelectedValue), Amount);
        _AdjustErrorLabel.Visible = !Success;
        if (!Success) return;

        Response.Redirect("BisAdjustStorageAssetQuantity.aspx");
    }
}
