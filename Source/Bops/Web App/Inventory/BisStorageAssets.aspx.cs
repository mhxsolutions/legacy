using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class Inventory_BisStorageAssets : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
    }

    protected void _StorageAssetsGridview_RowDataBound(object Sender, GridViewRowEventArgs E)
    {
        if (E.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView RowData = E.Row.DataItem as DataRowView;
            if (RowData == null) return;

            int ProductRef = Convert.ToInt32(RowData["ProductRef"]);
            int Quantity = Convert.ToInt32(RowData["Quantity"]);
            int AssetId = Convert.ToInt32(RowData["Id"]);

            // Abort if we can't get the stuff we need for processing.

            LinkButton TransferLink = E.Row.FindControl("_TransferLinkbutton") as LinkButton;
            if (TransferLink == null) return;
            LinkButton DeactivateLink = E.Row.FindControl("_DeactivateLinkbutton") as LinkButton;
            if (DeactivateLink == null) return;

            TransferLink.PostBackUrl = string.Format("BisStorageTransfer.aspx?AssetId={0}&ProductId={1}", AssetId, ProductRef);
            TransferLink.Visible = (Quantity > 0);

            DeactivateLink.PostBackUrl = string.Format("BisDeactivateStorageAsset.aspx?AssetId={0}", AssetId);
            DeactivateLink.Visible = (Quantity == 0);
        }
    }
}
