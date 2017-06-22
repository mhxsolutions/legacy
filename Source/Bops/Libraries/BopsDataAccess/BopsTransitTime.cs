using System;

namespace BopsDataAccess
{
    public class BopsTransitTime
    {
        private int _TransitId;
        private int _FromRef;
        private int _ToRef;
        private int _Transit;
        private double? _Points;
        private bool _Hourly;
        private int _Hour;
        private int? _Sample;
        private DateTime? _Edited;
        private string _Editor;

        public int TransitId
        {
            get { return _TransitId; }
            set { _TransitId = value; }
        }

        public int FromRef
        {
            get { return _FromRef; }
            set { _FromRef = value; }
        }

        public int ToRef
        {
            get { return _ToRef; }
            set { _ToRef = value; }
        }

        public int Transit
        {
            get { return _Transit; }
            set { _Transit = value; }
        }

        public double? Points
        {
            get { return _Points; }
            set { _Points = value; }
        }

        public bool Hourly
        {
            get { return _Hourly; }
            set { _Hourly = value; }
        }

        public int Hour
        {
            get { return _Hour; }
            set { _Hour = value; }
        }

        public int? Sample
        {
            get { return _Sample; }
            set { _Sample = value; }
        }

        public DateTime? Edited
        {
            get { return _Edited; }
            set { _Edited = value; }
        }

        public string Editor
        {
            get { return _Editor; }
            set { _Editor = value; }
        }
    }
}
