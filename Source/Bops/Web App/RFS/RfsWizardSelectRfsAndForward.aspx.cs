using System;
using System.Web.UI;
using BopsDataAccess;
using BopsDataConnector;

// ReSharper disable InconsistentNaming
public partial class RFS_RfsWizardSelectRfsAndForward : Page
// ReSharper restore InconsistentNaming
{
    private const string ContextRfsId = "CONTEXT_RFSID";

// ReSharper disable InconsistentNaming
    protected void Page_Load(object sender, EventArgs e)
// ReSharper restore InconsistentNaming
    {
        int rfsId;
        string redirectPage = "RfsWizardSelect.aspx";

        if (Request.Params["RFSID"] != null && int.TryParse(Request.Params["RFSID"], out rfsId))
        {
            IBopsDataConnector dataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsRfs rfs = dataConnector.DwsNoRepData.Get<BopsRfs>(rfsId);

                if (rfs != null)
                {
                    Session[ContextRfsId] = rfsId;
                    string target = Request.Params["Target"] ?? "Main";

                    switch (target)
                    {
                        case "Main":
                            redirectPage = "RfsWizardMain.aspx";
                            break;
                        case "Services":
                            redirectPage = "RfsWizardServices.aspx";
                            break;
                        case "Stakeholders":
                            redirectPage = "RfsWizardStakeholders.aspx";
                            break;

                        default:
                            redirectPage = "RfsWizardMain.aspx";
                            break;
                    }
                }
            }
            finally
            {
                dataConnector.CloseSessions();
            }
        }

        Context.Response.Redirect(redirectPage);
    }
}
