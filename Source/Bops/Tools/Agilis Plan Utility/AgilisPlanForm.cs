using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Text;
using System.Windows.Forms;
using AgilisCore;
using BopsDataAccess;
using log4net;
using log4net.Config;
using NHibernate;
using NHibernate.Criterion;
using Configuration=NHibernate.Cfg.Configuration;
[assembly: XmlConfigurator(Watch = true)]

namespace Agilis_Plan_Utility
{
    public partial class AgilisPlanForm : Form, IAgilisStatusInterface
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisPlanForm));

        private List<Data> _DisplayData;

        private string _AgilisRestUrl;
        private string _AgilisRestCompany;
        private string _AgilisUserId;
        private string _AgilisPassword;

        public List<Data> DisplayData
        {
            get { return _DisplayData; }
            set { _DisplayData = value; }
        }

        public AgilisPlanForm()
        {
            InitializeComponent();

            _AgilisRestUrl = ConfigurationManager.AppSettings["AgilisRestUrl"];
            _AgilisRestCompany = ConfigurationManager.AppSettings["AgilisRestCompany"];
            _AgilisUserId = ConfigurationManager.AppSettings["AgilisUserId"];
            _AgilisPassword = ConfigurationManager.AppSettings["AgilisPassword"];

            string[] Columns = { "Plan Date", "Driver", "Driver ID", "PDID", "Number", "Status", "Jobs", "History", "Last Update" };

            foreach (string ColumnName in Columns)
            {
                listView1.Columns.Add(ColumnName, -2, HorizontalAlignment.Left);
            }

            ProgressUpdate("", "", 0, 0);
        }

        private static int CompareData(Data left, Data right)
        {
            if (left.WorkOrder.SlotStartDate < right.WorkOrder.SlotStartDate)
                return -1;
            else if (left.WorkOrder.SlotStartDate > right.WorkOrder.SlotStartDate)
                return 1;

            int NameCompare = left.DriverName.CompareTo(right.DriverName);
            if (NameCompare != 0)
                return NameCompare;

            if (left.WorkOrder.Sequence < right.WorkOrder.Sequence)
                return -1;
            else if (left.WorkOrder.Sequence > right.WorkOrder.Sequence)
                return 1;
            else
                return 0;
        }

        private void QueryWorkOrders(DateTime StartTime, DateTime EndTime, string ReadFromFileName)
        {
            _Log.InfoFormat("Querying work orders from {0} to {1}", StartTime, EndTime);

            Configuration NHibernateConfiguration = new Configuration();
            NHibernateConfiguration.AddAssembly("BopsDataAccess");
            ISessionFactory NHibernateSessionFactory = NHibernateConfiguration.BuildSessionFactory();

            using (ISession NHibernateSession = NHibernateSessionFactory.OpenSession())
            {
                NHibernateSessionFactory.Close();
                Dictionary<int, BopsDriver> DriverLookup = new Dictionary<int, BopsDriver>();
                _DisplayData = new List<Data>();
                List<AgilisWorkOrder> AgilisData;
                AgilisQuery Query = new AgilisQuery(_AgilisRestUrl, _AgilisRestCompany);

                if (ReadFromFileName == null)
                    AgilisData = Query.GetWorkOrdersByPlanDate(_AgilisUserId, _AgilisPassword, StartTime, "AgilisPlanUtility.xml", this);
                else
                    AgilisData = Query.GetWorkOrdersFromFile(ReadFromFileName, this);
            
                foreach (AgilisWorkOrder order in AgilisData)
                {
                    BopsDriver DriverData;

                    try
                    {
                        if (DriverLookup.ContainsKey(order.DriverNumber))
                        {
                            DriverData = DriverLookup[order.DriverNumber];
                        }
                        else
                        {
                            DriverData = (BopsDriver)NHibernateSession.Load(typeof(BopsDriver), order.DriverNumber);
                            DriverLookup.Add(order.DriverNumber, DriverData);
                        }
                    }
                    catch (Exception e)
                    {
                        // If we got an exception looking up driver data, let's add dummy
                        // values for sake of displaying something meaningful.

                        DriverData = new BopsDriver();
                        DriverData.DriverId = order.DriverNumber;
                        DriverData.LastName = "?";
                        DriverData.FirstName = "?";
                        DriverLookup.Add(order.DriverNumber, DriverData);   // cache the failure
                        _Log.Error(e);
                    }

                    string DriverName = string.Format("{0}, {1}", DriverData.LastName, DriverData.FirstName);
                    _DisplayData.Add(new Data(DriverName, order));
                }

                NHibernateSession.Close();
                _DisplayData.Sort(CompareData);
                LoadWorkOrders();

                statusStrip1.Items["toolStripStatusLabel1"].Text = string.Format("Displaying {0} work orders", _DisplayData.Count);
                statusStrip1.Update();
            }
        }

        private void LoadWorkOrders()
        {
            listView1.Items.Clear();

            foreach (Data w in _DisplayData)
            {
                ListViewItem Item = new ListViewItem(w.WorkOrder.SlotStartDate.ToShortDateString());
                Item.SubItems.Add(w.DriverName);
                Item.SubItems.Add(w.WorkOrder.DriverNumber.ToString());
                Item.SubItems.Add(w.WorkOrder.PlannerDetailId.ToString());
                Item.SubItems.Add(w.WorkOrder.WorkOrderNumber);
                Item.SubItems.Add(w.WorkOrder.CurrentStatus);
                Item.SubItems.Add(w.WorkOrder.Jobs.Count.ToString());

                int HistoryCount = 0;
                foreach (AgilisWorkOrderJob job in w.WorkOrder.Jobs)
                    HistoryCount += job.History.Count;

                Item.SubItems.Add(HistoryCount.ToString());
                Item.SubItems.Add(w.WorkOrder.StatusLastUpdated.ToString("G"));
                listView1.Items.Add(Item);
            }

            foreach (ColumnHeader Hdr in listView1.Columns)
                Hdr.Width = -2;
        }

        public void ProgressUpdate(string PrimaryText, string SecondaryText, int CurrentNumber, int TotalNumber)
        {
            statusStrip1.Items["toolStripStatusLabel1"].Text = PrimaryText;
            statusStrip1.Update();
        }

        private void yesterdaysPlanToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DateTime StartTime = DateTime.Now.Date.AddDays(-1);
            DateTime EndTime = StartTime.AddDays(1);
            QueryWorkOrders(StartTime, EndTime, null);
        }

        private void todaysPlanToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DateTime StartTime = DateTime.Now.Date;
            DateTime EndTime = StartTime.AddDays(1);
            QueryWorkOrders(StartTime, EndTime, null);
        }

        private void tomorrowToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DateTime StartTime = DateTime.Now.Date.AddDays(1);
            DateTime EndTime = StartTime.AddDays(1);
            QueryWorkOrders(StartTime, EndTime, null);
        }

        private void fromFileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OpenFileDialog PickRawFileDialog = new OpenFileDialog();
            PickRawFileDialog.Title = "Specify Work Orders Input File Name";
            PickRawFileDialog.Filter = "XML Files (*.xml)|*.xml|All files (*.*)|*.*";
            PickRawFileDialog.DefaultExt = "xml";
            PickRawFileDialog.FilterIndex = 1;
            //PickRawFileDialog.FileName = "";
            PickRawFileDialog.InitialDirectory = Directory.GetCurrentDirectory();

            if (PickRawFileDialog.ShowDialog() == DialogResult.OK)
                QueryWorkOrders(DateTime.MinValue, DateTime.MinValue, PickRawFileDialog.FileName);
        }

        private void checkDriversForTomorrowsPlanToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // First, get the work orders for tomorrow's plan.

            string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

            DateTime StartTime = DateTime.Now.Date.AddDays(1);
            DateTime EndTime = StartTime.AddDays(1);

            Configuration NHibernateConfiguration = new Configuration();
            NHibernateConfiguration.AddAssembly("BopsDataAccess");
            ISessionFactory NHibernateSessionFactory = NHibernateConfiguration.BuildSessionFactory();

            using (ISession NHibernateSession = NHibernateSessionFactory.OpenSession())
            {
                NHibernateSessionFactory.Close();

                AgilisSynchronizer Synchronizer = new AgilisSynchronizer(_AgilisRestUrl, _AgilisRestCompany, _AgilisUserId, _AgilisPassword, 
                    DbServer, NHibernateSession, false);

                List<AgilisWorkOrder> Plan = Synchronizer.GetDailyPlanWorkOrders(StartTime, EndTime, false);

                // Next, query the list of drivers from Agilis.

                AgilisQuery Query = new AgilisQuery(_AgilisRestUrl, _AgilisRestCompany);
                List<AgilisDriver> Drivers = Query.GetDrivers(_AgilisUserId, _AgilisPassword, "AgilisPlanUtility.xml", this);

                // Build a dictionary of the drivers', keyed by their numeric IDs.

                Dictionary<int, AgilisDriver> DriverIndex = new Dictionary<int, AgilisDriver>();
                foreach (AgilisDriver Driver in Drivers)
                {
                    if (DriverIndex.ContainsKey(Driver.DriverId))
                    {
                        // TODO: we might want to make noise if we have duplicate IDs, but I don't think Agilis allows it.

                        DriverIndex[Driver.DriverId] = Driver;
                    }
                    else
                    {
                        DriverIndex.Add(Driver.DriverId, Driver);
                    }
                }

                Dictionary<int, BopsDriver> DriversNeedingUploadIndex = new Dictionary<int, BopsDriver>();

                foreach (AgilisWorkOrder WorkOrder in Plan)
                {
                    if (!DriverIndex.ContainsKey(WorkOrder.DriverNumber))
                    {
                        if (!DriversNeedingUploadIndex.ContainsKey(WorkOrder.DriverNumber))
                        {
                            BopsDriver DriverToUpload = (BopsDriver)NHibernateSession.Load(typeof(BopsDriver), WorkOrder.DriverNumber);
                            DriversNeedingUploadIndex.Add(WorkOrder.DriverNumber, DriverToUpload);
                        }
                    }
                }

                StringBuilder Message = new StringBuilder();

                if (DriversNeedingUploadIndex.Count == 0)
                {
                    Message.Append("All drivers in tomorrow's plan are on the Agilis site.");
                }
                else
                {
                    int Number = 0;
                    Message.Append("The following drivers need to be uploaded (or have their driver IDs set correctly): ");

                    foreach (KeyValuePair<int, BopsDriver> pair in DriversNeedingUploadIndex)
                    {
                        if (Number == 0)
                            Message.AppendFormat("{0} {1}", pair.Value.FirstName, pair.Value.LastName);
                        else
                            Message.AppendFormat(", {0} {1}", pair.Value.FirstName, pair.Value.LastName);

                        Number++;
                    }
                }

                MessageBox.Show(Message.ToString(), "Results of Driver Check");
                NHibernateSession.Close();
            }
        }

        private void cancelToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DialogResult Confirm = MessageBox.Show("Are you sure you want to cancel the selected work orders?", "Confirm Cancel", 
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (Confirm == DialogResult.Yes)
            {
                List<AgilisWorkOrder> DoomedWorkOrders = new List<AgilisWorkOrder>();

                foreach (int index in listView1.SelectedIndices)
                    DoomedWorkOrders.Add(_DisplayData[index].WorkOrder);

                AgilisExporter Exporter = new AgilisExporter(_AgilisRestUrl, _AgilisRestCompany, AgilisExportMode.Update, false, false);
                AgilisIntegrationOperation Result = Exporter.CancelWorkOrders(DoomedWorkOrders, _AgilisUserId, _AgilisPassword, this);

                if (!Result.Successful)
                {
                    MessageBox.Show("An error occurred while cancelling. Check the log for details.", "Error",
                                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void querySignaturesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string WorkOrderNumber;

            if (listView1.SelectedIndices.Count != 1)
            {
                FindForm f = new FindForm();
                DialogResult r = f.ShowDialog();

                if (r != System.Windows.Forms.DialogResult.OK)
                    return;

                WorkOrderNumber = f.WorkOrderNumber;
            }
            else
            {
                WorkOrderNumber = _DisplayData[listView1.SelectedIndices[0]].WorkOrder.WorkOrderNumber;
            }

            AgilisQuery Query = new AgilisQuery(_AgilisRestUrl, _AgilisRestCompany);
            List<AgilisSignature> Signatures = Query.GetWorkOrderSignatures(_AgilisUserId, _AgilisPassword, WorkOrderNumber, this);
            if (Signatures.Count == 0)
                MessageBox.Show("No signatures were retrieved.");
        }

        private void findToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FindForm f = new FindForm();
            DialogResult r = f.ShowDialog();

            if (r == System.Windows.Forms.DialogResult.OK)
            {
                listView1.SelectedIndices.Clear();

                for (int i = 0; i < _DisplayData.Count; i++)
                {
                    if (_DisplayData[i].WorkOrder.WorkOrderNumber.CompareTo(f.WorkOrderNumber) == 0)
                    {
                        listView1.SelectedIndices.Add(i);
                        listView1.EnsureVisible(i);
                        return;
                    }
                }
            }
        }

        private void copyWorkOrderNumberToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (listView1.SelectedIndices.Count == 1)
            {
                string WorkOrderNumber = _DisplayData[listView1.SelectedIndices[0]].WorkOrder.WorkOrderNumber;
                Clipboard.SetText(WorkOrderNumber);
            }
        }

        private bool DailyPlanIsReady(ISession NHibernateSession, DateTime PlanDate)
        {
            IList DailyPlans = NHibernateSession.CreateCriteria(typeof(BopsDriverPlanArchive))
                .Add(Expression.Eq("PlanDate", PlanDate))
                .List();

            return DailyPlans.Count > 0;
        }

        private void checkIfTomorrowsPlanIsReadyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Configuration NHibernateConfiguration = new Configuration();
            NHibernateConfiguration.AddAssembly("BopsDataAccess");
            ISessionFactory NHibernateSessionFactory = NHibernateConfiguration.BuildSessionFactory();

            using (ISession NHibernateSession = NHibernateSessionFactory.OpenSession())
            {
                NHibernateSessionFactory.Close();

                if (DailyPlanIsReady(NHibernateSession, DateTime.Now.Date.AddDays(1)))
                    MessageBox.Show("Tomorrow's plan is ready for upload.");
                else
                    MessageBox.Show("Tomorrow's plan is not ready!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                NHibernateSession.Close();
            }
        }

        private void clearToolStripMenuItem_Click(object sender, EventArgs e)
        {
            listView1.Items.Clear();
            _DisplayData.Clear();
            GC.Collect();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }
    }

    #region Data Helper Class
    public class Data
    {
        private string _DriverName;
        private AgilisWorkOrder _WorkOrder;

        public Data(string _DriverName, AgilisWorkOrder _WorkOrder)
        {
            this._DriverName = _DriverName;
            this._WorkOrder = _WorkOrder;
        }

        public string DriverName
        {
            get { return _DriverName; }
            set { _DriverName = value; }
        }

        public AgilisWorkOrder WorkOrder
        {
            get { return _WorkOrder; }
            set { _WorkOrder = value; }
        }
    }
    #endregion

}