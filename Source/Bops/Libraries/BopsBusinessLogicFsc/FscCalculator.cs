using System.Collections.Generic;
using System.Text;
using BopsDataAccess;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFsc
{
    internal class FscCalculator : IFscCalculator
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(FscCalculator));

        private struct FscDetails
        {
            public BopsFsc Fsc { get; set; }

            public object Details { get; set; }
        }

        private readonly IRfsDataContext _rfsDataContext;
        private Dictionary<int, FscDetails> _fscDetails;
        private FscFuelPriceLookup _fuelPriceLookup;

        public FscCalculator(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;
            PrecacheFscData();
        }

        public FscFuelPriceLookup FuelPriceLookup
        {
            get { return _fuelPriceLookup; }
        }

        private void PrecacheFscData()
        {
            _fuelPriceLookup = new FscFuelPriceLookup(_rfsDataContext);

            _fscDetails = new Dictionary<int, FscDetails>();
            var allFsc = _rfsDataContext.GetFuelSurcharge();
            foreach (var fsc in allFsc)
            {
                var newDetails = new FscDetails();
                newDetails.Fsc = fsc;

                switch (fsc.CostMethodRef)
                {
                    case BopsFsc.FscCostMethod.FuelIndexedPercentOfTransportation:
                        newDetails.Details = new FscFloatIndexedDetailLookup(fsc, _rfsDataContext);
                        break;
                    case BopsFsc.FscCostMethod.FuelIndexedCentsPerMile:
                        newDetails.Details = new FscFloatIndexedDetailLookup(fsc, _rfsDataContext);
                        break;
                    case BopsFsc.FscCostMethod.OdLookup:
                        newDetails.Details = new FscOdIndexedDetailLookup(fsc, _rfsDataContext);
                        break;

                    default:
                        Log.ErrorFormat("Invalid cost method ({0}) on record for FSC {1}", fsc.CostMethodRef);
                        continue;
                }

                _fscDetails.Add(fsc.FscId, newDetails);
            }
        }

        public FscCalculationResult CalculateFsc(BopsLoad load, BopsRfsRateDetails rateDetails, 
            double baseRevenue, StringBuilder calculationDetails)
        {
            // If no fuel surcharge applies, there's nothing to do; return success.

            if (!rateDetails.FuelSurchargeApplies)
                return new FscCalculationResult(FscCalculationResultType.Success);

            // If the fuel surcharge is a fixed rate, then apply said rate to the manual revenue.

            if (rateDetails.FscFixedRate.HasValue)
            {
                var fscAmount = rateDetails.FscFixedRate.Value * baseRevenue;
                calculationDetails.AppendFormat(", {0:c} FSC at fixed {1:p}", fscAmount, rateDetails.FscFixedRate.Value);
                return new FscCalculationResult(FscCalculationResultType.Success, fscAmount);
            }
            else if (rateDetails.FscMatrixRef.HasValue && _fscDetails.ContainsKey(rateDetails.FscMatrixRef.Value))
            {
                var fd = _fscDetails[rateDetails.FscMatrixRef.Value];

                switch (fd.Fsc.CostMethodRef)
                {
                    case BopsFsc.FscCostMethod.FuelIndexedPercentOfTransportation:
                        if (!load.LogOutDate.HasValue)
                            return new FscCalculationResult(FscCalculationResultType.InvalidLogoutDate);

                        var percentLookupDetails = fd.Details as FscFloatIndexedDetailLookup;
                        var percentResult = percentLookupDetails.GetIndexedValue(load.LogOutDate.Value);

                        switch (percentResult.ResultCode)
                        {
                            case FscFloatIndexedDetailLookup.LookupResult.Code.Success:
                                var fscAmount = percentResult.FuelSurcharge * baseRevenue;
                                calculationDetails.AppendFormat(", {0:c} FSC at {1:p}", fscAmount, percentResult.FuelSurcharge);
                                return new FscCalculationResult(FscCalculationResultType.Success, fscAmount);
                            case FscFloatIndexedDetailLookup.LookupResult.Code.FuelPriceUnavailable:
                                return new FscCalculationResult(FscCalculationResultType.FloatLookupFuelPriceUnavailable);
                            case FscFloatIndexedDetailLookup.LookupResult.Code.SurchargeUnavailable:
                                return new FscCalculationResult(FscCalculationResultType.FloatLookupSurchargeUnavailable);

                            default:
                                return new FscCalculationResult(FscCalculationResultType.UnknownError);
                        }

                    case BopsFsc.FscCostMethod.FuelIndexedCentsPerMile:
                        if (!load.LogOutDate.HasValue)
                            return new FscCalculationResult(FscCalculationResultType.InvalidLogoutDate);
                        if (!rateDetails.Mileage.HasValue || (rateDetails.Mileage.Value <= 0.0))
                            return new FscCalculationResult(FscCalculationResultType.InvalidMileage);

                        var centsLookupDetails = fd.Details as FscFloatIndexedDetailLookup;
                        var centsLookupResult = centsLookupDetails.GetIndexedValue(load.LogOutDate.Value);

                        switch (centsLookupResult.ResultCode)
                        {
                            case FscFloatIndexedDetailLookup.LookupResult.Code.Success:
                                var fscAmount = centsLookupResult.FuelSurcharge * rateDetails.Mileage.Value;
                                calculationDetails.AppendFormat(", {0:c} FSC at {1:c} per mile", fscAmount, centsLookupResult.FuelSurcharge);
                                return new FscCalculationResult(FscCalculationResultType.Success, centsLookupResult.FuelSurcharge * rateDetails.Mileage.Value);
                            case FscFloatIndexedDetailLookup.LookupResult.Code.FuelPriceUnavailable:
                                return new FscCalculationResult(FscCalculationResultType.FloatLookupFuelPriceUnavailable);
                            case FscFloatIndexedDetailLookup.LookupResult.Code.SurchargeUnavailable:
                                return new FscCalculationResult(FscCalculationResultType.FloatLookupSurchargeUnavailable);

                            default:
                                return new FscCalculationResult(FscCalculationResultType.UnknownError);
                        }

                    case BopsFsc.FscCostMethod.OdLookup:
                        var odIndexedLookup = fd.Details as FscOdIndexedDetailLookup;
                        var odResult = odIndexedLookup.GetOdSurcharge(load);

                        switch (odResult.ResultCode)
                        {
                            case FscOdIndexedDetailLookup.LookupResult.Code.Success:
                                var fscAmount = odResult.FuelSurcharge;
                                calculationDetails.AppendFormat(", {0:c} FSC from O/D", fscAmount);
                                return new FscCalculationResult(FscCalculationResultType.Success, fscAmount);
                            case FscOdIndexedDetailLookup.LookupResult.Code.NoMatch:
                                return new FscCalculationResult(FscCalculationResultType.OdLookupFailureNoMatch);
                            case FscOdIndexedDetailLookup.LookupResult.Code.InvalidMatchMode:
                                return new FscCalculationResult(FscCalculationResultType.OdLookupFailureInvalidMatchMode);

                            default:
                                return new FscCalculationResult(FscCalculationResultType.UnknownError);
                        }
                }

                return new FscCalculationResult(FscCalculationResultType.InvalidFscCostMethod);
            }

            return new FscCalculationResult(FscCalculationResultType.InvalidFscId);
        }
    }
}
