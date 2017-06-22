using System;
using System.Text;
using BopsDataAccess;

namespace AgilisCore
{
    public class AgilisDriver
    {
        #region Fields

        private int _DriverId;
        private int _VehicleNumber;
        private string _PhoneNumber;
        private DateTime _LastSynced;
        private string _FirstName;
        private string _LastName;
        private int _FleetNumber;
        private int _BusinessUnitNumber;
        private bool _Active;

        #endregion

        #region Construction

        public AgilisDriver()
        {

        }

        public AgilisDriver(BopsDriver Driver)
        {
            _DriverId = Driver.DriverId;
            _FirstName = Driver.FirstName;
            _LastName = Driver.LastName;
            _PhoneNumber = Driver.WorkPhone;
            _Active = Driver.Agilis;

            // Assumed defaults. The default fleet number used to be 155, but it got changed
            // to 158 at some point for some unknown reason.

            _BusinessUnitNumber = 101;
            _FleetNumber = 158;
        }

        #endregion

        #region Properties

        public int DriverId
        {
            get { return _DriverId; }
            set { _DriverId = value; }
        }

        public int VehicleNumber
        {
            get { return _VehicleNumber; }
            set { _VehicleNumber = value; }
        }

        public string PhoneNumber
        {
            get { return _PhoneNumber; }
            set { _PhoneNumber = value; }
        }

        public DateTime LastSynced
        {
            get { return _LastSynced; }
            set { _LastSynced = value; }
        }

        public string FirstName
        {
            get { return _FirstName; }
            set { _FirstName = value; }
        }

        public string LastName
        {
            get { return _LastName; }
            set { _LastName = value; }
        }

        public int FleetNumber
        {
            get { return _FleetNumber; }
            set { _FleetNumber = value; }
        }

        public int BusinessUnitNumber
        {
            get { return _BusinessUnitNumber; }
            set { _BusinessUnitNumber = value; }
        }

        public bool Active
        {
            get { return _Active; }
            set { _Active = value; }
        }

        #endregion

        public override string ToString()
        {
            StringBuilder ReturnValue = new StringBuilder();

            ReturnValue.AppendFormat("DriverId = {0}, ", DriverId);
            ReturnValue.AppendFormat("VehicleNumber = {0}, ", VehicleNumber);
            ReturnValue.AppendFormat("PhoneNumber = {0}, ", PhoneNumber);
            ReturnValue.AppendFormat("LastSynced = {0}, ", LastSynced.ToString("G"));
            ReturnValue.AppendFormat("FirstName = {0}, ", FirstName);
            ReturnValue.AppendFormat("LastName = {0}, ", LastName);
            ReturnValue.AppendFormat("FleetNumber = {0}, ", FleetNumber);
            ReturnValue.AppendFormat("BusinessUnitNumber = {0}, ", BusinessUnitNumber);
            ReturnValue.AppendFormat("Active = {0}", Active);

            return ReturnValue.ToString();
        }

        public bool IsValid()
        {
            return DriverId != 0 &&
                   PhoneNumber != string.Empty &&
                   LastName != string.Empty &&
                   FirstName != string.Empty;
        }
    }
}
