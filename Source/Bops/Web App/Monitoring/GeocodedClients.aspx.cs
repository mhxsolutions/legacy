using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Web.UI.HtmlControls;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;
using log4net;

namespace Web_App.Monitoring
{
    public partial class GeocodedClients : System.Web.UI.Page
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof (GeocodedClients));
        private const string _DwsRepData = "NHibernateDwsRepData.xml.config";

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

        #endregion

        #region Helper Methods

        private void ConfigureMap(double SiteLatitude, double SiteLongitude, IEnumerable<PushPin> Pins)
        {
            StringBuilder s = new StringBuilder(
                "<script type=\"text/javascript\">" + Environment.NewLine +
                "var map1 = null;" + Environment.NewLine +

                "function InitializeMap()" + Environment.NewLine +
                "{" + Environment.NewLine +
                "    map1 = new VEMap('map1');" + Environment.NewLine +
                "    map1.LoadMap(new VELatLong(" + SiteLatitude + ", " + SiteLongitude +
                "), 10, VEMapStyle.Road , false, VEMapMode.Mode2D, false);" + Environment.NewLine +
                "    map1.HideDashboard();" + Environment.NewLine +
                "}" + Environment.NewLine +

                "function AddPins()" + Environment.NewLine +
                "{" + Environment.NewLine
                );

            int PinId = 1;

            foreach (PushPin pin in Pins)
            {
                s.AppendLine(string.Format(
                    "    var pin{0} = new VEShape(VEShapeType.Pushpin, new VELatLong({1}, {2}));", PinId, pin.Latitude,
                    pin.Longitude));
                s.AppendLine(string.Format("    pin{0}.SetTitle('{1}');", PinId, pin.Header));
                s.AppendLine(string.Format("    pin{0}.SetDescription('{1}');", PinId, pin.Description));
                s.AppendLine(string.Format("    map1.AddShape(pin{0});", PinId));

                PinId++;
            }

            s.AppendLine("}");
            s.AppendLine("</script>");

            ClientScript.RegisterClientScriptBlock(GetType(), "MapScript", s.ToString());
        }

        private string MakeOneLineAddress(BopsDestination d)
        {
            StringBuilder sb = new StringBuilder();

            if (d.StreetAddress1 != null)
                sb.AppendFormat("{0}<br />", d.StreetAddress1);

            if (d.State != null && d.PostalCode != null)
                sb.AppendFormat("{0}, {1} {2}", d.City, d.State, d.Zip);
            else
                sb.Append(d.City);

            if (d.ContactName != null && d.ContactVoicePhoneNumber != null)
            {
                if (d.ContactEmailAddress != null)
                    sb.AppendFormat("<br />Contact: <a href=\"mailto:{0}\">{1}</a> at {2}<br />", d.ContactEmailAddress,
                                    d.ContactName, d.ContactVoicePhoneNumber);
                else
                    sb.AppendFormat("<br />Contact: {0} at {1}<br />", d.ContactName, d.ContactVoicePhoneNumber);
            }

            return sb.ToString();
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                const double StartLatitude = 33.92635; // Centered right above the 710/405 intersection
                const double StartLongitude = -118.1073;
                SessionManager<string> Mgr = new SessionManager<string>();

                try
                {
                    List<PushPin> Pins = new List<PushPin>();
                    string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
                    ISession DwsNoRepData = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

                    IList<BopsDestination> Destinations = DwsNoRepData.CreateCriteria(typeof (BopsDestination))
                                                                      .Add(
                                                                          Expression.Not(Expression.Eq("Latitude",
                                                                                                       (double) 0)))
                                                                      .Add(
                                                                          Expression.Not(Expression.Eq("Longitude",
                                                                                                       (double) 0)))
                                                                      .List<BopsDestination>();

                    foreach (BopsDestination d in Destinations)
                    {
                        string HeaderText = d.Name;
                        Pins.Add(new PushPin(d.Latitude, d.Longitude, HeaderText, MakeOneLineAddress(d)));
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
                catch (Exception e1)
                {
                    _Log.Error(e1);
                }
                finally
                {
                    Mgr.CloseAllSessions(false);
                }
            }
        }
    }
}