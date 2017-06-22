using System;

namespace BopsDataAccess
{
    public class BopsRfsLocation
    {
        private const int _LocationCodeLength = 3;
        private const int _MaxNameLength = 50;
        private const int _FscAccountLength = 5;
        private const int _FscSubAccountLength = 6;
        private const int _MaxCpnyIDLength = 10;
        private const int _MaxDatabaseNameLength = 50;
        private const int _MaxSLCOALength = 10;
        private const int _MaxSLSUBLength = 10;

        private string _LocationCode;
        private string _Name;
        private string _FscAccount;
        private string _FscSubAccount;
        private string _CpnyID;
        private string _DatabaseName;
        private string _SLCOA;
        private string _SLSUB;

        public string LocationCode
        {
            get { return _LocationCode; }
            set
            {
                if (value.Length != _LocationCodeLength)
                    throw new ArgumentOutOfRangeException("value", string.Format("Location code must be {0} characters", _LocationCodeLength));
                _LocationCode = value;
            }
        }

        public string Name
        {
            get { return _Name; }
            set
            {
                if (string.IsNullOrEmpty(value))
                    throw new ArgumentNullException("value", "Name cannot be empty");
                if (value.Length >= _MaxNameLength)
                    throw new ArgumentOutOfRangeException("value", string.Format("Name must be no more than {0} characters", _MaxNameLength));
                _Name = value;
            }
        }

        public string FscAccount
        {
            get { return _FscAccount; }
            set
            {
                if (value.Length != _FscAccountLength)
                    throw new ArgumentOutOfRangeException("value", string.Format("FSC account must be {0} characters", _FscAccountLength));
                _FscAccount = value;
            }
        }

        public string FscSubAccount
        {
            get { return _FscSubAccount; }
            set
            {
                if (value.Length != _FscSubAccountLength)
                    throw new ArgumentOutOfRangeException("value", string.Format("FSC sub account must be {0} characters", _FscSubAccountLength));
                _FscSubAccount = value;
            }
        }

        public string DatabaseName
        {
            get { return _DatabaseName; }
            set
            {
                if ((value??string.Empty).Length > _MaxDatabaseNameLength)
                    throw new ArgumentOutOfRangeException("value", string.Format("Name must be no more than {0} characters", _MaxDatabaseNameLength));
                _DatabaseName = value;
            }
        }

        public string CpnyID
        {
            get { return _CpnyID; }
            set
            {
                if ((value ?? string.Empty).Length > _MaxCpnyIDLength)
                    throw new ArgumentOutOfRangeException("value", string.Format("Company id must be no more than {0} characters", _MaxCpnyIDLength));
                _CpnyID = value;
            }
        }

        public string SLCOA
        {
            get { return _SLCOA; }
            set
            {
                if ((value ?? string.Empty).Length > _MaxSLCOALength)
                    throw new ArgumentOutOfRangeException("value", string.Format("SLCOA must be no more than {0} characters", _MaxSLCOALength));
                _SLCOA = value;
            }
        }

        public string SLSUB
        {
            get { return _SLSUB; }
            set
            {
                if ((value ?? string.Empty).Length > _MaxSLSUBLength)
                    throw new ArgumentOutOfRangeException("value", string.Format("SLSUB must be no more than {0} characters", _MaxSLSUBLength));
                _SLSUB = value;
            }
        }

        public int CompanyRef { get; set; }

        public override string ToString()
        {
            return _Name;
        }
    }
}
