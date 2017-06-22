using System;

namespace BopsDataAccess
{
    public class BopsProjectManagerBillOfLadingDetail
    {
        private int _DetailId;
        private int _BolRef;
        private string _UserData1;
        private string _UserData2;
        private string _UserData3;
        private string _UserData4;
        private string _UserData5;
        private string _ItemId;
        private int? _Count;
        private double? _Weight;
        private string _WeightUnit;
        private string _Notes;
        private string _Creator;
        private DateTime? _CreateTime;
        private string _EditUser;
        private DateTime? _EditTime;

        public int DetailId
        {
            get { return _DetailId; }
            set { _DetailId = value; }
        }

        public int BolRef
        {
            get { return _BolRef; }
            set { _BolRef = value; }
        }

        public string UserData1
        {
            get { return _UserData1; }
            set { _UserData1 = value; }
        }

        public string UserData2
        {
            get { return _UserData2; }
            set { _UserData2 = value; }
        }

        public string UserData3
        {
            get { return _UserData3; }
            set { _UserData3 = value; }
        }

        public string UserData4
        {
            get { return _UserData4; }
            set { _UserData4 = value; }
        }

        public string UserData5
        {
            get { return _UserData5; }
            set { _UserData5 = value; }
        }

        public string ItemId
        {
            get { return _ItemId; }
            set { _ItemId = value; }
        }

        public int? Count
        {
            get { return _Count; }
            set { _Count = value; }
        }

        public double? Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public string WeightUnit
        {
            get { return _WeightUnit; }
            set { _WeightUnit = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public string Creator
        {
            get { return _Creator; }
            set { _Creator = value; }
        }

        public DateTime? CreateTime
        {
            get { return _CreateTime; }
            set { _CreateTime = value; }
        }

        public string EditUser
        {
            get { return _EditUser; }
            set { _EditUser = value; }
        }

        public DateTime? EditTime
        {
            get { return _EditTime; }
            set { _EditTime = value; }
        }
    }
}
