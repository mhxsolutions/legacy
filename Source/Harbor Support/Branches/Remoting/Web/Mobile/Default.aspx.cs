using System;
using System.IO;
using System.Web;
using BopsDataAccess;
using log4net;
using NHibernate;
using NHibernateUtilities;
using RunAtServer.Web.UI.WebControls;

public partial class Mobile_Default : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Mobile_Default));
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if ((Request.Params["DrId"] != null) && !IsPostBack)
        {
            int Drid;
            if (int.TryParse(Request.Params["DrId"], out Drid))
            {
                SessionManager<string> Mgr = new SessionManager<string>();

                try
                {
                    string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
                    ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                    HopsDrEntry Dr = DwsNoRepData.Get<HopsDrEntry>(Drid);
                    FlashControl1.FlashVarsCollection.Add(new FlashVarItem("DrId", Drid.ToString()));

                    if (Dr != null)
                    {
                        FlashControl1.FlashVarsCollection.Add(new FlashVarItem("BlId", Dr.ProjectManagerBolRef.ToString()));
                        FlashControl1.FlashVarsCollection.Add(new FlashVarItem("Count", Dr.Count.ToString()));
                        FlashControl1.FlashVarsCollection.Add(new FlashVarItem("Weight", Dr.Weight.ToString()));

                        if (Dr.GatePass != null && Dr.GatePass != string.Empty)
                            FlashControl1.FlashVarsCollection.Add(new FlashVarItem("GatePass", Dr.GatePass));
                        if (Dr.LoadRef != null && Dr.LoadRef != string.Empty)
                            FlashControl1.FlashVarsCollection.Add(new FlashVarItem("LoadRef", Dr.LoadRef));
                        if (Dr.Tractor != null && Dr.Tractor != string.Empty)
                            FlashControl1.FlashVarsCollection.Add(new FlashVarItem("Tractor", Dr.Tractor));
                    }

                    FlashControl1.FlashVarsCollection.Add(new FlashVarItem("Finalized", Dr.Finalized.ToString()));
                }
                catch (Exception e1)
                {
                    _Log.Error(e1);
                }
                finally
                {
                    Mgr.CloseAllSessions(false);
                }
            }
        }

    }
}
