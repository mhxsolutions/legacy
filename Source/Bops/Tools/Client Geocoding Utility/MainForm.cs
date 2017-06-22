using System;
using System.Collections;
using System.Threading;
using System.Windows.Forms;
using BopsDataAccess;
using Client_Geocoding_Utility.us.geocoder.rpc;
using NHibernate;
using NHibernate.Cfg;
using log4net;
using log4net.Config;
[assembly: XmlConfigurator(Watch = true)]

namespace Client_Geocoding_Utility
{
    public delegate void DeleteStatusUpdate(string s, int Min, int Max, int Current);
    public delegate void DelegateAddListviewItem(ListViewItem item);
    public delegate void DelegateThreadFinished();

    public partial class MainForm : Form
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(MainForm));

        private Thread _GeocodingThread;
        ManualResetEvent _EventStopThread;
        ManualResetEvent _EventThreadStopped;

        public DelegateAddListviewItem _DelegateAddListviewItem;
        public DelegateThreadFinished _DelegateThreadFinished;
        public DeleteStatusUpdate _DelegateStatusUpdate;

        private GeoCode_Service _Geocoder;

        private ToolStripStatusLabel StatusText
        {
            get { return (ToolStripStatusLabel)statusStrip1.Items[0]; }
        }

        private ToolStripProgressBar StatusProgressBar
        {
            get { return (ToolStripProgressBar)statusStrip1.Items[1]; }
        }

        public MainForm()
        {
            InitializeComponent();
            StatusProgressBar.Visible = false;
            StatusText.Text = "";
            _Geocoder = new GeoCode_Service();

            _DelegateAddListviewItem = new DelegateAddListviewItem(AddListviewItem);
            _DelegateThreadFinished = new DelegateThreadFinished(GeocodingFinished);
            _DelegateStatusUpdate = new DeleteStatusUpdate(StatusUpdate);

            _EventStopThread = new ManualResetEvent(false);
            _EventThreadStopped = new ManualResetEvent(false);
        }

        private bool AddressIsAvailable(BopsDestination d)
        {
            return d.StreetAddress1 != null && d.StreetAddress1.Length > 0 &&
                   d.City != null && d.City.Length > 0 &&
                   d.State != null && d.State.Length > 0 &&
                   d.Zip != null && d.Zip.Length > 0;
        }

        private string MakeGeocodeAddress(BopsDestination d)
        {
            return string.Format("{0}, {1}, {2} {3}", d.StreetAddress1 ?? string.Empty, 
                d.City ?? string.Empty, d.State ?? string.Empty, d.Zip ?? string.Empty);
        }

        private void Geocode()
        {
            bool Cancelled = false;
            Configuration NHibernateConfiguration = new Configuration();
            NHibernateConfiguration.AddAssembly("BopsDataAccess");
            ISessionFactory NHibernateSessionFactory = NHibernateConfiguration.BuildSessionFactory();
            int FailureCount = 0;
            int SuccessCount = 0;

            using (ISession NHibernateSession = NHibernateSessionFactory.OpenSession())
            {
                ITransaction NHibernateTransaction = NHibernateSession.BeginTransaction();
                IList Clients = NHibernateSession.CreateCriteria(typeof(BopsDestination))
                    .List();
                int NumberToGeocode = Clients.Count;
                Invoke(_DelegateStatusUpdate, new object[] { "Initializing...", 1, NumberToGeocode, -1 });

                for (int i = 0; i < NumberToGeocode; i++)
                {
                    BopsDestination client = (BopsDestination)Clients[i];
                    string GeocodeAddress = MakeGeocodeAddress(client);

                    _Log.InfoFormat("Geocoding {0}, {1}", client.Name, GeocodeAddress);

                    if (AddressIsAvailable(client))
                    {
                        float Latitude = 0;
                        float Longitude = 0;
                        string StatusMessage = string.Format("Geocoding {0}, {1}...", client.Name, GeocodeAddress);

                        Invoke(_DelegateStatusUpdate, new object[] { StatusMessage, 0, 0, i + 1 });

                        try
                        {
                            object[] Result = _Geocoder.geocode_address(GeocodeAddress);

                            if (Result.Length == 1)
                            {
                                GeocoderAddressResult r = (GeocoderAddressResult)Result[0];
                                Latitude = r.lat;
                                Longitude = r.@long;
                            }

                            ListViewItem n = new ListViewItem(client.Name);
                            n.SubItems.Add(client.StreetAddress1);
                            n.SubItems.Add(client.City);
                            n.SubItems.Add(client.State);
                            n.SubItems.Add(client.Zip);

                            if (client.DestinationId == client.ParentRef)
                                n.SubItems.Add("True");
                            else
                                n.SubItems.Add("False");

                            if (Latitude != 0 && Longitude != 0)
                            {
                                n.SubItems.Add(Latitude.ToString());
                                n.SubItems.Add(Longitude.ToString());
                            }

                            client.Latitude = Latitude;
                            client.Longitude = Longitude;
                            NHibernateSession.Update(client);

                            Invoke(_DelegateAddListviewItem, new object[] {n});

                            SuccessCount++;
                        }
                        catch (Exception ex)
                        {
                            FailureCount++;
                            _Log.Error(ex);
                        }

                        if (_EventStopThread.WaitOne(0, true))
                        {
                            _Log.Info("Geocoding cancelled by user, exiting secondary thread");
                            Cancelled = true;
                            goto exit_routine;
                        }
                    }
                    else
                    {
                        _Log.WarnFormat("Invalid address for ID {0}, {1}", client.DestinationId, client.Name);
                    }
                }

            exit_routine:

                if (Cancelled)
                    NHibernateTransaction.Rollback();
                else
                    NHibernateTransaction.Commit();

                NHibernateSession.Close();
            }

            NHibernateSessionFactory.Close();
            _Log.InfoFormat("Geocoding thread exiting with {0} successes and {1} failures", SuccessCount, FailureCount);

            if (Cancelled)
                _EventThreadStopped.Set();
            else
                Invoke(_DelegateThreadFinished, null);
        }

        private void GeocodeButton_Click(object sender, EventArgs e)
        {
            if (_GeocodingThread == null)
            {
                _Log.Info("Beginning geocoding");
                StatusProgressBar.Visible = true;

                GeocodeButton.Text = "Cancel";
                _EventStopThread.Reset();
                _EventThreadStopped.Reset();
                _GeocodingThread = new Thread(new ThreadStart(Geocode));
                _GeocodingThread.Name = "Geocoding";
                _GeocodingThread.Start();
            }
            else
            {
                _Log.Info("Cancel request submitted");
                _EventStopThread.Set();
                StatusText.Text = "Cancelling...";
                GeocodeButton.Enabled = false;

                while (_GeocodingThread.IsAlive)
                {
                    if (WaitHandle.WaitAll((new ManualResetEvent[] { _EventThreadStopped }), 100, true))
                        break;

                    Application.DoEvents();
                }

                GeocodingFinished();
            }
        }

        private void AddListviewItem(ListViewItem item)
        {
            ClientListview.Items.Add(item);
        }

        private void GeocodingFinished()
        {
            _GeocodingThread = null;
            StatusProgressBar.Visible = false;
            StatusText.Text = "";
            GeocodeButton.Text = "Geocode All";
            GeocodeButton.Enabled = true;

            foreach (ColumnHeader h in ClientListview.Columns)
                h.Width = -2;

            _Log.Info("Geocoding finished");
        }

        private void StatusUpdate(string s, int Min, int Max, int Current)
        {
            if (s != null)
                StatusText.Text = s;

            if (Min != Max)
            {
                StatusProgressBar.Minimum = Min;
                StatusProgressBar.Maximum = Max;
            }

            if (Current >= 0)
                StatusProgressBar.Value = Current;
        }

        private void LookupButton_Click(object sender, EventArgs e)
        {
            GeocodeSingleClient d = new GeocodeSingleClient();
            d.ShowDialog();
        }
    }
}