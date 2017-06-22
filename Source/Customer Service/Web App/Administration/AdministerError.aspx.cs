using System;
using System.Web.UI.HtmlControls;

public partial class Administration_AdministerError : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Add a refresh meta-tag to redirect in a few seconds.

        HtmlMeta RefreshTag = new HtmlMeta();
        RefreshTag.HttpEquiv = "refresh";
        RefreshTag.Content = "10; URL=AdministerUsers.aspx";
        Header.Controls.Add(RefreshTag);
    }
}
