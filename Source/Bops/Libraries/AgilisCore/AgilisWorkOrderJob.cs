using System.Collections.Generic;

namespace AgilisCore
{
    public class AgilisWorkOrderJob
    {
        private int _WorkOrderJobId;
        private int _WorkOrderRef;
        private int _AgilisJobId;
        private string _AgilisJobType;
        private string _Description;

        public List<AgilisWorkOrderJobStatusHistory> _History;
        private Dictionary<string, string> _AdditionalInfo;

        #region Properties

        public int WorkOrderJobId
        {
            get { return _WorkOrderJobId; }
            set { _WorkOrderJobId = value; }
        }

        public int WorkOrderRef
        {
            get { return _WorkOrderRef; }
            set { _WorkOrderRef = value; }
        }

        public int AgilisJobId
        {
            get { return _AgilisJobId; }
            set { _AgilisJobId = value; }
        }

        public string AgilisJobType
        {
            get { return _AgilisJobType; }
            set { _AgilisJobType = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public List<AgilisWorkOrderJobStatusHistory> History
        {
            get { return _History; }
            set { _History = value; }
        }

        public Dictionary<string, string> AdditionalInfo
        {
            get { return _AdditionalInfo; }
            set { _AdditionalInfo = value; }
        }

        #endregion

        #region Construction

        public AgilisWorkOrderJob()
        {
            _History = new List<AgilisWorkOrderJobStatusHistory>();
            _AdditionalInfo = new Dictionary<string, string>();
        }

        #endregion
    }
}
