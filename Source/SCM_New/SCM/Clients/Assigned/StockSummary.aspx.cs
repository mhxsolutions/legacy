using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Clients.Assigned
{
    public partial class StockSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Calendar1.SelectedDate = DateTime.Today;
            }
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            GridViewExporter1.WriteXlsToResponse();
        }
    }
}