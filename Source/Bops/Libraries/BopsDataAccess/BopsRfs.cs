using System;

namespace BopsDataAccess
{
    public class BopsRfs
    {
        private const string DefaultLocationCode = "201";

        public int RfsId { get; set; }
        public int SalespersonRef { get; set; }
        public int ShipperRef { get; set; }
        public int CommodityRef { get; set; }
        public int WorkTypeRef { get; set; }
        public string WorkDescription { get; set; }
        public string Vessel { get; set; }
        public DateTime? FirstFreeDate { get; set; }
        public DateTime? LastFreeDate { get; set; }
        public int HarborProjectRef { get; set; }
        public int StatusRef { get; set; }
        public DateTime BeginDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int StorageFreeDays { get; set; }
        public string LocationCode { get; set; }
        public int CompanyRef { get; set; }

        public BopsRfs()
        {
            LocationCode = DefaultLocationCode;
        }

        public BopsRfs(BopsRfs rhs)
        {
            RfsId = rhs.RfsId;
            SalespersonRef = rhs.SalespersonRef;
            ShipperRef = rhs.ShipperRef;
            CommodityRef = rhs.CommodityRef;
            WorkTypeRef = rhs.WorkTypeRef;
            WorkDescription = rhs.WorkDescription;
            Vessel = rhs.Vessel;
            FirstFreeDate = rhs.FirstFreeDate;
            LastFreeDate = rhs.LastFreeDate;
            HarborProjectRef = rhs.HarborProjectRef;
            StatusRef = rhs.StatusRef;
            BeginDate = rhs.BeginDate;
            EndDate = rhs.EndDate;
            StorageFreeDays = rhs.StorageFreeDays;
            LocationCode = rhs.LocationCode;
        }
    }
}
