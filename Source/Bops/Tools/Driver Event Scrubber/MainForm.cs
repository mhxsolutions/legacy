using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.Windows.Forms;
using AgilisCore;
using BopsDataAccess;
using BopsDataConnector;
using BopsUtilities;
using NHibernateUtilities;
using log4net;
using log4net.Config;
using NHibernate.Criterion;

[assembly: XmlConfigurator(Watch = true)]

namespace Driver_Event_Scrubber
{
    public partial class MainForm : Form
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(MainForm));

        private List<PlanSummary> _Plans;
        private ListViewComparerFactory _PlansComparerFactory;

        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object Sender, EventArgs E)
        {
        }

        private int PopulatePlanListview()
        {
            _PlansComparerFactory = new ListViewComparerFactory(6);
            _PlansComparerFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Integer;

            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                _PlanListview.SuspendLayout();
                _PlanListview.Items.Clear();

                // Get all the available fleets.

                IList<BopsFleet> Fleets = DataConnector.DwsNoRepData.CreateCriteria(typeof(BopsFleet)).List<BopsFleet>();
                Dictionary<int, BopsFleet> FleetMap = new Dictionary<int, BopsFleet>();
                foreach (BopsFleet Fleet in Fleets)
                {
                    FleetMap.Add(Fleet.FleetId, Fleet);    
                }

                // Get the raw list of plans.

                IList<BopsDriverPlan> Plans = DataConnector.DwsNoRepData.CreateCriteria(typeof(BopsDriverPlan))
                    .Add(Expression.Eq("PlanDate", _PlanDatePicker.Value.Date))
                    .List<BopsDriverPlan>();

                // Filter out the plans for drivers who aren't marked for Agilis.

                int[] DriverIds = new int[Plans.Count];
                for (int Index = 0; Index < Plans.Count; Index++)
                    DriverIds[Index] = Plans[Index].DriverRef;

                Dictionary<int, BopsDriver> DriverMap = ReadUtilities.LoadObjectDictionary<int, BopsDriver>(DataConnector.DwsNoRepData, "DriverId", DriverIds);
                for (int Index = 0; Index < Plans.Count; /* LOOP INDEX IS UPDATED CONDITIONALLY IN THE LOOP BELOW */ )
                {
                    BopsDriver Driver = DriverMap[Plans[Index].DriverRef];
                    if (Driver.Agilis)
                        Index++;
                    else
                        Plans.RemoveAt(Index);
                }

                if (Plans.Count < 1)
                    return 0;

                // Now fetch the plan details for our list of plans and generate plan summaries.

                int[] PlanIds = new int[Plans.Count];
                for (int Index = 0; Index < Plans.Count; Index++)
                    PlanIds[Index] = Plans[Index].PlanId;

                IList<BopsDriverPlanDetail> Details = ReadUtilities.LoadObjectList<int, BopsDriverPlanDetail>(DataConnector.DwsNoRepData, "PlanRef", PlanIds);
                Debug.Assert(Details.Count > 0);

                GeneratePlanSummaries(DataConnector, _PlanDatePicker.Value.Date, Plans, Details, DriverMap);

                // Finally, add the summary items to the listview. Columns:
                //
                //  0   Last Name
                //  1   First Name
                //  2   Fleet
                //  3   Origins
                //  4   Destinations
                //  5   Locations

                foreach (PlanSummary Plan in _Plans)
                {
                    ListViewItem NewItem = new ListViewItem(Plan.Driver.LastName);
                    NewItem.SubItems.Add(Plan.Driver.FirstName);

                    NewItem.SubItems.Add(Plan.Driver.FleetRef.HasValue
                                             ? FleetMap[Plan.Driver.FleetRef.Value].Description
                                             : "(none)");

                    NewItem.SubItems.Add(Plan.OriginsNeedingGeocoding > 0
                                             ? string.Format("{0} ({1})", Plan.Origins.Count, Plan.OriginsNeedingGeocoding)
                                             : Plan.Origins.Count.ToString());

                    NewItem.SubItems.Add(Plan.DestinationsNeedingGeocoding > 0
                                             ? string.Format("{0} ({1})", Plan.Destinations.Count, Plan.DestinationsNeedingGeocoding)
                                             : Plan.Destinations.Count.ToString());

                    NewItem.SubItems.Add(Plan.Positions.Count.ToString());
                    NewItem.Tag = Plan;

                    _PlanListview.Items.Add(NewItem);
                }
            }
            catch (Exception Ex)
            {
                _Log.Error("An exception occurred populating plans listview.", Ex);
            }
            finally
            {
                DataConnector.CloseSessions();

                foreach (ColumnHeader Hdr in _PlanListview.Columns)
                    Hdr.Width = -2;
                _PlanListview.ResumeLayout();
            }

            return _Plans.Count;
        }

        private void GeneratePlanSummaries(IBopsDataConnector DataConnector, DateTime PlanDate, IEnumerable<BopsDriverPlan> Plans, 
            IEnumerable<BopsDriverPlanDetail> Details, IDictionary<int, BopsDriver> DriverMap)
        {
            Dictionary<int, BopsDriverPlan> PlanMap = new Dictionary<int, BopsDriverPlan>();
            foreach (BopsDriverPlan Plan in Plans)
            {
                if (!PlanMap.ContainsKey(Plan.PlanId))
                    PlanMap.Add(Plan.PlanId, Plan);
            }

            Dictionary<int, int> DestinationIds = new Dictionary<int, int>();
            Dictionary<int, PlanSummary> Summaries = new Dictionary<int, PlanSummary>();

            foreach (BopsDriverPlanDetail Detail in Details)
            {
                BopsDriverPlan Plan = PlanMap[Detail.PlanRef];

                PlanSummary Summary;
                if (Summaries.ContainsKey(Plan.DriverRef))
                {
                    Summary = Summaries[Plan.DriverRef];
                }
                else
                {
                    Summary = new PlanSummary();
                    Summaries.Add(Plan.DriverRef, Summary);
                }

                Summary.Plan = Plan;
                Summary.Details.Add(Detail);

                if (!Summary.Origins.ContainsKey(Detail.OriginRef))
                    Summary.Origins.Add(Detail.OriginRef, null);
                if (!Summary.Destinations.ContainsKey(Detail.DestinationRef))
                    Summary.Destinations.Add(Detail.DestinationRef, null);

                if (!DestinationIds.ContainsKey(Detail.OriginRef))
                    DestinationIds.Add(Detail.OriginRef, 0);
                if (!DestinationIds.ContainsKey(Detail.DestinationRef))
                    DestinationIds.Add(Detail.DestinationRef, 0);
            }

            Dictionary<int, BopsDestination> DestinationMap = ReadUtilities.LoadObjectDictionary<int, BopsDestination>(DataConnector.DwsRepData, "DestinationId", DestinationIds.Keys);

            _Plans = new List<PlanSummary>();
            foreach (KeyValuePair<int, PlanSummary> Pair in Summaries)
            {
                int OriginsNeedingGeocoding = 0, DestinationsNeedingGeocoding = 0;

                Dictionary<int, BopsDestination> NewOrigins = new Dictionary<int, BopsDestination>();
                foreach (KeyValuePair<int, BopsDestination> OriginPair in Pair.Value.Origins)
                {
                    NewOrigins.Add(OriginPair.Key, DestinationMap[OriginPair.Key]);
                    if (DestinationMap[OriginPair.Key].Latitude == 0 || DestinationMap[OriginPair.Key].Longitude == 0)
                        OriginsNeedingGeocoding++;
                }

                Dictionary<int, BopsDestination> NewDestinations = new Dictionary<int, BopsDestination>();
                foreach (KeyValuePair<int, BopsDestination> DestinationPair in Pair.Value.Origins)
                {
                    NewDestinations.Add(DestinationPair.Key, DestinationMap[DestinationPair.Key]);
                    if (DestinationMap[DestinationPair.Key].Latitude == 0 || DestinationMap[DestinationPair.Key].Longitude == 0)
                        DestinationsNeedingGeocoding++;
                }

                Pair.Value.Driver = DriverMap[Pair.Value.Plan.DriverRef];
                Pair.Value.Origins = NewOrigins;
                Pair.Value.Destinations = NewDestinations;
                Pair.Value.Positions = GetDriverPositions(DataConnector, Pair.Key, PlanDate);
                Pair.Value.OriginsNeedingGeocoding = OriginsNeedingGeocoding;
                Pair.Value.DestinationsNeedingGeocoding = DestinationsNeedingGeocoding;
                _Plans.Add(Pair.Value);
            }
        }

        private static List<AgilisDriverPosition> GetDriverPositions(IBopsDataConnector Connector, int DriverId, DateTime PlanDate)
        {
            IList<AgilisDriverPosition> Pos = Connector.DwsNoRepData.CreateCriteria(typeof (AgilisDriverPosition))
                .Add(Expression.Eq("DriverId", DriverId))
                .Add(Expression.Ge("Timestamp", PlanDate))
                .Add(Expression.Lt("Timestamp", PlanDate.AddDays(1)))
                .List<AgilisDriverPosition>();

            return new List<AgilisDriverPosition>(Pos);
        }

        private void _LookupButton_Click(object Sender, EventArgs E)
        {
            int PlanCount = PopulatePlanListview();
            if (PlanCount < 1)
                MessageHelper.ShowInvalidOperation("Sorry, but no plans were found for that date.");
        }

        private void _PlanListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (_PlanListview.Items.Count <= 0) return;
            _PlanListview.ListViewItemSorter = _PlansComparerFactory.CreateComparerForColumn(E.Column);
            _PlanListview.Sort();
        }

        private void _PlanListview_DoubleClick(object Sender, EventArgs E)
        {
            Debug.Assert(_PlanListview.SelectedItems.Count == 1);
            PlanSummary Plan = _PlanListview.SelectedItems[0].Tag as PlanSummary;
            Debug.Assert(Plan != null);
            ScrubbingForm NewForm = new ScrubbingForm(Plan);
            NewForm.ShowDialog();
        }

        private void _AnalyzeToClipboardMenuitem_Click(object Sender, EventArgs E)
        {
            if (_PlanListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select a single plan to analyze to clipboard.");
                return;
            }

            PlanSummary Plan = _PlanListview.SelectedItems[0].Tag as PlanSummary;
            Debug.Assert(Plan != null);
            LocationDataAnalyzer Analyzer = new LocationDataAnalyzer();
            StringBuilder Results = Analyzer.AnalyzeLocations(Plan.Positions);
            Clipboard.SetText(Results.ToString());
            MessageHelper.ShowSuccess("Analysis copied to clipboard.");
        }
    }
}