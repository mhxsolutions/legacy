using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DataUtilities;

public partial class Customers_InboundShippingMap : System.Web.UI.Page
{
    private const string _ContextClientId = "CONTEXT_CLIENTID";
    private const string _ContextImpersonate = "CONTEXT_IMPERSONATE";
    private const double _BudwayLatitude = 34.091;
    private const double _BudwayLongitude = -117.51;

    #region Helper Classes

    private struct PushPin
    {
        public enum ImageType
        {
            None,
            Truck,
            Destination
        }

        private double _Latitude;
        private double _Longitude;
        private string _Header;
        private string _Description;
        private ImageType _Image;

        public PushPin(double _Latitude, double _Longitude, string _Header, string _Description)
        {
            this._Latitude = _Latitude;
            this._Longitude = _Longitude;
            this._Header = _Header;
            this._Description = _Description;
            _Image = ImageType.None;
        }

        public PushPin(double _Latitude, double _Longitude, string _Header, string _Description, ImageType _Image)
        {
            this._Latitude = _Latitude;
            this._Longitude = _Longitude;
            this._Header = _Header;
            this._Description = _Description;
            this._Image = _Image;
        }

        public double Latitude
        {
            get { return _Latitude; }
            set { _Latitude = value; }
        }

        public double Longitude
        {
            get { return _Longitude; }
            set { _Longitude = value; }
        }

