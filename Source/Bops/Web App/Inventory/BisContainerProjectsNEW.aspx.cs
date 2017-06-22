using System;
using System.Web.UI.WebControls;
using DevExpress.Data;

public partial class Inventory_BisContainerProjectsNEW : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _ProjectsGridviewNEW.SortBy(_ProjectsGridviewNEW.Columns["Project Id"], ColumnSortOrder.Ascending);
    }
}
