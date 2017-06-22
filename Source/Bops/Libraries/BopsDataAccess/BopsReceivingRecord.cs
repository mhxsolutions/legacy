using System;

namespace BopsDataAccess
{
    public class BopsReceivingRecord
    {
        public int ReceiverId { get; set; }
        public int? Terminal { get; set; }
        public string ReceiverType { get; set; }
        public DateTime? DateReceived { get; set; }
        public int? ShippingClientRef { get; set; }
        public string ShippingAddress { get; set; }
        public int? ReceivingClientRef { get; set; }
        public string ReceiverAddress { get; set; }
        public int? PaymentContractRef { get; set; }
        public string PaymentAddress { get; set; }
        public string SourceRef { get; set; }
        public string EquipmentComments { get; set; }
        public int? ProductProfileRef { get; set; }
        public string ProductProfileDescription { get; set; }
        public string GroupLabel1 { get; set; }
        public string GroupLabel2 { get; set; }
        public string GroupLabel3 { get; set; }
        public string WeightLabel { get; set; }
        public string PackageLabel { get; set; }
        public bool? RecordLock { get; set; }
        public DateTime? CreationDate { get; set; }
        public string ReceiverDupeLock { get; set; }
        public string ReceiverDupeLockLabel { get; set; }
        public int? ReceiverRef { get; set; }
        public string ReceiverEditor { get; set; }
        public int? RfsRef { get; set; }
        public int? DetailWeight { get; set; }
        public RfsBillingStatus BillingStatus { get; set; }
        public int? OriginRef { get; set; }
        public int? DestinationRef { get; set; }
        public string ClientInvoiceData { get; set; }
        public string ClientPurchaseOrder { get; set; }
        public double? SpecialInvoiceValue { get; set; }
        public int? PostedCount { get; set; }
        public int CompanyRef { get; set; }
    }
}