        public string Header
        {
            get { return _Header; }
            set { _Header = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public ImageType Image
        {
            get { return _Image; }
            set { _Image = value; }
        }
    }

    private class DeliveryInProcess
    {
        private int _DriverId;
        private DateTime _LastAgilisEventTimestamp;
        private string _LastAgilisEventStatus;
        private string _FirstName;
        private string _LastName;
        private string _LoadReference;
        private int _ShipperId;
        private string _ShipperName;
        private int _DestinationId;
        private string _DestinationName;
        private DateTime _ScheduledArrival;
        private int _LastAgilisPositionId;
        private DateTime _LastAgilisPositionTimestamp;
        private double _DriverLatitude;
        private double _DriverLongitude;
        private double _ShipperLatitude;
        private double _ShipperLongitude;
        private double _DestinationLatitude;
        private double _DestinationLongitude;

        public int DriverId
        {
            get { return _DriverId; }
            set { _DriverId = value; }
        }

        public DateTime LastAgilisEventTimestamp
        {
            get { return _LastAgilisEventTimestamp; }
            set { _LastAgilisEventTimestamp = value; }
        }

        public string LastAgilisEventStatus
        {
            get { return _LastAgilisEventStatus; }
            set { _LastAgilisEventStatus = value; }
        }

        public string FirstName
        {
            get { return _FirstName; }
            set { _FirstName = value; }
        }

        public string LastName
        {
            get { return _LastName; }
            set { _LastName = value; }
        }

        public string LoadReference
        {
            get { return _LoadReference; }
            set { _LoadReference = value; }
        }

        public int ShipperId
        {
            get { return _ShipperId; }
            set { _ShipperId = value; }
        }

        public string ShipperName
        {
            get { return _ShipperName; }
            set { _ShipperName = value; }
        }

        public int DestinationId
        {
            get { return _DestinationId; }
            set { _DestinationId = value; }
        }

        public string DestinationName
        {
            get { return _DestinationName; }
            set { _DestinationName = value; }
        }

        public DateTime ScheduledArrival
        {
            get { return _ScheduledArrival; }
            set { _ScheduledArrival = value; }
        }

        public int LastAgilisPositionId
        {
            get { return _LastAgilisPositionId; }
            set { _LastAgilisPositionId = value; }
        }

        public DateTime LastAgilisPositionTimestamp
        {
            get { return _LastAgilisPositionTimestamp; }
            set { _LastAgilisPositionTimestamp = value; }
        }

        public double DriverLatitude
        {
            get { return _DriverLatitude; }
            set { _DriverLatitude = value; }
        }

        public double DriverLongitude
        {
            get { return _DriverLongitude; }
            set { _DriverLongitude = value; }
        }

        public double ShipperLatitude
        {
            get { return _ShipperLatitude; }
            set { _ShipperLatitude = value; }
        }

        public double ShipperLongitude
        {
            get { return _ShipperLongitude; }
            set { _ShipperLongitude = value; }
        }

        public double DestinationLatitude
        {
            get { return _DestinationLatitude; }
            set { _DestinationLatitude = value; }
        }

        public double DestinationLongitude
        {
            get { return _DestinationLongitude; }
            set { _DestinationLongitude = value; }
        }
    }

    #endregion

    #region Helper Methods

    private DeliveryInProcess GetDeliveryInProcessFromReader(IDataRecord Reader)
    {
        DeliveryInProcess ReturnValue = new DeliveryInProcess();

        ReturnValue.DriverId = IDataRecordUtilities.GetReaderInteger(Reader, "Driver ID");
        ReturnValue.LastAgilisEventTimestamp = IDataRecordUtilities.GetReaderDateTime(Reader, "Last Agilis Event Timestamp");
        ReturnValue.LastAgilisEventStatus = IDataRecordUtilities.GetReaderString(Reader, "Last Agilis Event Status");
        ReturnValue.FirstName = IDataRecordUtilities.GetReaderString(Reader, "First Name");
        ReturnValue.LastName = IDataRecordUtilities.GetReaderString(Reader, "Last Name");
        ReturnValue.LoadReference = IDataRecordUtilities.GetReaderString(Reader, "Load Ref");
        ReturnValue.ShipperId = IDataRecordUtilities.GetReaderInteger(Reader, "Shipper ID");
        ReturnValue.ShipperName = IDataRecordUtilities.GetReaderString(Reader, "Shipper Name");
        ReturnValue.DestinationId = IDataRecordUtilities.GetReaderInteger(Reader, "Destination ID");
        ReturnValue.DestinationName = IDataRecordUtilities.GetReaderString(Reader, "Destination Name");
        ReturnValue.ScheduledArrival = IDataRecordUtilities.GetReaderDateTime(Reader, "Scheduled Arrival");
        ReturnValue.LastAgilisPositionId = IDataRecordUtilities.GetReaderInteger(Reader, "Last Agilis Position ID");
        ReturnValue.LastAgilisPositionTimestamp = IDataRecordUtilities.GetReaderDateTime(Reader, "Last Agilis Position Timestamp");
        ReturnValue.DriverLatitude = IDataRecordUtilities.GetReaderDouble(Reader, "Driver Latitude");
        ReturnValue.DriverLongitude = IDataRecordUtilities.GetReaderDouble(Reader, "Driver Longitude");
        ReturnValue.ShipperLatitude = IDataRecordUtilities.GetReaderDouble(Reader, "Shipper Latitude");
        ReturnValue.ShipperLongitude = IDataRecordUtilities.GetReaderDouble(Reader, "Shipper Longitude");
        ReturnValue.DestinationLatitude = IDataRecordUtilities.GetReaderDouble(Reader, "Destination Latitude");
        ReturnValue.DestinationLongitude = IDataRecordUtilities.GetReaderDouble(Reader, "Destination Longitude");

        return ReturnValue;
    }

    private List<DeliveryInProcess> GetDeliveriesInProcess(int ClientFilter)
    {
        string DatabaseConnectionString = ConfigurationManager.AppSettings["Db1Connection"];
        List<DeliveryInProcess> ReturnValue = new List<DeliveryInProcess>();

        using (SqlConnection Connection = new SqlConnection(DatabaseConnectionString))
        {
            using (SqlCommand Command = new SqlCommand("CopsInboundShipping", Connection))
            {
                Connection.Open();
                Command.CommandType = CommandType.StoredProcedure;
                Command.Parameters.Add("@ClientDestinationFilter", SqlDbType.Int).Value = ClientFilter;

                SqlDataAdapter DataAdapter = new SqlDataAdapter(Command);
                DataSet Ds = new DataSet();
                DataAdapter.Fill(Ds);

                foreach (DataRow row in Ds.Tables[0].Rows)
                {
                    DataRowAdapter RowAdapter = new DataRowAdapter(row);
                    ReturnValue.Add(GetDeliveryInProcessFromReader(RowAdapter));
                }

                // TODO: Filter the data set on the basis of the current client.

                MapObjectsGridview.DataSource = Ds;
                MapObjectsGridview.DataBind();

                Connection.Close();
            }
        }

        return ReturnValue;
    }

    private void ConfigureMap(double SiteLatitude, double SiteLongitude, ICollection<PushPin> Pins)
    {
        StringBuilder s = new StringBuilder(
            "<script type=\"text/javascript\">" + Environment.NewLine +
                "var map;" + Environment.NewLine +

                "function initializeMap()" + Environment.NewLine +
                "{" + Environment.NewLine +
                "    map = new Microsoft.Maps.Map(document.getElementById('map'), { credentials: 'Aomled-nlNUI5GpUvYVX1bjCgsKjt4DeEbvYTq5uK7UmafXpFEWpRIUM_vwTdlpe', center: new Microsoft.Maps.Location(" + SiteLatitude + ", " + SiteLongitude + "), zoom: 12 });" + Environment.NewLine +
                "}" + Environment.NewLine +

                "function centerMap(latitude, longitude)" + Environment.NewLine +
                "{" + Environment.NewLine +
                "    var currentZoom = map.getZoom();" + Environment.NewLine +
                "    map.setView({ zoom: currentZoom, center: new Microsoft.Maps.Location(latitude, longitude) });" + Environment.NewLine +
                "}" + Environment.NewLine +

                "function addPins()" + Environment.NewLine +
                "{" + Environment.NewLine +

                "    map.entities.clear();" + Environment.NewLine +
                "    var destinationOptions = { icon: '../../Images/PushPin - Destination.gif', width: 32, height: 32 };" + Environment.NewLine +
                "    var truckOptions = { icon: '../../Images/PushPin - Truck.gif', width: 32, height: 32 };" + Environment.NewLine
            );

        foreach (PushPin pin in Pins)
        {
            if (pin.Latitude == 0 || pin.Longitude == 0) continue;

            s.AppendLine(string.Format("    map.entities.push(new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location({0}, {1}), {2}));",
                pin.Latitude, pin.Longitude, pin.Image == PushPin.ImageType.Truck ? "truckOptions" : "destinationOptions"));
        }

        s.AppendLine("}");
        s.AppendLine("</script>");

        ClientScript.RegisterClientScriptBlock(GetType(), "MapScript", s.ToString());
    }

    private string MakeHeaderText(DeliveryInProcess D)
    {
        return string.Format("Load <a href=\"http://budwaydirect.com/CopsWeb/Customers/_All/LoadTrackingReport.aspx?LoadRef={0}\">{0}</a>", D.LoadReference);
    }

    private string MakeDescriptionText(DeliveryInProcess D)
    {
        StringBuilder sb = new StringBuilder("<table>");

        sb.AppendFormat("<tr><td valign=\"top\">Shipper:</td><td valign=\"top\">{0}</td></tr>", D.ShipperName);
        sb.AppendFormat("<tr><td valign=\"top\">Destination:</td><td valign=\"top\">{0}</td></tr>", D.DestinationName);
        sb.AppendFormat("<tr><td valign=\"top\">Last Located At:</td><td valign=\"top\">{0}</td></tr>", D.LastAgilisPositionTimestamp);
        sb.AppendFormat("<tr><td valign=\"top\">Scheduled Arrival:</td valign=\"top\"><td>{0}</td></tr>", D.ScheduledArrival);
        sb.Append("</table>");

        return sb.ToString();
    }

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        // Add a refresh meta-tag to redraw the page every ten minutes.

        HtmlMeta RefreshTag = new HtmlMeta();
        RefreshTag.HttpEquiv = "refresh";
        RefreshTag.Content = "600";
        Header.Controls.Add(RefreshTag);

        // Put together a list of pushpins that should appear on the map.

        int ClientFilter = (Session[_ContextClientId] != null) ? Convert.ToInt32(Session[_ContextClientId]) : 0;
        if (Session[_ContextImpersonate] == null && (User.IsInRole("Administrators") || User.IsInRole("Power Users")))
            ClientFilter = 0;

        List<PushPin> Pins = new List<PushPin>();
        List<DeliveryInProcess> DeliveriesInProcess = GetDeliveriesInProcess(ClientFilter);
        Dictionary<string, PushPin> DestinationsAdded = new Dictionary<string, PushPin>();

        double SumLatitude = 0, SumLongitude = 0;
        foreach (DeliveryInProcess d in DeliveriesInProcess)
        {
            Pins.Add(new PushPin(d.DriverLatitude, d.DriverLongitude, MakeHeaderText(d), MakeDescriptionText(d), PushPin.ImageType.Truck));
            SumLatitude += d.DriverLatitude;
            SumLongitude += d.DriverLongitude;

            if (!DestinationsAdded.ContainsKey(d.DestinationName))
            {
                if (ClientFilter == d.DestinationId && d.DestinationLatitude != 0.0 && d.DestinationLongitude != 0.0)
                {
                    PushPin Destination = new PushPin(d.DestinationLatitude, d.DestinationLongitude, d.DestinationName, string.Empty);
                    Destination.Image = PushPin.ImageType.Destination;
                    DestinationsAdded.Add(d.DestinationName, Destination);
                    Pins.Add(Destination);
                }
            }
        }

        // Add the Bing control into the <head> of the page.

        HtmlGenericControl Include = new HtmlGenericControl("script");
        Include.Attributes.Add("type", "text/javascript");
        Include.Attributes.Add("src", "http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0");
        Page.Header.Controls.Add(Include);

        // Configure the map and set the body attributes to run the javascript functions.
        // By default the map is centered at Budway, but the ShowMap call in the underlying
        // script will make a "best format" guess for all the locations.

        ConfigureMap(_BudwayLatitude, _BudwayLongitude, Pins);
        Master.BodyControl.Attributes["onload"] = "initializeMap(); addPins();";
    }

