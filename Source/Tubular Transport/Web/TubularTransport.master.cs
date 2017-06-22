using System;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BopsDataAccess;
using BopsDataConnector;
using CopsUtilities;

public partial class TubularTransport : System.Web.UI.MasterPage
{
    private const string _ContextClientId = "CONTEXT_CLIENTID";

    public HtmlGenericControl BodyControl
    {
        get { return Body; }
    }

    public Menu TreeViewControl
    {
        get { return _TopMenu; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        CopsSiteMapProvider.SetWebApplicationRootDirectory(Request.PhysicalApplicationPath);

        if (IsPostBack) return;
        if (Session[_ContextClientId] == null) return;

        int ClientId = Convert.ToInt32(Session[_ContextClientId]);
        IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector(false);

        try
        {
            BopsDestination Client = DataConnector.DwsRepData.Load<BopsDestination>(ClientId);
            _UserLabel.Text = Client.ToString();
        }
        finally
        {
            DataConnector.CloseSessions();
        }
    }
    protected void _TopMenu_MenuItemClick(object sender, System.Web.UI.WebControls.MenuEventArgs e)
    {

    }
}
