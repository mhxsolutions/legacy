using System;
using BopsBusinessLogicBis;
using BopsDataAccess;

public partial class Inventory_BisStorageCreateAssetFromRailcarUkey : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return; // Postbacks should never occur, but what the heck.

        string RailcarUkey = Request.QueryString["Ukey"];
        if (string.IsNullOrEmpty(RailcarUkey)) return;

        IBisStorage Storage = BisFactory.GetBisStorage();
        BopsBisStorageAsset NewAsset = Storage.CreateStorageAssetFromRailcar(RailcarUkey);
        if (NewAsset != null)
            Response.Redirect("BisStorageAssets.aspx");
    }
}
