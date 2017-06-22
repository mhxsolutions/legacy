using System;
using System.Collections.Generic;

namespace AgilisCore
{
    public class AgilisWorkOrder
    {
        public const int _MaxDriverNumberLength = 50;
        public const int _MaxWorkOrderNumberLength = 100;
        public const int _MaxWorkOrderJobCodeLength = 3;
        public const int _MaxBusinessUnitNumberLength = 20;
        public const int _MaxNotesLength = 2000;
        public const int _MaxWorkGroupNumberLength = 100;
        public const int _MaxFirstNameLength = 100;
        public const int _MaxLastNameLength = 100;
        public const int _MaxStreetAddress1Length = 100;
        public const int _MaxStreetAddress2Length = 100;
        public const int _MaxCityLength = 100;
        public const int _MaxStateLength = 2;
        public const int _MaxZipCodeLength = 20;
        public const int _MaxCountryLength = 3;
        public const int _MaxPhoneNumberLength = 15;
        public const int _MaxPhoneExtensionLength = 10;
        public const int _MaxEmailAddressLength = 500;

        #region Fields
        private int _WorkOrderId;
        private string _WorkOrderNumber;
        private string _WorkOrderGroup;
        private DateTime _LastEdited;
        private string _CurrentStatus;
        private DateTime _StatusLastUpdated;
        private DateTime _SlotStartDate;
        private int _DriverNumber;

        private string _CustomerFirstName;
        private string _CustomerLastName;
        private string _CustomerStreetAddress1;
        private string _CustomerStreetAddress2;
        private string _CustomerCity;
        private string _CustomerState;
        private string _CustomerZipCode;
        private string _CustomerCountry;
        private string _CustomerPhoneNumber;
        private string _CustomerPhoneNumberExtension;

        private string _ContactFirstName;
        private string _ContactLastName;
        private string _ContactStreetAddress1;
        private string _ContactStreetAddress2;
        private string _ContactCity;
        private string _ContactState;
        private string _ContactZipCode;
        private string _ContactCountry;
        private string _ContactPhoneNumber;
        private string _ContactPhoneNumberExtension;

        private string _PickupFirstName;
        private string _PickupLastName;
        private string _PickupStreetAddress1;
        private string _PickupStreetAddress2;
        private string _PickupCity;
        private string _PickupState;
        private string _PickupZipCode;
        private string _PickupCountry;
        private string _PickupPhoneNumber;
        private string _PickupPhoneNumberExtension;

        private string _Notes;                  // A concatenation of Budway and any client provided notes.

        private int _Sequence;                  // Stored in the misc1 field
        private int _PlannerDetailId;           // Stored in the misc2 field
        private int _OriginId;                  // Stored in the misc3 field
        private int _DestinationId;             // Stored in the misc4 field
        private string _DisplayWorkOrderNumber; // Stored in the misc5 field
        private string _LoadRef;                // Parsed from the work order number

        private string _Tractor;
        private string _Trailer;
        private DateTime _ScheduledArrive;      // Held only in memory and used for export
        
        private List<AgilisWorkOrderJob> _Jobs;
        #endregion

        #region Properties
        public int WorkOrderId
        {
            get { return _WorkOrderId; }
            set { _WorkOrderId = value; }
        }

        public string WorkOrderNumber
        {
            get { return _WorkOrderNumber; }
            set { _WorkOrderNumber = value; }
        }

        public string WorkOrderGroup
        {
            get { return _WorkOrderGroup; }
            set { _WorkOrderGroup = value; }
        }

        public DateTime LastEdited
        {
            get { return _LastEdited; }
            set { _LastEdited = value; }
        }

        public string CurrentStatus
        {
            get { return _CurrentStatus; }
            set { _CurrentStatus = value; }
        }

        public DateTime StatusLastUpdated
        {
            get { return _StatusLastUpdated; }
            set { _StatusLastUpdated = value; }
        }

