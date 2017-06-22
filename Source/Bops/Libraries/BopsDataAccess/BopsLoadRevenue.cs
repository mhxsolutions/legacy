using System;

namespace BopsDataAccess
{
    public enum LoadStatus
    {
        None = 1,
        Logout,
        POD
    }

    public class BopsLoadRevenue
    {
        private string _LoadReference;
        private string _Type;
        private string _ShipperName;
        private string _OriginName;
        private string _ReceiverName;
        private string _DestinationName;
        private string _DriverName;
        private DateTime? _LogoutDate;
        private double? _PurRevenue;
        private double? _UpiRevenue;
        private double? _BolRevenue;
        private double? _Weight;
        private double? _EstimatedRevenue;
        private double? _ManualRevenue;
        private LoadStatus _LoadStatus;
        private double? _FuelSurchargeRevenue;

        public BopsLoadRevenue()
        {
            _LoadStatus = BopsDataAccess.LoadStatus.None;
        }

        public string LoadReference
        {
            get { return _LoadReference; }
            set { _LoadReference = value; }
        }

        public string Type
        {
            get { return _Type; }
            set { _Type = value; }
        }

        public string ShipperName
        {
            get { return _ShipperName; }
            set { _ShipperName = value; }
        }

        public string OriginName
        {
            get { return _OriginName; }
            set { _OriginName = value; }
        }

        public string ReceiverName
        {
            get { return _ReceiverName; }
            set { _ReceiverName = value; }
        }

        public string DestinationName
        {
            get { return _DestinationName; }
            set { _DestinationName = value; }
        }

        public string DriverName
        {
            get { return _DriverName; }
            set { _DriverName = value; }
        }

        public DateTime? LogoutDate
        {
            get { return _LogoutDate; }
            set { _LogoutDate = value; }
        }

        public double? PurRevenue
        {
            get { return _PurRevenue; }
            set { _PurRevenue = value; }
        }

        public double? UpiRevenue
        {
            get { return _UpiRevenue; }
            set { _UpiRevenue = value; }
        }

        public double? BolRevenue
        {
            get { return _BolRevenue; }
            set { _BolRevenue = value; }
        }

        public double? Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public double? EstimatedRevenue
        {
            get { return _EstimatedRevenue; }
            set { _EstimatedRevenue = value; }
        }

        public double? ManualRevenue
        {
            get { return _ManualRevenue; }
            set { _ManualRevenue = value; }
        }

        public LoadStatus LoadStatus
        {
            get { return _LoadStatus; }
            set { _LoadStatus = value; }
        }

        public double? FuelSurchargeRevenue
        {
            get { return _FuelSurchargeRevenue; }
            set { _FuelSurchargeRevenue = value; }
        }
    }
}
