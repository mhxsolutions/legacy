namespace BopsDataAccess
{
    public class BopsRfsInvoiceStatus
    {
        public int StatusId { get; set; }
        public string Status { get; set; }

        public RfsInvoiceStatus StatusEnum => (RfsInvoiceStatus)StatusId;

        public override string ToString()
        {
            return Status;
        }

        public BopsRfsInvoiceStatus()
        {
        }

        public BopsRfsInvoiceStatus(RfsInvoiceStatus statusId, string status)
        {
            StatusId = (int)statusId;
            Status = status;
        }
    }
}
