using System;

namespace BopsDataAccess
{
    public class BopsRfsStorageBillingDetail
    {
        private double _revenue;

        public int DetailId { get; set; }
        public int BillingRef { get; set; }
        public int InventoryRef { get; set; }
        public DateTime PriorDateBilledThrough { get; set; }
        public DateTime NewDateBilledThrough { get; set; }
        public int BillToClientRef { get; set; }
        public int ProfileRef { get; set; }
        public double Quantity { get; set; }
        public double CyclesBilled { get; set; }
        public double AverageCostPerCycle { get; set; }

        public double Revenue
        {
            get { return _revenue; }
            set { _revenue = Math.Round(value, 2); }
        }

        public string PublicDetails { get; set; }
        public string PrivateDetails { get; set; }
        public RfsBillingStatus BillingStatus { get; set; }
        public int CompanyRef { get; set; }


        public BopsRfsStorageBillingDetail()
        {
            BillingStatus = RfsBillingStatus.PendingReview;
        }

        public bool Equals(BopsRfsStorageBillingDetail Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other.BillingRef == BillingRef &&
                   Other.InventoryRef == InventoryRef &&
                   Other.BillToClientRef == BillToClientRef &&
                   Other._revenue == _revenue &&
                   Equals(Other.PublicDetails, PublicDetails) &&
                   Other.BillingStatus == BillingStatus;
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsRfsStorageBillingDetail)) return false;
            return Equals((BopsRfsStorageBillingDetail) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                int Result = BillingRef;
                Result = (Result*397) ^ InventoryRef;
                Result = (Result*397) ^ BillToClientRef;
                Result = (Result*397) ^ _revenue.GetHashCode();
                Result = (Result*397) ^ (PublicDetails != null ? PublicDetails.GetHashCode() : 0);
                Result = (Result*397) ^ (int)BillingStatus;
                return Result;
            }
        }

        public static bool operator ==(BopsRfsStorageBillingDetail Left, BopsRfsStorageBillingDetail Right)
        {
            return Equals(Left, Right);
        }

        public static bool operator !=(BopsRfsStorageBillingDetail Left, BopsRfsStorageBillingDetail Right)
        {
            return !Equals(Left, Right);
        }

        public override string ToString()
        {
            return string.Format("RFS storage billing detail {0} for inventory item {1}", DetailId, InventoryRef);
        }
    }
}
