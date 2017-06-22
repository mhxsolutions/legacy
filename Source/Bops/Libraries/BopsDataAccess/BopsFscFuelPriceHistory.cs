using System;

namespace BopsDataAccess
{
    public class BopsFscFuelPriceHistory
    {
        private int _FuelPriceId;
        private DateTime _BeginDate;
        private DateTime? _EndDate;
        private double _FuelPrice;

        public int FuelPriceId
        {
            get { return _FuelPriceId; }
            set { _FuelPriceId = value; }
        }

        public DateTime BeginDate
        {
            get { return _BeginDate; }
            set { _BeginDate = value; }
        }

        public DateTime? EndDate
        {
            get { return _EndDate; }
            set { _EndDate = value; }
        }

        public double FuelPrice
        {
            get { return _FuelPrice; }
            set { _FuelPrice = value; }
        }
    }
}
