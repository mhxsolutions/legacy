using System;

namespace BopsDataAccess
{
    public class BopsFscDetailOdIndexed
    {
        [Flags]
        public enum OdMatchMode
        {
            None = 0x0,
            MatchOrigin = 0x1,
            MatchDestination = 0x2,
            MatchBoth = 0x3
        }

        private int _FscDetailId;
        private int _FscRef;
        private OdMatchMode _MatchMode;
        private int _OriginRef;
        private int _DestinationRef;
        private double _FscValue;

        public int FscDetailId
        {
            get { return _FscDetailId; }
            set { _FscDetailId = value; }
        }

        public int FscRef
        {
            get { return _FscRef; }
            set { _FscRef = value; }
        }

        public OdMatchMode MatchMode
        {
            get { return _MatchMode; }
            set { _MatchMode = value; }
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

        public double FscValue
        {
            get { return _FscValue; }
            set { _FscValue = value; }
        }
    }
}
