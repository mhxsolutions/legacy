using System;
using BopsBusinessLogicBis;
using BopsDataAccess;

public partial class Inventory_BisStorageCreateSiloAsset : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _NameTextbox.Focus();
    }

    protected void _CreateButton_Click(object Sender, EventArgs E)
    {
        IBisStorage Storage = BisFactory.GetBisStorage();
        int ProductTypeRef = Convert.ToInt32(_ProductTypeDropdownlist.SelectedValue);
        BopsBisStorageAsset NewAsset = Storage.CreateStorageAssetSilo(_NameTextbox.Text, _DescriptionTextbox.Text, ProductTypeRef);
        if (NewAsset != null)
            Response.Redirect("BisStorageAssets.aspx");
    }
}
