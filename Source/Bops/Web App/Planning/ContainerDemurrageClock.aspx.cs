using System;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;

public partial class Planning_ContainerDemurrageClock : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _DemurrageGridview.Sort("Remaining", SortDirection.Ascending);
    }

    protected void _DemurrageGridview_RowDataBound(object Sender, GridViewRowEventArgs E)
    {
        if (E.Row.RowType == DataControlRowType.DataRow)
        {
            // Abort if we can't get the stuff we need for processing.

            DataRowView RowData = E.Row.DataItem as DataRowView;
            if (RowData == null) return;

            int HoursLeft = Convert.ToInt32(RowData["Remaining"]);
            if (HoursLeft > 24) return;

            if (HoursLeft < 12)
            {
                E.Row.BackColor = Color.Red;
                E.Row.ForeColor = Color.White;
            }
            else
            {
                E.Row.BackColor = Color.Yellow;
            }
        }
    }
}
