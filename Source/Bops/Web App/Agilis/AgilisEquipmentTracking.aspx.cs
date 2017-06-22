using System;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Agilis_AgilisEquipmentTracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Add a refresh meta-tag to redraw the page every ten minutes.

            HtmlMeta RefreshTag = new HtmlMeta();
            RefreshTag.HttpEquiv = "refresh";
            RefreshTag.Content = "600";
            Header.Controls.Add(RefreshTag);

            GridView1.Sort("Equipment_ID", SortDirection.Ascending);
        }
    }

    protected void DropDownLists_PreRender(object sender, EventArgs e)
    {
        DropDownList TheList = sender as DropDownList;
        if (TheList != null)
        {
            if (TheList.Items.Count > 0 && TheList.Items[0].Text != "All")
                TheList.Items.Insert(0, new ListItem("All", ""));
        }
    }

    protected void ClearFiltersButton_Click(object sender, EventArgs e)
    {
        EquipmentIdFilterDropDownList.SelectedIndex = 0;
        EquipmentTypeFilterDropDownList.SelectedIndex = 0;
        DriverFilterDropDownList.SelectedIndex = 0;
    }
}
