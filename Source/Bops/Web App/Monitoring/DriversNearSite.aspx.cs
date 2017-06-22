using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using log4net;
using Configuration = NHibernate.Cfg.Configuration;

namespace Web_App.Monitoring
{
    public partial class DriversNearSite : System.Web.UI.Page
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(DriversNearSite));

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
        }

        #endregion

        #region Helper Methods
        private static string GetReaderString(SqlDataReader Reader, string FieldName)
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

        private static int GetReaderInteger(SqlDataReader Reader, string FieldName)
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

        private static double GetReaderDouble(SqlDataReader Reader, string FieldName)
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

        private static DateTime GetReaderDateTime(SqlDataReader Reader, string FieldName)
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

            ReturnValue.DriverId = GetReaderInteger(Reader, "EmployeeId");
            ReturnValue.FirstName = GetReaderString(Reader, "FirstName");
            ReturnValue.LastName = GetReaderString(Reader, "LastName");
            ReturnValue.PhoneNumber = GetReaderString(Reader, "WorkPhone");
            ReturnValue.Latitude = GetReaderDouble(Reader, "Latitude");
            ReturnValue.Longitude = GetReaderDouble(Reader, "Longitude");
            ReturnValue.Timestamp = GetReaderDateTime(Reader, "Timestamp");

            return ReturnValue;
        }

        private List<LatestDriverPosition> GetLatestDriverPositions()
        {
            string DatabaseConnectionString = ConfigurationManager.AppSettings["Db1Connection"];
            List<LatestDriverPosition> ReturnValue = new List<LatestDriverPosition>();

            using (SqlConnection Connection = new SqlConnection(DatabaseConnectionString))
            {
                using (SqlCommand Command = new SqlCommand("AgilisLatestDriverPositions", Connection))
                {
                    Connection.Open();

                    Command.CommandType = CommandType.StoredProcedure;
                    //Command.Parameters.Add("@BeginDate", SqlDbType.DateTime).Value = Begin;
                    //Command.Parameters.Add("@EndDate", SqlDbType.DateTime).Value = End;

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

        private double DegreesToRadians(double Degrees)
        {
            return Degrees * Math.PI / 180;
        }

        private double Square(double x)
        {
            return x * x;
        }

        private double ComputeSphericalDistance(double Latitude1, double Longitude1, double Latitude2, double Longitude2)
        {
            const double EarthRadius = 3956.0;

            Latitude1 = DegreesToRadians(Latitude1);
            Longitude1 = DegreesToRadians(Longitude1);
            Latitude2 = DegreesToRadians(Latitude2);
            Longitude2 = DegreesToRadians(Longitude2);

            double LatDelta = Latitude2 - Latitude1;
            double LonDelta = Longitude2 - Longitude1;

            double Temp = Square(Math.Sin(LatDelta / 2)) + Math.Cos(Latitude1) * Math.Cos(Latitude2) * Square(Math.Sin(LonDelta / 2));
            double CentralAngle = 2 * Math.Atan2(Math.Sqrt(Temp), Math.Sqrt(1 - Temp));

            return EarthRadius * CentralAngle;
        }

        private void ConfigureMap(double SiteLatitude, double SiteLongitude, List<PushPin> Pins)
        {
            StringBuilder s = new StringBuilder(
                "<script type=\"text/javascript\">" + Environment.NewLine +
                    "var map1 = null;" + Environment.NewLine +

                    "function InitializeMap()" + Environment.NewLine +
                    "{" + Environment.NewLine +
                        "    map1 = new VEMap('map1');" + Environment.NewLine +
                        "    map1.LoadMap(new VELatLong(" + SiteLatitude + ", " + SiteLongitude + "), 17, VEMapStyle.Hybrid, false, VEMapMode.Mode2D, false);" + Environment.NewLine +
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

        private string MakeClientNameAndAddress(BopsDestination d)
        {
            return string.Format("{0} - {1}, {2}, {3} {4}", d.Name ?? string.Empty,
                d.StreetAddress1 ?? string.Empty, d.City ?? string.Empty,
                d.State ?? string.Empty, d.Zip ?? string.Empty);
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

                int DestId;
                if (Request.Params["DestId"] != null)
                    DestId = Convert.ToInt32(Request.Params["DestId"]);
                else
                    DestId = Convert.ToInt32(ConfigurationManager.AppSettings["BudwayDestinationId"]);

                // There's no way we should fail to have a destination ID by now.
                Debug.Assert(DestId != 0);

                /*
                 * The default cutoff distance is five miles. This could be accessed programmatically
                 * if desired, but five miles seems a pretty safe bet for the moment. The default latitude
                 * and longitude are of Budway, for safety's sake.
                 */

                const double CutoffDistance = 5.0;
                double SiteLatitude = 34.091;
                double SiteLongitude = -117.51;

                string DwsRepFile = Path.Combine(Request.PhysicalApplicationPath, "NHibernateDwsRepData.xml.config");
                ISessionFactory DwsRepDataSessionFactory = new Configuration()
                    .Configure(DwsRepFile)
                    .BuildSessionFactory();

                using (ISession DwsRepDataSession = DwsRepDataSessionFactory.OpenSession())
                {
                    DwsRepDataSessionFactory.Close();

                    if (DestId != 0)
                    {
                        BopsDestination Dest = (BopsDestination)DwsRepDataSession.Load(typeof(BopsDestination), DestId);
                        if (Dest != null && Dest.Latitude != 0 && Dest.Longitude != 0)
                        {
                            SiteLatitude = Dest.Latitude;
                            SiteLongitude = Dest.Longitude;
                        }
                    }

                    // If this isn't a post back, then we need to load up the destination list.

                    if (!IsPostBack)
                    {
                        IList Destinations = DwsRepDataSession.CreateCriteria(typeof(BopsDestination))
                            .Add(Expression.Not(Expression.Eq("Latitude", 0.0)))
                            .Add(Expression.Not(Expression.Eq("Longitude", 0.0)))
                            .List();

                        foreach (BopsDestination d in Destinations)
                        {
                            ListItem NewItem = new ListItem();
                            NewItem.Text = MakeClientNameAndAddress(d);
                            NewItem.Value = d.DestinationId.ToString();
                            DestinationList.Items.Add(NewItem);
                        }

                        for (int i = 0; i < DestinationList.Items.Count; i++)
                        {
                            if (DestinationList.Items[i].Value.CompareTo(DestId.ToString()) == 0)
                                DestinationList.SelectedIndex = i;
                        }
                    }

                    DwsRepDataSession.Close();
                }

                // Finally, put together a list of pushpins that should appear on the map.

                List<PushPin> Pins = new List<PushPin>();
                List<LatestDriverPosition> Drivers = GetLatestDriverPositions();

                foreach (LatestDriverPosition d in Drivers)
                {
                    double DistanceFromSite = ComputeSphericalDistance(SiteLatitude, SiteLongitude, d.Latitude, d.Longitude);
                    if (DistanceFromSite <= CutoffDistance)
                    {
                        string HeaderText = d.FirstName + " " + d.LastName;
                        string DescriptionText = string.Format("{0}<br>{1}", FormatPhoneNumber(d.PhoneNumber), d.Timestamp);

                        Pins.Add(new PushPin(d.Latitude, d.Longitude, HeaderText, DescriptionText));
                    }
                }

                // Add the Virtual Earth control into the <head> of the page.

                HtmlGenericControl Include = new HtmlGenericControl("script");
                Include.Attributes.Add("type", "text/javascript");
                Include.Attributes.Add("src", "http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.1");
                Page.Header.Controls.Add(Include);

                // Configure the map and set the body attributes to run the javascript functions.

                ConfigureMap(SiteLatitude, SiteLongitude, Pins);
                Master.BodyControl.Attributes["onload"] = "InitializeMap(); AddPins();";
            }
        }

        protected void DestinationList_SelectedIndexChanged(object sender, EventArgs e)
        {
            int NewDestId = Convert.ToInt32(DestinationList.SelectedValue);
            string RedirectPage = Request.CurrentExecutionFilePath + "?DestId=" + NewDestId;
            Context.Response.Redirect(RedirectPage);
        }
    }
}