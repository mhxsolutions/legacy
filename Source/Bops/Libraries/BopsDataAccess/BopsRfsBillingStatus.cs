
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BopsDataAccess
{
    [Table("RFS Billing Statuses")]
    public class BopsRfsBillingStatus
    {
        private int _StatusId;
        private string _Status;

        [Key]
        [Column("Status Id")]
        public int StatusId
        {
            get { return _StatusId; }
            set { _StatusId = value; }
        }

        [NotMapped]
        public RfsBillingStatus StatusEnum
        {
            get { return (RfsBillingStatus) _StatusId; }
        }

        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        public override string ToString()
        {
            return _Status;
        }
    }
}
