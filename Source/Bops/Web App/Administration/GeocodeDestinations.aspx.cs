using System;
using System.IO;
using BopsDataAccess;
using Client_Geocoding_Utility.us.geocoder.rpc;
using log4net;
using NHibernate;
using NHibernateUtilities;
using GeocoderAddressResult = Web_App.GeoCode_Service.GeocoderAddressResult;

public partial class Administration_GeocodeDestinations : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Administration_GeocodeDestinations));

    private const string _DwsRepData = "NHibernateDwsRepData.xml.config";

    private void UpdateAddressFields()
    {
        bool Clear = true;
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
        SessionManager<string> Mgr = new SessionManager<string>();
        ISession DwsRepSession = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

        if (DestinationDropdown.SelectedValue != string.Empty)
        {
            int DestinationId = Convert.ToInt32(DestinationDropdown.SelectedValue);
            BopsDestination Destination = DwsRepSession.Get<BopsDestination>(DestinationId);

            if (Destination != null)
            {
                AddressTextbox.Text = Destination.StreetAddress1;
                CityTextbox.Text = Destination.City;
                StateTextbox.Text = Destination.State;
                ZipTextbox.Text = Destination.Zip;

                if (Destination.Latitude != 0 && Destination.Longitude != 0)
                {
                    LatitudeTextbox.Text = Destination.Latitude.ToString();
                    LongitudeTextbox.Text = Destination.Longitude.ToString();
                }
                else
                {
                    LatitudeTextbox.Text = string.Empty;
                    LongitudeTextbox.Text = string.Empty;
                }

                Clear = false;
            }
        }

        Mgr.RemoveAllSessions(false);

        if (Clear)
            AddressTextbox.Text = CityTextbox.Text = StateTextbox.Text = ZipTextbox.Text = LatitudeTextbox.Text = LongitudeTextbox.Text = string.Empty;

        GeocodingFailureLabel.Visible = false;
        ShowLocationHyperlink.Visible = false;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DestinationDropdown.DataBind();
            DestinationDropdown.SelectedValue = DestinationDropdown.Items[0].Value;
            UpdateAddressFields();
        }
    }

    protected void DestinationDropdown_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateAddressFields();
    }

    private string MakeGeocodeAddress()
    {
        return string.Format("{0}, {1}, {2} {3}", AddressTextbox.Text, CityTextbox.Text, StateTextbox.Text, ZipTextbox.Text);
    }

    protected void GeocodeButton_Click(object sender, EventArgs e)
    {
        bool ShowError = true;
        GeoCode_Service Geocoder = new GeoCode_Service();
        string GeocodeAddress = MakeGeocodeAddress();

        try
        {
            object[] Result = Geocoder.geocode_address(GeocodeAddress);

            if (Result.Length == 1)
            {
                GeocoderAddressResult r = (GeocoderAddressResult)Result[0];

                if (r.lat != 0 && r.@long != 0)
                {
                    LatitudeTextbox.Text = r.lat.ToString();
                    LongitudeTextbox.Text = r.@long.ToString();
                    string HeaderText = Server.UrlEncode(DestinationDropdown.SelectedItem.Text);
                    string DescriptionText = Server.UrlEncode(string.Format("{0}, {1}, {2} {3}", 
                        AddressTextbox.Text, CityTextbox.Text, StateTextbox.Text, ZipTextbox.Text));
                    ShowLocationHyperlink.NavigateUrl =
                        string.Format("~/Monitoring/ShowLocation.aspx?Latitude={0}&Longitude={1}&Header={2}&Description={3}",
                                      LatitudeTextbox.Text, LongitudeTextbox.Text, HeaderText, DescriptionText);
                    ShowLocationHyperlink.Target = "_blank";
                    ShowError = false;
                }
            }
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }

        GeocodingFailureLabel.Visible = ShowError;
        ShowLocationHyperlink.Visible = !ShowError;
    }

    private void UpdateDestination(bool IncludeAddress)
    {
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
        SessionManager<string> Mgr = new SessionManager<string>();
        ISession DwsRepSession = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

        if (DestinationDropdown.SelectedValue != string.Empty)
        {
            int DestinationId = Convert.ToInt32(DestinationDropdown.SelectedValue);
            BopsDestination Destination = DwsRepSession.Get<BopsDestination>(DestinationId);

            if (Destination != null)
            {
                double Latitude, Longitude;

                if (double.TryParse(LatitudeTextbox.Text, out Latitude) &&
                    double.TryParse(LongitudeTextbox.Text, out Longitude))
                {
                    Destination.Latitude = Latitude;
                    Destination.Longitude = Longitude;

                    if (IncludeAddress)
                    {
                        Destination.StreetAddress1 = AddressTextbox.Text;
                        Destination.City = CityTextbox.Text;
                        Destination.State = StateTextbox.Text;
                        Destination.Zip = ZipTextbox.Text;
                    }

                    Mgr.BeginTransaction(_DwsRepData);
                    DwsRepSession.Update(Destination);
                }
            }
        }
        
        Mgr.RemoveAllSessions(true);
        DestinationDropdown.DataBind();
        UpdateAddressFields();
    }

    protected void UpdateCoordinatesButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            UpdateDestination(false);
    }

    protected void UpdateCoordinatesAndAddressButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            UpdateDestination(true);
    }
}
