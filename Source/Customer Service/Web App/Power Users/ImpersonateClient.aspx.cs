using System;

public partial class Power_Users_ImpersonateClient : System.Web.UI.Page
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";
    private const string _ContextImpersonate = "CONTEXT_IMPERSONATE";

    protected void Page_Load(object Sender, EventArgs E)
    {
        if (Session[_ContextImpersonate] != null)
        {
            ImpersonatePanel.Visible = false;
            ClearImpersonatePanel.Visible = true;
        }
        else
        {
            ImpersonatePanel.Visible = true;
            ClearImpersonatePanel.Visible = false;
        }
    }

    protected void ImpersonateButton_Click(object Sender, EventArgs E)
    {
        string ClientIdString = ClientDropdownlist.SelectedValue;
        if (!string.IsNullOrEmpty(ClientIdString))
        {
            int ClientId = Convert.ToInt32(ClientIdString);
            Session[_ContextClientId] = ClientId;
            Session[_ContextImpersonate] = ClientDropdownlist.SelectedItem;
        }

        Response.Redirect("~/");
    }

    protected void ClearImpersonateButton_Click(object Sender, EventArgs E)
    {
        Session.Remove(_ContextImpersonate);
        Session[_ContextClientId] = _BudwayDestinationId;
        Response.Redirect("~/");
    }
}
