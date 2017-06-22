using System;
using System.Collections;
using System.Windows.Forms;
using BopsDataAccess;
using Client_Geocoding_Utility.us.geocoder.rpc;
using log4net;
using NHibernate;
using NHibernate.Cfg;

namespace Client_Geocoding_Utility
{
    public partial class GeocodeSingleClient : Form
    {
        private class Client
        {
            private BopsDestination _ClientDetails;

            public BopsDestination ClientDetails
            {
                get { return _ClientDetails; }
            }

            public Client(BopsDestination _ClientDetails)
            {
                this._ClientDetails = _ClientDetails;
            }

            private string MakeClientNameAndAddress(BopsDestination d)
            {
                return string.Format("{0} - {1}, {2}, {3} {4}", d.Name ?? string.Empty,
                    d.StreetAddress1 ?? string.Empty, d.City ?? string.Empty,
                    d.State ?? string.Empty, d.Zip ?? string.Empty);
            }

            public override string ToString()
            {
                return MakeClientNameAndAddress(_ClientDetails);
            }
        }

        private static readonly ILog _Log = LogManager.GetLogger(typeof(GeocodeSingleClient));

        private GeoCode_Service _Geocoder;
        private ISession _Session;
        private Client _LastSuccessfulLookup;

        public GeocodeSingleClient()
        {
            InitializeComponent();

            _Geocoder = new GeoCode_Service();
            Closed += new EventHandler(OnClosed);
        }

        private void LoadClients()
        {
            Cursor = Cursors.WaitCursor;
            IList Clients = _Session.CreateCriteria(typeof(BopsDestination)).List();

            foreach (BopsDestination client in Clients)
                ClientCombobox.Items.Add(new Client(client));

            ClientCombobox.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
            ClientCombobox.AutoCompleteSource = AutoCompleteSource.ListItems;

            Cursor = Cursors.Default;
        }

        private void InitializeNHibernateSession()
        {
            Configuration NHibernateConfiguration = new Configuration();
            NHibernateConfiguration.AddAssembly("BopsDataAccess");
            ISessionFactory NHibernateSessionFactory = NHibernateConfiguration.BuildSessionFactory();
            _Session = NHibernateSessionFactory.OpenSession();
            NHibernateSessionFactory.Close();
        }

        private string MakeGeocodeAddress(BopsDestination d)
        {
            return string.Format("{0}, {1}, {2} {3}", d.StreetAddress1 ?? string.Empty,
                d.City ?? string.Empty, d.State ?? string.Empty, d.Zip ?? string.Empty);
        }

        private void LookupButton_Click(object sender, EventArgs e)
        {
            if (ClientCombobox.SelectedIndex >= 0)
            {
                Client c = (Client)ClientCombobox.Items[ClientCombobox.SelectedIndex];
                string GeocodeAddress = MakeGeocodeAddress(c.ClientDetails);

                Cursor = Cursors.WaitCursor;

                try
                {
                    object[] Result = _Geocoder.geocode_address(GeocodeAddress);
                    Cursor = Cursors.Default;

                    if (Result.Length == 1)
                    {
                        GeocoderAddressResult r = (GeocoderAddressResult)Result[0];
                        LatitudeTextbox.Text = r.lat.ToString();
                        LongitudeTextbox.Text = r.@long.ToString();

                        _LastSuccessfulLookup = c;
                        UpdateDatabaseButton.Enabled = true;
                    }
                }
                catch (Exception)
                {
                    Cursor = Cursors.Default;
                    MessageBox.Show("An exception occured, likely due to an invalid address.", "Geocoding Error",
                                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void OnClosed(object sender, EventArgs e)
        {
            _Log.Debug("Closing NHibernate session");
            _Session.Close();
        }

        private void GeocodeSingleClient_Load(object sender, EventArgs e)
        {
            InitializeNHibernateSession();
            LoadClients();
        }

        private void UpdateDatabaseButton_Click(object sender, EventArgs e)
        {
            UpdateDatabaseButton.Enabled = false;
            _LastSuccessfulLookup.ClientDetails.Latitude = Convert.ToDouble(LatitudeTextbox.Text);
            _LastSuccessfulLookup.ClientDetails.Longitude = Convert.ToDouble(LongitudeTextbox.Text);

            ITransaction tx = _Session.BeginTransaction();
            _Session.Update(_LastSuccessfulLookup.ClientDetails);
            _LastSuccessfulLookup = null;
            tx.Commit();
        }
    }
}