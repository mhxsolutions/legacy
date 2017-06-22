using System;
using System.Data;
using System.IO;
using System.Web.UI;
using BopsDataAccess;
using NHibernate;
using NHibernateUtilities;

public partial class RFS_RfsWizardStakeholderReferences : Page
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
        if (!IsPostBack)
        {
            if (Session[_ContextRfsId] != null)
                SetSelectedRfsLabel();

            // Configure the spreadsheet control columns. Hide the first two, which contain keys, 
            // and set the widths for the type and reference columns that follow.

            FpSpread1.Sheets[0].Columns[0].Visible = false;
            FpSpread1.Sheets[0].Columns[1].Visible = false;
            FpSpread1.Sheets[0].Columns[2].Width = 250;
            FpSpread1.Sheets[0].Columns[3].Width = 375;

            // Use the data from the SqlDataSource defined on the page to set the stakeholder name 
            // and role into the header. This reminds the user which stakeholder he's editing.

            DataSourceSelectArguments args = new DataSourceSelectArguments();
            DataView view = StakeholderDetails.Select(args) as DataView;
            if (view != null)
            {
                string Client = view[0].Row["Client"].ToString();
                string Role = view[0].Row["Role"].ToString();
                StakeholderDetailsLabel.Text = Client + " (" + Role + ")";
            }
            else
            {
                Response.Redirect("RfsWizardStakeholderError.aspx");
            }
        }
    }
}
