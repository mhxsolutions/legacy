using System;
using System.Web.UI.WebControls;

public partial class Inventory_BisTransactionHistory : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _HistoryGridview.Sort("Tx Id", SortDirection.Ascending);

        if (Request.Params["AssetId"] != null)
        {
            int AssetId = Convert.ToInt32(Request.Params["AssetId"]);
            _TransactionHistoryDatasource.FilterExpression = string.Format("[Origin Id] = {0} OR [Destination Ref] = '{0}'", AssetId);
            _PageTitleLabel.Text = string.Format("Transaction History For Storage Asset {0}", AssetId);
            _ShowAllButton.Visible = true;
        }
    }

    protected void _ShowAllButton_Click(object Sender, EventArgs E)
    {
        Response.Redirect("BisTransactionHistory.aspx");
    }
}
