using System;
using System.IO;
using System.Web.UI.WebControls;
using BopsDataAccess;
using log4net;
using NHibernate;
using NHibernateUtilities;

public partial class Monitoring_DriversFuelCards : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Monitoring_DriversFuelCards));

    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        DriverFuelCardsGridview.Sort("Driver", SortDirection.Ascending);

        if (Request.Params["CardId"] == null) return;

        CardIdTextbox.Text = Request.Params["CardId"];
        DriversDropdownlist.Focus();
    }

    protected void ServerValidateNewValue(object Sender, ServerValidateEventArgs E)
    {
        bool Valid = false;
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        SessionManager<string> Mgr = new SessionManager<string>();

        try
        {
            ISession DwsNoRepSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

            BopsFuelCardDriverAssignment ExistingAssignment = DwsNoRepSession.Get<BopsFuelCardDriverAssignment>(CardIdTextbox.Text);
            if (ExistingAssignment == null)
            {
                Valid = true;
            }
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }
        finally
        {
            E.IsValid = Valid;
            Mgr.RemoveAllSessions(false);
        }
    }

    protected void AddButton_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        DriverFuelCardsDatasource.InsertParameters["CardId"].DefaultValue = CardIdTextbox.Text;
        DriverFuelCardsDatasource.InsertParameters["DriverId"].DefaultValue = DriversDropdownlist.SelectedValue;
        DriverFuelCardsDatasource.Insert();
    }
}
