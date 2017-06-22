using System;
using System.IO;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using NHibernate;
using NHibernateUtilities;

public partial class RFS_RfsWizardTools : System.Web.UI.Page
{
    private const string _ContextRfsId = "CONTEXT_RFSID";
    private const string _DwsRepData = "NHibernateDwsRepData.xml.config";
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    private void SetSelectedRfsLabel()
    {
        SessionManager<string> Mgr = new SessionManager<string>();
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
        ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
        ISession DwsRepData = Mgr.AddSession(_DwsRepData, ConfigurationFileName);
        BopsRfs Rfs = DwsNoRepData.Get<BopsRfs>(Session[_ContextRfsId]);

        string ShipperName = "(?)", ProductName = "(?)";
        BopsDestination Shipper = DwsRepData.Get<BopsDestination>(Rfs.ShipperRef);
        if (Shipper != null)
            ShipperName = Shipper.Name;
        BopsAtsfProduct Product = DwsRepData.Get<BopsAtsfProduct>(Rfs.CommodityRef);
        if (Product != null)
            ProductName = Product.Name;

        Mgr.RemoveSession(_DwsNoRepData, false);
        Mgr.RemoveSession(_DwsRepData, false);

        SelectedRfsLabel.Text = string.Format("Working with RFS ID {0}: {1}, {2}", Rfs.RfsId, ShipperName, ProductName);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session[_ContextRfsId] == null || (!User.IsInRole("Power Users") && !User.IsInRole("Administrators")))
            Response.Redirect("RfsWizardSelect.aspx");

        if (!IsPostBack)
            SetSelectedRfsLabel();
    }

    private void TransferToValidationPage(int RfsId)
    {
        string TargetUrl = string.Format("RfsValidateSingleRfs.aspx?RfsId={0}", RfsId);
        Response.Redirect(TargetUrl);
    }
    
    protected void ValidateCurrentRfsButton_Click(object sender, EventArgs e)
    {
        int RfsId = Convert.ToInt32(Session[_ContextRfsId]);
        TransferToValidationPage(RfsId);
    }

    protected void DuplicateCurrentRfsButton_Click(object sender, EventArgs e)
    {
        int RfsId = Convert.ToInt32(Session[_ContextRfsId]);

        SessionManager<string> Mgr = new SessionManager<string>();
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

        IRfsDuplicator Duplicator = RfsFactory.GetRfsDuplicator(DwsNoRepData);
        int NewRfsId = Duplicator.DuplicateRfs(RfsId);

        if (NewRfsId > 0)
        {
            Session[_ContextRfsId] = NewRfsId;
            Response.Redirect("RfsWizardMain.aspx");
        }
        else
        {
            TransferToValidationPage(RfsId);
        }
    }
}
