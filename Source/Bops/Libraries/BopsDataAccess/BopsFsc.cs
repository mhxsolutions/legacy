using System;

namespace BopsDataAccess
{
    public class BopsFsc
    {
        public enum FscCostMethod
        {
            None,
            FuelIndexedPercentOfTransportation,
            FuelIndexedCentsPerMile,
            OdLookup
        }

        private int _FscId;
        private string _Name;
        private string _Description;
        private FscCostMethod _CostMethodRef;
        private DateTime _BeginDate;
        private DateTime? _EndDate;

        public int FscId
        {
            get { return _FscId; }
            set { _FscId = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public FscCostMethod CostMethodRef
        {
            get { return _CostMethodRef; }
            set { _CostMethodRef = value; }
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
    }
}
