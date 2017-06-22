using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
using AgilisCore;
using AgilisIntegrationServiceCore;
using BopsBusinessLogicAgilis;
using NHibernate;
using NHibernateUtilities;
using log4net;
using log4net.Config;

[assembly: XmlConfigurator(Watch = true)]

namespace Agilis_Synchronization_Utility
{
    public partial class AgilisSynchronizationForm : Form, IAgilisStatusInterface
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisSynchronizationForm));

        private const string _AgilisDemoSystemUrl = "https://demo.agilissystems.com/ibis/rest";
        private const string _AgilisDemoCompany = "1086";
        private const string _AgilisProductionSystemUrl = "https://ibis.agilissystems.com/ibis/rest";
        private const string _AgilisProductionCompany = "8231";

        private SessionManager<string> _SessionManager;
        private ISession _DwsNoRepSession;
        private ISession _EqManagerSession;

        private string AgilisRestUrl
        {
            get { return UseDemoSystem.Checked ? _AgilisDemoSystemUrl : _AgilisProductionSystemUrl; }
        }
        
        private string AgilisRestCompany
        {
            get { return UseDemoSystem.Checked ? _AgilisDemoCompany : _AgilisProductionCompany; }
        }
        
        public AgilisSynchronizationForm()
        {
            InitializeComponent();
        }

        protected override void OnLoad(EventArgs e)
        {
            _SessionManager = new SessionManager<string>();
            _DwsNoRepSession = _SessionManager.AddSession("NHibernateDwsNoRepData.xml.config", "NHibernateDwsNoRepData.xml.config");
            _EqManagerSession = _SessionManager.AddSession("NHibernateEqManager.xml.config", "NHibernateEqManager.xml.config");

            base.OnLoad(e);
        }

        protected override void OnClosed(EventArgs e)
        {
            _SessionManager.CloseAllSessions(true);

            base.OnClosed(e);
        }

        [Conditional("DEBUG")]
        private void InitializeCredentials()
        {
            if (UseDemoSystem.Checked)
            {
                UserId.Text = "mgr";
                Password.Text = "mgr";
            }
            else
            {
                UserId.Text = "jwilliston";
                Password.Text = "irronarr";
            }

        }
        
        private void AgilisSynchronizationForm_Load(object sender, EventArgs e)
        {
            ProgressUpdate("", "", 0, 0);
            StartDate.Value = DateTime.Now.Date;
            EndDate.Value = StartDate.Value.AddDays(1);
            NowButton_Click(null, null);
            InitializeCredentials();
        }

        private void ImportButton_Click(object sender, EventArgs e)
        {
            if (UserId.Text == "" || Password.Text == "")
            {
                MessageBox.Show("You must supply a user name and password to access the Agilis system.",
                                "Invalid Credentials", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            
            if (EndDate.Value <= StartDate.Value)
            {
                MessageBox.Show("The end date must be greater than the start date.",
                                "Invalid Interval", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (RawFile.Text == "")
            {
                MessageBox.Show("You must supply a valid name for the raw, XML output file.",
                                "Invalid File Name", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            
            DoImport();
        }

        public void ProgressUpdate(string PrimaryText, string SecondaryText, int CurrentNumber, int TotalNumber)
        {
            statusStrip1.Items["ProgressText"].Text = PrimaryText;
            statusStrip1.Update();
        }

        private void PickRawFile_Click(object sender, EventArgs e)
        {
            SaveFileDialog PickRawFileDialog = new SaveFileDialog();
            PickRawFileDialog.Title = "Specify Output File Name";
            PickRawFileDialog.Filter = "XML Files (*.xml)|*.xml|All files (*.*)|*.*";
            PickRawFileDialog.DefaultExt = "xml";
            PickRawFileDialog.FilterIndex = 1;
            PickRawFileDialog.FileName = RawFile.Text;
            PickRawFileDialog.InitialDirectory = Directory.GetCurrentDirectory();
            PickRawFileDialog.CheckFileExists = false;
            PickRawFileDialog.OverwritePrompt = false;

            if (PickRawFileDialog.ShowDialog() == DialogResult.OK)
                RawFile.Text = PickRawFileDialog.FileName;
        }
 
        private void DoImport()
        {
            bool ReadFromFile = false;

            if (File.Exists(RawFile.Text))
            {
                DialogResult r = MessageBox.Show("The specified file already exists. Would you like to read from it? (No means overwrite)",
                                                 "Confirm File Read", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question);

                if (r == DialogResult.Cancel)
                    return;
                else if (r == DialogResult.Yes)
                    ReadFromFile = true;
            }

            bool SyncDrivers = false;
            bool SyncDriverPositions = false;
            bool SyncDriverEvents = false;
            bool SyncWorkOrders = false;
            bool SyncWorkOrderSignatures = false;
            
            CheckedListBox.CheckedItemCollection DataToSynchronize = DataTypes.CheckedItems;
            foreach (object o in DataToSynchronize)
            {
                switch(o.ToString())
                {
                    case "Drivers":
                        SyncDrivers = true;
                        break;
                    case "Driver Events":
                        SyncDriverEvents = true;
                        break;
                    case "Driver Positions":
                        SyncDriverPositions = true;
                        break;
                    case "Work Orders":
                        SyncWorkOrders = true;
                        break;
                    case "Work Order Signatures":
                        SyncWorkOrderSignatures = true;
                        break; 
                }
            }
            
            bool BulkImport = UseOneTransaction.Checked;
            _Log.InfoFormat("Import beginning at {0}.", DateTime.Now.ToString("G"));
            
            if (BulkImport)
                _Log.Info("Using one database transaction for all operations.");
            else
                _Log.Info("Using one database transaction for each work order.");

            string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
            
            _Log.DebugFormat("Import beginning at {0}.", DateTime.Now.ToString("G"));
            _Log.DebugFormat("User ID:    {0}", UserId.Text);
            _Log.DebugFormat("Password:   {0}", Password.Text);
            _Log.DebugFormat("Start Date: {0}, {1} GMT", StartDate.Value.ToString("G"), StartDate.Value.ToUniversalTime().ToString("G"));
            _Log.DebugFormat("End Date:   {0}, {1} GMT", EndDate.Value.ToString("G"), EndDate.Value.ToUniversalTime().ToString("G"));
            _Log.DebugFormat("File Name:  {0}", RawFile.Text);

            AgilisSynchronizer Synchronizer = new AgilisSynchronizer(AgilisRestUrl, AgilisRestCompany, UserId.Text, Password.Text, DbServer, _DwsNoRepSession, false);
            Synchronizer.ReadAgilisDataFromFile = ReadFromFile;
            if (UseImportFilters.Checked)
                Synchronizer.Filters = AgilisOperationFilter.GetActiveFilters(_DwsNoRepSession, DateTime.Now);

            Synchronizer.SignaturesFolder = Path.Combine(Directory.GetCurrentDirectory(), "Signatures");
            if (!Directory.Exists(Synchronizer.SignaturesFolder))
                Directory.CreateDirectory(Synchronizer.SignaturesFolder);
            AgilisEventHandler EventHandlers = new AgilisEventHandler();
            EventHandlers.WorkOrderImportNotifier = new WorkOrderImportEventHandler(_DwsNoRepSession, _EqManagerSession);
            Synchronizer.EventHandler = EventHandlers;

            if (SyncDrivers)
            {
                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.Drivers, AgilisOperationTypes.Import, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }
            if (SyncDriverEvents)
            {
                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.DriverEvents, AgilisOperationTypes.Import, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }
            if (SyncDriverPositions)
            {
                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.DriverPositions, AgilisOperationTypes.Import, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }
            if (SyncWorkOrders)
            {
                List<AgilisIntegrationOperation> Result;

                if (UsePlanDateImport.Checked)
                    Result = Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ImportFull, StartDate.Value.Date, StartDate.Value.Date, RawFile.Text, this);
                else
                    Result = Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, AgilisOperationTypes.Import, StartDate.Value, EndDate.Value, RawFile.Text, this);

                LogSynchronizerResult(Result);
            }
            if (SyncWorkOrderSignatures)
            {
                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.WorkOrderSignatures, AgilisOperationTypes.Import, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }
            
            _Log.DebugFormat("Import ending at {0}.", DateTime.Now.ToString("G"));
        }

        private void LogSynchronizerResult(IList<AgilisIntegrationOperation> Result)
        {
            for (int i = 0; i < Result.Count; i++)
            {
                _Log.InfoFormat("Operation {0}: ", Result[i].ToString());
                _DwsNoRepSession.Save(Result[i]);
            }
        }

        private void ExportButton_Click(object sender, EventArgs e)
        {
            if (UserId.Text == "" || Password.Text == "")
            {
                MessageBox.Show("You must supply a user name and password to access the Agilis system.",
                                "Invalid Credentials", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (EndDate.Value <= StartDate.Value)
            {
                MessageBox.Show("The end date must be greater than the start date.",
                                "Invalid Interval", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            DoExport();
        }

        private void DoExport()
        {
            bool SyncDrivers = false;
            bool SyncWorkOrders = false;

            CheckedListBox.CheckedItemCollection DataToSynchronize = DataTypes.CheckedItems;
            foreach (object o in DataToSynchronize)
            {
                switch (o.ToString())
                {
                    case "Drivers":
                        SyncDrivers = true;
                        break;
                    case "Work Orders":
                        SyncWorkOrders = true;
                        break;

                    default:
                        _Log.WarnFormat("Attempt to export unsupported data type: {0}", o.ToString());
                        break;
                }
            }

            string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

            _Log.InfoFormat("Export beginning at {0}.", DateTime.Now.ToString("G"));
            _Log.InfoFormat("User ID:    {0}", UserId.Text);
            _Log.InfoFormat("Password:   {0}", Password.Text);
            _Log.InfoFormat("Start Date: {0}, {1} GMT", StartDate.Value.ToString("G"), StartDate.Value.ToUniversalTime().ToString("G"));
            _Log.InfoFormat("End Date:   {0}, {1} GMT", EndDate.Value.ToString("G"), EndDate.Value.ToUniversalTime().ToString("G"));

            AgilisSynchronizer Synchronizer = new AgilisSynchronizer(AgilisRestUrl, AgilisRestCompany, UserId.Text, Password.Text, DbServer, _DwsNoRepSession, SimulationMode.Checked);

            if (SyncWorkOrders)
            {
                if (UseDriverPlanControls.Checked)
                    Synchronizer.DriverPlanControls = AgilisDriverPlanControl.GetDriverPlanControls(_DwsNoRepSession, StartDate.Value.Date);

                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ExportFull, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }
            if (SyncDrivers)
            {
                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.Drivers, AgilisOperationTypes.ExportFull, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }

            _Log.InfoFormat("Export ending at {0}.", DateTime.Now.ToString("G"));
        }

        private void NowButton_Click(object sender, EventArgs e)
        {
            RawFile.Text = "Agilis Import " + DateTime.Now.ToString("yyyy-MM-dd HH-mm-ss") + ".xml";
        }

        private void SynchronizeButton_Click(object sender, EventArgs e)
        {
            bool SyncDrivers = false;
            bool SyncWorkOrders = false;

            CheckedListBox.CheckedItemCollection DataToSynchronize = DataTypes.CheckedItems;
            foreach (object o in DataToSynchronize)
            {
                switch (o.ToString())
                {
                    case "Drivers":
                        SyncDrivers = true;
                        break;
                    case "Work Orders":
                        SyncWorkOrders = true;
                        break;

                    default:
                        _Log.WarnFormat("Attempt to export unsupported data type: {0}", o.ToString());
                        break;
                }
            }

            string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
            AgilisSynchronizer Synchronizer = new AgilisSynchronizer(AgilisRestUrl, AgilisRestCompany, UserId.Text, Password.Text, DbServer, _DwsNoRepSession, SimulationMode.Checked);
            if (UseImportFilters.Checked)
                Synchronizer.Filters = AgilisOperationFilter.GetActiveFilters(_DwsNoRepSession, DateTime.Now);

            Synchronizer.SignaturesFolder = "\\\\Imladris\\Media\\Agilis";

            if (SyncWorkOrders)
            {
                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ExportUpdate, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }
            if (SyncDrivers)
            {
                List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.Drivers, AgilisOperationTypes.ExportUpdate, StartDate.Value, EndDate.Value, RawFile.Text, this);
                LogSynchronizerResult(Result);
            }
        }

        private void FinalizeButton_Click(object sender, EventArgs e)
        {
            string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
            AgilisSynchronizer Synchronizer = new AgilisSynchronizer(AgilisRestUrl, AgilisRestCompany, UserId.Text, Password.Text, DbServer, _DwsNoRepSession, SimulationMode.Checked);
            List<AgilisIntegrationOperation> Result = Synchronizer.FinalizePlan(StartDate.Value, RawFile.Text, this);
            LogSynchronizerResult(Result);
        }

        private void UseProductionSystem_CheckedChanged(object sender, EventArgs e)
        {
            InitializeCredentials();
        }

        private void UseDemoSystem_CheckedChanged(object sender, EventArgs e)
        {
            InitializeCredentials();
        }

        private void AisSyncButton_Click(object sender, EventArgs e)
        {
            var aisCore = new AisMain {SimulationOnly = SimulationMode.Checked};
            var midnight = DateTime.Now.Date;
            aisCore.PerformSynchronization(midnight, midnight);
        }
    }
}