using System;
using System.Web.UI.WebControls;

public partial class Auditing_AuditRfsCalculationResults : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.Sort("Logout Date", SortDirection.Ascending);
        }
    }
}
