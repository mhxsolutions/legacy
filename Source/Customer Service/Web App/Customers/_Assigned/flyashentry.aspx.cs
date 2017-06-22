using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customers__Assigned_flyashentry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ASPxGridView1_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
    {
        //initialize date/time columns to current date/time
        e.NewValues["Arrive"] = DateTime.Now;
        e.NewValues["Scale"] = DateTime.Now;
        e.NewValues["Depart"] = DateTime.Now;
  
    }
}