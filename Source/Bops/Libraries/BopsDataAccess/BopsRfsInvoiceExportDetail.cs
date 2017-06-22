using System;

namespace BopsDataAccess
{
    public class BopsRfsInvoiceExportDetail
    {
        private int _ExportRef;
        private int _InvoiceRef;
        private string _GeneralLedgerCode;
        private string _ClientAbbreviation;
        private double _DetailAmount;
        private DateTime _InvoiceDate;
        private DateTime _DueDate;

        public int ExportRef
        {
            get { return _ExportRef; }
            set { _ExportRef = value; }
        }

        public int InvoiceRef
        {
            get { return _InvoiceRef; }
            set { _InvoiceRef = value; }
        }

        public string GeneralLedgerCode
        {
            get { return _GeneralLedgerCode; }
            set { _GeneralLedgerCode = value; }
        }

        public string ClientAbbreviation
        {
            get { return _ClientAbbreviation; }
            set { _ClientAbbreviation = value; }
        }

        public double DetailAmount
        {
            get { return _DetailAmount; }
            set { _DetailAmount = Math.Round(value, 2); }
        }

        public DateTime InvoiceDate
        {
            get { return _InvoiceDate; }
            set { _InvoiceDate = value; }
        }

        public DateTime DueDate
        {
            get { return _DueDate; }
            set { _DueDate = value; }
        }

        public bool Equals(BopsRfsInvoiceExportDetail Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other._InvoiceRef == _InvoiceRef && Other._ExportRef == _ExportRef && Equals(Other._ClientAbbreviation, _ClientAbbreviation) && Other._DetailAmount == _DetailAmount && Other._InvoiceDate.Equals(_InvoiceDate) && Other._DueDate.Equals(_DueDate) && Equals(Other._GeneralLedgerCode, _GeneralLedgerCode);
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsRfsInvoiceExportDetail)) return false;
            return Equals((BopsRfsInvoiceExportDetail) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                int Result = _InvoiceRef;
                Result = (Result*397) ^ _ExportRef;
                Result = (Result*397) ^ (_ClientAbbreviation != null ? _ClientAbbreviation.GetHashCode() : 0);
                Result = (Result*397) ^ _DetailAmount.GetHashCode();
                Result = (Result*397) ^ _InvoiceDate.GetHashCode();
                Result = (Result*397) ^ _DueDate.GetHashCode();
                Result = (Result*397) ^ (_GeneralLedgerCode != null ? _GeneralLedgerCode.GetHashCode() : 0);
                return Result;
            }
        }
    }
}
