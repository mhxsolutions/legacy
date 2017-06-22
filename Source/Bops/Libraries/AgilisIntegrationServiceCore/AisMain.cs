using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using AgilisCore;
using BopsBusinessLogicAgilis;
using BopsDataAccess;
using BopsUtilities;
using NHibernate.Criterion;
using log4net;
using NHibernate;

namespace AgilisIntegrationServiceCore
{
    public class AisMain
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AisMain));

        private readonly EmailDistributionListManager _NotificationListManager;
        public bool SimulationOnly { get; set; }

        public AisMain()
        {
            _NotificationListManager = new EmailDistributionListManager();

            bool simulationOnly;
            if (bool.TryParse(ConfigurationManager.AppSettings["AgilisSignaturesFolder"], out simulationOnly))
                SimulationOnly = simulationOnly;
        }

        public EmailDistributionListManager NotificationListManager
        {
            get { return _NotificationListManager; }
        }

        private void SendNotificationEmail(string ListName, string Subject, string Body)
        {
            _NotificationListManager.SendMessage(ListName, Subject, Body);
        }

        private void SendNotificationEmail(string Subject, string Body)
        {
            SendNotificationEmail("General", Subject, Body);
        }

        private static string MakeSignatureFolderName()
        {
            string Root = ConfigurationManager.AppSettings["AgilisSignaturesFolder"];
            string Folder = Path.Combine(Root, "Agilis Signatures");

            // Make sure the folder exists.

            if (!Directory.Exists(Folder))
                Directory.CreateDirectory(Folder);

            return Folder;
        }

        private static string MakeRawDataFileName(AgilisDataTypes DataType, AgilisOperationTypes Operation)
        {
            string Root = ConfigurationManager.AppSettings["AgilisDataFolder"];
            string Folder = Path.Combine(Root, "Agilis Import Data\\" + DateTime.Now.ToString("yyyy-MM-dd"));

            // Make sure the folder exists.

            if (!Directory.Exists(Folder))
                Directory.CreateDirectory(Folder);

            return Path.Combine(Folder, string.Format("{0} {1} {2}.xml", DateTime.Now.ToString("yyyy-MM-dd HH-mm-ss"), DataType, Operation));
        }

        private static void SaveOperationResult(ISession Session, AgilisIntegrationOperation Result)
        {
            _Log.InfoFormat("Operation: {0}", Result.ToString());
            Session.Save(Result);
        }

        private static void SaveOperationResults(ISession Session, IList<AgilisIntegrationOperation> Results)
        {
            ITransaction Tx = Session.BeginTransaction();

            try
            {
                for (int i = 0; i < Results.Count; i++)
                    SaveOperationResult(Session, Results[i]);
                Tx.Commit();
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Exception while saving operation results. Details follow.", e);
                if (Tx != null)
                    Tx.Rollback();
            }
        }

        private static bool AllOperationsSucceeded(IEnumerable<AgilisIntegrationOperation> Results)
        {
            foreach (AgilisIntegrationOperation Result in Results)
            {
                if (!Result.Successful)
                    return false;
            }

            return true;
        }

        private static bool DailyPlanIsReady(ISession Session, DateTime PlanDate)
        {
            IList<BopsDriverPlanArchive> DailyPlans = Session.CreateCriteria(typeof(BopsDriverPlanArchive))
                .Add(Expression.Eq("PlanDate", PlanDate))
                .List <BopsDriverPlanArchive>();

            return DailyPlans.Count > 0;
        }

        private static void FinalizeDailyPlan(DateTime PlanDate, ISession Session, AgilisSynchronizer Synchronizer)
        {
            IList<AgilisIntegrationOperation> FullCancels = Session.CreateCriteria(typeof(AgilisIntegrationOperation))
                .Add(Expression.Eq("PlanDate", PlanDate))
                .Add(Expression.Eq("OperationString", AgilisOperationTypes.CancelFull.ToString()))
                .List<AgilisIntegrationOperation>();

            if (FullCancels.Count == 0)
            {
                _Log.InfoFormat("Finalizing work orders for plan date {0}.", PlanDate.ToShortDateString());
                string RawDataFileName = MakeRawDataFileName(AgilisDataTypes.WorkOrders, AgilisOperationTypes.CancelFull);
                List<AgilisIntegrationOperation> Result = Synchronizer.FinalizePlan(PlanDate, RawDataFileName, null);
                SaveOperationResults(Session, Result);
            }
        }

        private static void UploadDailyPlan(ISession Session, AgilisSynchronizer Synchronizer, DateTime PlanDate)
        {
            DateTime EndDate = PlanDate.AddDays(1);

            _Log.Info("Importing drivers before performing full work order export.");
            string RawDataFileName = MakeRawDataFileName(AgilisDataTypes.Drivers, AgilisOperationTypes.Import);
            List<AgilisIntegrationOperation> Result = Synchronizer.Synchronize(AgilisDataTypes.Drivers, AgilisOperationTypes.Import, PlanDate, EndDate, RawDataFileName, null);
            SaveOperationResults(Session, Result);

            _Log.Info("Performing full work order export.");
            RawDataFileName = MakeRawDataFileName(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ExportFull);
            Result = Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ExportFull, PlanDate, EndDate, RawDataFileName, null);
            SaveOperationResults(Session, Result);

            _Log.Info("Performing full work order import based on daily plan date.");
            RawDataFileName = MakeRawDataFileName(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ImportFull);
            Result = Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ImportFull, PlanDate, PlanDate, RawDataFileName, null);
            SaveOperationResults(Session, Result);
        }

        private static bool HandleDailyPlanExport(DateTime PlanDate, ISession Session, AgilisSynchronizer Synchronizer, bool UploadOnlyIfPlanIsReady)
        {
            IList<AgilisIntegrationOperation> FullExports = Session.CreateCriteria(typeof(AgilisIntegrationOperation))
                .Add(Expression.Eq("PlanDate", PlanDate))
                .Add(Expression.Eq("DataTypeString", AgilisDataTypes.WorkOrders.ToString()))
                .Add(Expression.Eq("OperationString", AgilisOperationTypes.ExportFull.ToString()))
                .List<AgilisIntegrationOperation>();

            if (FullExports.Count == 0)
            {
                if (!UploadOnlyIfPlanIsReady || DailyPlanIsReady(Session, PlanDate))
                {
                    _Log.InfoFormat("No full work order export found for plan date {0}.", PlanDate.ToShortDateString());
                    UploadDailyPlan(Session, Synchronizer, PlanDate);
                }
                else
                {
                    _Log.InfoFormat("No full work order export found for plan date {0}; no daily plan is ready; skipping further processing.",
                                    PlanDate.ToShortDateString());
                }

                return true;
            }

            return false;
        }

        private static List<AgilisIntegrationOperation> ImportData(ISession Session, AgilisSynchronizer Synchronizer,
            DateTime PartialAnchorTime, DateTime FullAnchorTime, DateTime EndDate)
        {
            DateTime AnchorTime;
            List<AgilisIntegrationOperation> Results = new List<AgilisIntegrationOperation>();

            _Log.Info("Importing driver events.");
            AnchorTime = PartialImportIsSafe(Session, FullAnchorTime.Date, AgilisDataTypes.DriverEvents) ? PartialAnchorTime : FullAnchorTime;
            string RawDataFileName = MakeRawDataFileName(AgilisDataTypes.DriverEvents, AgilisOperationTypes.Import);
            Results.AddRange(Synchronizer.Synchronize(AgilisDataTypes.DriverEvents, AgilisOperationTypes.Import, AnchorTime, EndDate, RawDataFileName, null));

            _Log.Info("Importing driver position history.");
            // At Dan's suggestion, I am removing the full import for driver positions. It's just too much data with the new phones.
            // Unfortunately I find this doesn't do the trick. Apparently, the caller passes in the full import time for both 
            // parameters in some cases.
            //AnchorTime = PartialImportIsSafe(Session, FullAnchorTime.Date, AgilisDataTypes.DriverPositions) ? PartialAnchorTime : FullAnchorTime;
            AnchorTime = PartialAnchorTime;
            RawDataFileName = MakeRawDataFileName(AgilisDataTypes.DriverPositions, AgilisOperationTypes.Import);
            Results.AddRange(Synchronizer.Synchronize(AgilisDataTypes.DriverPositions, AgilisOperationTypes.Import, AnchorTime, EndDate, RawDataFileName, null));

            /*
             * Importing work orders uses two different approaches, the partial import using the import
             * operation and the full import using the full import operation. The reason is that the lower
             * level routines use two different Agilis APIs, which makes the system more "self-healing" in
             * the event that changes are not being reported by the partial update API. This was first
             * noticed on 06/11/2007 when changes in the load or sequence were not being returned in the next
             * set of updates from Agilis. We had previously not noticed this happening, perhaps because
             * both of those factors were being included in the work order number. Changing to a new, planner
             * detail ID naming convention for work order numbers brought the issue to a boil.
             */

            _Log.Info("Importing work orders before performing work order export update.");
            AgilisOperationTypes WorkOrderImportType;
            if (PartialImportIsSafe(Session, FullAnchorTime.Date, AgilisDataTypes.WorkOrders))
            {
                AnchorTime = PartialAnchorTime;
                WorkOrderImportType = AgilisOperationTypes.Import;
            }
            else
            {
                AnchorTime = FullAnchorTime;
                WorkOrderImportType = AgilisOperationTypes.ImportFull;
            }

            RawDataFileName = MakeRawDataFileName(AgilisDataTypes.WorkOrders, WorkOrderImportType);
            Results.AddRange(Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, WorkOrderImportType, AnchorTime, EndDate, RawDataFileName, null));

            _Log.Info("Importing work order signatures.");
            RawDataFileName = MakeRawDataFileName(AgilisDataTypes.WorkOrderSignatures, AgilisOperationTypes.Import);
            Results.AddRange(Synchronizer.Synchronize(AgilisDataTypes.WorkOrderSignatures, AgilisOperationTypes.Import, AnchorTime, EndDate, RawDataFileName, null));

            SaveOperationResults(Session, Results);
            return Results;
        }

        private static bool PartialImportIsSafe(ISession Session, DateTime PlanDate, AgilisDataTypes DataType)
        {
            bool ReturnValue = false;

            // Partial import is always safe for types other than work orders. Partial
            // import is safe for work orders only when we've had a successful full import
            // for the current plan date within a user-defined period.

            if (DataType != AgilisDataTypes.WorkOrders)
            {
                ReturnValue = true;
            }
            else
            {
                int ForceFullImportInterval = Convert.ToInt32(ConfigurationManager.AppSettings["ForceFullImportInterval"]);
                DateTime CutoffTime = DateTime.Now.AddMilliseconds(-ForceFullImportInterval);

                IList<AgilisIntegrationOperation> FullImports = Session.CreateCriteria(typeof(AgilisIntegrationOperation))
                    .Add(Expression.Eq("PlanDate", PlanDate))
                    .Add(Expression.Ge("BeginDate", CutoffTime))
                    .Add(Expression.Eq("DataTypeString", DataType.ToString()))
                    .Add(Expression.Eq("Successful", true))
                    .List<AgilisIntegrationOperation>();

                if (FullImports.Count > 0)
                {
                    _Log.InfoFormat("Partial import safe for {0} in light of last, successful full import.", DataType.ToString());
                    ReturnValue = true;
                }
            }

            return ReturnValue;
        }

        private static void PostProcessUpdates(string DatabaseConnectionString, DateTime BeginDate, DateTime EndDate)
        {
            using (SqlConnection Connection = new SqlConnection(DatabaseConnectionString))
            {
                Connection.Open();

                using (SqlCommand Command = new SqlCommand("AgilisUpdateDailyPlanOffsets", Connection))
                {
                    Command.CommandType = CommandType.StoredProcedure;
                    Command.Parameters.Add("@BeginDate", SqlDbType.DateTime).Value = BeginDate;
                    Command.Parameters.Add("@EndDate", SqlDbType.DateTime).Value = EndDate;
                    Command.CommandTimeout = 120;   // Wait for up to two minutes because the stored procedure can be slow at day's end.
                    Command.ExecuteNonQuery();
                }

                Connection.Close();
            }
        }

        /*
         * The following two methods manually create the database sessions used. I would prefer such details to be
         * in XML configuration files, but the service cannot read the files (or something like that) when running
         * under Win2k3 for some reason. TODO: move this stuff back into configuration files.
         */

        private static ISession CreateNoRepSession()
        {
            Dictionary<string, string> Props = new Dictionary<string, string>();
            Props.Add("connection.provider", "NHibernate.Connection.DriverConnectionProvider");
            Props.Add("dialect", "NHibernate.Dialect.MsSql2008Dialect");
            Props.Add("connection.driver_class", "NHibernate.Driver.SqlClientDriver");
            Props.Add("connection.connection_string", "Data Source=SQL4;Initial Catalog=\"DWS No Rep Data\";Integrated Security=True");
            Props.Add("cache.use_second_level_cache", "false");

            ISessionFactory SessionFactory = new NHibernate.Cfg.Configuration()
                .AddProperties(Props)
                .AddAssembly("AgilisCore")
                .AddAssembly("BopsDataAccess")
                .BuildSessionFactory();

            ISession ReturnValue = SessionFactory.OpenSession();
            SessionFactory.Close();
            return ReturnValue;
        }

        private static ISession CreateEqManagerSession()
        {
            Dictionary<string, string> Props = new Dictionary<string, string>();
            Props.Add("connection.provider", "NHibernate.Connection.DriverConnectionProvider");
            Props.Add("dialect", "NHibernate.Dialect.MsSql2008Dialect");
            Props.Add("connection.driver_class", "NHibernate.Driver.SqlClientDriver");
            Props.Add("connection.connection_string", "Data Source=SQL4;Initial Catalog=\"EQ Manager\";Integrated Security=True");
            Props.Add("cache.use_second_level_cache", "false");

            ISessionFactory SessionFactory = new NHibernate.Cfg.Configuration()
                .AddProperties(Props)
                .AddAssembly("BopsDataAccess")
                .BuildSessionFactory();

            ISession ReturnValue = SessionFactory.OpenSession();
            SessionFactory.Close();
            return ReturnValue;
        }

        public void PerformSynchronization(DateTime PartialAnchorTime, DateTime FullAnchorTime)
        {
            bool RunPostProcessing = false;
            DateTime SynchronizeBeginTime = DateTime.Now;
            _Log.InfoFormat("AIS beginning synchronize with anchor time {0}.", PartialAnchorTime.ToString("G"));

            string AgilisRestUrl = ConfigurationManager.AppSettings["AgilisRestUrl"];
            string AgilisRestCompany = ConfigurationManager.AppSettings["AgilisRestCompany"];
            string AgilisUserId = ConfigurationManager.AppSettings["AgilisUserId"];
            string AgilisPassword = ConfigurationManager.AppSettings["AgilisPassword"];
            string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

            bool SynchronizeWhenImportFails = Convert.ToBoolean(ConfigurationManager.AppSettings["SynchronizeWhenImportFails"]);

            DateTime MidnightToday = DateTime.Now.Date;
            DateTime MidnightTomorrow = MidnightToday.AddDays(1);
            DateTime MidnightYesterday = MidnightToday.AddDays(-1);

            //string AssemblyPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            //SessionManager<string> SessionManager = new SessionManager<string>();
            //ISession DwsNoRepSession = SessionManager.AddSession("NHibernateDwsNoRepData.xml.config", Path.Combine(AssemblyPath, "NHibernateDwsNoRepData.xml.config"));
            //ISession EqManagerSession = SessionManager.AddSession("NHibernateEqManager.xml.config", Path.Combine(AssemblyPath, "NHibernateEqManager.xml.config"));

            ISession DwsNoRepSession = CreateNoRepSession();
            ISession EqManagerSession = CreateEqManagerSession();

            AgilisSynchronizer Synchronizer = new AgilisSynchronizer(AgilisRestUrl, AgilisRestCompany, AgilisUserId, AgilisPassword, DbServer, DwsNoRepSession, SimulationOnly);
            Synchronizer.SignaturesFolder = MakeSignatureFolderName();
            Synchronizer.DriverPlanControls = AgilisDriverPlanControl.GetDriverPlanControls(DwsNoRepSession, FullAnchorTime.Date);
            AgilisEventHandler EventHandlers = new AgilisEventHandler();
            WorkOrderImportEventHandler ImportEventHandler = new WorkOrderImportEventHandler(DwsNoRepSession, EqManagerSession);
            EventHandlers.WorkOrderImportNotifier = ImportEventHandler;
            Synchronizer.EventHandler = EventHandlers;

            FinalizeDailyPlan(MidnightYesterday, DwsNoRepSession, Synchronizer);

            if (!HandleDailyPlanExport(MidnightToday, DwsNoRepSession, Synchronizer, false))
            {
                int DailyPlanPreloadHour = Convert.ToInt32(ConfigurationManager.AppSettings["DailyPlanPreloadHour"]);
                if (DailyPlanPreloadHour <= DateTime.Now.Hour)
                {
                    // Need to set a synchronizer up for tomorrow's driver plan controls (if any) before calling
                    // the daily plan export.

                    AgilisSynchronizer Preloader = new AgilisSynchronizer(AgilisRestUrl, AgilisRestCompany, AgilisUserId, AgilisPassword, DbServer, DwsNoRepSession, SimulationOnly);
                    Preloader.DriverPlanControls = AgilisDriverPlanControl.GetDriverPlanControls(DwsNoRepSession, MidnightTomorrow);
                    HandleDailyPlanExport(MidnightTomorrow, DwsNoRepSession, Preloader, true);
                }

                Synchronizer.Filters = AgilisOperationFilter.GetActiveFilters(DwsNoRepSession, SynchronizeBeginTime);
                List<AgilisIntegrationOperation> ImportResults = ImportData(DwsNoRepSession, Synchronizer, PartialAnchorTime, FullAnchorTime, MidnightTomorrow);

                if (AllOperationsSucceeded(ImportResults) || SynchronizeWhenImportFails)
                {
                    _Log.Info("Performing driver export update.");
                    string RawDataFileName = MakeRawDataFileName(AgilisDataTypes.Drivers, AgilisOperationTypes.ExportUpdate);
                    List<AgilisIntegrationOperation> SyncResult = Synchronizer.Synchronize(AgilisDataTypes.Drivers, AgilisOperationTypes.ExportUpdate,
                                                                                           FullAnchorTime, MidnightTomorrow, RawDataFileName, null);
                    SaveOperationResults(DwsNoRepSession, SyncResult);

                    _Log.Info("Performing work order export update.");
                    RawDataFileName = MakeRawDataFileName(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ExportUpdate);
                    SyncResult = Synchronizer.Synchronize(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ExportUpdate,
                                                          FullAnchorTime, MidnightTomorrow, RawDataFileName, null);
                    SaveOperationResults(DwsNoRepSession, SyncResult);
                    RunPostProcessing = true;
                }
                else
                {
                    _Log.Warn("Failure while importing data; synchronization will not proceed.");
                    SendNotificationEmail("AIS Notification: Import Issue", "Failure while importing data; synchronization will not proceed.");
                }
            }

            DwsNoRepSession.Close();
            EqManagerSession.Close();

            // If any messages were logged during the import, we need to send them to dispatch.

            if (ImportEventHandler.Messages.Count > 0)
            {
                StringBuilder b = new StringBuilder();
                b.AppendLine("This is an automated message from the Agilis Integration Service (AIS). Invalid tractor/trailer");
                b.AppendLine("numbers have been detected while importing work orders. Details follow.");
                b.AppendLine("");
                foreach (string s in ImportEventHandler.Messages)
                    b.AppendLine(s);

                SendNotificationEmail("Dispatch", "Invalid tractor/trailer numbers", b.ToString());
            }

            //SessionManager.CloseAllSessions(true);

            if (RunPostProcessing)
            {
                _Log.Info("Beginning post processing");
                PostProcessUpdates(DbServer, PartialAnchorTime, DateTime.Now);
            }

            TimeSpan Interval = DateTime.Now - SynchronizeBeginTime;
            _Log.InfoFormat("AIS ending synchronize, total run time was {0}.", Interval.ToString());
        }
    }
}
