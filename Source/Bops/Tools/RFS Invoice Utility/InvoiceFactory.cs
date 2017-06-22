using System.Collections.Generic;
using System.Configuration;

namespace RFS_Invoice_Utility
{
    class InvoiceFactory
    {
        private const string _DefaultInvoiceType = "budway";
        private readonly InvoiceConfigurationSection _SectionData;

        public InvoiceFactory()
        {
            _SectionData = (InvoiceConfigurationSection)ConfigurationManager.GetSection("invoicetypes");
        }

        static public string DefaultInvoiceType
        {
            get { return _DefaultInvoiceType; }
        }

        public IList<InvoiceElement> InvoiceTypes
        {
            get
            {
                List<InvoiceElement> ReturnValue = new List<InvoiceElement>();
                foreach (InvoiceElement Invoice in _SectionData.Invoices)
                {
                    ReturnValue.Add(Invoice);
                }
                return ReturnValue;
            }
        }

        private InvoiceElement LookupInvoiceFromKey(string Key)
        {
            foreach (InvoiceElement Invoice in _SectionData.Invoices)
            {
                if (Key == Invoice.Key)
                    return Invoice;
            }

            return null;
        }

        public CrystalDecisions.CrystalReports.Engine.ReportDocument ManufactureCrystalReport(string Key)
        {
            InvoiceElement Invoice = LookupInvoiceFromKey(Key);
            string ClassName = string.Format("RFS_Invoice_Utility.{0}", Invoice.Value);
            return System.Reflection.Assembly.GetExecutingAssembly().CreateInstance(ClassName) as CrystalDecisions.CrystalReports.Engine.ReportDocument;
        }
    }
}
