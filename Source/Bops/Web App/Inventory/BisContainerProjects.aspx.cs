using System;
using System.Web.UI.WebControls;

public partial class Inventory_BisContainerProjects : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _ProjectsGridview.Sort("Project Id", SortDirection.Ascending);
    }
}
