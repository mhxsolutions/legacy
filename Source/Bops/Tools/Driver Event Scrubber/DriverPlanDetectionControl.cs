using System;
using System.Collections.Generic;
using System.Windows.Forms;
using AgilisCore;
using BopsDataAccess;

namespace Driver_Event_Scrubber
{
    public partial class DriverPlanDetectionControl : UserControl
    {
        private class VisitWrapper
        {
            private readonly PlanSummary.Visit _Visit;

            public VisitWrapper(PlanSummary.Visit Visit)
            {
                _Visit = Visit;
            }

            public override string ToString()
            {
                return string.Format("Arrived {0}, Departed {1}", _Visit.ArrivalPosition.Timestamp.ToShortTimeString(),
                                     _Visit.DeparturePosition.Timestamp.ToShortTimeString());
            }
        }

        private int _StepNumber;
        private BopsDestination _Origin;
        private DateTime _OriginScheduledArrive;
        private DateTime _OriginScheduledDepart;
        private readonly List<PlanSummary.Visit> _OriginDetectedVisits;
        private BopsDestination _Destination;
        private DateTime _DestinationScheduledArrive;
        private DateTime _DestinationScheduledDepart;
        private readonly List<PlanSummary.Visit> _DestinationDetectedVisits;

        public int StepNumber
        {
            get { return _StepNumber; }
            set { _StepNumber = value; }
        }

        public BopsDestination Origin
        {
            get { return _Origin; }
            set { _Origin = value; }
        }

        public DateTime OriginScheduledArrive
        {
            get { return _OriginScheduledArrive; }
            set { _OriginScheduledArrive = value; }
        }

        public DateTime OriginScheduledDepart
        {
            get { return _OriginScheduledDepart; }
            set { _OriginScheduledDepart = value; }
        }

        public BopsDestination Destination
        {
            get { return _Destination; }
            set { _Destination = value; }
        }

        public DateTime DestinationScheduledArrive
        {
            get { return _DestinationScheduledArrive; }
            set { _DestinationScheduledArrive = value; }
        }

        public DateTime DestinationScheduledDepart
        {
            get { return _DestinationScheduledDepart; }
            set { _DestinationScheduledDepart = value; }
        }

        public IList<PlanSummary.Visit> OriginDetectedVisits
        {
            get { return _OriginDetectedVisits; }
        }

        public IList<PlanSummary.Visit> DestinationDetectedVisits
        {
            get { return _DestinationDetectedVisits; }
        }

        public DriverPlanDetectionControl()
        {
            _OriginDetectedVisits = new List<PlanSummary.Visit>();
            _DestinationDetectedVisits = new List<PlanSummary.Visit>();

            InitializeComponent();
        }

        private void SelectSingleComboboxItem(ComboBox Ctl)
        {
            if (Ctl.Items.Count == 1)
                Ctl.SelectedItem = Ctl.Items[0];
        }

        private void DriverPlanDetectionControl_Load(object Sender, EventArgs E)
        {
            _StepTextbox.Text = _StepNumber.ToString();

            _OriginNameTextbox.Text = _Origin.ToString();
            _OriginScheduledArriveTextbox.Text = _OriginScheduledArrive == DateTime.MinValue ? "?" : _OriginScheduledArrive .ToShortTimeString();
            _OriginScheduledDepartTextbox.Text = _OriginScheduledDepart == DateTime.MinValue ? "?" : _OriginScheduledDepart.ToShortTimeString();

            foreach (PlanSummary.Visit Visit in _OriginDetectedVisits)
            {
                _OriginDetectedVisitsCombobox.Items.Add(new VisitWrapper(Visit));
            }

            _DestinationNameTextbox.Text = _Destination.ToString();
            _DestinationScheduledArriveTextbox.Text = _DestinationScheduledArrive == DateTime.MinValue ? "?" : _DestinationScheduledArrive.ToShortTimeString();
            _DestinationScheduledDepartTextbox.Text = _DestinationScheduledDepart == DateTime.MinValue ? "?" : _DestinationScheduledDepart.ToShortTimeString();

            foreach (PlanSummary.Visit Visit in _DestinationDetectedVisits)
            {
                _DestinationDetectedVisitsCombobox.Items.Add(new VisitWrapper(Visit));
            }

            SelectSingleComboboxItem(_OriginDetectedVisitsCombobox);
            SelectSingleComboboxItem(_DestinationDetectedVisitsCombobox);
        }
    }
}
