using System;
using System.IO;
using BopsDataAccess;
using NHibernate;
using NHibernateUtilities;

public partial class Auditing_AuditRfsCalculationResultsResolveNoService : System.Web.UI.Page
{
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";
    //private const string _DwsRepData = "NHibernateDwsRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Params["DocumentId"] == null)
            Response.Redirect("AuditRfsCalculationResults.aspx");

        /*
        if (!IsPostBack)
        {
            string LoadRef = Request.Params["LoadRef"];

            SessionManager<string> Mgr = new SessionManager<string>();
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

            //ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
            //ISession DwsRepData = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

            BopsLoad Load = DwsNoRepData.Get<BopsLoad>(LoadRef);
            if (Load != null)
            {
                if (Load.RfsRef.HasValue)
                {
                    BopsRfs Rfs = DwsNoRepData.Get<BopsRfs>(Load.RfsRef.Value);


                }
            }
        }
         */
    }
}
