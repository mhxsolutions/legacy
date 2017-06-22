using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.HtmlControls;
using log4net;

namespace Web_App.Monitoring
{
    public partial class DriversNearHarbor : System.Web.UI.Page
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(DriversNearHarbor));

        #region Helper Classes

        private struct PushPin
        {
            private double _Latitude;
            private double _Longitude;
            private string _Header;
            private string _Description;

            public PushPin(double _Latitude, double _Longitude, string _Header, string _Description)
            {
                this._Latitude = _Latitude;
                this._Longitude = _Longitude;
                this._Header = _Header;
                this._Description = _Description;
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
        }

        private class LatestDriverPosition
        {
            private int _DriverId;
            private string _FirstName;
            private string _LastName;
            private string _PhoneNumber;
            private double _Latitude;
            private double _Longitude;
            private DateTime _Timestamp;
            private string _OriginName;
            private string _WorkOrderNumber;

            public int DriverId
            {
                get { return _DriverId; }
                set { _DriverId = value; }
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

            public string PhoneNumber
            {
                get { return _PhoneNumber; }
                set { _PhoneNumber = value; }
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

            public DateTime Timestamp
            {
                get { return _Timestamp; }
                set { _Timestamp = value; }
            }

            public string OriginName
            {
                get { return _OriginName; }
                set { _OriginName = value; }
            }

            public string WorkOrderNumber
            {
                get { return _WorkOrderNumber; }
                set { _WorkOrderNumber = value; }
            }
        }

        #endregion

        #region Helper Methods
        private static string GetReaderString(IDataRecord Reader, string FieldName)
        {
            try
            {
                return Reader[FieldName].ToString();
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return string.Empty;
        }

        private static int GetReaderInteger(IDataRecord Reader, string FieldName)
        {
            try
            {
                return Convert.ToInt32(Reader[FieldName]);
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return 0;
        }

        private static double GetReaderDouble(IDataRecord Reader, string FieldName)
        {
            try
            {
                return Convert.ToDouble(Reader[FieldName]);
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return 0;
        }

        private static DateTime GetReaderDateTime(IDataRecord Reader, string FieldName)
        {
            try
            {
                DateTime ReturnValue = Convert.ToDateTime(Reader[FieldName]);
                return ReturnValue;
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return DateTime.MinValue;
        }

        private LatestDriverPosition GetLatestDriverPositionFromReader(SqlDataReader Reader)
        {
            LatestDriverPosition ReturnValue = new LatestDriverPosition();

            ReturnValue.DriverId = GetReaderInteger(Reader, "Driver Ref");
            ReturnValue.FirstName = GetReaderString(Reader, "First Name");
            ReturnValue.LastName = GetReaderString(Reader, "Last Name");
            ReturnValue.PhoneNumber = GetReaderString(Reader, "Phone");
            ReturnValue.Latitude = GetReaderDouble(Reader, "Latitude");
            ReturnValue.Longitude = GetReaderDouble(Reader, "Longitude");
            ReturnValue.Timestamp = GetReaderDateTime(Reader, "Timestamp");
            ReturnValue.WorkOrderNumber = GetReaderString(Reader, "Work Order Number");
            ReturnValue.OriginName = GetReaderString(Reader, "Destination");

            return ReturnValue;
        }

        private List<LatestDriverPosition> GetLatestDriverPositions()
        {
            string DatabaseConnectionString = ConfigurationManager.AppSettings["Db1Connection"];
            List<LatestDriverPosition> ReturnValue = new List<LatestDriverPosition>();

            using (SqlConnection Connection = new SqlConnection(DatabaseConnectionString))
            {
                using (SqlCommand Command = new SqlCommand("AgilisLatestDriversByClientCategory", Connection))
                {
                    Connection.Open();

                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.Add("@BeginDate", SqlDbType.DateTime).Value = DateTime.Now.Date;
                    Command.Parameters.Add("@EndDate", SqlDbType.DateTime).Value = DateTime.Now.Date.AddDays(1);
                    Command.Parameters.Add("@ClientCategory", SqlDbType.Int).Value = 1; // Harbor category

                    using (SqlDataReader Reader = Command.ExecuteReader())
                    {
                        while (Reader.Read())
                            ReturnValue.Add(GetLatestDriverPositionFromReader(Reader));

                        Reader.Close();
                    }

                    Connection.Close();
                }
            }

            return ReturnValue;
        }

        private void ConfigureMap(double SiteLatitude, double SiteLongitude, IEnumerable<PushPin> Pins)
        {
            StringBuilder s = new StringBuilder(
                "<script type=\"text/javascript\">" + Environment.NewLine +
                    "var map1 = null;" + Environment.NewLine +

                    "function InitializeMap()" + Environment.NewLine +
                    "{" + Environment.NewLine +
                    "    map1 = new VEMap('map1');" + Environment.NewLine +
                    "    map1.LoadMap(new VELatLong(" + SiteLatitude + ", " + SiteLongitude + "), 11, VEMapStyle.Road , false, VEMapMode.Mode2D, false);" + Environment.NewLine +
                    "    map1.HideDashboard();" + Environment.NewLine +
                    "}" + Environment.NewLine +

                    "function AddPins()" + Environment.NewLine +
                    "{" + Environment.NewLine
                );

            int PinId = 1;

            foreach (PushPin pin in Pins)
            {
                s.AppendLine(string.Format("    var pin{0} = new VEShape(VEShapeType.Pushpin, new VELatLong({1}, {2}));", PinId, pin.Latitude, pin.Longitude));
                s.AppendLine(string.Format("    pin{0}.SetTitle('{1}');", PinId, pin.Header));
                s.AppendLine(string.Format("    pin{0}.SetDescription('{1}');", PinId, pin.Description));
                s.AppendLine(string.Format("    map1.AddShape(pin{0});", PinId));

                PinId++;
            }

            s.AppendLine("}");
            s.AppendLine("</script>");

            ClientScript.RegisterClientScriptBlock(GetType(), "MapScript", s.ToString());
        }

        private string FormatPhoneNumber(string PhoneNumber)
        {
            if (PhoneNumber.Length > 0)
                return string.Format("({0}) {1}-{2}", PhoneNumber.Substring(0, 3), PhoneNumber.Substring(3, 3), PhoneNumber.Substring(6));
            else
                return string.Empty;
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Add a refresh meta-tag to redraw the sheet every two minutes.

                HtmlMeta RefreshTag = new HtmlMeta();
                RefreshTag.HttpEquiv = "refresh";
                RefreshTag.Content = "120";
                Header.Controls.Add(RefreshTag);

                const double StartLatitude = 33.82635;      // Centered right above the 710/405 intersection
                const double StartLongitude = -118.2073;

                List<PushPin> Pins = new List<PushPin>();
                List<LatestDriverPosition> Drivers = GetLatestDriverPositions();

                foreach (LatestDriverPosition d in Drivers)
                {
                    string HeaderText = d.FirstName + " " + d.LastName;
                    string DescriptionText = string.Format("Heading to {0}<br>for work order {1}<br>{2}<br>{3}", d.OriginName,
                        d.WorkOrderNumber, FormatPhoneNumber(d.PhoneNumber), d.Timestamp);
                    Pins.Add(new PushPin(d.Latitude, d.Longitude, HeaderText, DescriptionText));
                }

                // Add the Virtual Earth control into the <head> of the page.

                HtmlGenericControl Include = new HtmlGenericControl("script");
                Include.Attributes.Add("type", "text/javascript");
                Include.Attributes.Add("src", "http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.1");
                Page.Header.Controls.Add(Include);

                // Configure the map and set the body attributes to run the javascript functions.

                ConfigureMap(StartLatitude, StartLongitude, Pins);
                Master.BodyControl.Attributes["onload"] = "InitializeMap(); AddPins();";
            }
        }
    }
}