        public DateTime SlotStartDate
        {
            get { return _SlotStartDate; }
            set { _SlotStartDate = value; }
        }

        public int DriverNumber
        {
            get { return _DriverNumber; }
            set { _DriverNumber = value; }
        }

        public int Sequence
        {
            get { return _Sequence; }
            set { _Sequence = value; }
        }

        public int PlannerDetailId
        {
            get { return _PlannerDetailId; }
            set { _PlannerDetailId = value; }
        }

        public string LoadRef
        {
            get { return _LoadRef; }
            set { _LoadRef = value; }
        }

        public List<AgilisWorkOrderJob> Jobs
        {
            get { return _Jobs; }
            set { _Jobs = value; }
        }

        public string CustomerFirstName
        {
            get { return _CustomerFirstName; }
            set { _CustomerFirstName = value; }
        }

        public string CustomerLastName
        {
            get { return _CustomerLastName; }
            set { _CustomerLastName = value; }
        }

        public string CustomerStreetAddress1
        {
            get { return _CustomerStreetAddress1; }
            set { _CustomerStreetAddress1 = value; }
        }

        public string CustomerStreetAddress2
        {
            get { return _CustomerStreetAddress2; }
            set { _CustomerStreetAddress2 = value; }
        }

        public string CustomerCity
        {
            get { return _CustomerCity; }
            set { _CustomerCity = value; }
        }

        public string CustomerState
        {
            get { return _CustomerState; }
            set { _CustomerState = value; }
        }

        public string CustomerZipCode
        {
            get { return _CustomerZipCode; }
            set { _CustomerZipCode = value; }
        }

        public string CustomerCountry
        {
            get { return _CustomerCountry; }
            set { _CustomerCountry = value; }
        }

        public string CustomerPhoneNumber
        {
            get { return _CustomerPhoneNumber; }
            set { _CustomerPhoneNumber = value; }
        }

        public string CustomerPhoneNumberExtension
        {
            get { return _CustomerPhoneNumberExtension; }
            set { _CustomerPhoneNumberExtension = value; }
        }

        public string ContactFirstName
        {
            get { return _ContactFirstName; }
            set { _ContactFirstName = value; }
        }

        public string ContactLastName
        {
            get { return _ContactLastName; }
            set { _ContactLastName = value; }
        }

        public string ContactStreetAddress1
        {
            get { return _ContactStreetAddress1; }
            set { _ContactStreetAddress1 = value; }
        }

        public string ContactStreetAddress2
        {
            get { return _ContactStreetAddress2; }
            set { _ContactStreetAddress2 = value; }
        }

        public string ContactCity
        {
            get { return _ContactCity; }
            set { _ContactCity = value; }
        }

        public string ContactState
        {
            get { return _ContactState; }
            set { _ContactState = value; }
        }

        public string ContactZipCode
        {
            get { return _ContactZipCode; }
            set { _ContactZipCode = value; }
        }

        public string ContactCountry
        {
            get { return _ContactCountry; }
            set { _ContactCountry = value; }
        }

        public string ContactPhoneNumber
        {
            get { return _ContactPhoneNumber; }
            set { _ContactPhoneNumber = value; }
        }

        public string ContactPhoneNumberExtension
        {
            get { return _ContactPhoneNumberExtension; }
            set { _ContactPhoneNumberExtension = value; }
        }

        public string PickupFirstName
        {
            get { return _PickupFirstName; }
            set { _PickupFirstName = value; }
        }

        public string PickupLastName
        {
            get { return _PickupLastName; }
            set { _PickupLastName = value; }
        }

        public string PickupStreetAddress1
        {
            get { return _PickupStreetAddress1; }
            set { _PickupStreetAddress1 = value; }
        }

        public string PickupStreetAddress2
        {
            get { return _PickupStreetAddress2; }
            set { _PickupStreetAddress2 = value; }
        }

        public string PickupCity
        {
            get { return _PickupCity; }
            set { _PickupCity = value; }
        }

