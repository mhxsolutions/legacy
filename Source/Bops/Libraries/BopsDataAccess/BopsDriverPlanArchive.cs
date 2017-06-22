using System;

namespace BopsDataAccess
{
    public class BopsDriverPlanArchive
    {
        private Int32 _PlanId;
        private Int32 _DriverRef;
        private DateTime? _PlanDate;
        private DateTime? _StartTime;
        private Decimal _MinDayPay;
        private DateTime? _PayrollStart;

        public int PlanId
        {
            get { return _PlanId; }
            set { _PlanId = value; }
        }

        public int DriverRef
        {
            get { return _DriverRef; }
            set { _DriverRef = value; }
        }

        public DateTime? PlanDate
        {
            get { return _PlanDate; }
            set { _PlanDate = value; }
        }

        public DateTime? StartTime
        {
            get { return _StartTime; }
            set { _StartTime = value; }
        }

        public decimal MinDayPay
        {
            get { return _MinDayPay; }
            set { _MinDayPay = value; }
        }

        public DateTime? PayrollStart
        {
            get { return _PayrollStart; }
            set { _PayrollStart = value; }
        }
    }
}
