using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

public partial class RFS_RfsWizardRequestAssessorial : Page
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
            // Necessary to ensure that the page options get set correctly every time, even when the
            // back/forward buttons are used for navigation.

            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            SetSelectedRfsLabel();
            CostMethodList.Attributes.Add("onchange", "UpdatePrivateCostControls(this.options[this.selectedIndex].value);");
            PublicCostMethodList.Attributes.Add("onchange", "UpdatePublicCostControls(this.options[this.selectedIndex].value);");

            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession NHibernateSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            BopsRfs Rfs = NHibernateSession.Get<BopsRfs>(Session[_ContextRfsId]);

            if (Rfs != null)
            {
                ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
                ISession DwsRepDataSession = Mgr.AddSession(_DwsRepData, ConfigurationFileName);
                BopsDestination ShipperDestination = DwsRepDataSession.Get<BopsDestination>(Rfs.ShipperRef);
                ShipperStakeholderLabel.Text = string.Format("{0}: {1}, {2}", ShipperDestination.Name,
                    ShipperDestination.City, ShipperDestination.State ?? "");
                Mgr.RemoveSession(_DwsRepData, false);
            }

            string Mode = Request.QueryString["mode"];

            if (Mode.ToLower() == "edit")
            {
                int ServiceId = Convert.ToInt32(Request.QueryString["ServiceId"]);
                BopsRfsServicesRequested ServiceDetails = NHibernateSession.Get<BopsRfsServicesRequested>(ServiceId);

                if (ServiceDetails.CalculationScope == RfsCalculationScopeType.Private)
                    ScopeDropdown.SelectedValue = "Private";
                else if (ServiceDetails.CalculationScope == RfsCalculationScopeType.Public)
                    ScopeDropdown.SelectedValue = "Public";
                else
                    ScopeDropdown.SelectedValue = "Both";

                // Do the data binding so we can intelligently manipulate the stakeholder lists.
                BillToStakeholderList.DataBind();

                ServicesList.SelectedValue = ServiceDetails.ServiceOfferedRef.ToString();
                if (BillToStakeholderList.Items.FindByValue(ServiceDetails.BillToRef.ToString()) != null)
                    BillToStakeholderList.SelectedValue = ServiceDetails.BillToRef.ToString();

                SpecialNeedsTextbox.Text = ServiceDetails.SpecialNeeds;
                CostMethodList.SelectedValue = ServiceDetails.PrivateRate.CostMethodRef.ToString();
                PublicCostMethodList.SelectedValue = ServiceDetails.PublicRate.CostMethodRef.ToString();

                ConfigurePrivateCostControls(ServiceDetails.PrivateRate.CostMethodRef.Value);
                ConfigurePublicCostControls(ServiceDetails.PublicRate.CostMethodRef.Value);

                if (ServiceDetails.PrivateRate.Cost.HasValue)
                    CostTextbox.Text = ServiceDetails.PrivateRate.Cost.Value.ToString();
                if (ServiceDetails.PrivateRate.UnitRef.HasValue)
                    CostUnitList.SelectedValue = ServiceDetails.PrivateRate.UnitRef.Value.ToString();
                if (ServiceDetails.PrivateRate.CostMatrixRef.HasValue)
                    CostMatrixList.SelectedValue = ServiceDetails.PrivateRate.CostMatrixRef.Value.ToString();

                if (ServiceDetails.PublicRate.Cost.HasValue)
                    PublicCostTextbox.Text = ServiceDetails.PublicRate.Cost.Value.ToString();
                if (ServiceDetails.PublicRate.UnitRef.HasValue)
                    PublicCostUnitList.SelectedValue = ServiceDetails.PublicRate.UnitRef.Value.ToString();
                if (ServiceDetails.PublicRate.CostMatrixRef.HasValue)
                    PublicCostMatrixList.SelectedValue = ServiceDetails.PublicRate.CostMatrixRef.Value.ToString();

                GroupDropdown.SelectedIndex = ServiceDetails.ServiceGroup - 1;
                UnlinkPrivateRateCheckbox.Checked = ServiceDetails.PrivateRateIsUnlinked;
                SaveButton.Text = "Save Changes";
            }
            else
            {
                CostTextbox.Style["display"] = "";
                PerLabel.Style["display"] = "none";
                CostUnitList.Style["display"] = "none";
                CostMatrixList.Style["display"] = "none";

                PublicCostTextbox.Style["display"] = "";
                PublicPerLabel.Style["display"] = "none";
                PublicCostUnitList.Style["display"] = "none";
                PublicCostMatrixList.Style["display"] = "none";

                GroupDropdown.SelectedIndex = 0;
                SaveButton.Text = "Add Service";
            }

            Mgr.RemoveSession(_DwsNoRepData, true);

            if (!User.IsInRole("Administrators"))
            {
                PrivateRatePanel.Visible = false;
                ScopePanel.Visible = false;
            }
        }
    }

    private void ConfigurePrivateCostControls(int CostMethod)
    {
        switch (CostMethod)
        {
            case 1:
                CostTextbox.Style["display"] = "";
                PerLabel.Style["display"] = "none";
                CostUnitList.Style["display"] = "none";
                CostMatrixList.Style["display"] = "none";
                break;
            case 2:
                CostTextbox.Style["display"] = "";
                PerLabel.Style["display"] = "";
                CostUnitList.Style["display"] = "";
                CostMatrixList.Style["display"] = "none";
                break;
            case 3:
                CostTextbox.Style["display"] = "none";
                PerLabel.Style["display"] = "none";
                CostUnitList.Style["display"] = "none";
                CostMatrixList.Style["display"] = "";
                break;
        }
    }

    private void ConfigurePublicCostControls(int CostMethod)
    {
        switch (CostMethod)
        {
            case 1:
                PublicCostTextbox.Style["display"] = "";
                PublicPerLabel.Style["display"] = "none";
                PublicCostUnitList.Style["display"] = "none";
                PublicCostMatrixList.Style["display"] = "none";
                break;
            case 2:
                PublicCostTextbox.Style["display"] = "";
                PublicPerLabel.Style["display"] = "";
                PublicCostUnitList.Style["display"] = "";
                PublicCostMatrixList.Style["display"] = "none";
                break;
            case 3:
                PublicCostTextbox.Style["display"] = "none";
                PublicPerLabel.Style["display"] = "none";
                PublicCostUnitList.Style["display"] = "none";
                PublicCostMatrixList.Style["display"] = "";
                break;
        }
    }

    private void GetServiceDetails(BopsRfsServicesRequested Service)
    {
        string Mode = Request.QueryString["mode"];

        Service.ServiceOfferedRef = Convert.ToInt32(ServicesList.SelectedValue);
        Service.BillToRef = Convert.ToInt32(BillToStakeholderList.SelectedValue);
        Service.SpecialNeeds = SpecialNeedsTextbox.Text;

        // Assessorial are always billed on the load.

        Service.PublicBillingEventType = RfsBillingEventType.Load;
        Service.PrivateBillingEventType = RfsBillingEventType.Load;

        // Get the public rate data.

        Service.PublicRate.CostMethodRef = Convert.ToInt32(PublicCostMethodList.SelectedValue);
        if (PublicCostTextbox.Text.Length > 0)
            Service.PublicRate.Cost = Convert.ToDouble(PublicCostTextbox.Text);
        Service.PublicRate.UnitRef = Convert.ToInt32(PublicCostUnitList.SelectedValue);
        Service.PublicRate.CostMatrixRef = Convert.ToInt32(PublicCostMatrixList.SelectedValue);

        // Administrators can set both public and private rate data, so if the user is in
        // that role, we need to get the private data from the form.

        if (User.IsInRole("Administrators"))
        {
            Service.PrivateRate.CostMethodRef = Convert.ToInt32(CostMethodList.SelectedValue);
            if (CostTextbox.Text.Length > 0)
                Service.PrivateRate.Cost = Convert.ToDouble(CostTextbox.Text);
            Service.PrivateRate.UnitRef = Convert.ToInt32(CostUnitList.SelectedValue);
            Service.PrivateRate.CostMatrixRef = Convert.ToInt32(CostMatrixList.SelectedValue);

            switch (ScopeDropdown.SelectedValue)
            {
                case "Private":
                    Service.CalculationScope = RfsCalculationScopeType.Private;
                    break;
                case "Public":
                    Service.CalculationScope = RfsCalculationScopeType.Public;
                    break;
                case "Both":
                    Service.CalculationScope = RfsCalculationScopeType.Both;
                    break;
            }

            Service.PrivateRateIsUnlinked = UnlinkPrivateRateCheckbox.Checked;
        }

        // Otherwise, we may need to set the private fields based on the public fields, if
        // the form is set to add a new service.

        else if ((Mode.ToLower() == "add") || (!Service.PrivateRateIsUnlinked && !User.IsInRole("Administrators")))
        {
            Service.PrivateRate = Service.PublicRate;
            Service.CalculationScope = RfsCalculationScopeType.Both;
        }

        Service.ServiceGroup = GroupDropdown.SelectedIndex + 1;
    }

    private int EnsureRfsHasShipperStakeholder(ISession DwsNoRepData, BopsRfs Rfs)
    {
        IList<BopsRfsStakeholder> Shippers = DwsNoRepData.CreateCriteria(typeof(BopsRfsStakeholder))
            .Add(Expression.Eq("RfsRef", Rfs.RfsId))
            .Add(Expression.Eq("RoleRef", BopsRfsStakeholderRoleType.Shipper))
            .List<BopsRfsStakeholder>();

        if (Shippers.Count == 0)
        {
            BopsRfsStakeholder Shipper = new BopsRfsStakeholder();
            Shipper.ClientRef = Rfs.ShipperRef;
            Shipper.RfsRef = Rfs.RfsId;
            Shipper.RoleRef = BopsRfsStakeholderRoleType.Shipper;
            DwsNoRepData.Save(Shipper);

            return Shipper.StakeholderId;
        }
        else
        {
            // Delete any extras and return the ID of the first shipper, updating it if necessary.

            for (int i = 1; i < Shippers.Count; i++)
                DwsNoRepData.Delete(Shippers[i]);

            if (Shippers[0].ClientRef != Rfs.ShipperRef)
            {
                Shippers[0].ClientRef = Rfs.ShipperRef;
                DwsNoRepData.Update(Shippers[0]);
            }

            return Shippers[0].StakeholderId;
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        SessionManager<string> Mgr = new SessionManager<string>();
        ISession DwsNoRepDataSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
        string Mode = Request.QueryString["mode"];
        Mgr.BeginTransaction(_DwsNoRepData);

        if (Mode.ToLower() == "add")
        {
            BopsRfs Rfs = DwsNoRepDataSession.Get<BopsRfs>(Session[_ContextRfsId]);
            BopsRfsServicesRequested Service = new BopsRfsServicesRequested();
            Service.RfsRef = Rfs.RfsId;
            Service.ShipperRef = EnsureRfsHasShipperStakeholder(DwsNoRepDataSession, Rfs);
            GetServiceDetails(Service);
            DwsNoRepDataSession.Save(Service);
        }
        else
        {
            int ServiceId = Convert.ToInt32(Request.QueryString["ServiceId"]);
            BopsRfsServicesRequested Service = DwsNoRepDataSession.Get<BopsRfsServicesRequested>(ServiceId);
            GetServiceDetails(Service);
            DwsNoRepDataSession.Update(Service);
        }

        Mgr.RemoveSession(_DwsNoRepData, true);
        Response.Redirect("RfsWizardServices.aspx");
    }

    protected void ServerValidateBillTo(object sender, ServerValidateEventArgs e)
    {
        e.IsValid = (BillToStakeholderList.SelectedValue != string.Empty);
    }
}
