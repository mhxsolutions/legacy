using System;

namespace BopsDataAccess
{
    public class BopsRfsStorageRateAssignment
    {
        private int _AssignmentId;
        private int _StorageRateRef;
        private int _ProfileRef;
        private DateTime _BeginDate;
        private DateTime _EndDate;
        private string _Description;

        public int AssignmentId
        {
            get { return _AssignmentId; }
            set { _AssignmentId = value; }
        }

        public int StorageRateRef
        {
            get { return _StorageRateRef; }
            set { _StorageRateRef = value; }
        }

        public int ProfileRef
        {
            get { return _ProfileRef; }
            set { _ProfileRef = value; }
        }

        public DateTime BeginDate
        {
            get { return _BeginDate; }
            set { _BeginDate = value; }
        }

        public DateTime EndDate
        {
            get { return _EndDate; }
            set { _EndDate = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public bool ContainsDate(DateTime D)
        {
            return _BeginDate <= D && D < _EndDate;
        }

        public bool ContainsOrEndsWithDate(DateTime D)
        {
            return _BeginDate <= D && D <= _EndDate;
        }

        public override string ToString()
        {
            return
                string.Format(
                    "AssignmentId = {0}, StorageRateRef = {1}, ProfileRef = {2}, BeginDate = {3}, EndDate = {4}, Description = {5}",
                    _AssignmentId, _StorageRateRef, _ProfileRef, _BeginDate, _EndDate, _Description);
        }
    }
}
