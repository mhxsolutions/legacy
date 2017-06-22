using System;

namespace Web_App.Customers._Assigned
{
    public partial class Default : System.Web.UI.Page
    {
        private const int BudwayDestinationId = 166073081;
        private const string ContextClientId = "CONTEXT_CLIENTID";
        private const int BudwayColumnsBegin = 3;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session[ContextClientId] != null)
            {
                int clientId = Convert.ToInt32(Session[ContextClientId]);

                // If the user is not a Budway employee, strip the columns we don't want the user to see.

                if (clientId != BudwayDestinationId)
                {
                    for (var i = BudwayColumnsBegin; i < _GridView1.Columns.Count; i++)
                        _GridView1.Columns[i].Visible = false;
                }
            }
            else
            {
                Response.Redirect("~/");
            }
        }
    }
}