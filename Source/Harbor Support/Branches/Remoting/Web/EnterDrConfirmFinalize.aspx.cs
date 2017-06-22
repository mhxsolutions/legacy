using System;
using System.IO;
using System.Web.UI;
using BopsDataAccess;
using log4net;
using NHibernate;
using NHibernateUtilities;

public partial class EnterDrConfirmFinalize : Page
{
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";
    private static readonly ILog _Log = LogManager.GetLogger(typeof(EnterDr));

    protected void Page_Load(object sender, EventArgs e)
    {
        int Drid;
        if (!int.TryParse(Request.Params["DrId"], out Drid))
        {
            _Log.ErrorFormat("Bad DRID {0} passed to confirm page", Request.Params["DrId"]);
            Context.Response.Redirect("EnterDrError.aspx");
        }
    }

    protected void ConfirmButton_Click(object sender, EventArgs e)
    {
        bool CommitChanges = false;
        SessionManager<string> Mgr = new SessionManager<string>();
        string RedirectPage = "EnterDr.aspx";

        try
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            Mgr.BeginTransaction(_DwsNoRepData);

            int Drid;
            int.TryParse(Request.Params["DrId"], out Drid);
            HopsDrEntry DrEntry = DwsNoRepData.Get<HopsDrEntry>(Drid);

            BopsLoad Load = DwsNoRepData.Get<BopsLoad>(DrEntry.LoadRef);
            BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(Drid);
            Pmdr.Count = DrEntry.Count;
            Pmdr.Weight = DrEntry.Weight;
            Pmdr.LoadKeyRef = Load.LoadKey;
            Pmdr.GatePass = DrEntry.GatePass;
            DwsNoRepData.Update(Pmdr);

            DrEntry.Finalized = true;
            DwsNoRepData.SaveOrUpdateCopy(DrEntry);

            CommitChanges = true;
        }
        catch (Exception e1)
        {
            RedirectPage = "EnterDrError.aspx";
            _Log.Debug("An exception occured, details follow.", e1);
        }
        finally
        {
            Mgr.CloseAllSessions(CommitChanges);
            Context.Response.Redirect(RedirectPage);
        }
    }

    protected void CancelButton_Click(object sender, EventArgs e)
    {
        string RedirectPage = string.Format("EnterDr.aspx?DrId={0}", Request.Params["DrId"]);
        Context.Response.Redirect(RedirectPage);
    }
}
