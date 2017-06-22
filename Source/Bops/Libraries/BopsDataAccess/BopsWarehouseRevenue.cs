using System;

namespace BopsDataAccess
{
    public enum WarehouseDocumentType
    {
        None,
        Received,
        Shipped
    }

    public class BopsWarehouseRevenue
    {
        private int _RevenueId;
        private int _DocumentId;
        private WarehouseDocumentType _DocumentType;
        private DateTime _DocumentDate;
        private double _Weight;
        private double _Revenue;
        private double _FuelSurchargeRevenue;

        public int RevenueId
        {
            get { return _RevenueId; }
            set { _RevenueId = value; }
        }

        public int DocumentId
        {
            get { return _DocumentId; }
            set { _DocumentId = value; }
        }

        public WarehouseDocumentType DocumentType
        {
            get { return _DocumentType; }
            set { _DocumentType = value; }
        }

        public DateTime DocumentDate
        {
            get { return _DocumentDate; }
            set { _DocumentDate = value; }
        }

        public double Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public double Revenue
        {
            get { return _Revenue; }
            set { _Revenue = value; }
        }

        public double FuelSurchargeRevenue
        {
            get { return _FuelSurchargeRevenue; }
            set { _FuelSurchargeRevenue = value; }
        }
    }
}
