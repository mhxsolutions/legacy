using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

public partial class RFS_RfsWizardRequestTransporation : Page
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
            IndeterminateDestinationCheckbox.Attributes.Add("onclick", "IndeterminateStatusChanged();");
            CostMethodList.Attributes.Add("onchange", "UpdatePrivateCostControls(this.options[this.selectedIndex].value);");
            PublicCostMethodList.Attributes.Add("onchange", "UpdatePublicCostControls(this.options[this.selectedIndex].value);");

            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            BopsRfs Rfs = DwsNoRepSession.Get<BopsRfs>(Session[_ContextRfsId]);

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
                BopsRfsServicesRequested ServiceDetails = DwsNoRepSession.Get<BopsRfsServicesRequested>(ServiceId);

                if (ServiceDetails.CalculationScope == RfsCalculationScopeType.Private)
                    ScopeDropdown.SelectedValue = "Private";
                else if (ServiceDetails.CalculationScope == RfsCalculationScopeType.Public)
                    ScopeDropdown.SelectedValue = "Public";
                else
                    ScopeDropdown.SelectedValue = "Both";

                ServicesList.SelectedValue = ServiceDetails.ServiceOfferedRef.ToString();

                // Do the data binding so we can intelligently manipulate the stakeholder lists.

                BillToStakeholderList.DataBind();
                ReceiverStakeholderList.DataBind();
                OriginStakeholderList.DataBind();
                DestinationStakeholderList.DataBind();

                if (BillToStakeholderList.Items.FindByValue(ServiceDetails.BillToRef.ToString()) != null)
                    BillToStakeholderList.SelectedValue = ServiceDetails.BillToRef.ToString();
                if (ReceiverStakeholderList.Items.FindByValue(ServiceDetails.ReceiverRef.ToString()) != null)
                    ReceiverStakeholderList.SelectedValue = ServiceDetails.ReceiverRef.ToString();
                if (OriginStakeholderList.Items.FindByValue(ServiceDetails.OriginRef.ToString()) != null)
                    OriginStakeholderList.SelectedValue = ServiceDetails.OriginRef.ToString();

                if (ServiceDetails.IndeterminateDestination)
                {
                    IndeterminateDestinationCheckbox.Checked = true;
                    DestinationStakeholderList.Style["display"] = "none";
                }
                else
                {
                    IndeterminateDestinationCheckbox.Checked = false;
                    DestinationStakeholderList.Style["display"] = "";
                    if (DestinationStakeholderList.Items.FindByValue(ServiceDetails.DestinationRef.ToString()) != null)
                        DestinationStakeholderList.SelectedValue = ServiceDetails.DestinationRef.ToString();
                }

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
                SpecialUnitTextbox.Text = ServiceDetails.PrivateRate.SpecialUnitText;

                if (ServiceDetails.PublicRate.Cost.HasValue)
                    PublicCostTextbox.Text = ServiceDetails.PublicRate.Cost.Value.ToString();
                if (ServiceDetails.PublicRate.UnitRef.HasValue)
                    PublicCostUnitList.SelectedValue = ServiceDetails.PublicRate.UnitRef.Value.ToString();
                if (ServiceDetails.PublicRate.CostMatrixRef.HasValue)
                    PublicCostMatrixList.SelectedValue = ServiceDetails.PublicRate.CostMatrixRef.Value.ToString();
                PublicSpecialUnitTextbox.Text = ServiceDetails.PublicRate.SpecialUnitText;

                MinimumChargedWeightTextbox.Text = ServiceDetails.PrivateRate.MinimumChargedWeight.ToString();

                if (ServiceDetails.PrivateRate.FscFixedRate.HasValue)
                    FixedRateTextbox.Text = ServiceDetails.PrivateRate.FscFixedRate.Value.ToString();
                if (ServiceDetails.PrivateRate.FscMatrixRef.HasValue)
                    FscList.SelectedValue = ServiceDetails.PrivateRate.FscMatrixRef.Value.ToString();
                if (ServiceDetails.PrivateRate.Mileage.HasValue)
                    OdMileageTextbox.Text = ServiceDetails.PrivateRate.Mileage.Value.ToString();

                if (ServiceDetails.PublicRate.FscFixedRate.HasValue)
                    PublicFixedRateTextbox.Text = ServiceDetails.PublicRate.FscFixedRate.Value.ToString();
                if (ServiceDetails.PublicRate.FscMatrixRef.HasValue)
                    PublicFscList.SelectedValue = ServiceDetails.PublicRate.FscMatrixRef.Value.ToString();
                if (ServiceDetails.PublicRate.Mileage.HasValue)
                    PublicOdMileageTextbox.Text = ServiceDetails.PublicRate.Mileage.Value.ToString();

                PublicMinimumChargedWeightTextbox.Text = ServiceDetails.PublicRate.MinimumChargedWeight.ToString();

                ConfigurePrivateFscControls(GetFscModeString(ServiceDetails.PrivateRate), true);
                ConfigurePublicFscControls(GetFscModeString(ServiceDetails.PublicRate), true);

                GroupDropdown.SelectedIndex = ServiceDetails.ServiceGroup - 1;
                UnlinkPrivateRateCheckbox.Checked = ServiceDetails.PrivateRateIsUnlinked;
                SaveButton.Text = "Save Changes";
            }
            else
            {
                ConfigurePrivateCostControls(1);
                ConfigurePublicCostControls(1);
                ConfigurePrivateFscControls("Matrix", true);
                ConfigurePublicFscControls("Matrix", true);
                GroupDropdown.SelectedIndex = 0;
                SaveButton.Text = "Add Service";
            }

            // If there are no destinations for this RFS, be sure to check the indeterminate box and hide
            // the destinations dropdown altogether.

            IList<BopsRfsStakeholder> Stakeholders = DwsNoRepSession.CreateCriteria(typeof(BopsRfsStakeholder))
                .Add(Expression.Eq("RfsRef", Session[_ContextRfsId]))
                .List<BopsRfsStakeholder>();
            int[] Counts = new int[(int)BopsRfsStakeholderRoleType.BillTo + 1];
            foreach (BopsRfsStakeholder stakeholder in Stakeholders)
                Counts[(int)stakeholder.RoleRef]++;

            if (Counts[(int)BopsRfsStakeholderRoleType.Destination] < 1)
            {
                IndeterminateDestinationCheckbox.Checked = true;
                IndeterminateDestinationCheckbox.Enabled = false;
                DestinationStakeholderList.Visible = false;
            }

            Mgr.RemoveAllSessions(true);

            if (!User.IsInRole("Administrators"))
            {
                PrivateRatePanel.Visible = false;
                ScopePanel.Visible = false;
            }
        }
        else
        {
            // We have to set the cost controls manually on post-back, insofar as the Javascript merely responds
            // to selections but doesn't initialize.

            int CostMethod;
            string CostMethodString = CostMethodList.SelectedValue;
            ConfigurePrivateCostControls(int.TryParse(CostMethodString, out CostMethod) ? CostMethod : 1);
            CostMethodString = PublicCostMethodList.SelectedValue;
            ConfigurePublicCostControls(int.TryParse(CostMethodString, out CostMethod) ? CostMethod : 1);
        }
    }

    private void ConfigurePrivateCostControls(int CostMethod)
    {
        switch (CostMethod)
        {
            case 1:     // Flat Fee
                CostTextbox.Style["display"] = "";
                PerLabel.Style["display"] = "none";
                CostUnitList.Style["display"] = "none";
                CostMatrixList.Style["display"] = "none";
                SpecialUnitTextbox.Style["display"] = "none";
                break;
            case 2:     // Per Unit
                CostTextbox.Style["display"] = "";
                PerLabel.Style["display"] = "";
                CostUnitList.Style["display"] = "";
                CostMatrixList.Style["display"] = "none";
                SpecialUnitTextbox.Style["display"] = "none";
                break;
            case 3:     // Matrix
                CostTextbox.Style["display"] = "none";
                PerLabel.Style["display"] = "none";
                CostUnitList.Style["display"] = "none";
                CostMatrixList.Style["display"] = "";
                SpecialUnitTextbox.Style["display"] = "none";
                break;
            case 4:     // Special Unit
                CostTextbox.Style["display"] = "";
                PerLabel.Style["display"] = "";
                CostUnitList.Style["display"] = "none";
                CostMatrixList.Style["display"] = "none";
                SpecialUnitTextbox.Style["display"] = "";
                break;
            case 5:     // Per Item
                CostTextbox.Style["display"] = "";
                PerLabel.Style["display"] = "none";
                CostUnitList.Style["display"] = "none";
                CostMatrixList.Style["display"] = "none";
                SpecialUnitTextbox.Style["display"] = "none";
                break;
        }
    }

    private void ConfigurePublicCostControls(int CostMethod)
    {
        switch (CostMethod)
        {
            case 1:     // Flat Fee
                PublicCostTextbox.Style["display"] = "";
                PublicPerLabel.Style["display"] = "none";
                PublicCostUnitList.Style["display"] = "none";
                PublicCostMatrixList.Style["display"] = "none";
                PublicSpecialUnitTextbox.Style["display"] = "none";
                break;
            case 2:     // Per Unit
                PublicCostTextbox.Style["display"] = "";
                PublicPerLabel.Style["display"] = "";
                PublicCostUnitList.Style["display"] = "";
                PublicCostMatrixList.Style["display"] = "none";
                PublicSpecialUnitTextbox.Style["display"] = "none";
                break;
            case 3:     // Matrix
                PublicCostTextbox.Style["display"] = "none";
                PublicPerLabel.Style["display"] = "";
                PublicCostUnitList.Style["display"] = "none";
                PublicCostMatrixList.Style["display"] = "";
                PublicSpecialUnitTextbox.Style["display"] = "none";
                break;
            case 4:     // Special Unit
                PublicCostTextbox.Style["display"] = "";
                PublicPerLabel.Style["display"] = "";
                PublicCostUnitList.Style["display"] = "none";
                PublicCostMatrixList.Style["display"] = "none";
                PublicSpecialUnitTextbox.Style["display"] = "";
                break;
            case 5:     // Per Item
                PublicCostTextbox.Style["display"] = "";
                PublicPerLabel.Style["display"] = "none";
                PublicCostUnitList.Style["display"] = "none";
                PublicCostMatrixList.Style["display"] = "none";
                PublicSpecialUnitTextbox.Style["display"] = "none";
                break;
        }
    }

    private void GetServiceDetails(BopsRfsServicesRequested Service)
    {
        string Mode = Request.QueryString["mode"];

        Service.ServiceOfferedRef = Convert.ToInt32(ServicesList.SelectedValue);

        if (BillToStakeholderList.SelectedValue != string.Empty)
            Service.BillToRef = Convert.ToInt32(BillToStakeholderList.SelectedValue);
        if (ReceiverStakeholderList.SelectedValue != string.Empty)
            Service.ReceiverRef = Convert.ToInt32(ReceiverStakeholderList.SelectedValue);
        if (OriginStakeholderList.SelectedValue != string.Empty)
            Service.OriginRef = Convert.ToInt32(OriginStakeholderList.SelectedValue);
        Service.IndeterminateDestination = IndeterminateDestinationCheckbox.Checked;

        // Set the public and private billing event types.

        Service.PublicBillingEventType = RfsBillingEventType.Load;
        Service.PrivateBillingEventType = RfsBillingEventType.Load;

        if (Service.IndeterminateDestination)
            Service.DestinationRef = null;
        else if (DestinationStakeholderList.SelectedValue != string.Empty)
            Service.DestinationRef = Convert.ToInt32(DestinationStakeholderList.SelectedValue);

        Service.SpecialNeeds = SpecialNeedsTextbox.Text;

        // Get the public rate data.

        Service.PublicRate.CostMethodRef = Convert.ToInt32(PublicCostMethodList.SelectedValue);
        if (PublicCostTextbox.Text.Length > 0)
            Service.PublicRate.Cost = Convert.ToDouble(PublicCostTextbox.Text);
        Service.PublicRate.UnitRef = Convert.ToInt32(PublicCostUnitList.SelectedValue);
        Service.PublicRate.CostMatrixRef = Convert.ToInt32(PublicCostMatrixList.SelectedValue);
        Service.PublicRate.SpecialUnitText = PublicSpecialUnitTextbox.Text;

        if (PublicMinimumChargedWeightTextbox.Text.Length > 0)
            Service.PublicRate.MinimumChargedWeight = Convert.ToInt32(PublicMinimumChargedWeightTextbox.Text);

        switch (PublicFscRadioButtonList.SelectedValue)
        {
            case "None":
                Service.PublicRate.FscFixedRate = null;
                Service.PublicRate.FscMatrixRef = null;
                Service.PublicRate.Mileage = null;
                break;
            case "Fixed Rate":
                Service.PublicRate.FscFixedRate = Convert.ToDouble(PublicFixedRateTextbox.Text);
                Service.PublicRate.FscMatrixRef = null;
                Service.PublicRate.Mileage = null;
                break;
            case "Matrix":
                Service.PublicRate.FscFixedRate = null;
                Service.PublicRate.FscMatrixRef = Convert.ToInt32(PublicFscList.SelectedValue);
                int FscMatrixRef;
                if (int.TryParse(PublicOdMileageTextbox.Text, out FscMatrixRef))
                    Service.PublicRate.Mileage = FscMatrixRef;
                else
                    Service.PublicRate.Mileage = null;
                break;
            case "Special Unit":
                break;
        }

        // Administrators can set both public and private rate data, so if the user is in
        // that role, we need to get the private data from the form.

        if (User.IsInRole("Administrators"))
        {
            Service.PrivateRate.CostMethodRef = Convert.ToInt32(CostMethodList.SelectedValue);
            if (CostTextbox.Text.Length > 0)
                Service.PrivateRate.Cost = Convert.ToDouble(CostTextbox.Text);
            Service.PrivateRate.UnitRef = Convert.ToInt32(CostUnitList.SelectedValue);
            Service.PrivateRate.CostMatrixRef = Convert.ToInt32(CostMatrixList.SelectedValue);
            Service.PrivateRate.SpecialUnitText = SpecialUnitTextbox.Text;

            if (MinimumChargedWeightTextbox.Text.Length > 0)
                Service.PrivateRate.MinimumChargedWeight = Convert.ToInt32(MinimumChargedWeightTextbox.Text);

            switch (FscRadioButtonList.SelectedValue)
            {
                case "None":
                    Service.PrivateRate.FscFixedRate = null;
                    Service.PrivateRate.FscMatrixRef = null;
                    Service.PrivateRate.Mileage = null;
                    break;
                case "Fixed Rate":
                    Service.PrivateRate.FscFixedRate = Convert.ToDouble(FixedRateTextbox.Text);
                    Service.PrivateRate.FscMatrixRef = null;
                    Service.PrivateRate.Mileage = null;
                    break;
                case "Matrix":
                    Service.PrivateRate.FscFixedRate = null;
                    Service.PrivateRate.FscMatrixRef = Convert.ToInt32(FscList.SelectedValue);
                    int FscMatrixRef;
                    if (int.TryParse(OdMileageTextbox.Text, out FscMatrixRef))
                        Service.PrivateRate.Mileage = FscMatrixRef;
                    else
                        Service.PrivateRate.Mileage = null;
                    break;
            }

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

    private void CopyRateDetails(RfsEstimatedThroughputDetails Details, BopsRfsRateDetails Rate)
    {
        if (Details != null)
        {
            Rate.EstimatedRevenue = Details.EstimatedRevenue;
            Rate.EstimatedMinutes = Details.EstimatedMinutes;
            Rate.EstimatedThroughput = Details.EstimatedThroughput;
        }
        else
        {
            Rate.EstimatedRevenue = null;
            Rate.EstimatedMinutes = null;
            Rate.EstimatedThroughput = null;
        }
    }

    private void SetServiceEstimatedThroughput(ISession DwsNoRepSession, ISession DwsRepSession, BopsRfsServicesRequested Service)
    {
        IRfsEstimatedThroughputCalculator Estc = RfsFactory.GetRfsEstimatedServiceThroughputCalculator(DwsNoRepSession, DwsRepSession);
        RfsEstimatedServiceThroughput Details = Estc.CalculateEstimatedServiceThroughput(Service);
        CopyRateDetails(Details.PrivateRate, Service.PrivateRate);
        CopyRateDetails(Details.PublicRate, Service.PublicRate);
    }

    private string GetFscModeString(BopsRfsRateDetails RateDetails)
    {
        if (RateDetails.FscFixedRate.HasValue)
            return "Fixed Rate";
        else if (RateDetails.FscMatrixRef.HasValue)
            return "Matrix";
        else
            return "None";
    }

    private void ConfigurePrivateFscControls(string Value, bool Select)
    {
        int Index = -1;

        switch (Value)
        {
            case "None":
                FscListLabel.Style["display"] = "none";
                FscList.Style["display"] = "none";
                FixedRateLabel.Style["display"] = "none";
                FixedRateTextbox.Style["display"] = "none";
                MileageLabel.Style["display"] = "none";
                OdMileageTextbox.Style["display"] = "none";
                Index = 0;
                break;
            case "Fixed Rate":
                FscListLabel.Style["display"] = "none";
                FscList.Style["display"] = "none";
                FixedRateLabel.Style["display"] = "";
                FixedRateTextbox.Style["display"] = "";
                MileageLabel.Style["display"] = "none";
                OdMileageTextbox.Style["display"] = "none";
                Index = 1;
                break;
            case "Matrix":
                FscListLabel.Style["display"] = "";
                FscList.Style["display"] = "";
                FixedRateLabel.Style["display"] = "none";
                FixedRateTextbox.Style["display"] = "none";
                MileageLabel.Style["display"] = "";
                OdMileageTextbox.Style["display"] = "";
                Index = 2;
                break;
        }

        if (Select)
            FscRadioButtonList.SelectedIndex = Index;
    }

    private void ConfigurePublicFscControls(string Value, bool Select)
    {
        int Index = -1;

        switch (Value)
        {
            case "None":
                PublicFscListLabel.Style["display"] = "none";
                PublicFscList.Style["display"] = "none";
                PublicFixedRateLabel.Style["display"] = "none";
                PublicFixedRateTextbox.Style["display"] = "none";
                PublicMileageLabel.Style["display"] = "none";
                PublicOdMileageTextbox.Style["display"] = "none";
                Index = 0;
                break;
            case "Fixed Rate":
                PublicFscListLabel.Style["display"] = "none";
                PublicFscList.Style["display"] = "none";
                PublicFixedRateLabel.Style["display"] = "";
                PublicFixedRateTextbox.Style["display"] = "";
                PublicMileageLabel.Style["display"] = "none";
                PublicOdMileageTextbox.Style["display"] = "none";
                Index = 1;
                break;
            case "Matrix":
                PublicFscListLabel.Style["display"] = "";
                PublicFscList.Style["display"] = "";
                PublicFixedRateLabel.Style["display"] = "none";
                PublicFixedRateTextbox.Style["display"] = "none";
                PublicMileageLabel.Style["display"] = "";
                PublicOdMileageTextbox.Style["display"] = "";
                Index = 2;
                break;
        }

        if (Select)
            PublicFscRadioButtonList.SelectedIndex = Index;
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
        if (Page.IsValid)
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepDataSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
            ISession DwsRepDataSession = Mgr.AddSession(_DwsRepData, ConfigurationFileName);
            string Mode = Request.QueryString["mode"];

            Mgr.BeginTransaction(_DwsNoRepData);

            if (Mode.ToLower() == "add")
            {
                BopsRfs Rfs = DwsNoRepDataSession.Get<BopsRfs>(Session[_ContextRfsId]);
                BopsRfsServicesRequested Service = new BopsRfsServicesRequested();
                Service.RfsRef = Rfs.RfsId;
                Service.ShipperRef = EnsureRfsHasShipperStakeholder(DwsNoRepDataSession, Rfs);
                GetServiceDetails(Service);

                if (DataIsValid(DwsNoRepDataSession, Service))
                {
                    SetServiceEstimatedThroughput(DwsNoRepDataSession, DwsRepDataSession, Service);
                    DwsNoRepDataSession.Save(Service);
                }
            }
            else
            {
                int ServiceId = Convert.ToInt32(Request.QueryString["ServiceId"]);
                BopsRfsServicesRequested Service = DwsNoRepDataSession.Get<BopsRfsServicesRequested>(ServiceId);
                GetServiceDetails(Service);

                if (DataIsValid(DwsNoRepDataSession, Service))
                {
                    SetServiceEstimatedThroughput(DwsNoRepDataSession, DwsRepDataSession, Service);
                    DwsNoRepDataSession.Update(Service);
                }
            }

            Mgr.RemoveAllSessions(true);
            Response.Redirect("RfsWizardServices.aspx");
        }
    }

    private bool DataIsValid(ISession DwsNoRepSession, BopsRfsServicesRequested Service)
    {
        // In the event that an FSC matrix using cents per mile was specified, we must have a mileage.

        if (Service.PrivateRate.FscMatrixRef != null)
        {
            BopsFsc Fsc = DwsNoRepSession.Get<BopsFsc>(Service.PrivateRate.FscMatrixRef);

            if (Fsc != null)
            {
                if (Fsc.CostMethodRef == BopsFsc.FscCostMethod.FuelIndexedCentsPerMile)
                    return Service.PrivateRate.Mileage.HasValue && Service.PrivateRate.Mileage.Value > 0;
                else 
                    return true;
            }

            return false;
        }

        return true;
    }

    protected void ServerValidateBillTo(object sender, ServerValidateEventArgs e)
    {
        e.IsValid = (BillToStakeholderList.SelectedValue != string.Empty);
    }

    protected void ServerValidateReceiver(object sender, ServerValidateEventArgs e)
    {
        e.IsValid = (ReceiverStakeholderList.SelectedValue != string.Empty);
    }

    protected void ServerValidateOrigin(object sender, ServerValidateEventArgs e)
    {
        e.IsValid = (OriginStakeholderList.SelectedValue != string.Empty);
    }

    protected void ServerValidateDestination(object sender, ServerValidateEventArgs e)
    {
        e.IsValid = (IndeterminateDestinationCheckbox.Checked) ||(DestinationStakeholderList.SelectedValue != string.Empty);
    }

    protected void ServerValidateFixedFscRate(object sender, ServerValidateEventArgs e)
    {
        double Rate;
        e.IsValid = (FscRadioButtonList.SelectedValue != "Fixed Rate") ||
                    (double.TryParse(e.Value, out Rate) && (-0.50 <= Rate && Rate <= 0.50));
    }

    protected void PublicServerValidateFixedFscRate(object sender, ServerValidateEventArgs e)
    {
        double Rate;
        e.IsValid = (PublicFscRadioButtonList.SelectedValue != "Fixed Rate") ||
                    (double.TryParse(e.Value, out Rate) && (-0.50 <= Rate && Rate <= 0.50));
    }

    protected void ServerValidateMileage(object sender, ServerValidateEventArgs e)
    {
        if (FscRadioButtonList.SelectedValue == "Matrix")
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepDataSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

            double Mileage;
            BopsFsc Fsc = DwsNoRepDataSession.Get<BopsFsc>(Convert.ToInt32(FscList.SelectedValue));

            e.IsValid = (Fsc != null) &&
                        ((Fsc.CostMethodRef != BopsFsc.FscCostMethod.FuelIndexedCentsPerMile) || 
                         (double.TryParse(OdMileageTextbox.Text, out Mileage) && (Mileage >= 0.0)));

            Mgr.RemoveAllSessions(false);
        }
        else
        {
            e.IsValid = true;
        }
    }

    protected void PublicServerValidateMileage(object sender, ServerValidateEventArgs e)
    {
        if (PublicFscRadioButtonList.SelectedValue == "Matrix")
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepDataSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

            double Mileage;
            BopsFsc Fsc = DwsNoRepDataSession.Get<BopsFsc>(Convert.ToInt32(PublicFscList.SelectedValue));

            e.IsValid = (Fsc != null) &&
                        ((Fsc.CostMethodRef != BopsFsc.FscCostMethod.FuelIndexedCentsPerMile) || 
                         (double.TryParse(PublicOdMileageTextbox.Text, out Mileage) && (Mileage >= 0.0)));

            Mgr.RemoveAllSessions(false);
        }
        else
        {
            e.IsValid = true;
        }
    }

    protected void FscRadioButtonList_SelectedIndexChanged(object sender, EventArgs e)
    {
        ConfigurePrivateFscControls(FscRadioButtonList.SelectedValue, false);
    }

    protected void PublicFscRadioButtonList_SelectedIndexChanged(object sender, EventArgs e)
    {
        ConfigurePublicFscControls(PublicFscRadioButtonList.SelectedValue, false);
    }
}
