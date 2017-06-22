using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

public partial class RFS_RfsWizardMain : Page
{
    private const string _ContextRfsId = "CONTEXT_RFSID";
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";
    private const string _DwsRepData = "NHibernateDwsRepData.xml.config";

    protected void Page_Load(object Sender, EventArgs E)
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

            LocationList.SelectedValue = Rfs.LocationCode;
            StatusList.SelectedValue = Rfs.StatusRef.ToString();
            SalespersonList.SelectedValue = Rfs.SalespersonRef.ToString();
            ShipperList.SelectedValue = Rfs.ShipperRef.ToString();
            CommodityList.SelectedValue = Rfs.CommodityRef.ToString();
            WorkTypeList.SelectedValue = Rfs.WorkTypeRef.ToString();

            if (!string.IsNullOrEmpty(Rfs.Vessel))
                RailcarTextbox.Text = Rfs.Vessel;
            if (Rfs.FirstFreeDate.HasValue)
                FfdTextbox.Text = Rfs.FirstFreeDate.Value.ToString("d");
            if (Rfs.LastFreeDate.HasValue)
                LfdTextbox.Text = Rfs.LastFreeDate.Value.ToString("d");
            if (!string.IsNullOrEmpty(Rfs.WorkDescription))
                DescriptionTextbox.Text = Rfs.WorkDescription;
            StorageFreeDaysTextbox.Text = Rfs.StorageFreeDays.ToString();

            BeginDateTextbox.Text = Rfs.BeginDate.ToShortDateString();
            EndDateTextbox.Text = Rfs.EndDate.HasValue ? Rfs.EndDate.Value.ToShortDateString() : string.Empty;
        }

        if (User.IsInRole("Power Users") || User.IsInRole("Administrators")) return;
        SaveChangesButton.Visible = false;
        SaveChangesAndProceedButton.Visible = false;
    }

    private bool SaveChanges()
    {
        if (!Page.IsValid)
            return false;

        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        SessionManager<string> Mgr = new SessionManager<string>();
        ISession NHibernateSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
        BopsRfs Rfs = NHibernateSession.Get<BopsRfs>(Session[_ContextRfsId]);

        if (Rfs != null)
        {
            Mgr.BeginTransaction(_DwsNoRepData);
            Rfs.LocationCode = LocationList.SelectedValue;
            Rfs.StatusRef = Convert.ToInt32(StatusList.SelectedValue);
            Rfs.SalespersonRef = Convert.ToInt32(SalespersonList.SelectedValue);
            Rfs.ShipperRef = Convert.ToInt32(ShipperList.SelectedValue);
            Rfs.CommodityRef = Convert.ToInt32(CommodityList.SelectedValue);
            Rfs.WorkTypeRef = Convert.ToInt32(WorkTypeList.SelectedValue);

            // TODO: Add an error when processing an empty begin date field or perhaps validation.

            DateTime ParseTarget;
            if (DateTime.TryParse(BeginDateTextbox.Text, out ParseTarget))
                Rfs.BeginDate = ParseTarget;

            if (DateTime.TryParse(EndDateTextbox.Text, out ParseTarget))
                Rfs.EndDate = ParseTarget;
            else
                Rfs.EndDate = null;

            Rfs.Vessel = RailcarTextbox.Text;

            if (FfdTextbox.Text == string.Empty)
                Rfs.FirstFreeDate = null;
            else
                Rfs.FirstFreeDate = Convert.ToDateTime(FfdTextbox.Text);
            if (LfdTextbox.Text == string.Empty)
                Rfs.LastFreeDate = null;
            else
                Rfs.LastFreeDate = Convert.ToDateTime(LfdTextbox.Text);

            Rfs.WorkDescription = DescriptionTextbox.Text;
            Rfs.StorageFreeDays = Convert.ToInt32(StorageFreeDaysTextbox.Text);
            NHibernateSession.Update(Rfs);

            IList<BopsRfsStakeholder> Stakeholders = NHibernateSession.CreateCriteria(typeof(BopsRfsStakeholder))
                .Add(Expression.Eq("RfsRef", Rfs.RfsId))
                .Add(Expression.Eq("RoleRef", BopsRfsStakeholderRoleType.Shipper))
                .List<BopsRfsStakeholder>();

            // If no shipper stakeholder exists, we create one.

            if (Stakeholders.Count == 0)
            {
                BopsRfsStakeholder NewShipperStakeholder = new BopsRfsStakeholder();
                NewShipperStakeholder.RfsRef = Rfs.RfsId;
                NewShipperStakeholder.RoleRef = BopsRfsStakeholderRoleType.Shipper;
                NewShipperStakeholder.ClientRef = Rfs.ShipperRef;
                NHibernateSession.Save(NewShipperStakeholder);
            }
            else
            {
                // Otherwise, we update the first shipper stakeholder in the list.

                Stakeholders[0].ClientRef = Rfs.ShipperRef;
                NHibernateSession.Update(Stakeholders[0]);

                // And delete any shipper stakeholders beyond the first.

                for (int I = 1; I < Stakeholders.Count; I++)
                    NHibernateSession.Delete(Stakeholders[I]);
            }
        }

        Mgr.RemoveSession(_DwsNoRepData, true);
        return true;
    }

    protected void ServerValidateBeginDate(object Sender, ServerValidateEventArgs E)
    {
        DateTime MinimumDate = new DateTime(2007, 1, 1), ParseTarget;
        E.IsValid = DateTime.TryParse(E.Value, out ParseTarget) && (MinimumDate <= ParseTarget);
    }

    protected void SaveChangesButton_Click(object Sender, EventArgs E)
    {
        SaveChanges();
    }

    protected void SaveChangesAndProceedButton_Click(object Sender, EventArgs E)
    {
        if (SaveChanges())
            Response.Redirect("RfsWizardStakeholders.aspx");
    }
}
