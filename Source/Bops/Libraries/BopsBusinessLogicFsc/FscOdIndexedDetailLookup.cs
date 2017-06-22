using System.Collections.Generic;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFsc
{
    internal class FscOdIndexedDetailLookup
    {
        public class LookupResult
        {
            public enum Code
            {
                Success,
                InvalidMatchMode,
                NoMatch
            }

            private readonly Code _resultCode;
            private readonly BopsFscDetailOdIndexed _details;
            private readonly double _fuelSurcharge;

            public Code ResultCode
            {
                get { return _resultCode; }
            }

            public BopsFscDetailOdIndexed Details
            {
                get { return _details; }
            }

            public double FuelSurcharge
            {
                get { return _fuelSurcharge; }
            }

            public LookupResult(Code resultCode)
            {
                this._resultCode = resultCode;
                _fuelSurcharge = 0;
                _details = null;
            }

            public LookupResult(Code resultCode, BopsFscDetailOdIndexed details, double fuelSurcharge)
            {
                _resultCode = resultCode;
                _fuelSurcharge = fuelSurcharge;
                _details = details;
            }
        }

        private readonly List<BopsFscDetailOdIndexed> _surcharges;

        public FscOdIndexedDetailLookup(BopsFsc fsc, IRfsDataContext rfsDataContext)
        {
            var allRows = rfsDataContext.GetFuelSurchargeDetailOdByFscIdIndexedOrderedByMatchMode(fsc.FscId);
            _surcharges = new List<BopsFscDetailOdIndexed>(allRows);
        }

        public LookupResult GetOdSurcharge(BopsLoad load)
        {
            foreach (var row in _surcharges)
            {
                switch (row.MatchMode)
                {
                    case BopsFscDetailOdIndexed.OdMatchMode.MatchBoth:
                        if (load.OriginRef == row.OriginRef && load.DeliveryLocationRef == row.DestinationRef)
                            return new LookupResult(LookupResult.Code.Success, row, row.FscValue);
                        break;
                    case BopsFscDetailOdIndexed.OdMatchMode.MatchDestination:
                        if (load.DeliveryLocationRef == row.DestinationRef)
                            return new LookupResult(LookupResult.Code.Success, row, row.FscValue);
                        break;
                    case BopsFscDetailOdIndexed.OdMatchMode.MatchOrigin:
                        if (load.OriginRef == row.OriginRef)
                            return new LookupResult(LookupResult.Code.Success, row, row.FscValue);
                        break;

                    default:
                        return new LookupResult(LookupResult.Code.InvalidMatchMode);
                }
            }

            return new LookupResult(LookupResult.Code.NoMatch);
        }
    }
}
