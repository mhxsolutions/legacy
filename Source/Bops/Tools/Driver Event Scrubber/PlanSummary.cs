using System.Collections.Generic;
using AgilisCore;
using BopsDataAccess;

namespace Driver_Event_Scrubber
{
    public class PlanSummary
    {
        #region Helper Classes

        public class Visit
        {
            private int _ClientId;
            private int _ArrivalIndex;
            private AgilisDriverPosition _ArrivalPosition;
            private int _DepartureIndex;
            private AgilisDriverPosition _DeparturePosition;

            public int ClientId
            {
                get { return _ClientId; }
                set { _ClientId = value; }
            }

            public int ArrivalIndex
            {
                get { return _ArrivalIndex; }
                set { _ArrivalIndex = value; }
            }

            public AgilisDriverPosition ArrivalPosition
            {
                get { return _ArrivalPosition; }
                set { _ArrivalPosition = value; }
            }

            public int DepartureIndex
            {
                get { return _DepartureIndex; }
                set { _DepartureIndex = value; }
            }

            public AgilisDriverPosition DeparturePosition
            {
                get { return _DeparturePosition; }
                set { _DeparturePosition = value; }
            }

            public Visit(int ClientId, int ArrivalIndex, AgilisDriverPosition ArrivalPosition, int DepartureIndex, AgilisDriverPosition DeparturePosition)
            {
                _ClientId = ClientId;
                _ArrivalIndex = ArrivalIndex;
                _ArrivalPosition = ArrivalPosition;
                _DepartureIndex = DepartureIndex;
                _DeparturePosition = DeparturePosition;
            }
        }

        public class DetailVisits
        {
            private readonly List<Visit> _OriginVisits;
            private readonly List<Visit> _DestinationVisits;

            public IList<Visit> OriginVisits
            {
                get { return _OriginVisits; }
            }

            public IList<Visit> DestinationVisits
            {
                get { return _DestinationVisits; }
            }

            public DetailVisits()
            {
                _OriginVisits = new List<Visit>();
                _DestinationVisits = new List<Visit>();
            }
        }

        #endregion

        private BopsDriverPlan _Plan;
        private List<BopsDriverPlanDetail> _Details;
        BopsDriver _Driver;
        private Dictionary<int, BopsDestination> _Origins;
        private int _OriginsNeedingGeocoding;
        private Dictionary<int, BopsDestination> _Destinations;
        private int _DestinationsNeedingGeocoding;
        private List<AgilisDriverPosition> _Positions;

        private List<DetailVisits> _DetectedVisits;

        public BopsDriverPlan Plan
        {
            get { return _Plan; }
            set { _Plan = value; }
        }

        public List<BopsDriverPlanDetail> Details
        {
            get { return _Details; }
            set { _Details = value; }
        }

        public BopsDriver Driver
        {
            get { return _Driver; }
            set { _Driver = value; }
        }

        public Dictionary<int, BopsDestination> Origins
        {
            get { return _Origins; }
            set { _Origins = value; }
        }

        public int OriginsNeedingGeocoding
        {
            get { return _OriginsNeedingGeocoding; }
            set { _OriginsNeedingGeocoding = value; }
        }

        public Dictionary<int, BopsDestination> Destinations
        {
            get { return _Destinations; }
            set { _Destinations = value; }
        }

        public int DestinationsNeedingGeocoding
        {
            get { return _DestinationsNeedingGeocoding; }
            set { _DestinationsNeedingGeocoding = value; }
        }

        public List<AgilisDriverPosition> Positions
        {
            get { return _Positions; }
            set { _Positions = value; }
        }

        public List<DetailVisits> DetectedVisits
        {
            get { return _DetectedVisits; }
            set { _DetectedVisits = value; }
        }

        public PlanSummary()
        {
            _Details = new List<BopsDriverPlanDetail>();
            _Origins = new Dictionary<int, BopsDestination>();
            _Destinations = new Dictionary<int, BopsDestination>();
            _Positions = new List<AgilisDriverPosition>();
        }
    }
}
