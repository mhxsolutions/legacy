using System;
using BopsBusinessLogicBis;

public partial class Inventory_BisDeactivateStorageAsset : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return; // Postbacks should never occur, but what the heck.

        if (Request.QueryString["AssetId"] == null) return;
        int AssetId = Convert.ToInt32(Request.QueryString["AssetId"]);
        if (AssetId < 1) return;

        IBisStorage Storage = BisFactory.GetBisStorage();
        if (Storage.DeactivateStorageAsset(AssetId))
            Response.Redirect("BisStorageAssets.aspx");
    }
}
