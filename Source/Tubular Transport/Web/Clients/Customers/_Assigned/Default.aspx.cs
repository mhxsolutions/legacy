using System;

public partial class CustomersAssignedDefault : System.Web.UI.Page
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";
    private const int _BudwayColumnsBegin = 5;

    protected void Page_Load(object Sender, EventArgs E)
    {
        if (Session[_ContextClientId] != null)
        {
            int ClientId = Convert.ToInt32(Session[_ContextClientId]);

            // If the user is not a Budway employee, strip the columns we don't want the user to see.

            if (ClientId != _BudwayDestinationId)
            {
                for (int I = _BudwayColumnsBegin; I < ASPxGridView1.Columns.Count; I++)
                    ASPxGridView1.Columns[I].Visible = false;
                   
            }
        }
        else
        {
            Response.Redirect("~/");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        CopReportExporter.WriteXlsxToResponse();
    }
}
