using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CopsUtilities;

public partial class Customers__All_InventoryOnConsignmentOCTG : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ExportToExcelButton_Click(object sender, EventArgs e)
    {
        GridViewExporter.Export("InventoryConsignmentSummary.xls", GridView1);
    }
}