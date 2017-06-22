using System;
using System.IO;
using BopsDataAccess;
using NHibernate;
using NHibernateUtilities;

public partial class Administration_FscForwardToMatrixDetailsEdit : System.Web.UI.Page
{
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
        string RedirectPage = "FscEditMatrices.aspx";

        if (Request.Params["FSCID"] != null)
        {
            int FscId = Convert.ToInt32(Request.Params["FSCID"]);

            SessionManager<string> Mgr = new SessionManager<string>();
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            ISession DwsNoRepSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            BopsFsc Fsc = DwsNoRepSession.Get<BopsFsc>(FscId);
            Mgr.RemoveAllSessions(false);

            switch (Fsc.CostMethodRef)
            {
                // Both of these are float indexed and may be edited by the same page.
                case BopsFsc.FscCostMethod.FuelIndexedPercentOfTransportation:
                case BopsFsc.FscCostMethod.FuelIndexedCentsPerMile:
                    RedirectPage = string.Format("FscEditFloatIndexedDetails.aspx?FSCID={0}", FscId);
                    break;
                case BopsFsc.FscCostMethod.OdLookup:
                    RedirectPage = string.Format("FscEditOdIndexedDetails.aspx?FSCID={0}", FscId);
                    break;
            }
        }

        Context.Response.Redirect(RedirectPage);
    }
}
