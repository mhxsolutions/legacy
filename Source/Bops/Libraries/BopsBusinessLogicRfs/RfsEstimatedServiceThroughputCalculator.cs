using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    public class RfsEstimatedServiceThroughputCalculator : IRfsEstimatedThroughputCalculator
    {
        private const double DefaultMinimumChargedWeight = 40000;

        private readonly IRfsDataContext _rfsDataContext;

        public RfsEstimatedServiceThroughputCalculator(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;
        }

        private BopsDestination GetParentDestination(int destinationId)
        {
            var returnValue = _rfsDataContext.GetDestinationById(destinationId);
            if (returnValue.ParentRef.HasValue
                && returnValue.ParentRef != 0
                && returnValue.ParentRef != returnValue.DestinationId)
            {
                returnValue = _rfsDataContext.GetDestinationById(returnValue.ParentRef.Value);
            }
                
            return returnValue;
        }

        private double CalculatePerWeightRevenue(BopsRfsRateDetails rate)
        {
            var returnValue = -1.0;
            var weight = (rate.MinimumChargedWeight > 0) 
                ? rate.MinimumChargedWeight : DefaultMinimumChargedWeight;

            if (rate.UnitRef.HasValue)
            {
                switch ((RfsCostMethodUnits)rate.UnitRef)
                {
                    case RfsCostMethodUnits.Load:
                    case RfsCostMethodUnits.Truck:
                        returnValue = rate.Cost.Value;
                        break;

                    case RfsCostMethodUnits.CWT:
                        returnValue = rate.Cost.Value * (weight / 100);
                        break;

                    case RfsCostMethodUnits.Pound:
                        returnValue = rate.Cost.Value * weight;
                        break;

                    case RfsCostMethodUnits.Ton:
                        returnValue = rate.Cost.Value * (weight / 2000);
                        break;
                }
            }

            return returnValue;
        }

        private double CalculateEstimatedRevenue(BopsRfsRateDetails rate)
        {
            var returnValue = -1.0;

            if (rate.CostMethodRef.HasValue)
            {
                switch ((RfsCostMethods)rate.CostMethodRef.Value)
                {
                    case RfsCostMethods.FlatFee:
                        returnValue = rate.Cost.Value;
                        break;
                    case RfsCostMethods.PerUnit:
                        returnValue = CalculatePerWeightRevenue(rate);
                        break;
                }
            }

            return returnValue;
        }

        private double CalculateEstimatedMinutes(BopsRfsServicesRequested service)
        {
            var returnValue = -1.0;

            if (service.OriginRef.HasValue && service.DestinationRef.HasValue)
            {
                var originStakeholder = _rfsDataContext.GetStakeholderById(service.OriginRef.Value);
                var destinationStakeholder = _rfsDataContext.GetStakeholderById(service.DestinationRef.Value);

                if (originStakeholder != null && destinationStakeholder != null)
                {
                    var origin = GetParentDestination(originStakeholder.ClientRef);
                    var destination = GetParentDestination(destinationStakeholder.ClientRef);

                    if (origin != null && destination != null)
                    {
                        var transitTimes = _rfsDataContext.GetTransitTimeByOriginDestinationAndHour(
                            origin.DestinationId, destination.DestinationId, 0);

                        if (origin.UnloadTime.HasValue && destination.UnloadTime.HasValue &&
                            destination.AverageRelocate.HasValue && transitTimes.Count > 0)
                        {
                            returnValue = origin.UnloadTime.Value + transitTimes[0].Transit +
                                          destination.UnloadTime.Value +
                                          destination.AverageRelocate.Value;
                        }
                    }
                }
            }

            return returnValue;
        }

        public RfsEstimatedServiceThroughput CalculateEstimatedServiceThroughput(BopsRfsServicesRequested service)
        {
            var privateRevenue = CalculateEstimatedRevenue(service.PrivateRate);
            var publicRevenue = CalculateEstimatedRevenue(service.PublicRate);
            var minutes = CalculateEstimatedMinutes(service);
            return new RfsEstimatedServiceThroughput(privateRevenue, publicRevenue, minutes);
        }
    }
}
