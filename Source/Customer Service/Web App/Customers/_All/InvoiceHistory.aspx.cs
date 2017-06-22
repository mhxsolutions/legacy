using System;
using System.Web;
using System.Web.UI.WebControls;

public partial class Customers__All_InvoiceHistory : System.Web.UI.Page
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";

    protected void Page_Load(object Sender, EventArgs E)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (Session[_ContextClientId] != null)
        {
            // Hide the hidden column if we're not a Budway employee.

            int ClientId = Convert.ToInt32(Session[_ContextClientId]);
            if (ClientId != _BudwayDestinationId)
                GridView1.Columns[2].Visible = false;
        }

        if (IsPostBack) return;
        GridView1.Sort("Date", SortDirection.Descending);
    }
}