    protected void MapObjectsGridview_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton CenterMapButton = e.Row.FindControl("CenterMapLinkbutton") as LinkButton;
            DataRowView row = e.Row.DataItem as DataRowView;

            if (row["Driver Latitude"] != null && row["Driver Latitude"] != DBNull.Value &&
                row["Driver Longitude"] != null && row["Driver Longitude"] != DBNull.Value)
            {
                double Latitude = Convert.ToDouble(row["Driver Latitude"]);
                double Longitude = Convert.ToDouble(row["Driver Longitude"]);

                if (Latitude != 0.0 && Longitude != 0.0)
                    CenterMapButton.OnClientClick = string.Format("centerMap({0}, {1}); return false;", Latitude, Longitude);
            }
            else
            {
                CenterMapButton.Text = string.Empty;
            }
        }
    }

    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;
            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }

        return newSortDirection;
    }

    protected void MapObjectsGridview_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        MapObjectsGridview.PageIndex = e.NewPageIndex;
        MapObjectsGridview.DataBind();
    }

    protected void MapObjectsGridview_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataSet Ds = MapObjectsGridview.DataSource as DataSet;

        if (Ds != null)
        {
            DataView DefaultView = new DataView(Ds.Tables[0]);
            DefaultView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);
            MapObjectsGridview.DataSource = DefaultView;
            MapObjectsGridview.DataBind();
        }
    }
}
