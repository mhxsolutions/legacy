using System;

namespace BopsDataAccess
{
    public class BopsProjectManagerDeliveryOrder
    {
        private int _PmdoId;
        private string _Description;
        private bool _IsHarbor;
        private bool _IsCrossDock;
        private DateTime _StartDate;
        private DateTime? _EndDate;
        private int _ProductRef;
        private string _DeliveryOrder;
        private string _Vessel;
        private string _RailcarRef;
        private int _ProjectClientRef;
        private int _ShipFromRef;
        private int? _DeliverToRef;
        private int? _BillToRef;
        private string _Instructions;
        private string _ProjectManager;
        private bool _IsComplete;
        private DateTime? _CreateDate;
        private string _CreateUser;
        private DateTime? _LastUpdate;
        private string _LastUpdateUser;
        private DateTime? _CompletionDate;
        private string _DrDescription;
        private string _PoNumber;
        private string _ClientNumber;
        private string _Pier;
        private string _Berth;
        private int? _BrokerRef;
        private string _Contact;
        private string _BolH1;
        private string _BolH2;
        private string _BolH3;
        private string _BolH4;
        private string _BolH5;
        private int _ProjectStatusRef;
        private int? _TariffRef;
        private string _SupportDocs;
        private int? _RfsRef;

        public int PmdoId
        {
            get { return _PmdoId; }
            set { _PmdoId = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public bool IsHarbor
        {
            get { return _IsHarbor; }
            set { _IsHarbor = value; }
        }

        public bool IsCrossDock
        {
            get { return _IsCrossDock; }
            set { _IsCrossDock = value; }
        }

        public DateTime StartDate
        {
            get { return _StartDate; }
            set { _StartDate = value; }
        }

        public DateTime? EndDate
        {
            get { return _EndDate; }
            set { _EndDate = value; }
        }

        public int ProductRef
        {
            get { return _ProductRef; }
            set { _ProductRef = value; }
        }

        public string DeliveryOrder
        {
            get { return _DeliveryOrder; }
            set { _DeliveryOrder = value; }
        }

        public string Vessel
        {
            get { return _Vessel; }
            set { _Vessel = value; }
        }

        public string RailcarRef
        {
            get { return _RailcarRef; }
            set { _RailcarRef = value; }
        }

        public int ProjectClientRef
        {
            get { return _ProjectClientRef; }
            set { _ProjectClientRef = value; }
        }

        public int ShipFromRef
        {
            get { return _ShipFromRef; }
            set { _ShipFromRef = value; }
        }

        public int? DeliverToRef
        {
            get { return _DeliverToRef; }
            set { _DeliverToRef = value; }
        }

        public int? BillToRef
        {
            get { return _BillToRef; }
            set { _BillToRef = value; }
        }

        public string Instructions
        {
            get { return _Instructions; }
            set { _Instructions = value; }
        }

        public string ProjectManager
        {
            get { return _ProjectManager; }
            set { _ProjectManager = value; }
        }

        public bool IsComplete
        {
            get { return _IsComplete; }
            set { _IsComplete = value; }
        }

        public DateTime? CreateDate
        {
            get { return _CreateDate; }
            set { _CreateDate = value; }
        }

        public string CreateUser
        {
            get { return _CreateUser; }
            set { _CreateUser = value; }
        }

        public DateTime? LastUpdate
        {
            get { return _LastUpdate; }
            set { _LastUpdate = value; }
        }

        public string LastUpdateUser
        {
            get { return _LastUpdateUser; }
            set { _LastUpdateUser = value; }
        }

        public DateTime? CompletionDate
        {
            get { return _CompletionDate; }
            set { _CompletionDate = value; }
        }

        public string DrDescription
        {
            get { return _DrDescription; }
            set { _DrDescription = value; }
        }

        public string PoNumber
        {
            get { return _PoNumber; }
            set { _PoNumber = value; }
        }

        public string ClientNumber
        {
            get { return _ClientNumber; }
            set { _ClientNumber = value; }
        }

        public string Pier
        {
            get { return _Pier; }
            set { _Pier = value; }
        }

        public string Berth
        {
            get { return _Berth; }
            set { _Berth = value; }
        }

        public int? BrokerRef
        {
            get { return _BrokerRef; }
            set { _BrokerRef = value; }
        }

        public string Contact
        {
            get { return _Contact; }
            set { _Contact = value; }
        }

        public string BolH1
        {
            get { return _BolH1; }
            set { _BolH1 = value; }
        }

        public string BolH2
        {
            get { return _BolH2; }
            set { _BolH2 = value; }
        }

        public string BolH3
        {
            get { return _BolH3; }
            set { _BolH3 = value; }
        }

        public string BolH4
        {
            get { return _BolH4; }
            set { _BolH4 = value; }
        }

        public string BolH5
        {
            get { return _BolH5; }
            set { _BolH5 = value; }
        }

        public int ProjectStatusRef
        {
            get { return _ProjectStatusRef; }
            set { _ProjectStatusRef = value; }
        }

        public int? TariffRef
        {
            get { return _TariffRef; }
            set { _TariffRef = value; }
        }

        public string SupportDocs
        {
            get { return _SupportDocs; }
            set { _SupportDocs = value; }
        }

        public int? RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }
    }
}
