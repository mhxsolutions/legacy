using System;
using BopsDataAccess;

namespace Scm.OpsCore.Legacy.DataLayer
{
    public class BopsRfsStorageBillingInput
    {
        public int InventoryId { get; set; }
        public string WeightLabel { get; set; }
        public int Weight { get; set; }
        public int ProfileId { get; set; }
        public string CountLabel { get; set; }
        public int Count { get; set; }
        public DateTime? DateBilledThrough { get; set; }
        public int ReceiverId { get; set; }
        public DateTime DateReceived { get; set; }
        public int ReceivingClientRef { get; set; }
        public DateTime? DateShipped { get; set; }
        public int RateId { get; set; }
        public int BillToClientRef { get; set; }
        public RfsStorageBillingType BillingType { get; set; }
        public int DaysInCycle { get; set; }
        public double UnitCostPerCycle { get; set; }
        public int UnitRef { get; set; }
        public int AssignmentId { get; set; }
        public DateTime BeginDate { get; set; }
        public DateTime EndDate { get; set; }
        public int RfsId { get; set; }
        public int StorageFreeDays { get; set; }
    }
}
