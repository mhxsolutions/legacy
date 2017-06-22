using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customers__Assigned_SteelscapeOrdersDelivered : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ASPxGridView1_CustomUnboundColumnData(object sender, DevExpress.Web.ASPxGridViewColumnDataEventArgs e)
    {
        ASPxGridView grid = (ASPxGridView)sender;
        int rowIndex = grid.FindVisibleIndexByKeyValue(e.GetListSourceFieldValue("Order #"));

        if (e.Column.FieldName == "InventryRunningBalance")
        {
            string materialNo = Convert.ToString(grid.GetRowValues(rowIndex, "Mat#")).Trim();
            decimal tonsInventory = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(rowIndex, "Tons Inventory"))) ? Convert.ToDecimal(grid.GetRowValues(rowIndex, "Tons Inventory")) : 0;
            decimal tonsOrdered = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(rowIndex, "Tons Ordered"))) ? Convert.ToDecimal(grid.GetRowValues(rowIndex, "Tons Ordered")) : 0;
            decimal tonsDelivered = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(rowIndex, "Tons Delivered"))) ? Convert.ToDecimal(grid.GetRowValues(rowIndex, "Tons Delivered")) : 0;
            decimal tonsComitted = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(rowIndex, "Tons Comitted"))) ? Convert.ToDecimal(grid.GetRowValues(rowIndex, "Tons Comitted")) : 0;
            
            decimal previousBalance = GetPreviousRunningBalance(grid, materialNo, rowIndex);

            e.Value = previousBalance + tonsInventory - (tonsOrdered - tonsDelivered - tonsComitted);
        }
    }

    private decimal GetPreviousRunningBalance(ASPxGridView grid, string materialNo, int rowIndex)
    {
        decimal previousBalance = 0;

        for (int i = rowIndex - 1; i >= 0; i--)
        {
            if (Convert.ToString(grid.GetRowValues(i, "Mat#")).Trim().Equals(materialNo))
            {
                previousBalance = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(i, "InventryRunningBalance"))) ? Convert.ToDecimal(grid.GetRowValues(i, "InventryRunningBalance")) : 0;
                break;
            }
        }
        return previousBalance;
    }

}