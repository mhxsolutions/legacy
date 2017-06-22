using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using BopsDataAccess;
using NHibernate;
using NHibernateUtilities;

// ReSharper disable InconsistentNaming
namespace RFS
{
    public partial class RFS_RfsSelect : Page
// ReSharper restore InconsistentNaming
    {
        private const string ContextRfsId = "CONTEXT_RFSID";
        private const string DwsRepData = "NHibernateDwsRepData.xml.config";
        private const string DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

        private void SetSelectedRfsLabel()
        {
            SessionManager<string> mgr = new SessionManager<string>();
            string configurationFileName = Path.Combine(Request.PhysicalApplicationPath, RFS_RfsSelect.DwsNoRepData);
            ISession dwsNoRepData = mgr.AddSession(DwsNoRepData, configurationFileName);
            if (Request != null)
                configurationFileName = Path.Combine(Request.PhysicalApplicationPath, RFS_RfsSelect.DwsRepData);
            ISession dwsRepData = mgr.AddSession(DwsRepData, configurationFileName);
            BopsRfs rfs = dwsNoRepData.Get<BopsRfs>(Session[ContextRfsId]);

            string shipperName = "(?)", productName = "(?)";
            BopsDestination shipper = dwsRepData.Get<BopsDestination>(rfs.ShipperRef);
            if (shipper != null)
                shipperName = shipper.Name;
            BopsAtsfProduct product = dwsRepData.Get<BopsAtsfProduct>(rfs.CommodityRef);
            if (product != null)
                productName = product.Name;

            mgr.RemoveSession(DwsNoRepData, false);
            mgr.RemoveSession(DwsRepData, false);

            SelectedRfsLabel.Text = string.Format("Working with RFS ID {0}: {1}, {2}", rfs.RfsId, shipperName, productName);
        }

// ReSharper disable InconsistentNaming
        protected void Page_Load(object sender, EventArgs e)
// ReSharper restore InconsistentNaming
        {
            QuickRfsIdTextbox.Focus();

            if (IsPostBack) return;
            GridView1.Sort("RFS ID", SortDirection.Ascending);
            if (Session[ContextRfsId] != null)
                SetSelectedRfsLabel();
        }

// ReSharper disable InconsistentNaming
        protected void DropDownLists_PreRender(object sender, EventArgs e)
// ReSharper restore InconsistentNaming
        {
            DropDownList list = sender as DropDownList;
            if (list == null) return;
            if (list.Items.Count > 0 && list.Items[0].Text != "All")
                list.Items.Insert(0, new ListItem("All", ""));
        }

// ReSharper disable InconsistentNaming
        protected void ClearFiltersButton_Click(object sender, EventArgs e)
// ReSharper restore InconsistentNaming
        {
            RfsIdFilterDropDownList.SelectedIndex = 0;
            SalespersonFilterDropDownList.SelectedIndex = 0;
            ShipperFilterDropDownList.SelectedIndex = 0;
            VesselFilterDropDownList.SelectedIndex = 0;
            CommodityFilterDropDownList.SelectedIndex = 0;
        }

// ReSharper disable InconsistentNaming
        protected void QuickSelectButton_Click(object sender, EventArgs e)
// ReSharper restore InconsistentNaming
        {
            string redirectUrl = string.Format("RfsWizardSelectRfsAndForward.aspx?RFSID={0}", QuickRfsIdTextbox.Text);
            Response.Redirect(redirectUrl);
        }
    }
}
