using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class Monitoring_ShowLocation : System.Web.UI.Page
{
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Add the Virtual Earth control into the <head> of the page.

            HtmlGenericControl Include = new HtmlGenericControl("script");
            Include.Attributes.Add("type", "text/javascript");
            Include.Attributes.Add("src", "http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.1");
            Page.Header.Controls.Add(Include);

            double StartLatitude = 33.82635;      // Centered right above the 710/405 intersection
            double StartLongitude = -118.2073;
            string HeaderText = "Location";
            string Description = string.Empty;

            if (Request.Params["Latitude"] != null)
                double.TryParse(Request.Params["Latitude"], out StartLatitude);
            if (Request.Params["Latitude"] != null)
                double.TryParse(Request.Params["Longitude"], out StartLongitude);
            if (Request.Params["Header"] != null)
                HeaderText = Request.Params["Header"];
            if (Request.Params["Description"] != null)
                Description = Request.Params["Description"];

            List<PushPin> Pins = new List<PushPin>();
            Pins.Add(new PushPin(StartLatitude, StartLongitude, HeaderText, Description));

            ConfigureMap(StartLatitude, StartLongitude, Pins);

            TitleLabel.Text = string.Format("Map Showing {0}", HeaderText);
        }
    }

    private void ConfigureMap(double SiteLatitude, double SiteLongitude, List<PushPin> Pins)
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
}
