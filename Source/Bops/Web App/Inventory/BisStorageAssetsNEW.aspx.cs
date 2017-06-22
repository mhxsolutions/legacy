using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class Inventory_BisStorageAssetsNEW : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
    }

    protected void _StorageAssetsGridviewNEW_HtmlRowCreated(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
    {
        if (e.RowType == DevExpress.Web.GridViewRowType.Data)
        {
            int ProductRef = Convert.ToInt32(e.GetValue("ProductRef"));
            int Quantity = Convert.ToInt32(e.GetValue("Quantity"));
            int AssetId = Convert.ToInt32(e.GetValue("Id"));

            // Abort if we can't get the stuff we need for processing.

            LinkButton TransferLink = _StorageAssetsGridviewNEW.FindRowCellTemplateControl(e.VisibleIndex, null, "_TransferLinkbutton") as LinkButton;
            if (TransferLink == null) return;
            LinkButton DeactivateLink = _StorageAssetsGridviewNEW.FindRowCellTemplateControl(e.VisibleIndex, null, "_DeactivateLinkbutton") as LinkButton;
            if (DeactivateLink == null) return;
    
            TransferLink.PostBackUrl = string.Format("BisStorageTransfer.aspx?AssetId={0}&ProductId={1}", AssetId, ProductRef);
            TransferLink.Visible = (Quantity > 0);

            DeactivateLink.PostBackUrl = string.Format("BisDeactivateStorageAsset.aspx?AssetId={0}", AssetId);
            DeactivateLink.Visible = (Quantity == 0);
        }
    }
}
