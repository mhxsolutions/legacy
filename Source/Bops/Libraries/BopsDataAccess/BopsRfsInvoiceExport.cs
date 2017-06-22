using System;

namespace BopsDataAccess
{
    public class BopsRfsInvoiceExport
    {
        private int _ExportId;
        private DateTime _ExportDate;
        private string _UserId;
        private int _InvoiceCount;
        private double _TotalRevenue;

        public int ExportId
        {
            get { return _ExportId; }
            set { _ExportId = value; }
        }

        public DateTime ExportDate
        {
            get { return _ExportDate; }
            set { _ExportDate = value; }
        }

        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public int InvoiceCount
        {
            get { return _InvoiceCount; }
            set { _InvoiceCount = value; }
        }

        public double TotalRevenue
        {
            get { return _TotalRevenue; }
            set { _TotalRevenue = Math.Round(value, 2); }
        }
    }
}
