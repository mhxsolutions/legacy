using System;
using System.Web;

public partial class Administration_DestinationSets : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }

    protected void _CreateButton_Click(object Sender, EventArgs E)
    {
        _SetsDatasource.InsertParameters["Name"].DefaultValue = _NewSetNameTextbox.Text;
        _SetsDatasource.Insert();
        _NewSetNameTextbox.Text = string.Empty;
    }
}
