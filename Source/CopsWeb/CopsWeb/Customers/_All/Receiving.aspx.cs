using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customers__All_Receiving : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            deStart.Date = DateTime.Today.AddMonths(-1);
            deEnd.Date = DateTime.Today;
        }
    }
}