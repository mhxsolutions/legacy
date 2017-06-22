using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_ExportControl : System.Web.UI.UserControl
{
    // FileName="Inventory Detail" GridViewID="ASPxGridView1"

    public string FileName { get; set; }
    public string GridViewID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvExporter.FileName = FileName;
        gvExporter.GridViewID = GridViewID;
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrWhiteSpace(FileName) && !string.IsNullOrWhiteSpace(GridViewID))
        {
            gvExporter.WriteXlsxToResponse(); 
        }
    }
}