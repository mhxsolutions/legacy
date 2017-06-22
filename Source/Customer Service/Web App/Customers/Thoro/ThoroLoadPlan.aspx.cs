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

public partial class Customers_Thoro_ThoroLoadPlan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void export2excel_Click(object Sender, EventArgs E)
    {
        GridViewExporter.Export("BudwayDirect_ThoroDetails.xls", GridView1);
    }
}