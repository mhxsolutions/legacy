using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;

namespace Web.Clients
{
    public partial class Inventory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            GridViewExporter1.WriteXlsxToResponse();
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            ASPxGridView1.ExpandAll();
        }

        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            ASPxGridView1.CollapseAll();
        }
    }
}