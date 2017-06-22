using System;

namespace BopsDataAccess
{
    public class BopsCpsContainer
    {
        private string _ContainerId;
        private int _LastKnownLocationRef;
        private DateTime _LastKnownLocationTimestamp;

        public string ContainerId
        {
            get { return _ContainerId; }
            set { _ContainerId = value; }
        }

        public int LastKnownLocationRef
        {
            get { return _LastKnownLocationRef; }
            set { _LastKnownLocationRef = value; }
        }

        public DateTime LastKnownLocationTimestamp
        {
            get { return _LastKnownLocationTimestamp; }
            set { _LastKnownLocationTimestamp = value; }
        }

        public BopsCpsContainer()
        {
        }

        public BopsCpsContainer(string ContainerId, int LastKnownLocationRef, DateTime LastKnownLocationTimestamp)
        {
            _ContainerId = ContainerId;
            _LastKnownLocationRef = LastKnownLocationRef;
            _LastKnownLocationTimestamp = LastKnownLocationTimestamp;
        }

        public override string ToString()
        {
            return string.Format("Container {0} last known at {1} at {2}",
                                 _ContainerId, _LastKnownLocationRef, _LastKnownLocationTimestamp);
        }
    }
}
