using System;

namespace Web.Power_Users
{
    public partial class ImpersonateClient : System.Web.UI.Page
    {
        private const int BudwayDestinationId = 166073081;
        private const string ContextClientId = "CONTEXT_CLIENTID";
        private const string ContextImpersonate = "CONTEXT_IMPERSONATE";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            if (Session[ContextImpersonate] != null)
            {
                ImpersonatePanel.Visible = false;
                ClearImpersonatePanel.Visible = true;
            }
            else
            {
                ImpersonatePanel.Visible = true;
                ClearImpersonatePanel.Visible = false;
            }

            ClientDropdownlist.DataBind();
            if (ClientDropdownlist.Items.Count < 1)
            {
                ClientDropdownlist.Visible = false;
                ImpersonateButton.Visible = false;
                NoClientsLabel.Visible = true;
            }
        }

        protected void ImpersonateButton_Click(object sender, EventArgs e)
        {
            var clientIdString = ClientDropdownlist.SelectedValue;
            if (!string.IsNullOrEmpty(clientIdString))
            {
                var clientId = Convert.ToInt32(clientIdString);
                Session[ContextClientId] = clientId;
                Session[ContextImpersonate] = ClientDropdownlist.SelectedItem;
            }

            Response.Redirect("~/");
        }

        protected void ClearImpersonateButton_Click(object sender, EventArgs e)
        {
            Session.Remove(ContextImpersonate);
            Session[ContextClientId] = BudwayDestinationId;
            Response.Redirect("~/");
        }
    }
}