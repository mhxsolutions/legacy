using System.Collections.Generic;
using BopsDataAccess;
using BopsDataConnector;

namespace BopsBusinessLogicPlanning
{
    public class DriverPlanningDetails
    {
        private readonly BopsDriver _Driver;
        private readonly BopsDriverPlan _Plan;
        private readonly List<BopsDriverPlanDetail> _Details;
        private readonly Dictionary<int, BopsDestination> _Destinations;

        public BopsDriver Driver
        {
            get { return _Driver; }
        }

        public BopsDriverPlan Plan
        {
            get { return _Plan; }
        }

        public IList<BopsDriverPlanDetail> Details
        {
            get { return _Details; }
        }

        public Dictionary<int, BopsDestination> Destinations
        {
            get { return _Destinations; }
        }

        public bool HasDetails
        {
            get { return _Details != null; }
        }

        public bool HasDestinations
        {
            get { return _Destinations != null; }
        }

        public bool IsContiguous
        {
            get 
            {
                if (_Details.Count == 0) return true;
                int LastDestination = _Details[0].DestinationRef;
                for (int Index = 1; Index < _Details.Count; Index++)
                {
                    if (_Details[Index].OriginRef != LastDestination) return false;
                    LastDestination = _Details[Index].DestinationRef;
                }

                return true;
            }
        }

        public DriverPlanningDetails(BopsDriver Driver, BopsDriverPlan Plan)
        {
            _Driver = Driver;
            _Plan = Plan;
        }

        public DriverPlanningDetails(BopsDriver Driver, BopsDriverPlan Plan, IEnumerable<BopsDriverPlanDetail> Details)
        {
            _Driver = Driver;
            _Plan = Plan;
            _Details = new List<BopsDriverPlanDetail>(Details);
        }

        public DriverPlanningDetails(BopsDriver Driver, BopsDriverPlan Plan, IEnumerable<BopsDriverPlanDetail> Details, IDictionary<int, BopsDestination> Destinations)
        {
            _Driver = Driver;
            _Plan = Plan;
            if (Details != null)
                _Details = new List<BopsDriverPlanDetail>(Details);
            if (Destinations != null)
                _Destinations = new Dictionary<int, BopsDestination>(Destinations);
        }

        public void AddDestination(IBopsDataConnector DataConnector, int DestinationId)
        {
            if (_Destinations.ContainsKey(DestinationId)) return;
            BopsDestination Destination = DataConnector.DwsRepData.Get<BopsDestination>(DestinationId);
            _Destinations.Add(Destination.DestinationId, Destination);
        }

        public void AddDestination(BopsDestination Destination)
        {
            if (_Destinations.ContainsKey(Destination.DestinationId)) return;
            _Destinations.Add(Destination.DestinationId, Destination);
        }
    }
}
