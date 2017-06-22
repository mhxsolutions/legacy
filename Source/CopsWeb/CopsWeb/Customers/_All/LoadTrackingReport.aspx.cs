using System;
using System.Configuration;
using System.Globalization;
//using BopsDataAccess;
//using Scm.OpsCore.Legacy.DataLayer;

namespace Web_App.Customers._All
{
    public partial class LoadTrackingReport : BasePage
    {
        private const int BudwayDestinationId = 166073081;
        private const string ContextClientId = "CONTEXT_CLIENTID";

        //private static string FormatDestinationName(BopsDestination destination)
        //{
        //    return !string.IsNullOrEmpty(destination.State)
        //               ? string.Format("{0}: {1}, {2}", destination.Name, destination.City, destination.State)
        //               : string.Format("{0}: {1}", destination.Name, destination.City);
        //}

        //private bool SessionUserIsAuthorizedForLoad(IRfsDataContext rfsDataContext, BopsLoad load, BopsDestination origin, BopsDestination destination)
        //{
        //    // Nobody is authorized to look at a null load. It just doesn't make sense.

        //    if (load == null)
        //        return false;

        //    // If the user is a Budway-appointed administrator or power user, permission is granted for any load.

        //    if (User.IsInRole("Administrators") || User.IsInRole("Power Users"))
        //        return true;

        //    if (Session[ContextClientId] != null)
        //    {
        //        var clientId = Convert.ToInt32(Session[ContextClientId]);

        //        // If the user is a Budway employee, permission is granted for any load.

        //        if (clientId == BudwayDestinationId)
        //            return true;

        //        // If the shipper matches the user's client ID, then permission is granted.

        //        if (load.RfsRef.HasValue)
        //        {
        //            var rfs = rfsDataContext.GetRfsById(load.RfsRef.Value);

        //            if (rfs != null)
        //            {
        //                if (clientId == rfs.ShipperRef)
        //                    return true;
        //            }
        //        }

        //        // The last chance is that the client ID matches the origin or destination.

        //        if (origin != null && destination != null)
        //            return clientId == origin.DestinationId || clientId == destination.DestinationId;
        //    }

        //    return false;
        //}

        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    var loadReference = Request.Params["LoadRef"];
        //    var dbServer = ConfigurationManager.AppSettings["Db1Connection"];

        //    LoadTrackingUnifiedHistoryControl1.LoadReference = loadReference;
        //    LoadTrackingUnifiedHistoryControl1.DatabaseConnection = dbServer;
        //    LoadTrackingUnifiedLoadContentsControl1.LoadReference = loadReference;
        //    LoadTrackingUnifiedLoadContentsControl1.DatabaseConnection = dbServer;

        //    if (IsPostBack) return;
        //    if (string.IsNullOrWhiteSpace(loadReference)) return;

        //    var rfsDataContext = TemporaryKernel.GetRfsDataContext();

        //    try
        //    {
        //        var planDetail = rfsDataContext.GetDriverPlanDetailsByLoadReference(loadReference);
        //        var loadDetails = rfsDataContext.GetLoadByReference(loadReference);
        //        BopsDestination origin = null, destination = null;

        //        if (loadDetails != null)
        //        {
        //            if (loadDetails.OriginRef.HasValue)
        //                origin = rfsDataContext.GetDestinationById(loadDetails.OriginRef.Value);
        //            if (loadDetails.DeliveryLocationRef.HasValue)
        //                destination = rfsDataContext.GetDestinationById(loadDetails.DeliveryLocationRef.Value);
        //        }

        //        if (!SessionUserIsAuthorizedForLoad(rfsDataContext, loadDetails, origin, destination))
        //        {
        //            var targetUrl = "LoadTrackingReportInvalidLoadError.aspx?LoadRef=" + Request.Params["LoadRef"];
        //            Response.Redirect(targetUrl);

        //            // TODO: ensure the finally gets hit
        //        }

        //        if (planDetail.Count == 1)
        //        {
        //            LoadReferenceNumberLabel.Text = loadReference;
        //            var detail = planDetail[0];
        //            var plan = rfsDataContext.GetDriverPlanById(detail.PlanRef);

        //            var arrive = new DateTime(plan.PlanDate.Value.Year, plan.PlanDate.Value.Month,
        //                plan.PlanDate.Value.Day,
        //                detail.ScheduledArrival.Value.Hour, detail.ScheduledArrival.Value.Minute,
        //                detail.ScheduledArrival.Value.Second);
        //            var depart = new DateTime(plan.PlanDate.Value.Year, plan.PlanDate.Value.Month,
        //                plan.PlanDate.Value.Day,
        //                detail.ScheduledDeparture.Value.Hour, detail.ScheduledDeparture.Value.Minute,
        //                detail.ScheduledDeparture.Value.Second);

        //            ArrivalLabel.Text = arrive.ToString(CultureInfo.InvariantCulture);
        //            DepartureLabel.Text = depart.ToString(CultureInfo.InvariantCulture);
        //        }

        //        if (loadDetails != null)
        //        {
        //            LoadReferenceNumberLabel.Text = loadReference;

        //            if (origin != null)
        //                OriginLabel.Text = FormatDestinationName(origin);
        //            if (destination != null)
        //                DestinationLabel.Text = FormatDestinationName(destination);
        //        }
        //        else
        //        {
        //            var targetUrl = "LoadTrackingReportInvalidLoadError.aspx?LoadRef=" + Request.Params["LoadRef"];
        //            Response.Redirect(targetUrl);
        //        }
        //    }
        //    finally
        //    {
        //        // TODO: free the RFS data context
        //    }
        //}
    }
}
