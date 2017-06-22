using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Clients.Assigned
{
    public partial class Cycle_Count_Stock : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            var filename = "CycleCount " + DateTime.Now.ToString("yyyy-MM-dd HH:mm tt");
            GridViewExporter1.WritePdfToResponse(filename, true);
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            var filename = "CycleCountYard " + DateTime.Now.ToString("yyyy-MM-dd HH:mm tt");
            GridViewExporter2.WritePdfToResponse(filename, true);
        }

        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            var filename = "CycleCount " + DateTime.Now.ToString("yyyy-MM-dd HH:mm tt");
            GridViewExporter1.WriteXlsxToResponse(filename, true);
        }
    }
}