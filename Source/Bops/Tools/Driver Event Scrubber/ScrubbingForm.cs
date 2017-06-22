using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using BopsDataAccess;

namespace Driver_Event_Scrubber
{
    public partial class ScrubbingForm : Form
    {
        private const int _UserControlHeight = 120;

        private class DetailsSorter : IComparer<BopsDriverPlanDetail>
        {
            public int Compare(BopsDriverPlanDetail X, BopsDriverPlanDetail Y)
            {
                if (X.SequenceNumber < Y.SequenceNumber)
                    return -1;
                if (X.SequenceNumber > Y.SequenceNumber)
                    return 1;
                return 0;
            }
        }

        private PlanSummary _Plan;

        public ScrubbingForm(PlanSummary Plan)
        {
            Debug.Assert(Plan != null);
            _Plan = Plan;
            InitializeComponent();
        }

        private StringBuilder GetPlanDescription()
        {
            int Sequence = 0;
            StringBuilder Sb = new StringBuilder();

            foreach (BopsDriverPlanDetail Detail in _Plan.Details)
            {
                BopsDestination Origin = _Plan.Origins[Detail.OriginRef];
                BopsDestination Destination = _Plan.Destinations[Detail.DestinationRef];
                Sb.AppendLine(string.Format("{0:D02}: {1} to {2}", Sequence++, Origin, Destination));
            }

            return Sb;
        }

        private void ScrubbingForm_Load(object Sender, EventArgs E)
        {
            Text = string.Format("Scrubbing Plan {0} for Driver {1}", _Plan.Plan.PlanId, _Plan.Driver);
            _Plan.Details.Sort(new DetailsSorter());

            LocationDataAnalyzer Analyzer = new LocationDataAnalyzer();
            Analyzer.AnalyzeLocations(_Plan.Positions);

            if (Analyzer.PotentialDataHoles > 0)
                MessageBox.Show(string.Format("{0} potential data holes detected.", Analyzer.PotentialDataHoles));

            // TODO: hook this stuff up to a better interface.

            StringBuilder Sb = new StringBuilder("PLAN");
            Sb.AppendLine();
            Sb.AppendLine("----");
            Sb.Append(GetPlanDescription());
            Sb.AppendLine();
            Sb.AppendLine("DETECTED");
            Sb.AppendLine("--------");

            LocationClientDetector Detector = new LocationClientDetector(_Plan);
            Sb.Append(Detector.DetectClientLocations());

            Clipboard.SetText(Sb.ToString());

            Detector.UpdatePlanSummaryWithDetectedVisits();

            DateTime OriginArrive = _Plan.Plan.StartTime.HasValue ? _Plan.Plan.StartTime.Value : DateTime.MinValue;
            DateTime OriginDepart = OriginArrive;

            for (int Index = 0; Index < _Plan.Details.Count; Index++)
            {
                BopsDriverPlanDetail Detail = _Plan.Details[Index];
                DriverPlanDetectionControl NewControl = new DriverPlanDetectionControl();

                NewControl.StepNumber = Detail.SequenceNumber;

                NewControl.Origin = _Plan.Origins[Detail.OriginRef];
                NewControl.OriginScheduledArrive = OriginArrive;
                NewControl.OriginScheduledDepart = OriginDepart;

                foreach (PlanSummary.Visit Visit in _Plan.DetectedVisits[Index].OriginVisits)
                {
                    NewControl.OriginDetectedVisits.Add(Visit);
                }

                NewControl.Destination = _Plan.Destinations[Detail.DestinationRef];
                NewControl.DestinationScheduledArrive = Detail.ScheduledArrival.HasValue ? Detail.ScheduledArrival.Value : DateTime.MinValue;
                NewControl.DestinationScheduledDepart = Detail.ScheduledDeparture.HasValue ? Detail.ScheduledDeparture.Value : DateTime.MinValue;

                foreach (PlanSummary.Visit Visit in _Plan.DetectedVisits[Index].DestinationVisits)
                {
                    NewControl.DestinationDetectedVisits.Add(Visit);
                }

                NewControl.Location = new Point(0, _UserControlHeight * Index);

                Controls.Add(NewControl);

                // Set up the origin times for the next pass through the loop.

                OriginArrive = NewControl.DestinationScheduledArrive;
                OriginDepart = NewControl.DestinationScheduledDepart;
            }
        }
    }
}