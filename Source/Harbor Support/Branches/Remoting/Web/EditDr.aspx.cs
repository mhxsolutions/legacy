using System;
using System.IO;
using System.Web.UI.WebControls;
using BopsDataAccess;
using log4net;
using NHibernate;
using NHibernateUtilities;

public partial class EditDr : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(EditDr));
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void ServerValidateDrId(object sender, ServerValidateEventArgs e)
    {
        bool DrIsValid = false;
        SessionManager<string> Mgr = new SessionManager<string>();

        try
        {
            int Drid;

            if (int.TryParse(DrTextbox.Text, out Drid))
            {
                string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(Drid);
                HopsDrEntry Hdr = DwsNoRepData.Get<HopsDrEntry>(Drid);
                DrIsValid = (Pmdr != null) && (Hdr != null);
            }
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }
        finally
        {
            Mgr.CloseAllSessions(false);
            e.IsValid = DrIsValid;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Request.Browser.IsMobileDevice)
        //    Response.Redirect("~/Mobile/");
    }

    protected void EditButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string RedirectPage = string.Format("EnterDr.aspx?DrId={0}", DrTextbox.Text);
            Context.Response.Redirect(RedirectPage);
        }
    }
}
