using System;
using System.Web.UI.HtmlControls;

// ReSharper disable CheckNamespace
public partial class Administration_AdministrationError : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        // Add a refresh meta-tag to redirect in a few seconds.

        HtmlMeta RefreshTag = new HtmlMeta();
        RefreshTag.HttpEquiv = "refresh";
        RefreshTag.Content = "10; URL=AdministerUsers.aspx";
        Header.Controls.Add(RefreshTag);
    }
}
