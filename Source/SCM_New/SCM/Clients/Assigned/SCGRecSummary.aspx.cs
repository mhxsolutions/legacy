using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Clients.Assigned
{
    public partial class SCGRecSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                deStart.Date = DateTime.Today.AddDays(-1);
                deEnd.Date = DateTime.Today;
                tbInfo.Text = "1 day";
            }
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            GridViewExporter1.WriteXlsxToResponse();
        }
    }
}