        public string PickupState
        {
            get { return _PickupState; }
            set { _PickupState = value; }
        }

        public string PickupZipCode
        {
            get { return _PickupZipCode; }
            set { _PickupZipCode = value; }
        }

        public string PickupCountry
        {
            get { return _PickupCountry; }
            set { _PickupCountry = value; }
        }

        public string PickupPhoneNumber
        {
            get { return _PickupPhoneNumber; }
            set { _PickupPhoneNumber = value; }
        }

        public string PickupPhoneNumberExtension
        {
            get { return _PickupPhoneNumberExtension; }
            set { _PickupPhoneNumberExtension = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public int OriginId
        {
            get { return _OriginId; }
            set { _OriginId = value; }
        }

        public int DestinationId
        {
            get { return _DestinationId; }
            set { _DestinationId = value; }
        }

        public string DisplayWorkOrderNumber
        {
            get { return _DisplayWorkOrderNumber; }
            set { _DisplayWorkOrderNumber = value; }
        }

        public string Tractor
        {
            get { return _Tractor; }
            set { _Tractor = value; }
        }

        public string Trailer
        {
            get { return _Trailer; }
            set { _Trailer = value; }
        }

        public DateTime ScheduledArrive
        {
            get { return _ScheduledArrive; }
            set { _ScheduledArrive = value; }
        }

        #endregion

        #region Constructor

        public AgilisWorkOrder()
        {
            _Jobs = new List<AgilisWorkOrderJob>();
        }

        #endregion

        public bool FieldLengthsAreValid()
        {
            return WorkOrderNumber.Length <= _MaxWorkOrderNumberLength &&
                   WorkOrderGroup.Length <= _MaxWorkGroupNumberLength &&
                   DriverNumber.ToString().Length <= _MaxDriverNumberLength &&
                   CustomerFirstName.Length <= _MaxFirstNameLength &&
                   CustomerLastName.Length <= _MaxLastNameLength &&
                   CustomerStreetAddress1.Length <= _MaxStreetAddress1Length &&
                   CustomerStreetAddress2.Length <= _MaxStreetAddress2Length &&
                   CustomerCity.Length <= _MaxCityLength &&
                   CustomerState.Length <= _MaxStateLength &&
                   CustomerZipCode.Length <= _MaxZipCodeLength &&
                   CustomerCountry.Length <= _MaxCountryLength &&
                   CustomerPhoneNumber.Length <= _MaxPhoneNumberLength &&
                   CustomerPhoneNumberExtension.Length <= _MaxPhoneExtensionLength &&
                   ContactStreetAddress1.Length <= _MaxStreetAddress1Length &&
                   ContactStreetAddress2.Length <= _MaxStreetAddress2Length &&
                   ContactCity.Length <= _MaxCityLength &&
                   ContactState.Length <= _MaxStateLength &&
                   ContactZipCode.Length <= _MaxZipCodeLength &&
                   ContactCountry.Length <= _MaxCountryLength &&
                   ContactPhoneNumber.Length <= _MaxPhoneNumberLength &&
                   ContactPhoneNumberExtension.Length <= _MaxPhoneExtensionLength &&
                   PickupStreetAddress1.Length <= _MaxStreetAddress1Length &&
                   PickupStreetAddress2.Length <= _MaxStreetAddress2Length &&
                   PickupCity.Length <= _MaxCityLength &&
                   PickupState.Length <= _MaxStateLength &&
                   PickupZipCode.Length <= _MaxZipCodeLength &&
                   PickupCountry.Length <= _MaxCountryLength &&
                   PickupPhoneNumber.Length <= _MaxPhoneNumberLength &&
                   PickupPhoneNumberExtension.Length <= _MaxPhoneExtensionLength &&
                   Notes.Length <= _MaxNotesLength &&
                   DisplayWorkOrderNumber.Length <= _MaxWorkOrderNumberLength;
        }
    }
}
