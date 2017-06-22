using System;

namespace BopsDataAccess
{
    public enum BopsDriverPlanDetailActionType
    {
        None,
        Move,
        Deliver,
        DropTrailer,
        HookTrailer,
        PreLoad
    }

    public class BopsDriverPlanDetail
    {
        private Int32 _PlanDetailId;
        private Int32 _PlanRef;
        private Int32 _OriginRef;
        private Int32 _DestinationRef;
        private Int32 _SequenceNumber;
        private String _Notes;
        private Int32 _MinutesInTransit;
        private Int32 _MinutesInDetention;
        private DateTime? _ScheduledArrival;
        private DateTime? _ScheduledDeparture;
        private String _LoadRef;
        private Int32 _ScheduleAdjust;
        private Boolean _DetentionCall;
        private DateTime? _ActualDepartOrigin;
        private DateTime? _ActualArriveDestination;
        private DateTime? _ActualDepartDestination;
        private Single _DestinationValue;
        private Decimal _Multiplier;
        private Boolean _HourlySw;
        private Decimal _HourlyWage;
        private String _PayrollEditor;
        private String _PlannerEditor;
        private Boolean _PayDetention;
        private DateTime? _LastEdited;
        private bool _BadTime;
        private string _TransitBillingLoadRef;
        private string _DwellBillingLoadRef;
        private int _ActionRef;
        private string _ClientNotes;

        public int PlanDetailId
        {
            get { return _PlanDetailId; }
            set { _PlanDetailId = value; }
        }

        public int PlanRef
        {
            get { return _PlanRef; }
            set { _PlanRef = value; }
        }

        public int OriginRef
        {
            get { return _OriginRef; }
            set { _OriginRef = value; }
        }

        public int DestinationRef
        {
            get { return _DestinationRef; }
            set { _DestinationRef = value; }
        }

        public int SequenceNumber
        {
            get { return _SequenceNumber; }
            set { _SequenceNumber = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public int MinutesInTransit
        {
            get { return _MinutesInTransit; }
            set { _MinutesInTransit = value; }
        }

        public int MinutesInDetention
        {
            get { return _MinutesInDetention; }
            set { _MinutesInDetention = value; }
        }

        public DateTime? ScheduledArrival
        {
            get { return _ScheduledArrival; }
            set { _ScheduledArrival = value; }
        }

        public DateTime? ScheduledDeparture
        {
            get { return _ScheduledDeparture; }
            set { _ScheduledDeparture = value; }
        }

        public string LoadRef
        {
            get { return _LoadRef; }
            set { _LoadRef = value; }
        }

        public int ScheduleAdjust
        {
            get { return _ScheduleAdjust; }
            set { _ScheduleAdjust = value; }
        }

        public bool DetentionCall
        {
            get { return _DetentionCall; }
            set { _DetentionCall = value; }
        }

        public DateTime? ActualDepartOrigin
        {
            get { return _ActualDepartOrigin; }
            set { _ActualDepartOrigin = value; }
        }

        public DateTime? ActualArriveDestination
        {
            get { return _ActualArriveDestination; }
            set { _ActualArriveDestination = value; }
        }

        public DateTime? ActualDepartDestination
        {
            get { return _ActualDepartDestination; }
            set { _ActualDepartDestination = value; }
        }

        public float DestinationValue
        {
            get { return _DestinationValue; }
            set { _DestinationValue = value; }
        }

        public decimal Multiplier
        {
            get { return _Multiplier; }
            set { _Multiplier = value; }
        }

        public bool HourlySw
        {
            get { return _HourlySw; }
            set { _HourlySw = value; }
        }

        public decimal HourlyWage
        {
            get { return _HourlyWage; }
            set { _HourlyWage = value; }
        }

        public string PayrollEditor
        {
            get { return _PayrollEditor; }
            set { _PayrollEditor = value; }
        }

        public string PlannerEditor
        {
            get { return _PlannerEditor; }
            set { _PlannerEditor = value; }
        }

        public bool PayDetention
        {
            get { return _PayDetention; }
            set { _PayDetention = value; }
        }

        public DateTime? LastEdited
        {
            get { return _LastEdited; }
            set { _LastEdited = value; }
        }

        public bool BadTime
        {
            get { return _BadTime; }
            set { _BadTime = value; }
        }

        public string TransitBillingLoadRef
        {
            get { return _TransitBillingLoadRef; }
            set { _TransitBillingLoadRef = value; }
        }

        public string DwellBillingLoadRef
        {
            get { return _DwellBillingLoadRef; }
            set { _DwellBillingLoadRef = value; }
        }

        public int ActionRef
        {
            get { return _ActionRef; }
            set { _ActionRef = value; }
        }

        public string ClientNotes
        {
            get { return _ClientNotes; }
            set { _ClientNotes = value; }
        }
    }
}
