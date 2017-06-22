using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Clients.All
{
    public partial class InboundDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            var filename = "Inbound Detail " + DateTime.Now.ToString("yyyy-MM-dd HH:mm tt");
            GridViewExporter1.WriteXlsxToResponse(filename, true);
        }
        protected void button1_Click(object sender, EventArgs e)
        {

        }
    }
}