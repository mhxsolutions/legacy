using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using BopsDataAccess;
using NHibernate;
using NHibernateUtilities;

public partial class RFS_RfsWizardStakeholders : Page
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
        if (Session[_ContextRfsId] == null)
            Response.Redirect("RfsWizardSelect.aspx");

        if (!IsPostBack)
        {
            StakeholdersGridview.Sort("Client", SortDirection.Ascending);

            SetSelectedRfsLabel();

            if (!User.IsInRole("Power Users") && !User.IsInRole("Administrators"))
            {
                StakeholdersGridview.Columns[2].Visible = false;
                StakeholdersGridview.Columns[3].Visible = false;
                StakeholdersGridview.Columns[4].Visible = false;
                StakeholdersGridview.Columns[5].Visible = false;
                AddNewStakeholderPanel.Visible = false;
            }
        }
    }
    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            RfsStakeholdersDatasource.InsertParameters["ClientRef"].DefaultValue = NewClientDropdown.SelectedValue;
            RfsStakeholdersDatasource.InsertParameters["RoleRef"].DefaultValue = NewRoleDropdown.SelectedValue;
            RfsStakeholdersDatasource.Insert();
        }
    }
}
