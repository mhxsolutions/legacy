using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

public partial class RFS_RfsWizardServices : Page
{
    private const string _ContextRfsId = "CONTEXT_RFSID";
    private const string _DwsRepData = "NHibernateDwsRepData.xml.config";
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    private void SetSelectedRfsLabel(ISession DwsNoRepData, ISession DwsRepData)
    {
        BopsRfs Rfs = DwsNoRepData.Get<BopsRfs>(Session[_ContextRfsId]);

        string ShipperName = "(?)", ProductName = "(?)";
        BopsDestination Shipper = DwsRepData.Get<BopsDestination>(Rfs.ShipperRef);
        if (Shipper != null)
            ShipperName = Shipper.Name;
        BopsAtsfProduct Product = DwsRepData.Get<BopsAtsfProduct>(Rfs.CommodityRef);
        if (Product != null)
            ProductName = Product.Name;

        SelectedRfsLabel.Text = string.Format("Working with RFS ID {0}: {1}, {2}", Rfs.RfsId, ShipperName, ProductName);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session[_ContextRfsId] == null)
            Response.Redirect("RfsWizardSelect.aspx");

        if (!IsPostBack)
        {
            SessionManager<string> Mgr = new SessionManager<string>();
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
            ISession DwsRepData = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

            if (Session[_ContextRfsId] != null)
                SetSelectedRfsLabel(DwsNoRepData, DwsRepData);

            ServicesGridview.Sort("Service Category", SortDirection.Ascending);    

            if (User.IsInRole("Power Users") || User.IsInRole("Administrators"))
            {
                // If it seems screw that we remove the invalid links only for power users and 
                // administrators, the reason is that the links are only visible in the first
                // place for said groups. The links are hidden via a LoginView control for non-
                // privileged users.

                RemoveInvalidServiceAdditionLinks(DwsNoRepData);
            }
            else
            {
                ServicesGridview.Columns[11].Visible = false;
                ServicesGridview.Columns[12].Visible = false;
            }

            Mgr.RemoveSession(_DwsNoRepData, false);
            Mgr.RemoveSession(_DwsRepData, false);
        }
    }

    private void RemoveInvalidServiceAdditionLinks(ISession DwsNoRepData)
    {
        IList<BopsRfsStakeholder> Stakeholders = DwsNoRepData.CreateCriteria(typeof (BopsRfsStakeholder))
            .Add(Expression.Eq("RfsRef", Session[_ContextRfsId]))
            .List<BopsRfsStakeholder>();
        int[] Counts = new int[(int)BopsRfsStakeholderRoleType.BillTo + 1];
        foreach (BopsRfsStakeholder stakeholder in Stakeholders)
            Counts[(int)stakeholder.RoleRef]++;

        // Remove the transportation link if we don't have bill-to, receiver, and origin stakeholders.
        // The destination can be indeterminate, and if we don't have any destintions, we hide the 
        // destination selection box.

        if (Counts[(int)BopsRfsStakeholderRoleType.BillTo] < 1 ||
            Counts[(int)BopsRfsStakeholderRoleType.Receiver] < 1 ||
            Counts[(int)BopsRfsStakeholderRoleType.Origin] < 1)
        {
            LoginView1.FindControl("AddTransportationHyperlink").Visible = false;
        }

        // Remove the warehouse link if we don't have bill-to, receiver, origin, and destination stakeholders.

        if (Counts[(int)BopsRfsStakeholderRoleType.BillTo] < 1 || Counts[(int)BopsRfsStakeholderRoleType.Receiver] < 1)
        {
            LoginView1.FindControl("AddWarehouseHyperlink").Visible = false;
        }

        // Remove the assessorial link if we don't have bill-to, receiver, origin, and destination stakeholders.

        if (Counts[(int)BopsRfsStakeholderRoleType.BillTo] < 1)
        {
            LoginView1.FindControl("AddAssessorialHyperlink").Visible = false;
        }
    }
}
