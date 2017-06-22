using System;
using System.Web.Security;
using BopsBusinessLogicBis;

public partial class Inventory_BisStorageTransfer : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _QuantityTextbox.Focus();

        if (_OriginGridview.Rows.Count == 1)
        {
            string QuantityText = _OriginGridview.Rows[0].Cells[5].Text;
            double Quantity = Convert.ToDouble(QuantityText);
            _QuantityTextbox.Text = Quantity.ToString();
        }
    }

    protected void _TransferButton_Click(object Sender, EventArgs E)
    {
        _DestinationErrorLabel.Visible = (_DestinationGridview.SelectedValue == null);

        if (_DestinationGridview.SelectedValue == null)
            return;

        MembershipUser CurrentUser = Membership.GetUser();
        if (CurrentUser == null || string.IsNullOrEmpty(CurrentUser.UserName))
            return;

        int AssetId = Convert.ToInt32(Request.Params["AssetId"]);
        int DestinationId = Convert.ToInt32(_DestinationGridview.SelectedValue);
        double Quantity = Convert.ToDouble(_QuantityTextbox.Text);

        IBisStorage Storage = BisFactory.GetBisStorage();
        if (Storage.Transfer(CurrentUser.UserName, AssetId, DestinationId, Quantity))
            Response.Redirect("BisStorageAssets.aspx");
        else
            _TransferErrorLabel.Visible = true;
    }
}
