using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using CopsUtilities;

public partial class Customers__All_InventoryOnConsignment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ExportToExcelButton_Click(object sender, EventArgs e)
    {
        //GridViewExporter.Export("InventoryConsignmentSummary.xls", GridView1);
        InvenConsigExprot.WriteXlsxToResponse();
    }
}
