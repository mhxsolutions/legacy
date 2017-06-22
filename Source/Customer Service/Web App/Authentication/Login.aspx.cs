using System;
using System.IO;
using BopsDataAccess;
using log4net;
using NHibernate;
using NHibernateUtilities;

public partial class Authentication_Login : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Authentication_Login));

    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";
    private const string _ContextLoginId = "CONTEXT_LOGINID";

    private const string _DwsRepData = "NHibernateDwsRepData.xml.config";

    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Login1_OnLoggedIn(object sender, EventArgs e)
    {
        SessionManager<string> Mgr = new SessionManager<string>();
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
        CopsUserDetails UserDetails = DwsNoRepData.Get<CopsUserDetails>(Login1.UserName);

        if (UserDetails != null)
        {
            Session[_ContextClientId] = UserDetails.ClientFilterDestinationRef;
        }
        else
        {
            Session[_ContextClientId] = _BudwayDestinationId;
        }

        Session[_ContextLoginId] = Login1.UserName;
        Mgr.RemoveAllSessions(false);

        _Log.InfoFormat("User ID {0} logged in, client ID set to {1}", Login1.UserName, Session[_ContextClientId]);
    }
}
