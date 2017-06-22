using System;

namespace BopsDataAccess
{
    public class BopsRfsGeneralLedgerCode
    {
        private string _GeneralLedgerCode;
        private string _Description;

        public string GeneralLedgerCode
        {
            get { return _GeneralLedgerCode; }
            set { _GeneralLedgerCode = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public override string ToString()
        {
            return string.Format("{0} ({1})", _Description, _GeneralLedgerCode);
        }
    }
}
