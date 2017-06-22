using System;

namespace BopsDataAccess
{
    public enum RfsBillingEventType
    {
        None,
        Load,
        WarehouseIn,
        WarehouseOut
    }

    [Flags]
    public enum RfsCalculationScopeType
    {
        None = 0,
        Private = 0x1,
        Public = 0x2,
        Both = 0x3
    }

    public class BopsRfsServicesRequested
    {
        public int ServiceRequestedId { get; set; }
        public int RfsRef { get; set; }
        public int ServiceOfferedRef { get; set; }
        public int? OriginRef { get; set; }
        public int? DestinationRef { get; set; }
        public int? CommodityRef { get; set; }
        public int? ShipperRef { get; set; }
        public int? ReceiverRef { get; set; }
        public int? BillToRef { get; set; }
        public string SpecialNeeds { get; set; }
        public string TransloadType { get; set; }
        public bool IndeterminateDestination { get; set; }
        public int ServiceGroup { get; set; }
        public BopsRfsRateDetails PublicRate { get; set; }
        public BopsRfsRateDetails PrivateRate { get; set; }
        public bool PrivateRateIsUnlinked { get; set; }
        public RfsCalculationScopeType CalculationScope { get; set; }
        public RfsBillingEventType PrivateBillingEventType { get; set; }
        public RfsBillingEventType PublicBillingEventType { get; set; }

        public BopsRfsServicesRequested()
        {
            PrivateRate = new BopsRfsRateDetails();
            PublicRate = new BopsRfsRateDetails();
        }

        public BopsRfsServicesRequested(BopsRfsServicesRequested rhs)
        {
            ServiceRequestedId = rhs.ServiceRequestedId;
            RfsRef = rhs.RfsRef;
            ServiceOfferedRef = rhs.ServiceOfferedRef;
            OriginRef = rhs.OriginRef;
            DestinationRef = rhs.DestinationRef;
            CommodityRef = rhs.CommodityRef;
            ShipperRef = rhs.ShipperRef;
            ReceiverRef = rhs.ReceiverRef;
            BillToRef = rhs.BillToRef;
            SpecialNeeds = rhs.SpecialNeeds;
            TransloadType = rhs.TransloadType;
            IndeterminateDestination = rhs.IndeterminateDestination;
            ServiceGroup = rhs.ServiceGroup;
            CalculationScope = rhs.CalculationScope;
            PrivateRateIsUnlinked = rhs.PrivateRateIsUnlinked;
    
            PrivateRate = new BopsRfsRateDetails(rhs.PrivateRate);
            PublicRate = new BopsRfsRateDetails(rhs.PublicRate);
    
            PrivateBillingEventType = rhs.PrivateBillingEventType;
            PublicBillingEventType = rhs.PublicBillingEventType;
        }
    }
}
