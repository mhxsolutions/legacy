using System;
using System.Web.UI.WebControls;

public partial class LookupStartTimes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.Sort("Plan Date", SortDirection.Ascending);
        }

        Page.Form.DefaultButton = LookupButton.UniqueID;
        Page.Form.DefaultFocus = IdTextbox.ClientID;
    }

    protected void LookupButton_Click(object sender, EventArgs e)
    {
    }
}
