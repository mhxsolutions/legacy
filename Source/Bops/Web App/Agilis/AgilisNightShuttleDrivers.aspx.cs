using System;
using System.Web.UI.WebControls;
using log4net;

public partial class Agilis_AgilisNightShuttleDrivers : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Agilis_AgilisNightShuttleDrivers));

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.Sort("LastName, FirstName", SortDirection.Ascending);
        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeletedEventArgs e)
    {
        // After a delete, we refresh the new driver list. The point is to prevent a driver already 
        // on the list from showing up in the dropdownlist.

        NewDriverList.DataBind();
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            // I'm not sure why, but refreshing the page sometimes triggers the insert. And if the
            // other code hasn't correctly eliminated the names already on the list from the dropdown,
            // an exception can occur. As such, I've wrapped the insert in a try/catch block to prevent
            // unhelpful errors from accidental primary key duplication.

            try
            {
                NightShuttleDriversDatasource.Insert();
                NewDriverList.DataBind();
            }
            catch (Exception e1)
            {
                _Log.Error("An exception occured, details follow.", e1);
            }
        }
    }
}
