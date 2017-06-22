using System;
using System.Collections.Generic;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFsc
{
    internal class FscFloatIndexedDetailLookup
    {
        public class LookupResult
        {
            public enum Code
            {
                Success,
                FuelPriceUnavailable,
                SurchargeUnavailable
            }

            private readonly Code _resultCode;
            private readonly BopsFscDetailFloatIndexed _details;
            private readonly double _fuelSurcharge;

            public Code ResultCode
            {
                get { return _resultCode; }
            }

            public BopsFscDetailFloatIndexed Details
            {
                get { return _details; }
            }

            public double FuelSurcharge
            {
                get { return _fuelSurcharge; }
            }

            public LookupResult(Code resultCode)
            {
                _resultCode = resultCode;
                _fuelSurcharge = 0;
                _details = null;
            }

            public LookupResult(Code resultCode, BopsFscDetailFloatIndexed details, double fuelSurcharge)
            {
                _resultCode = resultCode;
                _fuelSurcharge = fuelSurcharge;
                _details = details;
            }
        }

        private readonly FscFuelPriceLookup _fuelPriceLookup;
        private readonly List<BopsFscDetailFloatIndexed> _surcharges;

        public FscFloatIndexedDetailLookup(BopsFsc fsc, IRfsDataContext rfsDataContext)
        {
            _fuelPriceLookup = new FscFuelPriceLookup(rfsDataContext);
            var allRows = rfsDataContext.GetFuelSurchargeDetailFloatIndexedByFscIdOrderedByIndexMinimum(fsc.FscId);
            _surcharges = new List<BopsFscDetailFloatIndexed>(allRows);
        }

        public LookupResult GetIndexedValue(DateTime dateInQuestion)
        {
            var fuelPrice = _fuelPriceLookup.GetFuelPriceHistory(dateInQuestion);
            if (fuelPrice == null)
                return new LookupResult(LookupResult.Code.FuelPriceUnavailable);

            foreach (var row in _surcharges)
            {
                if (row.IndexMinimum <= fuelPrice.FuelPrice && fuelPrice.FuelPrice <= row.IndexMaximum)
                    return new LookupResult(LookupResult.Code.Success, row, row.FscValue);
            }

            return new LookupResult(LookupResult.Code.SurchargeUnavailable);
        }
    }
}
