using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web.UI;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using Configuration=NHibernate.Cfg.Configuration;

public partial class Customers__All_LoadTrackingReport : Page
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";

    private static BopsDestination LookupDestination(ISession NHibernateSession, int Id)
    {
        BopsDestination Destination = NHibernateSession.Get<BopsDestination>(Id);
        if (Destination != null && Destination.ParentRef != null && Destination.ParentRef != 0 & Destination.ParentRef != Id)
            Destination = NHibernateSession.Get<BopsDestination>(Destination.ParentRef);
        return Destination;
    }

    private static string FormatDestinationName(BopsDestination Destination)
    {
        return !string.IsNullOrEmpty(Destination.State)
                   ? string.Format("{0}: {1}, {2}", Destination.Name, Destination.City, Destination.State)
                   : string.Format("{0}: {1}", Destination.Name, Destination.City);
    }

    private bool SessionUserIsAuthorizedForLoad(ISession DwsNoRepDataSession, BopsLoad Load, BopsDestination Origin, BopsDestination Destination)
    {
        // Nobody is authorized to look at a null load. It just doesn't make sense.

        if (Load == null)
            return false;

        // If the user is a Budway-appointed administrator or power user, permission is granted for any load.

        if (User.IsInRole("Administrators") || User.IsInRole("Power Users"))
            return true;

        if (Session[_ContextClientId] != null)
        {
            int ClientId = Convert.ToInt32(Session[_ContextClientId]);

            // If the user is a Budway employee, permission is granted for any load.

            if (ClientId == _BudwayDestinationId)
                return true;

            // If the shipper matches the user's client ID, then permission is granted.

            if (Load.RfsRef.HasValue)
            {
                BopsRfs Rfs = DwsNoRepDataSession.Get<BopsRfs>(Load.RfsRef.Value);

                if (Rfs != null)
                {
                    if (ClientId == Rfs.ShipperRef)
                        return true;
                }
            }

            // The last chance is that the client ID matches the origin or destination.

            if (Origin != null && Destination != null)
                return ClientId == Origin.DestinationId || ClientId == Destination.DestinationId;
        }

        return false;
    }

    protected void Page_Load(object Sender, EventArgs E)
    {
        string LoadReference = Request.Params["LoadRef"];
        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

        LoadTrackingUnifiedHistoryControl1.LoadReference = LoadReference;
        LoadTrackingUnifiedHistoryControl1.DatabaseConnection = DbServer;
        LoadTrackingUnifiedLoadContentsControl1.LoadReference = LoadReference;
        LoadTrackingUnifiedLoadContentsControl1.DatabaseConnection = DbServer;

        if (!IsPostBack)
        {
            string ApplicationRootFolder = Request.PhysicalApplicationPath;
            string DwsNoRepFile = Path.Combine(ApplicationRootFolder, "NHibernateDwsNoRepData.xml.config");
            string DwsRepFile = Path.Combine(ApplicationRootFolder, "NHibernateDwsRepData.xml.config");

            ISessionFactory DwsNoRepDataSessionFactory = new Configuration()
                .Configure(DwsNoRepFile)
                .BuildSessionFactory();
            ISession DwsNoRepDataSession = DwsNoRepDataSessionFactory.OpenSession();
            DwsNoRepDataSessionFactory.Close();

            ISessionFactory DwsRepDataSessionFactory = new Configuration()
                .Configure(DwsRepFile)
                .BuildSessionFactory();
            ISession DwsRepDataSession = DwsRepDataSessionFactory.OpenSession();
            DwsRepDataSessionFactory.Close();

            IList<BopsDriverPlanDetail> PlanDetail = DwsNoRepDataSession.CreateCriteria(typeof(BopsDriverPlanDetail))
                .Add(Expression.Eq("LoadRef", LoadReference))
                .List<BopsDriverPlanDetail>();
            BopsLoad LoadDetails = DwsNoRepDataSession.Get<BopsLoad>(LoadReference);
            BopsDestination Origin =  null, Destination = null;

            if (LoadDetails != null)
            {
                if (LoadDetails.OriginRef.HasValue)
                    Origin = LookupDestination(DwsRepDataSession, LoadDetails.OriginRef.Value);
                if (LoadDetails.DeliveryLocationRef.HasValue)
                    Destination = LookupDestination(DwsRepDataSession, LoadDetails.DeliveryLocationRef.Value);
            }

            if (!SessionUserIsAuthorizedForLoad(DwsNoRepDataSession, LoadDetails, Origin, Destination))
            {
                DwsRepDataSession.Close();
                DwsNoRepDataSession.Close();

                string TargetUrl = "LoadTrackingReportInvalidLoadError.aspx?LoadRef=" + Request.Params["LoadRef"];
                Response.Redirect(TargetUrl);
            }

            if (PlanDetail.Count == 1)
            {
                LoadReferenceNumberLabel.Text = LoadReference;
                BopsDriverPlanDetail Detail = PlanDetail[0];
                BopsDriverPlan Plan = DwsNoRepDataSession.Load<BopsDriverPlan>(Detail.PlanRef);

                DateTime Arrive = new DateTime(Plan.PlanDate.Value.Year, Plan.PlanDate.Value.Month, Plan.PlanDate.Value.Day,
                                 Detail.ScheduledArrival.Value.Hour, Detail.ScheduledArrival.Value.Minute,
                                 Detail.ScheduledArrival.Value.Second);
                DateTime Depart = new DateTime(Plan.PlanDate.Value.Year, Plan.PlanDate.Value.Month, Plan.PlanDate.Value.Day,
                                 Detail.ScheduledDeparture.Value.Hour, Detail.ScheduledDeparture.Value.Minute,
                                 Detail.ScheduledDeparture.Value.Second);

                ArrivalLabel.Text = Arrive.ToString();
                DepartureLabel.Text = Depart.ToString();
            }

            if (LoadDetails != null)
            {
                LoadReferenceNumberLabel.Text = LoadReference;

                if (Origin != null)
                    OriginLabel.Text = FormatDestinationName(Origin);
                if (Destination != null)
                    DestinationLabel.Text = FormatDestinationName(Destination);
            }
            else
            {
                DwsRepDataSession.Close();
                DwsNoRepDataSession.Close();

                string TargetUrl = "LoadTrackingReportInvalidLoadError.aspx?LoadRef=" + Request.Params["LoadRef"];
                Response.Redirect(TargetUrl);
            }

            DwsRepDataSession.Close();
            DwsNoRepDataSession.Close();
        }
    }
}
