using System.Collections.Generic;
using System.Linq;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsUtilities
{
    public class BopsRfsBillDetailMap
    {
        private Dictionary<int, BopsRfs> _rfsMap;
        private Dictionary<int, BopsRfsStakeholder> _stakeholdersMap;
        private Dictionary<int, BopsRfsServicesOffered> _servicesOfferedMap;
        private Dictionary<int, BopsRfsServicesRequested> _servicesRequestedMap;
        private IDictionary<int, BopsDestination> _destinationsMap;
        private readonly Dictionary<int, BopsRfsBillDetail> _detailsMap;

        public BopsRfsServicesOffered LookupServiceOffered(int serviceOfferedId)
        {
            return _servicesOfferedMap.ContainsKey(serviceOfferedId) ? 
                _servicesOfferedMap[serviceOfferedId] : null;
        }

        public BopsRfsServicesRequested LookupServiceRequested(int serviceRequestedId)
        {
            return _servicesRequestedMap.ContainsKey(serviceRequestedId) ? 
                _servicesRequestedMap[serviceRequestedId] : null;
        }

        public BopsDestination LookupDestination(int destinationId)
        {
            return _destinationsMap.ContainsKey(destinationId) ? 
                _destinationsMap[destinationId] : null;
        }

        public BopsRfs LookupRfs(int rfsId)
        {
            return _rfsMap.ContainsKey(rfsId) ? _rfsMap[rfsId] : null;
        }

        public BopsRfsBillDetail LookupBillDetail(int serviceCalculationResultId)
        {
            return _detailsMap.ContainsKey(serviceCalculationResultId) ? 
                _detailsMap[serviceCalculationResultId] : null;
        }

        private BopsDestination GetParentDestination(int childDestinationId)
        {
            if (!_destinationsMap.ContainsKey(childDestinationId))
                return null;

            var child = _destinationsMap[childDestinationId];
            if (child.ParentRef.HasValue && child.ParentRef.Value != child.DestinationId)
            {
                 if(!_destinationsMap.ContainsKey(child.ParentRef.Value))
                     return null;
                 return _destinationsMap[child.ParentRef.Value];
            }
                
            return child;
        }

        public BopsRfsBillDetailMap(IRfsDataContext rfsDataContext, 
            ICollection<BopsRfsServiceCalculationResult> results)
        {
            CacheServiceData(rfsDataContext);

            var loads = new Dictionary<string, BopsLoad>();
            var receivers = new Dictionary<int, BopsReceivingRecord>();
            var shippers = new Dictionary<int, BopsShippingRecord>();

            foreach (var result in results)
            {
                if (result.IsReceiver)
                {
                    if (!receivers.ContainsKey(result.DocumentId.Value))
                        receivers.Add(result.DocumentId.Value, null);
                }
                else if (result.IsBillOfLading)
                {
                    if (!shippers.ContainsKey(result.DocumentId.Value))
                        shippers.Add(result.DocumentId.Value, null);
                }
                else
                {
                    if (!loads.ContainsKey(result.LoadRef))
                        loads.Add(result.LoadRef, null);
                }
            }

            if (loads.Count > 0)
                loads = rfsDataContext.GetLoadsByReferences(loads.Keys.ToArray()).ToDictionary(l => l.LoadReference, l => l);
            if (receivers.Count > 0)
                receivers = rfsDataContext.GetReceiversByIDs(receivers.Keys.ToArray()).ToDictionary(r => r.ReceiverId, r => r);
            if (shippers.Count > 0)
                shippers = rfsDataContext.GetShippersByIDs(shippers.Keys.ToArray()).ToDictionary(s => s.LoadId, s => s);

            _detailsMap = new Dictionary<int, BopsRfsBillDetail>();

            foreach (var result in results)
            {
                // We can't process bills whose calculation results refer to a service requested that doesn't exist.

                if (!_servicesRequestedMap.ContainsKey(result.ServiceId))
                    continue;
                var service = _servicesRequestedMap[result.ServiceId];

                // We can't process bills whose service refers to a bill-to stakeholder that doesn't exist.

                if (!service.BillToRef.HasValue || !_stakeholdersMap.ContainsKey(service.BillToRef.Value))
                    continue;
                var billToStakeholder = _stakeholdersMap[service.BillToRef.Value];

                // We can't process bills whose bill-to stakeholder refers to a destination that doesn't exist.

                var billTo = GetParentDestination(billToStakeholder.ClientRef);
                if (billTo == null)
                    continue;

                // We can't process bills whose service requested refers to an RFS that doesn't exist.

                if (!_rfsMap.ContainsKey(service.RfsRef))
                    continue;
                var rfs = _rfsMap[service.RfsRef];

                // We can't process bills whose corresponding RFS has a shipper that doesn't exist.

                if (!_destinationsMap.ContainsKey(rfs.ShipperRef))
                    continue;
                var shipper = _destinationsMap[rfs.ShipperRef];

                if (result.IsLoad)
                {
                    // We can't process bills whose load doesn't exist.

                    if (!loads.ContainsKey(result.LoadRef))
                        continue;
                    var load = loads[result.LoadRef];

                    // We can't process loads whose delivery location isn't specified or doesn't exist.

                    if (!load.DeliveryLocationRef.HasValue || !_destinationsMap.ContainsKey(load.DeliveryLocationRef.Value))
                        continue;

                    var newDetail = new BopsRfsBillDetail(result, shipper, billTo) {Load = load};
                    _detailsMap.Add(result.ResultId, newDetail);
                }
                else if (service.DestinationRef.HasValue && _stakeholdersMap.ContainsKey(service.DestinationRef.Value))
                {
                    // We can't process receivers/BOLs whose destination stakeholder is unspecified or doesn't exist.

                    if (!_stakeholdersMap.ContainsKey(service.DestinationRef.Value))
                        continue;
                    var destinationId = _stakeholdersMap[service.DestinationRef.Value].ClientRef;

                    // We can't process receivers/BOLs whose destination stakeholder refers to a destination that doesn't exist.

                    if (!_destinationsMap.ContainsKey(destinationId))
                        continue;

                    if (result.IsReceiver)
                    {
                        // We can't process bills whose receiver doesn't exist.

                        if (!receivers.ContainsKey(result.DocumentId.Value))
                            continue;

                        var newDetail = new BopsRfsBillDetail(result, shipper, billTo)
                        {
                            Receiver = receivers[result.DocumentId.Value]
                        };
                        _detailsMap.Add(result.ResultId, newDetail);
                    }
                    else
                    {
                        // We can't process bills whose BOL doesn't exist.

                        if (!shippers.ContainsKey(result.DocumentId.Value))
                            continue;

                        var newDetail = new BopsRfsBillDetail(result, shipper, billTo)
                        {
                            Shipper = shippers[result.DocumentId.Value]
                        };
                        _detailsMap.Add(result.ResultId, newDetail);
                    }
                }
            }
        }

        private void CacheServiceData(IRfsDataContext rfsDataContext)
        {
            // TODO: Update this to use user company detail if appropriate.

            _destinationsMap = rfsDataContext.GetDestinations(0, 0, 0)
                .ToDictionary(d => d.DestinationId, d => d);
            _servicesOfferedMap = rfsDataContext.GetServicesOffered(0)
                .ToDictionary(s => s.Id, s => s);
            _servicesRequestedMap = rfsDataContext.GetServicesRequested(0, 0, 0)
                .ToDictionary(s => s.ServiceRequestedId, s => s);
            _rfsMap = rfsDataContext.GetRfs(0, 0, 0).ToDictionary(r => r.RfsId, r => r);
            _stakeholdersMap = rfsDataContext.GetStakeholders(0, 0, 0)
                .ToDictionary(s => s.StakeholderId, s => s);
        }
    }
}
