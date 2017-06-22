using System.Collections.Generic;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    internal class RfsStakeholderMappingManager
    {
        private const int OriginRole = 3;
        private const int DestinationRole = 4;

        private readonly int _rfsId;
        private readonly Dictionary<int, int> _originMap;
        private readonly Dictionary<int, int> _destinationMap;

        public int RfsId
        {
            get { return _rfsId; }
        }

        public RfsStakeholderMappingManager(int rfsId, IRfsDataContext rfsDataContext)
        {
            this._rfsId = rfsId;

            _originMap = new Dictionary<int, int>();
            _destinationMap = new Dictionary<int, int>();

            var rfsSpecificMappings = rfsDataContext.GetStakeholderClientMappingsByRfsId(rfsId);
            ProcessMappings(rfsDataContext, rfsSpecificMappings);
        }

        private void ProcessMappings(IRfsDataContext rfsDataContext, 
            IEnumerable<BopsRfsStakeholderClientMapping> mappings)
        {
            foreach (var mapping in mappings)
            {
                var mapDetails = rfsDataContext.GetStakeholderClientMappingsByIdAndOriginOrDestinationRole(mapping.MappingId);

                foreach (var detail in mapDetails)
                {
                    switch (detail.RoleRef)
                    {
                        case OriginRole:
                            if (_originMap.ContainsKey(detail.SourceClientRef))
                                _originMap[detail.SourceClientRef] = mapping.TargetClientRef;
                            else 
                                _originMap.Add(detail.SourceClientRef, mapping.TargetClientRef);
                            break;
                        case DestinationRole:
                            if (_destinationMap.ContainsKey(detail.SourceClientRef))
                                _destinationMap[detail.SourceClientRef] = mapping.TargetClientRef;
                            else
                                _destinationMap.Add(detail.SourceClientRef, mapping.TargetClientRef);
                            break;
                    }
                }
            }
        }

        public int LookupMapping(int role, int sourceClientRef)
        {
            var returnValue = 0;

            switch (role)
            {
                case OriginRole:
                    if (_originMap.ContainsKey(sourceClientRef))
                        returnValue = _originMap[sourceClientRef];
                    break;
                case DestinationRole:
                    if (_destinationMap.ContainsKey(sourceClientRef))
                        returnValue = _destinationMap[sourceClientRef];
                    break;
            }

            return returnValue;
        }
    }
}
