using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Clients.All
{
    public partial class Inbound_Trucks_Scheduled : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            GridViewExporter1.WriteXlsxToResponse();
        }

        protected void ASPxButton1_Click1(object sender, EventArgs e)
        {
            var filename = "Scheduled Inbound Truck Ct " + DateTime.Now.ToString("yyyy-MM-dd HH:mm tt");
            GridViewExporter1.WriteXlsxToResponse(filename, true);
        }
    }
}