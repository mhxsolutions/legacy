using System;
using System.Collections.Generic;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFsc
{
    internal class FscFuelPriceLookup
    {
        private readonly List<BopsFscFuelPriceHistory> _history;

        public FscFuelPriceLookup(IRfsDataContext rfsDataContext)
        {
            var fuelPriceHistory = rfsDataContext.GetFuelPriceHistoryOrderedByBeginDate();
            _history = new List<BopsFscFuelPriceHistory>(fuelPriceHistory);
        }

        public FscFuelPriceLookup(IEnumerable<BopsFscFuelPriceHistory> enumerableData)
        {
            _history = new List<BopsFscFuelPriceHistory>(enumerableData);
        }

        public BopsFscFuelPriceHistory GetFuelPriceHistory(DateTime dateInQuestion)
        {
            foreach (var historyRecord in _history)
            {
                if (historyRecord.BeginDate <= dateInQuestion)
                {
                    if (!historyRecord.EndDate.HasValue || (dateInQuestion < historyRecord.EndDate.Value))
                        return historyRecord;
                }
            }

            return null;
        }
    }
}
