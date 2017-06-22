using System;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;

public partial class Monitoring_DriversFuelUsageSummary : System.Web.UI.Page
{
    private void AddAssignFunction()
    {
        StringBuilder S = new StringBuilder(
            "<script type=\"text/javascript\">" + Environment.NewLine +
                "function AssignCard(CardId)" + Environment.NewLine +
                "{" + Environment.NewLine +
                "    window.location = 'DriversFuelCards.aspx?CardId=' + CardId;" + Environment.NewLine +
                "}" + Environment.NewLine
            );

        S.AppendLine("</script>");
        ClientScript.RegisterClientScriptBlock(GetType(), "AssignScript", S.ToString());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        AddAssignFunction();

        if (IsPostBack) return;

        DateTime DateValue = DateTime.Now.Date.AddDays(1);
        EndDateTextbox.Text = DateValue.ToString("d");
        BeginDateTextbox.Text = DateValue.AddDays(-30).ToString("d");

        DriverFuelUsageGridview.Sort("Driver", SortDirection.Ascending);
    }

    protected void DriverFuelUsageGridview_RowDataBound(object Sender, GridViewRowEventArgs E)
    {
        if (E.Row.RowType == DataControlRowType.DataRow)
        {
            // Abort if we can't get the stuff we need for processing.

            LinkButton AssignButton = E.Row.FindControl("AssignLinkbutton") as LinkButton;
            if (AssignButton == null) return;
            DataRowView Row = E.Row.DataItem as DataRowView;
            if (Row == null) return;
            if (Row["Card Id"] == null) return;
            string CardId = Row["Card Id"].ToString().Trim();
            
            // If we don't have a driver, then we need to set the assign link. Otherwise, we set the link button
            // text to an empty string so it doesn't even show up.

            if (Row["Driver"] == DBNull.Value)
            {
                AssignButton.OnClientClick = string.Format("AssignCard('{0}'); return false;", CardId);
            }
            else
            {
                AssignButton.Text = string.Empty;
            }
        }
    }
}
