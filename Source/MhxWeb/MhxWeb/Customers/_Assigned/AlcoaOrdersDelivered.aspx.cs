using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customers__Assigned_AlcoaOrdersDelivered : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ASPxGridView2_CustomUnboundColumnData(object sender, DevExpress.Web.ASPxGridViewColumnDataEventArgs e)
    {
        ASPxGridView grid = (ASPxGridView)sender;
        int rowIndex = grid.FindVisibleIndexByKeyValue(e.GetListSourceFieldValue("Order #"));

        if (e.Column.FieldName == "InventryRunningBalance")
        {
            string materialNo = Convert.ToString(grid.GetRowValues(rowIndex, "Mat#")).Trim();
            decimal balanceToDeliver = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(rowIndex, "Net Ton Balance to Deliver over/(short)"))) ? Convert.ToDecimal(grid.GetRowValues(rowIndex, "Net Ton Balance to Deliver over/(short)")) : 0;
            decimal committed = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(rowIndex, "Net Tons Committed"))) ? Convert.ToDecimal(grid.GetRowValues(rowIndex, "Net Tons Committed")) : 0;
            decimal previousBalance = GetPreviousRunningBalance(grid, materialNo, rowIndex);

            e.Value = balanceToDeliver + committed + previousBalance;
        }
    }

    private decimal GetPreviousRunningBalance(ASPxGridView grid, string materialNo, int rowIndex)
    {
        decimal previousBalance = 0;
        bool foundPriviousRecord = false;

        for (int i = rowIndex - 1; i >= 0; i--)
        {
            if (Convert.ToString(grid.GetRowValues(i, "Mat#")).Trim().Equals(materialNo))
            {
                previousBalance = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(i, "InventryRunningBalance"))) ? Convert.ToDecimal(grid.GetRowValues(i, "InventryRunningBalance")) : 0;
                foundPriviousRecord = true;
                break;
            }
        }
        if (!foundPriviousRecord)
        {
            previousBalance = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(rowIndex, "Net Tons Inventory"))) ? Convert.ToDecimal(grid.GetRowValues(rowIndex, "Net Tons Inventory")) : 0;
        }
        return previousBalance;
    }

}