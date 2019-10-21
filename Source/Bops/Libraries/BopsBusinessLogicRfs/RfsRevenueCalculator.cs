using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using BopsBusinessLogicFsc;
using BopsDataAccess;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    #region Helper Classes

    internal class ServiceComparer : IComparer<BopsRfsServicesRequested>
    {
        public int Compare(BopsRfsServicesRequested x, BopsRfsServicesRequested y)
        {
            if (x == null)
            {
                if (y == null)
                {
                    return 0;
                }
                return -1;
            }
            
            if (y == null)
            {
                return 1;
            }

            // Service group is the first determinant; a lower service group number always
            // comes before a higher service group number.

            if (x.ServiceGroup < y.ServiceGroup)
                return -1;
            if (x.ServiceGroup > y.ServiceGroup)
                return 1;

            // If the service groups are equal, then specificity is the next determinant.
            // Any service with a determinate destination comes before an indeterminate.

            if (!x.IndeterminateDestination && y.IndeterminateDestination)
                return -1;
            if (x.IndeterminateDestination && !y.IndeterminateDestination)
                return 1;

            // If we've made it this far, then both are either determinate or indeterminate.
            // In such a case, there really isn't anything we care about, so comparing the
            // origins/destinations will suffice.

            if (x.OriginRef < y.OriginRef)
                return -1;
            if (x.OriginRef > y.OriginRef)
                return 1;
            return 0;
        }
    }

    #endregion

    internal class RfsRevenueCalculator : IRfsRevenueCalculator
    {
        private const int OriginRole = 3;
        private const int DestinationRole = 4;
        private const double PoundsPerMetricTon = 2204.62262;

        private static readonly ILog Log = LogManager.GetLogger(typeof(RfsRevenueCalculator));

        #region Helper Classes

        private class RfsDetails
        {
            #region Fields

            #endregion

            #region Properties

            public BopsRfs Rfs { get; }
            public List<BopsRfsStakeholder> Origins { get; }
            public List<BopsRfsStakeholder> Destinations { get; }
            public List<BopsRfsStakeholder> Receivers { get; }
            public List<BopsRfsServicesOffered> ServicesOffered { get; }
            public List<BopsRfsServicesRequested> TransportationServices { get; }
            public List<BopsRfsServicesRequested> WarehouseServices { get; }
            public List<BopsRfsServicesRequested> AssessorialServices { get; }
            public RfsStakeholderMappingManager Mapper { get; set; }

            #endregion

            #region Construction

            public RfsDetails(BopsRfs rfs)
            {
                Rfs = rfs;

                Origins = new List<BopsRfsStakeholder>();
                Destinations = new List<BopsRfsStakeholder>();
                Receivers = new List<BopsRfsStakeholder>();
                ServicesOffered = new List<BopsRfsServicesOffered>();
                TransportationServices = new List<BopsRfsServicesRequested>();
                WarehouseServices = new List<BopsRfsServicesRequested>();
                AssessorialServices = new List<BopsRfsServicesRequested>();
                Mapper = null;
            }

            public RfsDetails(int rfsId, IRfsDataContext rfsDataContext)
            {
                Rfs = rfsDataContext.GetRfsById(rfsId);

                var rfsStakeholders = rfsDataContext.GetStakeholdersByRfsId(rfsId);
                Origins = new List<BopsRfsStakeholder>();
                Destinations = new List<BopsRfsStakeholder>();
                Receivers = new List<BopsRfsStakeholder>();

                foreach (var stakeholder in rfsStakeholders)
                {
                    switch (stakeholder.RoleRef)
                    {
                        case BopsRfsStakeholderRoleType.Origin:
                            Origins.Add(stakeholder);
                            break;
                        case BopsRfsStakeholderRoleType.Destination:
                            Destinations.Add(stakeholder);
                            break;
                        case BopsRfsStakeholderRoleType.Receiver:
                            Receivers.Add(stakeholder);
                            break;
                    }
                }

                var servicesList = rfsDataContext.GetServicesRequestedByRfsId(rfsId);

                ServicesOffered = new List<BopsRfsServicesOffered>();
                TransportationServices = new List<BopsRfsServicesRequested>();
                WarehouseServices = new List<BopsRfsServicesRequested>();
                AssessorialServices = new List<BopsRfsServicesRequested>();

                foreach (var service in servicesList)
                {
                    var serviceOffered = rfsDataContext.GetServiceOfferedById(service.ServiceOfferedRef);
                    ServicesOffered.Add(serviceOffered);

                    switch (serviceOffered.CategoryRef)
                    {
                        case RfsServiceCategories.Transportation:
                            TransportationServices.Add(service);
                            break;
                        case RfsServiceCategories.Warehouse:
                            WarehouseServices.Add(service);
                            break;
                        case RfsServiceCategories.Assessorial:
                            AssessorialServices.Add(service);
                            break;
                    }
                }

                Mapper = new RfsStakeholderMappingManager(rfsId, rfsDataContext);
            }
            #endregion
        }

        private class PerUnitRevenueAndWeight
        {
            #region Fields
            private double _revenue;

            #endregion

            #region Properties
            public double Revenue
            {
                get { return _revenue; }
                set { _revenue = Math.Round(value, 2); }
            }

            public double Weight { get; set; }

            #endregion
        }

        #endregion

        #region Fields

        private IRfsCalculatorStatus _statusCallback;
        private Dictionary<int, RfsDetails> _rfsDetailsCache;

        #endregion

        #region Properties

        public IRfsDataContext RfsDataContext { get; set; }

        public IRfsCalculatorStatus StatusCallback
        {
            set { _statusCallback = value; }
        }

        #endregion

        #region Construction
        public RfsRevenueCalculator()
        {
            _statusCallback = new RfsCalculatorStatusSink();
        }
        #endregion

        #region Helper Methods
        private BopsDestination GetParentDestination(int destinationId)
        {
            var returnValue = RfsDataContext.GetDestinationById(destinationId);
            if (returnValue.ParentRef.HasValue
                && returnValue.ParentRef != 0
                && returnValue.ParentRef != returnValue.DestinationId)
            {
                returnValue = RfsDataContext.GetDestinationById(returnValue.ParentRef.Value);
            }
                
            return returnValue;
        }

        private BopsDestination GetStakeholderDestination(int stakeholderId, IEnumerable<BopsRfsStakeholder> stakeholders)
        {
            foreach (BopsRfsStakeholder stakeholder in stakeholders)
            {
                if (stakeholderId == stakeholder.StakeholderId)
                    return GetParentDestination(stakeholder.ClientRef);
            }

            return null;
        }

        private static bool MatchClientToService(int role, int sourceClientRef, 
            int serviceClientRef, RfsStakeholderMappingManager mapper)
        {
            if (sourceClientRef == serviceClientRef)
                return true;
            if (mapper != null)
                return mapper.LookupMapping(role, sourceClientRef) == serviceClientRef;
            return false;
        }

        private bool TransportationServiceMatches(BopsRfs rfs, BopsRfsServicesRequested service, 
            IEnumerable<BopsRfsStakeholder> origins, IEnumerable<BopsRfsStakeholder> destinations, 
            BopsDestination loadOrigin, BopsDestination loadDestination, RfsStakeholderMappingManager mapper)
        {
            if (!service.OriginRef.HasValue)
            {
                Log.ErrorFormat("RFS {0}, transportation service {1} lacks origin", rfs.RfsId, service.ServiceRequestedId);
                return false;
            }

            var serviceOrigin = GetStakeholderDestination(service.OriginRef.Value, origins);

            if (serviceOrigin == null)
            {
                Log.ErrorFormat("RFS {0}, transportation service {1} has origin that doesn't match stakeholders.", rfs.RfsId, service.ServiceRequestedId);
                return false;
            }

            if (service.IndeterminateDestination)
            {
                if (MatchClientToService(OriginRole, loadOrigin.DestinationId, serviceOrigin.DestinationId, mapper))
                {
                    return true;
                }
            }
            else
            {
                if (!service.DestinationRef.HasValue)
                {
                    Log.ErrorFormat("RFS {0}, transportation service {1} lacks destination", rfs.RfsId, service.ServiceRequestedId);
                    return false;
                }

                var serviceDestination = GetStakeholderDestination(service.DestinationRef.Value, destinations);

                if (serviceDestination == null)
                {
                    Log.ErrorFormat("RFS {0}, transportation service {1} has destination that doesn't match stakeholders.", rfs.RfsId, service.ServiceRequestedId);
                    return false;
                }

                if (MatchClientToService(OriginRole, loadOrigin.DestinationId, serviceOrigin.DestinationId, mapper) &&
                    MatchClientToService(DestinationRole, loadDestination.DestinationId, serviceDestination.DestinationId, mapper))
                {
                    return true;
                }
            }

            return false;
        }

        private static PerUnitRevenueAndWeight CalculatePerUnitRevenueAndWeight(BopsLoad load, 
            BopsRfsServicesRequested service, BopsRfsRateDetails rate, StringBuilder calculationDetails)
        {
            var returnValue = new PerUnitRevenueAndWeight();
            Debug.Assert(rate.CostMethodRef == (int)RfsCostMethods.PerUnit);
            var costMethodUnit = (RfsCostMethodUnits)rate.UnitRef;

            if (costMethodUnit == RfsCostMethodUnits.Load || costMethodUnit == RfsCostMethodUnits.Truck)
            {
                Debug.Assert(rate.Cost.HasValue);
                returnValue.Revenue = rate.Cost.Value;
                returnValue.Weight = load.ChargedWeight.HasValue ? returnValue.Weight = load.ChargedWeight.Value : 0;
                calculationDetails.AppendFormat("{0:c3} per {1}", rate.Cost.Value, costMethodUnit.ToString().ToLower());
                return returnValue;
            }

            string weightDetails = null;

            if (costMethodUnit == RfsCostMethodUnits.Pound ||
                costMethodUnit == RfsCostMethodUnits.CWT ||
                costMethodUnit == RfsCostMethodUnits.Ton ||
                costMethodUnit == RfsCostMethodUnits.MetricTon)
            {
                if (load.PickUpRequestRef != 0)
                {
                    if (load.GrossWeight.HasValue)
                    {
                        if (rate.MinimumChargedWeight > load.GrossWeight)
                        {
                            returnValue.Weight = rate.MinimumChargedWeight;
                            weightDetails = string.Format("{0:n0} lbs. gross weight charged at {1:n0} lbs. minimum", load.GrossWeight, rate.MinimumChargedWeight);
                        }
                        else
                        {
                            returnValue.Weight = load.GrossWeight.Value;
                            weightDetails = string.Format("{0:n0} lbs. gross weight", load.GrossWeight);
                        }
                    }
                    else
                    {
                        returnValue.Weight = rate.MinimumChargedWeight;
                        weightDetails = string.Format("charged at {0:n0} lbs. minimum", rate.MinimumChargedWeight);
                    }
                }
                else
                {
                    if (load.ChargedWeight.HasValue)
                    {
                        if (rate.MinimumChargedWeight > load.ChargedWeight)
                        {
                            returnValue.Weight = rate.MinimumChargedWeight;
                            weightDetails = string.Format("{0:n0} lbs. charged weight charged at {1:n0} lbs. minimum", load.ChargedWeight.Value, rate.MinimumChargedWeight);
                        }
                        else
                        {
                            returnValue.Weight = load.ChargedWeight.Value;
                            weightDetails = string.Format("{0:n0} lbs. charged weight", load.ChargedWeight.Value);
                        }
                    }
                }

                if (returnValue.Weight > 0)
                {
                    Debug.Assert(rate.Cost.HasValue);

                    switch (costMethodUnit)
                    {
                        case RfsCostMethodUnits.Pound:
                            returnValue.Revenue = returnValue.Weight * rate.Cost.Value;
                            break;
                        case RfsCostMethodUnits.CWT:
                            returnValue.Revenue = (returnValue.Weight / 100) * rate.Cost.Value;
                            break;
                        case RfsCostMethodUnits.Ton:
                            returnValue.Revenue = (returnValue.Weight / 2000) * rate.Cost.Value;
                            break;
                        case RfsCostMethodUnits.MetricTon:
                            returnValue.Revenue = (returnValue.Weight / PoundsPerMetricTon) * rate.Cost.Value;
                            break;
                    }

                    calculationDetails.AppendFormat("{0} at {1:c3} per {2}", weightDetails, rate.Cost.Value, 
                        costMethodUnit.ToString().ToLower());
                    return returnValue;
                }
                
                Log.WarnFormat("Load {0}, RfsId {1}, ServiceRequestedId {2}: no weight available for calculation",
                                load.LoadReference, load.RfsRef, service.ServiceRequestedId);
                return null;
            }

            Log.ErrorFormat("Load {0}, RfsId {1}, ServiceRequestedId {2}: unsupported unit type {3}",
                             load.LoadReference, load.RfsRef, service.ServiceRequestedId, service.PrivateRate.UnitRef);
            return null;
        }

        private static double CalculateWarehouseWeightInPounds(WarehouseCalculationInputs document)
        {
            var returnValue = 0.0;

            if ((document.DocumentType == WarehouseDocumentType.Received) 
                && document.ReceiverDocument.DetailWeight.HasValue)
            {
                returnValue = document.ReceiverDocument.DetailWeight.Value;
            }
            else if ((document.DocumentType == WarehouseDocumentType.Shipped) 
                && document.ShipperDocument.PostedWeight.HasValue)
            {
                returnValue = document.ShipperDocument.PostedWeight.Value;
            }

            return returnValue;
        }

        private static PerUnitRevenueAndWeight CalculatePerUnitRevenueAndWeight(WarehouseCalculationInputs document, 
            BopsRfsServicesRequested service, BopsRfsRateDetails rate, StringBuilder calculationDetails)
        {
            var returnValue = new PerUnitRevenueAndWeight();
            Debug.Assert(rate.CostMethodRef == (int)RfsCostMethods.PerUnit);
            var costMethodUnit = (RfsCostMethodUnits)rate.UnitRef;

            if (costMethodUnit == RfsCostMethodUnits.Load 
                || costMethodUnit == RfsCostMethodUnits.Truck 
                || costMethodUnit == RfsCostMethodUnits.Railcar)
            {
                Debug.Assert(rate.Cost.HasValue);
                returnValue.Revenue = rate.Cost.Value;
                returnValue.Weight = CalculateWarehouseWeightInPounds(document);
                calculationDetails.AppendFormat("{0:c3} per {1}", rate.Cost.Value, costMethodUnit.ToString().ToLower());
                return returnValue;
            }

            if (costMethodUnit == RfsCostMethodUnits.Pound ||
                costMethodUnit == RfsCostMethodUnits.CWT ||
                costMethodUnit == RfsCostMethodUnits.Ton ||
                costMethodUnit == RfsCostMethodUnits.MetricTon)
            {
                returnValue.Weight = CalculateWarehouseWeightInPounds(document);

                if (returnValue.Weight > 0)
                {
                    Debug.Assert(rate.Cost.HasValue);

                    switch ((RfsCostMethodUnits)rate.UnitRef.Value)
                    {
                        case RfsCostMethodUnits.Pound:
                            returnValue.Revenue = returnValue.Weight * rate.Cost.Value;
                            break;
                        case RfsCostMethodUnits.CWT:
                            returnValue.Revenue = (returnValue.Weight / 100) * rate.Cost.Value;
                            break;
                        case RfsCostMethodUnits.Ton:
                            returnValue.Revenue = (returnValue.Weight / 2000) * rate.Cost.Value;
                            break;
                        case RfsCostMethodUnits.MetricTon:
                            returnValue.Revenue = (returnValue.Weight / PoundsPerMetricTon) * rate.Cost.Value;
                            break;
                    }

                    calculationDetails.AppendFormat("{0:n0} lbs. at {1:c3} per {2}", returnValue.Weight, 
                        rate.Cost.Value, costMethodUnit.ToString().ToLower());

                    return returnValue;
                }
                
                Log.WarnFormat("Warehouse document ID {0}, Type {1}, RfsId {2}, ServiceRequestedId {3}: no weight available for calculation",
                                document.DocumentId, document.DocumentType, document.RfsRef, service.ServiceRequestedId);
                return null;
            }

            Log.ErrorFormat("Warehouse document ID {0}, Type {1}, RfsId {2}, ServiceRequestedId {3}, unsupported unit type {4}", document.DocumentId, 
                document.DocumentType, document.RfsRef, service.ServiceRequestedId, service.PrivateRate.UnitRef);

            return null;
        }

        private void UpdateRfsResult(string loadReference, RfsCalculationResultType resultType, 
            BopsRfsCalculationResult result)
        {
            if (result == null)
            {
                result = new BopsRfsCalculationResult(loadReference)
                {
                    ResultType = resultType,
                    LastCalculation = DateTime.Now,
                    Resolved = false
                };

                RfsDataContext.AddCalculationResult(result);
                return;
            }

            if (!result.DoNotUpdate)
            {
                result.ResultType = resultType;
                result.LastCalculation = DateTime.Now;
                result.Resolved = false;
            }
        }

        private void UpdateRfsResult(int documentId, WarehouseDocumentType documentType, 
            RfsCalculationResultType resultType, BopsRfsCalculationResult result)
        {
            if (result == null)
            {
                result = new BopsRfsCalculationResult(documentId, documentType)
                {
                    ResultType = resultType,
                    LastCalculation = DateTime.Now,
                    Resolved = false
                };

                RfsDataContext.AddCalculationResult(result);
                return;
            }

            if (!result.DoNotUpdate)
            {
                result.ResultType = resultType;
                result.LastCalculation = DateTime.Now;
                result.Resolved = false;
            }
        }

        private Dictionary<int, RfsDetails> PreloadRfsDetails()
        {
            //return PreloadRfsDetailsIndividually();
            return PreloadRfsDetailsBulk();
        }

        private enum BulkStaging
        {
            LoadingRfs,
            MappingStakeholders,
            MappingServices,
            Complete
        }

        private Dictionary<int, RfsDetails> PreloadRfsDetailsBulk()
        {
            _statusCallback.InitializeProgressMeter(0, (int)BulkStaging.Complete);
            _statusCallback.ProgressUpdate("Loading basic RFS data...", null, (int)BulkStaging.LoadingRfs, (int)BulkStaging.Complete);

            // First, load up all RFS details into the return value dictionary for quick lookup.
            // NB: There may be room here for more optimization by bulk-loading the mapping.

            var returnValue = new Dictionary<int, RfsDetails>();

            // TODO: Update this to use user company detail if appropriate.

            var allRfs = RfsDataContext.GetRfs(0, 0, 0);

            foreach (var rfs in allRfs)
            {
                var details = new RfsDetails(rfs)
                {
                    Mapper = new RfsStakeholderMappingManager(rfs.RfsId, RfsDataContext)
                };
                returnValue.Add(rfs.RfsId, details);
            }

            // Next, load up all stakeholders and run through the list, adding origin, destination, 
            // and receiver types to the existing details.

            _statusCallback.ProgressUpdate("Mapping stakeholder data...", null, (int)BulkStaging.MappingStakeholders, (int)BulkStaging.Complete);

            // TODO: Update this to use user company detail if appropriate.

            var allStakeholders = RfsDataContext.GetStakeholders(0, 0, 0);
            foreach (var stakeholder in allStakeholders)
            {
                if (returnValue.ContainsKey(stakeholder.RfsRef))
                {
                    RfsDetails Details = returnValue[stakeholder.RfsRef];

                    switch (stakeholder.RoleRef)
                    {
                        case BopsRfsStakeholderRoleType.Origin:
                            Details.Origins.Add(stakeholder);
                            break;
                        case BopsRfsStakeholderRoleType.Destination:
                            Details.Destinations.Add(stakeholder);
                            break;
                        case BopsRfsStakeholderRoleType.Receiver:
                            Details.Receivers.Add(stakeholder);
                            break;
                    }
                }
                else
                {
                    Log.WarnFormat("Stakeholder exists for RFS ID {0}, which doesn't exist.", stakeholder.RfsRef);
                }
            }

            // Load up all the services offered into a dictionary for fast lookup in the step to come.

            _statusCallback.ProgressUpdate("Mapping service data...", null, (int)BulkStaging.MappingServices, (int)BulkStaging.Complete);
            var serviceOfferedLookup = RfsDataContext.GetServicesOffered(0).ToDictionary(s => s.Id, s => s);

            // With all the services offered in a dictionary, we can now run through the complete list of
            // services, adding the transportation and warehouse services to the details records.

            // TODO: Update this to use user company detail if appropriate.

            var allServicesRequested = RfsDataContext.GetServicesRequested(0, 0, 0);
            foreach (var service in allServicesRequested)
            {
                if (serviceOfferedLookup.ContainsKey(service.ServiceOfferedRef))
                {
                    var serviceOffered = serviceOfferedLookup[service.ServiceOfferedRef];

                    if (returnValue.ContainsKey(service.RfsRef))
                    {
                        var details = returnValue[service.RfsRef];

                        switch (serviceOffered.CategoryRef)
                        {
                            case RfsServiceCategories.Transportation:
                                details.TransportationServices.Add(service);
                                break;
                            case RfsServiceCategories.Warehouse:
                                details.WarehouseServices.Add(service);
                                break;
                        }
                    }
                    else
                    {
                        Log.WarnFormat("Service exists for RFS ID {0}, which doesn't exist.", service.RfsRef);
                    }
                }
                else
                {
                    Log.WarnFormat("Service requested {0} exists for service offered {1}, which doesn't exist.", 
                        service.ServiceRequestedId, service.ServiceOfferedRef);
                }
            }

            _statusCallback.ProgressUpdate("Caching complete", null, (int)BulkStaging.Complete, (int)BulkStaging.Complete);

            return returnValue;
        }

        private static List<BopsRfsServicesRequested> SortServicesByGroupAndSpecificity(IEnumerable<BopsRfsServicesRequested> services)
        {
            var returnValue = new List<BopsRfsServicesRequested>(services);
            returnValue.Sort(new ServiceComparer());
            return returnValue;
        }

        private void FindAllMatchingWarehouseServices(RfsDetails rfsDetails, WarehouseCalculationInputs document, 
            RfsStakeholderMappingManager globalMappings, ICollection<BopsRfsServicesRequested> matchingServices)
        {
            var skipGroup = -1;
            var services = SortServicesByGroupAndSpecificity(rfsDetails.WarehouseServices);

            foreach (var service in services)
            {
                if (skipGroup == service.ServiceGroup)
                    continue;

                BopsDestination shipper = null;
                BopsDestination receiver = null;

                if (document.DocumentType == WarehouseDocumentType.Received)
                {
                    // Either the public or the private billing type events must be set for the service to match.

                    if (service.PublicBillingEventType != RfsBillingEventType.WarehouseIn &&
                        service.PrivateBillingEventType != RfsBillingEventType.WarehouseIn)
                    {
                        continue;
                    }

                    // According to Dan, a receiver's shipper is identical to its receiver.

                    if (document.ReceiverDocument.ReceivingClientRef.HasValue)
                    {
                        receiver = GetParentDestination(document.ReceiverDocument.ReceivingClientRef.Value);
                        shipper = receiver;
                    }
                }
                else if (document.DocumentType == WarehouseDocumentType.Shipped)
                {
                    // Either the public or the private billing type events must be set for the service to match.

                    if (service.PublicBillingEventType != RfsBillingEventType.WarehouseOut &&
                        service.PrivateBillingEventType != RfsBillingEventType.WarehouseOut)
                    {
                        continue;
                    }

                    // According to Dan, a shipper's receiver is identical to its shipper.

                    if (document.ShipperDocument.ShippingClientRef.HasValue)
                    {
                        shipper = GetParentDestination(document.ShipperDocument.ShippingClientRef.Value);
                        receiver = shipper;
                    }
                }

                if (shipper == null || receiver == null)
                {
                    Log.WarnFormat("Receiver {0} lacks shipper/receiver", document.DocumentId);
                    continue;
                }

                var match = WarehouseServiceMatches(rfsDetails.Rfs, service, rfsDetails.Receivers, shipper, receiver, null);
                if (!match)
                    match = WarehouseServiceMatches(rfsDetails.Rfs, service, rfsDetails.Receivers, shipper, receiver, rfsDetails.Mapper);
                if (!match)
                    match = WarehouseServiceMatches(rfsDetails.Rfs, service, rfsDetails.Receivers, shipper, receiver, globalMappings);

                if (!match) continue;

                matchingServices.Add(service);
                skipGroup = service.ServiceGroup;
            }
        }

        private bool WarehouseServiceMatches(BopsRfs rfs, BopsRfsServicesRequested service, IEnumerable<BopsRfsStakeholder> receivers, 
            BopsDestination warehouseShipper, BopsDestination warehouseReceiver, RfsStakeholderMappingManager mapper)
        {
            if (!service.ShipperRef.HasValue)
            {
                Log.ErrorFormat("RFS {0}, transportation service {1} lacks shipper", rfs.RfsId, service.ServiceRequestedId);
                return false;
            }

            // While this method works reliably for the other stakeholders, the RFS systems have a defect that allow the
            // shipper not to be included in the stakeholder list. As such, we handle its retrieval a bit differently.

            //BopsDestination ServiceShipper = GetStakeholderDestination(Service.ShipperRef.Value, Shippers);
            var serviceShipper = GetParentDestination(rfs.ShipperRef);
            if (serviceShipper == null)
            {
                Log.ErrorFormat("RFS {0}, warehouse service {1} has shipper that doesn't match stakeholders.", rfs.RfsId, service.ServiceRequestedId);
                return false;
            }

            var serviceReceiver = GetStakeholderDestination(service.ReceiverRef.Value, receivers);
            if (serviceReceiver == null)
            {
                Log.ErrorFormat("RFS {0}, warehouse service {1} has receiver that doesn't match stakeholders.", rfs.RfsId, service.ServiceRequestedId);
                return false;
            }

            if (MatchClientToService(OriginRole, warehouseShipper.DestinationId, serviceShipper.DestinationId, mapper) &&
                MatchClientToService(DestinationRole, warehouseReceiver.DestinationId, serviceReceiver.DestinationId, mapper))
            {
                return true;
            }

            return false;
        }

        private void FindAllMatchingTransportationServices(RfsDetails rfsDetails, BopsLoad load, RfsStakeholderMappingManager globalMappings,
            ICollection<BopsRfsServicesRequested> matchingServices)
        {
            var skipGroup = -1;
            var services = SortServicesByGroupAndSpecificity(rfsDetails.TransportationServices);

            foreach (var service in services)
            {
                if (skipGroup == service.ServiceGroup)
                    continue;

                var loadOrigin = GetParentDestination(load.OriginRef.Value);
                var loadDestination = GetParentDestination(load.DeliveryLocationRef.Value);

                var match = TransportationServiceMatches(rfsDetails.Rfs, service, rfsDetails.Origins, rfsDetails.Destinations, loadOrigin, loadDestination, null);
                if (!match)
                    match = TransportationServiceMatches(rfsDetails.Rfs, service, rfsDetails.Origins, rfsDetails.Destinations, loadOrigin, loadDestination, rfsDetails.Mapper);
                if (!match)
                    match = TransportationServiceMatches(rfsDetails.Rfs, service, rfsDetails.Origins, rfsDetails.Destinations, loadOrigin, loadDestination, globalMappings);

                if (!match) continue;

                matchingServices.Add(service);
                skipGroup = service.ServiceGroup;
            }
        }

        private RfsDetails GetCachedRfsDetails(int rfsId)
        {
            RfsDetails returnValue;

            if (_rfsDetailsCache.ContainsKey(rfsId))
            {
                returnValue = _rfsDetailsCache[rfsId];
            }
            else
            {
                Log.DebugFormat("Loading details to cache for Rfs Id {0}", rfsId);

                try
                {
                    returnValue = new RfsDetails(rfsId, RfsDataContext);
                    _rfsDetailsCache.Add(rfsId, returnValue);
                }
                catch (Exception)
                {
                    returnValue = null;
                }
            }

            return returnValue;
        }

        private void LoadRevenueCalculationCore(IList<BopsLoad> loads, RfsLoadRevenueCalculationResult returnValue)
        {
            var beginTime = DateTime.Now;

            _statusCallback.InitializeProgressMeter(0, loads.Count);
            _statusCallback.ProgressUpdate("Initializing...", null, 0, loads.Count);

            // If we don't already have a cache, we'll build one as we go.

            if (_rfsDetailsCache == null)
                _rfsDetailsCache = new Dictionary<int, RfsDetails>();    

            // Get the existing calculation results and service calculation results 
            // for the loads.

            var index = 0;
            var loadReferences = new string[loads.Count];
            foreach (var load in loads)
            {
                loadReferences[index++] = load.LoadReference;
            }

            // Note well the use of string customization for the keys, which is relied upon below.
            // The lower-level service calculation results are indexed by LoadRef:ServiceId, whereas 
            // the higher level overall calculation results are indexed by capitalized load refs.

            var existingServiceResults = RfsDataContext.GetServiceCalculationResultsByLoadReferences(loadReferences)
                .ToDictionary(r => string.Format("{0}:{1}", r.LoadRef.ToUpper(), r.ServiceId), r => r);
            var existingCalculationResults = RfsDataContext.GetCalculationResultsByLoadReferences(loadReferences)
                .ToDictionary(l => l.LoadReference.ToUpper(), l => l);

            // Create a dictionary to keep track of the service calculation results that were updated.
            // This is needed to correct a particular sort of error, which is explained below.

            var updatedServiceResults = new Dictionary<string, BopsRfsServiceCalculationResult>();
            var loadsSkipped = new Dictionary<string, BopsLoad>();

            // Get the current RFS global stakeholder mappings.

            var globalMappings = new RfsStakeholderMappingManager(0, RfsDataContext);

            var currentLoadNumber = -1;
            string message;

            var fscCalculator = FscFactory.GetFscCalculator(RfsDataContext);

            foreach (var load in loads)
            {
                var calculationResult = existingCalculationResults.ContainsKey(load.LoadReference.ToUpper()) 
                    ? existingCalculationResults[load.LoadReference.ToUpper()] : null;

                try
                {
                    currentLoadNumber++;
                    message = string.Format("Processing load {0}, load date {1}, {2}/{3}", load.LoadReference, 
                                            load.LoadDate.Value.ToString("d"), currentLoadNumber + 1, loads.Count);
                    _statusCallback.ProgressUpdate(message, null, currentLoadNumber, loads.Count);
                    Log.Debug(message);

                    if (load.BillingStatus >= RfsBillingStatus.Approved)
                    {
                        // Add it to the list of loads skipped, so we can avoid reporting the services below
                        // as needing to be deleted but can't be.

                        loadsSkipped.Add(load.LoadReference, load);

                        returnValue.AlreadyApproved++;
                        Log.DebugFormat("Skipping load {0}, already approved", load.LoadReference);
                        UpdateRfsResult(load.LoadReference, RfsCalculationResultType.AlreadyInvoiced, calculationResult);
                        continue;
                    }

                    var revenue = RfsDataContext.GetLoadRevenueByReference(load.LoadReference);

                    if (revenue != null)
                    {
                        if (!string.IsNullOrEmpty(revenue.Type))
                        {
                            Log.DebugFormat("Load {0}, RfsId {1}: Revenue already equals {2} and will be skipped",
                                             load.LoadReference, load.RfsRef, revenue.ManualRevenue);
                            returnValue.LoadsSkippedAsManualCalculation++;
                            UpdateRfsResult(load.LoadReference, RfsCalculationResultType.ManualCalculation, calculationResult);
                            continue;
                        }
                        
                        Log.DebugFormat("Load {0}, RfsId {1}: Revenue already equals {2} and will be overwritten",
                                         load.LoadReference, load.RfsRef, revenue.ManualRevenue);
                    }

                    if (!load.RfsRef.HasValue)
                    {
                        returnValue.SkippedWithNullRfs++;
                        Log.DebugFormat("Skipping load {0} with null RFS", load.LoadReference);
                        UpdateRfsResult(load.LoadReference, RfsCalculationResultType.NullRfs, calculationResult);
                        continue;
                    }

                    if (load.RfsRef.Value == 0)
                    {
                        if (revenue != null)
                        {
                            Log.InfoFormat("Deleting revenue for load {0} with zero RFS", load.LoadReference);
                            RfsDataContext.RemoveLoadRevenue(revenue);
                        }

                        returnValue.RevenueDeletedWithZeroRfs++;
                        UpdateRfsResult(load.LoadReference, RfsCalculationResultType.ZeroRfs, calculationResult);
                        continue;
                    }

                    var rfsDetails = GetCachedRfsDetails(load.RfsRef.Value);
                    if (rfsDetails == null)
                    {
                        Log.DebugFormat("Could not load details for Rfs Id {0}", load.RfsRef.Value);
                        UpdateRfsResult(load.LoadReference, RfsCalculationResultType.InvalidRfs, calculationResult);
                        continue;
                    }

                    // Find all the services that match.

                    var matchingServices = new List<BopsRfsServicesRequested>();
                    FindAllMatchingTransportationServices(rfsDetails, load, globalMappings, matchingServices);

                    if (matchingServices.Count == 0)
                    {
                        Log.ErrorFormat("Load {0}, RfsId {1}: could not determine services", load.LoadReference, load.RfsRef);
                        returnValue.LoadsWithoutTransportationService++;
                        UpdateRfsResult(load.LoadReference, RfsCalculationResultType.NoServiceMatch, calculationResult);
                        continue;
                    }

                    // If we've arrived at this point without a revenue record, we need to generate a new one.

                    var newRevenue = false;
                    if (revenue == null)
                    {
                        revenue = new BopsLoadRevenue {LoadReference = load.LoadReference};
                        newRevenue = true;
                    }

                    var serviceResults = new List<BopsRfsServiceCalculationResult>();

                    foreach (var service in matchingServices)
                    {
                        var serviceResult = new BopsRfsServiceCalculationResult(load.LoadReference, service.ServiceRequestedId)
                        {
                            BillingStatus = RfsBillingStatus.PendingReview,
                            CalculationScope = service.CalculationScope,
                            BillingDate = load.LogOutDate,
                            CompanyRef = rfsDetails.Rfs.CompanyRef
                        };

                        var privateDetails = new StringBuilder();
                        var publicDetails = new StringBuilder();

                        if (((int)service.CalculationScope & (int)RfsCalculationScopeType.Private) > 0)
                        {
                            serviceResult.PrivateRate = CalculateRateRevenue(load, service, service.PrivateRate, privateDetails);

                            if (serviceResult.PrivateRate.RfsResult == RfsCalculationResultType.Success)
                            {
                                var result = fscCalculator.CalculateFsc(load, service.PrivateRate, serviceResult.PrivateRate.RfsRevenue, privateDetails);
                                serviceResult.PrivateRate.FscRevenue = result.FscAmount;
                                serviceResult.PrivateRate.FscResult = result.ResultCode;
                            }
                            else
                            {
                                serviceResult.PrivateRate.FscResult = FscCalculationResultType.NotCalculated;
                            }
                        }

                        if (((int)service.CalculationScope & (int)RfsCalculationScopeType.Public) > 0)
                        {
                            serviceResult.PublicRate = CalculateRateRevenue(load, service, service.PublicRate, publicDetails);

                            if (serviceResult.PublicRate.RfsResult == RfsCalculationResultType.Success)
                            {
                                var result = fscCalculator.CalculateFsc(load, service.PublicRate, serviceResult.PublicRate.RfsRevenue, publicDetails);
                                serviceResult.PublicRate.FscRevenue = result.FscAmount;
                                serviceResult.PublicRate.FscResult = result.ResultCode;
                            }
                            else
                            {
                                serviceResult.PublicRate.FscResult = FscCalculationResultType.NotCalculated;
                            }
                        }

                        serviceResult.PrivateRate.CalculationDetails = privateDetails.Length > 0 ? privateDetails.ToString() : null;
                        serviceResult.PublicRate.CalculationDetails = publicDetails.Length > 0 ? publicDetails.ToString() : null;

                        serviceResults.Add(serviceResult);
                    }

                    var serviceCalculationErrors = false;
                    double totalRevenue = 0.0, totalFsc = 0.0;
                    foreach (var result in serviceResults)
                    {
                        if ((result.PrivateRate.RfsResult != RfsCalculationResultType.Success) ||
                            (result.PublicRate.RfsResult != RfsCalculationResultType.Success))
                        {
                            serviceCalculationErrors = true;
                        }

                        var resultIndex = string.Format("{0}:{1}", result.LoadRef.ToUpper(), result.ServiceId);
                        if (existingServiceResults.ContainsKey(resultIndex))
                        {
                            var existingRecord = existingServiceResults[resultIndex];

                            // TODO: Optimize this whole routine rather than generating new results
                            //
                            // There's probably a better way to do this, but I'm taking the shortest 
                            // path to a working implementation right now. The old way of handling
                            // the database let me save or update records based on an ID. The new
                            // data layer is more ORM-ish, so here we update the EXISTING object as
                            // part of an open context to ensure any changes are saved.

                            existingRecord.BillingStatus = result.BillingStatus;
                            existingRecord.CalculationScope = result.CalculationScope;
                            existingRecord.BillingDate = result.BillingDate;
                            existingRecord.PrivateRate = result.PrivateRate;
                            existingRecord.PublicRate = result.PublicRate;
                            existingRecord.CompanyRef = result.CompanyRef;

                            // Whenever we update a service result, we add it to the updated dictionary
                            // for use in cleaning up old results below.

                            updatedServiceResults.Add(resultIndex, existingRecord);
                        }
                        else
                        {
                            RfsDataContext.AddServiceCalculationResult(result);
                        }
                        
                        totalRevenue += result.PrivateRate.RfsRevenue;
                        totalFsc += result.PrivateRate.FscRevenue;

                        // The private details go into [Load Rev]. The public details were originally intended to be
                        // summarized in another such table, but the RFS invoicing system makes that moot. Nevertheless,
                        // if a public summary table is desired, this is the place to add support in the future.
                    }

                    // NB:  Because we allow multiple services on a load, it isn't possible to store the correct
                    //      weight charged on each service here.

                    revenue.ManualRevenue = totalRevenue;
                    revenue.FuelSurchargeRevenue = totalFsc;
                    revenue.Weight = load.ChargedWeight;
                    revenue.LogoutDate = load.LogOutDate;

                    Debug.Assert(load.LoggedOut.HasValue);
                    if (load.LoggedOut.Value)
                    {
                        Debug.Assert(load.ProofOfDelivery.HasValue);
                        revenue.LoadStatus = load.ProofOfDelivery.Value ? LoadStatus.POD : LoadStatus.Logout;
                    }

                    if (newRevenue)
                        RfsDataContext.AddLoadRevenue(revenue);

                    Debug.Assert(revenue.ManualRevenue.HasValue);
                    Log.DebugFormat("Load {0}, RfsId {1}: set revenue to {2}", load.LoadReference,
                                     load.RfsRef, revenue.ManualRevenue.Value.ToString("c"));
                    returnValue.LoadsCalculated++;
                    UpdateRfsResult(load.LoadReference, serviceCalculationErrors 
                        ? RfsCalculationResultType.ServiceCalculationErrors : RfsCalculationResultType.Success, calculationResult);
                }
                catch (Exception e)
                {
                    returnValue.ErrorCount++;
                    Log.ErrorFormat("Exception calculating load {0} with date {1}; details follow.", load.LoadReference, load.LoadDate);
                    Log.Error(e);
                    UpdateRfsResult(load.LoadReference, RfsCalculationResultType.SoftwareException, calculationResult);
                }
            }

            // Here's where we put the updated service results dictionary to use. It's designed to address
            // a particular situation that occurs when a user creates a load assigned to an RFS, the system 
            // does a calculation with a particular service, and then the user adds a new service that is
            // preferred; in such a case, the old results will be left in place because there's no criterion
            // by which the cleanup procedure (which runs at the database level) can determine it's invalid.
            // So what we do here is run through the complete list of existing service calculation results
            // and delete each that wasn't updated.

            foreach (var pair in existingServiceResults)
            {
                // Check the loads skipped list and, if found, skip reporting it here.

                var ids = pair.Key.Split(':');
                Debug.Assert(ids.Length == 2);
                if (loadsSkipped.ContainsKey(ids[0]))
                    continue;

                // If we have a record of it in the updated list, then it's still valid and we skip it.

                if (updatedServiceResults.ContainsKey(pair.Key))
                    continue;

                // If it's an assessorial service, then we need to skip it.
                // TODO: Verify the service data is coming from cache.

                var serviceOffered = RfsDataContext.GetServiceOfferedByServiceRequestedId(pair.Value.ServiceId);
                Debug.Assert(serviceOffered != null);
                if (serviceOffered.CategoryRef == RfsServiceCategories.Assessorial)
                    continue;

                //var serviceRequestedId = pair.Value.ServiceId;
                //var serviceRequsted = RfsDataContext.GetServiceRequestedById()

                // Otherwise, it must be an old calculation result that shouldn't exist, so we delete it
                // if it's not already approved. If it is already approved, then this is an error condition
                // that needs to be logged. 

                if (pair.Value.BillingStatus < RfsBillingStatus.Approved)
                    RfsDataContext.RemoveServiceCalculationResult(pair.Value);
                else
                    Log.WarnFormat("{0} should be deleted but cannot because its status is {1}",
                        pair.Value, pair.Value.BillingStatus);
            }

            _rfsDetailsCache = null;
            RfsDataContext.SaveChanges();

            var totalTime = DateTime.Now - beginTime;
            message = string.Format("Processed {0} loads in {1}", loads.Count, totalTime);
            _statusCallback.ProgressUpdate(message, null, loads.Count - 1, loads.Count);
            _statusCallback.UninitializeProgressMeter();
            Log.Debug(message);
        }

        private static BopsRfsServiceCalculationResult.RateDetails CalculateRateRevenue(BopsLoad load, BopsRfsServicesRequested service,
            BopsRfsRateDetails rate, StringBuilder calculationDetails)
        {
            var returnValue = new BopsRfsServiceCalculationResult.RateDetails();

            switch ((RfsCostMethods)rate.CostMethodRef)
            {
                case RfsCostMethods.FlatFee:
                    returnValue.RfsRevenue = rate.Cost.Value;
                    calculationDetails.AppendFormat("{0:c} fee", rate.Cost.Value);
                    break;
                case RfsCostMethods.PerUnit:
                    var perUnit = CalculatePerUnitRevenueAndWeight(load, service, rate, calculationDetails);
                    if (perUnit != null)
                    {
                        returnValue.RfsRevenue = perUnit.Revenue;
                        returnValue.Weight = perUnit.Weight;
                    }
                    else
                    {
                        returnValue.RfsResult = RfsCalculationResultType.InvalidCostMethod;
                    }
                    break;
                case RfsCostMethods.Matrix:
                    returnValue.RfsResult = RfsCalculationResultType.InvalidCostMethod;
                    break;
                case RfsCostMethods.SpecialUnit:
                    returnValue.RfsRevenue = (load.SpecialInvoiceValue.HasValue ? load.SpecialInvoiceValue.Value : 0.0) * (rate.Cost.HasValue ? rate.Cost.Value : 0.0);
                    calculationDetails.AppendFormat("{0:n2} {1} at {2:c3} per {3}", 
                        load.SpecialInvoiceValue.HasValue ? load.SpecialInvoiceValue.Value : 0.0, 
                        rate.SpecialUnitText ?? "unit(s)", 
                        rate.Cost.HasValue ? rate.Cost.Value : 0.0,
                        rate.SpecialUnitText ?? "unit");
                    break;
                case RfsCostMethods.PerItem:
                    returnValue.RfsRevenue = (load.CoilCount ?? 0) * rate.Cost.Value;
                    calculationDetails.AppendFormat("{0:n0} at {1:c3} per item", load.CoilCount ?? 0, rate.Cost ?? 0.0);
                    break;
            }

            return returnValue;
        }

        private static BopsRfsServiceCalculationResult.RateDetails CalculateRateRevenue(WarehouseCalculationInputs document, BopsRfsServicesRequested service,
            BopsRfsRateDetails rate, StringBuilder calculationDetails)
        {
            var returnValue = new BopsRfsServiceCalculationResult.RateDetails();

            switch ((RfsCostMethods)rate.CostMethodRef)
            {
                case RfsCostMethods.FlatFee:
                    Debug.Assert(rate.Cost.HasValue);
                    returnValue.RfsRevenue = rate.Cost.Value;
                    calculationDetails.AppendFormat("{0:c} fee", returnValue.RfsRevenue);
                    break;
                case RfsCostMethods.PerUnit:
                    var perUnit = CalculatePerUnitRevenueAndWeight(document, service, rate, calculationDetails);
                    if (perUnit != null)
                    {
                        returnValue.RfsRevenue = perUnit.Revenue;
                        returnValue.Weight = perUnit.Weight;
                    }
                    else
                    {
                        returnValue.RfsResult = RfsCalculationResultType.InvalidCostMethod;
                    }
                    break;
                case RfsCostMethods.Matrix:
                    returnValue.RfsResult = RfsCalculationResultType.InvalidCostMethod;
                    break;
                case RfsCostMethods.SpecialUnit:
                    var specialInvoiceValue = document.DocumentType == WarehouseDocumentType.Received ? 
                        (document.ReceiverDocument.SpecialInvoiceValue.HasValue ? document.ReceiverDocument.SpecialInvoiceValue.Value : 0.0) : 
                        (document.ShipperDocument.SpecialInvoiceValue.HasValue ? document.ShipperDocument.SpecialInvoiceValue.Value : 0.0);
                    returnValue.RfsRevenue = specialInvoiceValue * (rate.Cost.HasValue ? rate.Cost.Value : 0.0);
                    calculationDetails.AppendFormat("{0:n2} {1} at {2:c3} per {3}",
                        specialInvoiceValue,
                        rate.SpecialUnitText ?? "unit(s)",
                        rate.Cost.HasValue ? rate.Cost.Value : 0.0,
                        rate.SpecialUnitText ?? "unit");
                    break;
                case RfsCostMethods.PerItem:
                    returnValue.RfsRevenue = document.GetPostedCount() * rate.Cost.Value;
                    calculationDetails.AppendFormat("{0:n0} at {1:c3} per item", document.GetPostedCount(), rate.Cost ?? 0.0);
                    break;
            }

            return returnValue;
        }

        private void WarehouseRevenueCalculationCore(IList<WarehouseCalculationInputs> documents, 
            RfsWarehouseRevenueCalculationResult returnValue)
        {
            var beginTime = DateTime.Now;

            _statusCallback.InitializeProgressMeter(0, documents.Count);
            _statusCallback.ProgressUpdate("Initializing...", null, 0, documents.Count);

            // If we don't already have a cache, we'll build one as we go.

            if (_rfsDetailsCache == null)
                _rfsDetailsCache = new Dictionary<int, RfsDetails>();

            // Get the existing calculation results and service calculation results 
            // for the warehouse documents.

            var receiverDocumentIds = documents.Where(d => d.DocumentType == WarehouseDocumentType.Received)
                .Select(d => d.DocumentId).ToArray();
            var shipperDocumentIds = documents.Where(d => d.DocumentType == WarehouseDocumentType.Shipped)
                .Select(d => d.DocumentId).ToArray();

            // Note well the use of string customization for the keys, which is relied upon below.
            // The lower-level service calculation results are indexed by WarehouseDocumentType:WarehouseDocumentId, whereas
            // the higher level overall calculation results are indexed by WarehouseDocumentType:WarehouseDocumentId:ServiceId.

            /*
             * The following lines are the source of a bug that has laid heretofore unrecognized since the days
             * we first started handling warehouse documents, receivers and shippers (BOLs). The functions that
             * get the calculation and service results do not discriminate between the two document types, which
             * means we're getting ALL the results that match the IDs, whether they're the right types or not.
             * Fixing this is mandatory to make the calculation routine stop trying to delete things that are 
             * entirely unrelated to the issue at hand.
             * 
             * After looking at NHibernateDataUtilities.GetObjectsByIds, the low-level method that ultimately 
             * fulfills the request, I believe the right fix is to modify the following:
             * 
             *      var chunk = session.CreateCriteria(typeof(TObj))
             *          .Add(Restrictions.In(propertyName, chunkIds))
             *          .List<TObj>();
             *
             * To be more specific, I think I need a version of the utility that takes a list of restrictions to
             * add to the query, rather than just a single ID column. Then I can separate the document ID handling
             * process at the top of the warehouse revenue calculation core into shippers and receivers, change the
             * code to make two calls to the function, and integrate the results into a single existing-services
             * dictionary for lookups.
             * 
             * Even though I'm fixing the problem, I'm leaving the comment here for future reference.
             * 
             * JBW, Friday, March 29, 2019, 15:12 hrs.
             */

            var combinedServiceResults = RfsDataContext
                .GetServiceCalculationResultsByWarehouseDocumentIds(receiverDocumentIds, WarehouseDocumentType.Received)
                .Union(RfsDataContext.GetServiceCalculationResultsByWarehouseDocumentIds(shipperDocumentIds, WarehouseDocumentType.Shipped));
            var combinedCalculationResults = RfsDataContext
                .GetCalculationResultsByWarehouseDocumentIds(receiverDocumentIds, WarehouseDocumentType.Received)
                .Union(RfsDataContext.GetCalculationResultsByWarehouseDocumentIds(shipperDocumentIds,
                    WarehouseDocumentType.Shipped));

            // Comment the above and uncomment the below to break it out and more easily inspect the loading.

            //var receiverServiceResults = RfsDataContext
            //    .GetServiceCalculationResultsByWarehouseDocumentIds(receiverDocumentIds, WarehouseDocumentType.Received)
            //    .ToList();
            //var shipperServiceResults = RfsDataContext
            //    .GetServiceCalculationResultsByWarehouseDocumentIds(shipperDocumentIds, WarehouseDocumentType.Shipped)
            //    .ToList();
            //var combinedServiceResults = receiverServiceResults.Union(shipperServiceResults).ToList();

            //var receiverCalculationResults = RfsDataContext
            //    .GetCalculationResultsByWarehouseDocumentIds(receiverDocumentIds, WarehouseDocumentType.Received)
            //    .ToList();
            //var shipperCalculationResults = RfsDataContext
            //    .GetCalculationResultsByWarehouseDocumentIds(shipperDocumentIds, WarehouseDocumentType.Shipped)
            //    .ToList();
            //var combinedCalculationResults = receiverCalculationResults.Union(shipperCalculationResults).ToList();

            var existingServiceResults = combinedServiceResults
                .ToDictionary(r => $"{r.DocumentType}:{r.DocumentId}:{r.ServiceId}");
            var existingCalculationResults = combinedCalculationResults
                .ToDictionary(r => $"{r.WarehouseDocumentType}:{r.WarehouseDocumentId}", r => r);

            // Create a dictionary to keep track of the service calculation results that were updated.
            // This is explained in the comments in the LoadRevenueCalculationCore method.

            var updatedServiceResults = new Dictionary<string, BopsRfsServiceCalculationResult>();
            var documentsSkipped = new Dictionary<string, WarehouseCalculationInputs>();

            // Get the current RFS global stakeholder mappings.

            var globalMappings = new RfsStakeholderMappingManager(0, RfsDataContext);

            var currentDocumentNumber = -1;
            string message;

            foreach (var document in documents)
            {
                var indexString = $"{document.DocumentType}:{document.DocumentId}";
                var calculationResult = existingCalculationResults.ContainsKey(indexString) 
                    ? existingCalculationResults[indexString] : null;

                try
                {
                    currentDocumentNumber++;
                    message = string.Format("Processing {0} ID {1}, date {2}", document.DocumentType, document.DocumentId, document.DocumentDate);
                    _statusCallback.ProgressUpdate(message, null, currentDocumentNumber, documents.Count);
                    Log.Debug(message);

                    if (document.DocumentType == WarehouseDocumentType.Received 
                            && document.ReceiverDocument.BillingStatus >= RfsBillingStatus.Approved
                        || document.DocumentType == WarehouseDocumentType.Shipped 
                            && document.ShipperDocument.BillingStatus >= RfsBillingStatus.Approved)
                    {
                        // Add it to the list of documents skipped, so we can avoid reporting the services below
                        // as needing to be deleted but can't be.

                        documentsSkipped.Add(indexString, document);

                        returnValue.AlreadyApproved++;
                        Log.DebugFormat("Skipping warehouse document {0}, type {1}, already approved", 
                            document.DocumentId, document.DocumentType);
                        UpdateRfsResult(document.DocumentId, document.DocumentType, RfsCalculationResultType.AlreadyInvoiced, calculationResult);
                        continue;
                    }

                    var revenue = RfsDataContext.GetWarehouseRevenueByDocumentTypeAndId(document.DocumentType, document.DocumentId);
                    if (revenue != null)
                    {
                        Log.DebugFormat("Warehouse document ID {0}, Type {1}, RfsId {2}: Revenue already equals {3} and will be overwritten",
                                         document.DocumentId, document.DocumentType.ToString(), document.RfsRef, revenue.Revenue);
                    }

                    if (!document.RfsRef.HasValue)
                    {
                        returnValue.SkippedWithNullRfs++;
                        Log.DebugFormat("Skipping warehouse document {0}, type {1} with null RFS", document.DocumentId, document.DocumentType.ToString());
                        UpdateRfsResult(document.DocumentId, document.DocumentType, RfsCalculationResultType.NullRfs, calculationResult);
                        continue;
                    }

                    if (document.RfsRef.Value == 0)
                    {
                        if (revenue != null)
                        {
                            Log.InfoFormat("Deleting revenue for warehouse document {0}, type {1} with zero RFS", document.DocumentId, document.DocumentType);
                            RfsDataContext.RemoveWarehouseRevenue(revenue);
                        }

                        returnValue.RevenueDeletedWithZeroRfs++;
                        UpdateRfsResult(document.DocumentId, document.DocumentType, RfsCalculationResultType.ZeroRfs, calculationResult);
                        continue;
                    }

                    var rfsDetails = GetCachedRfsDetails(document.RfsRef.Value);
                    if (rfsDetails == null)
                    {
                        Log.DebugFormat("Could not load details for Rfs Id {0}", document.RfsRef.Value);
                        UpdateRfsResult(document.DocumentId, document.DocumentType, RfsCalculationResultType.InvalidRfs, calculationResult);
                        continue;
                    }

                    // Find all the services that match.

                    var matchingServices = new List<BopsRfsServicesRequested>();
                    FindAllMatchingWarehouseServices(rfsDetails, document, globalMappings, matchingServices);

                    if (matchingServices.Count == 0)
                    {
                        Log.ErrorFormat("Warehouse document {0}, type {1}, RfsId {2}: could not determine services",
                            document.DocumentId, document.DocumentType, document.RfsRef);
                        returnValue.LoadsWithoutWarehouseService++;
                        UpdateRfsResult(document.DocumentId, document.DocumentType, RfsCalculationResultType.NoServiceMatch, calculationResult);
                        continue;
                    }

                    // If we've arrived at this point without a revenue record, we need to generate a new one.

                    var newRevenue = false;
                    if (revenue == null)
                    {
                        revenue = new BopsWarehouseRevenue
                        {
                            DocumentId = document.DocumentId,
                            DocumentType = document.DocumentType,
                            DocumentDate = document.DocumentDate
                        };
                        newRevenue = true;
                    }

                    var serviceResults = new List<BopsRfsServiceCalculationResult>();

                    foreach (var service in matchingServices)
                    {
                        var serviceResult = new BopsRfsServiceCalculationResult(document.DocumentId, document.DocumentType, service.ServiceRequestedId)
                        {
                            BillingStatus = RfsBillingStatus.PendingReview,
                            CalculationScope = service.CalculationScope,
                            BillingDate = document.DocumentDate,
                            CompanyRef = rfsDetails.Rfs.CompanyRef
                        };
                        var eventType = (document.DocumentType == WarehouseDocumentType.Received) 
                            ? RfsBillingEventType.WarehouseIn : RfsBillingEventType.WarehouseOut;

                        var privateDetails = new StringBuilder();
                        var publicDetails = new StringBuilder();

                        if ((((int)service.CalculationScope & (int)RfsCalculationScopeType.Private) > 0) 
                            && (service.PrivateBillingEventType == eventType))
                        {
                            serviceResult.PrivateRate = CalculateRateRevenue(document, service, service.PrivateRate, privateDetails);
                            serviceResult.PrivateRate.FscResult = FscCalculationResultType.NotCalculated;
                        }

                        if ((((int)service.CalculationScope & (int)RfsCalculationScopeType.Public) > 0) 
                            && (service.PublicBillingEventType == eventType))
                        {
                            serviceResult.PublicRate = CalculateRateRevenue(document, service, service.PublicRate, publicDetails);
                            serviceResult.PublicRate.FscResult = FscCalculationResultType.NotCalculated;
                        }

                        serviceResult.PrivateRate.CalculationDetails = privateDetails.Length > 0 ? privateDetails.ToString() : null;
                        serviceResult.PublicRate.CalculationDetails = publicDetails.Length > 0 ? publicDetails.ToString() : null;

                        serviceResults.Add(serviceResult);
                    }

                    var serviceCalculationErrors = false;
                    double totalRevenue = 0.0, totalFsc = 0.0, totalWeight = 0.0;
                    foreach (var result in serviceResults)
                    {
                        if ((result.PrivateRate.RfsResult != RfsCalculationResultType.Success) ||
                            (result.PublicRate.RfsResult != RfsCalculationResultType.Success))
                        {
                            serviceCalculationErrors = true;
                        }

                        var resultIndex = string.Format("{0}:{1}:{2}", result.DocumentType, result.DocumentId, result.ServiceId);
                        if (existingServiceResults.ContainsKey(resultIndex))
                        {
                            var existingRecord = existingServiceResults[resultIndex];

                            // TODO: Optimize this whole routine rather than generating new results
                            //
                            // See the lengthy comment in the load revenue calculation core for details.

                            existingRecord.BillingStatus = result.BillingStatus;
                            existingRecord.CalculationScope = result.CalculationScope;
                            existingRecord.BillingDate = result.BillingDate;
                            existingRecord.PrivateRate = result.PrivateRate;
                            existingRecord.PublicRate = result.PublicRate;
                            existingRecord.CompanyRef = result.CompanyRef;

                            // Whenever we update a service result, we add it to the updated dictionary
                            // for use in cleaning up old results below.

                            updatedServiceResults.Add(resultIndex, existingRecord);
                        }
                        else
                        {
                            RfsDataContext.AddServiceCalculationResult(result);
                        }

                        totalRevenue += result.PrivateRate.RfsRevenue;
                        totalFsc += result.PrivateRate.FscRevenue;

                        if (totalWeight == 0.0)
                        {
                            if (result.PrivateRate.Weight != 0.0)
                                totalWeight = result.PrivateRate.Weight;
                            else if (result.PublicRate.Weight != 0.0)
                                totalWeight = result.PublicRate.Weight;
                        }

                        // The private details go into [Load Rev]. The public details were originally intended to be
                        // summarized in another such table, but the RFS invoicing system makes that moot. Nevertheless,
                        // if a public summary table is desired, this is the place to add support in the future.
                    }

                    // NB:  Because we allow multiple services on a shipper/receiver, it isn't possible to store the correct
                    //      weight charged on each service here.

                    revenue.Revenue = totalRevenue;
                    revenue.FuelSurchargeRevenue = totalFsc;
                    revenue.Weight = totalWeight;
                    revenue.DocumentDate = document.DocumentDate;

                    if (newRevenue)
                        RfsDataContext.AddWarehouseRevenue(revenue);

                    Log.DebugFormat("Warehouse document ID {0}, Type {1}, RfsId {2}: set revenue to {3}",
                                    document.DocumentId, document.DocumentType, document.RfsRef, revenue.Revenue);

                    if (document.DocumentType == WarehouseDocumentType.Received)
                        returnValue.TotalReceivedCalculated++;
                    else if (document.DocumentType == WarehouseDocumentType.Shipped)
                        returnValue.TotalShippedCalculated++;

                    UpdateRfsResult(document.DocumentId, document.DocumentType, serviceCalculationErrors 
                        ? RfsCalculationResultType.ServiceCalculationErrors : RfsCalculationResultType.Success, calculationResult);
                }
                catch (Exception e)
                {
                    returnValue.ErrorCount++;

                    Log.ErrorFormat("Exception calculating warehouse document ID {0}, Type {1} with date {2}; details follow",
                                    document.DocumentId, document.DocumentType, document.DocumentDate);
                    Log.Error(e);
                    UpdateRfsResult(document.DocumentId, document.DocumentType, RfsCalculationResultType.SoftwareException, calculationResult);
                }
            }

            // Refer to the comments in the LoadRevenueCalculationCore method to understand the purpose of this code.

            foreach (var pair in existingServiceResults)
            {
                // Check the documents skipped list and, if found, skip reporting it here.

                var ids = pair.Key.Split(':');
                Debug.Assert(ids.Length == 3);
                var indexString = string.Format("{0}:{1}", ids[0], ids[1]);
                if (documentsSkipped.ContainsKey(indexString))
                    continue;

                if (updatedServiceResults.ContainsKey(pair.Key))
                    continue;

                // If it's an assessorial service, then we need to skip it.
                // TODO: Verify the service data is coming from cache.

                var serviceOffered = RfsDataContext.GetServiceOfferedByServiceRequestedId(pair.Value.ServiceId);
                Debug.Assert(serviceOffered != null);
                if (serviceOffered.CategoryRef == RfsServiceCategories.Assessorial)
                    continue;

                if (pair.Value.BillingStatus < RfsBillingStatus.Approved)
                    RfsDataContext.RemoveServiceCalculationResult(pair.Value);
                else
                    Log.WarnFormat("{0} should be deleted but cannot because its status is {1}",
                        pair.Value, pair.Value.BillingStatus);
            }

            _rfsDetailsCache = null;
            RfsDataContext.SaveChanges();

            var totalTime = DateTime.Now - beginTime;
            message = string.Format("Processed {0} documents in {1}", documents.Count, totalTime);
            _statusCallback.ProgressUpdate(message, null, documents.Count - 1, documents.Count);
            _statusCallback.UninitializeProgressMeter();
            Log.Debug(message);
        }

        #endregion

        public void PrecacheRfsData()
        {
            _rfsDetailsCache = PreloadRfsDetails();
        }

        public void CalculateLoadRevenue(IList<BopsLoad> loads, RfsLoadRevenueCalculationResult returnValue)
        {
            LoadRevenueCalculationCore(loads, returnValue);
        }

        public RfsLoadRevenueCalculationResult CalculateLoadRevenue(DateTime beginDate, DateTime endDate)
        {
            var returnValue = new RfsLoadRevenueCalculationResult();
            var loads = RfsDataContext.GetLoadsByLoadDateRange(beginDate, endDate);
            LoadRevenueCalculationCore(loads, returnValue);
            return returnValue;
        }

        public void CalculateWarehouseRevenue(IList<WarehouseCalculationInputs> documents,
                                              RfsWarehouseRevenueCalculationResult returnValue)
        {
            WarehouseRevenueCalculationCore(documents, returnValue);
        }

        public RfsWarehouseRevenueCalculationResult CalculateWarehouseRevenue(DateTime beginDate, DateTime endDate)
        {
            var returnValue = new RfsWarehouseRevenueCalculationResult();
            var documents = new List<WarehouseCalculationInputs>();

            var receivers = RfsDataContext.GetReceiversByDateReceivedRange(beginDate, endDate);

            foreach (var receiver in receivers)
            {
                var newReceiver = new WarehouseCalculationInputs
                {
                    DocumentId = receiver.ReceiverId,
                    DocumentType = WarehouseDocumentType.Received
                };
                if (receiver.DateReceived.HasValue)
                    newReceiver.DocumentDate = receiver.DateReceived.Value;
                if (receiver.RfsRef.HasValue)
                {
                    if (receiver.RfsRef.Value > 0)
                    {
                        newReceiver.RfsRef = receiver.RfsRef.Value;
                    }
                    else
                    {
                        Log.WarnFormat("Receiver {0} has invalid RFS value <= 0.", receiver.ReceiverId);
                        continue;
                    }
                }
                    
                newReceiver.ReceiverDocument = receiver;

                if (receiver.ProductProfileRef.HasValue)
                {
                    if (receiver.ProductProfileRef.Value > 0)
                    {
                        newReceiver.ProductProfile =
                            RfsDataContext.GetProductProfileById(receiver.ProductProfileRef.Value);
                    }
                    else
                    {
                        Log.WarnFormat("Receiver {0} has invalid product profile value <= 0.", receiver.ReceiverId);
                        continue;
                    }
                }
                    
                documents.Add(newReceiver);
            }

            var shippers = RfsDataContext.GetShippersByShipmentDateRange(beginDate, endDate);

            foreach (var shipper in shippers)
            {
                var newShipper = new WarehouseCalculationInputs
                {
                    DocumentId = shipper.LoadId,
                    DocumentType = WarehouseDocumentType.Shipped
                };
                if (shipper.ShipmentDate.HasValue)
                    newShipper.DocumentDate = shipper.ShipmentDate.Value;
                if (shipper.RfsRef.HasValue)
                    newShipper.RfsRef = shipper.RfsRef.Value;
                newShipper.ShipperDocument = shipper;
                // TODO: Add this back when/if we have a product profile.
                //if (TagData.Shipper.ProductProfileRef.HasValue)
                //    Shipper.ProductProfile = _DwsNoRepSession.Get<BopsProductProfile>(TagData.Receiver.ProductProfileRef.Value);
                documents.Add(newShipper);
            }

            WarehouseRevenueCalculationCore(documents, returnValue);

            return returnValue;
        }

        public void CleanInvalidRevenueResults()
        {
            var cleanBeginTime = DateTime.Now;

            RfsDataContext.RemoveInvalidRevenueResults();

            var interval = DateTime.Now - cleanBeginTime;
            Log.InfoFormat("Cleaning invalid revenue results total run time was {0}.", interval.ToString());
        }
    }
}
