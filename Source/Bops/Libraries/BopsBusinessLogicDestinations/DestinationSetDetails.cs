using System.Collections.Generic;
using BopsDataAccess;

namespace BopsBusinessLogicDestinations
{
    public class DestinationSetDetails
    {
        private BopsDestinationSet _Set;
        private List<BopsDestinationSetAssignment> _Assignments;

        public BopsDestinationSet Set
        {
            get { return _Set; }
            set { _Set = value; }
        }

        public List<BopsDestinationSetAssignment> Assignments
        {
            get { return _Assignments; }
            set { _Assignments = value; }
        }

        public DestinationSetDetails()
        {
        }

        public DestinationSetDetails(BopsDestinationSet Set, IEnumerable<BopsDestinationSetAssignment> Assignments)
        {
            _Set = Set;
            _Assignments = new List<BopsDestinationSetAssignment>(Assignments);
        }
    }
}
