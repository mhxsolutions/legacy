using System.Collections.Generic;
using System.Configuration;

namespace RFS_Invoice_Utility
{
    public class InvoiceFactory
    {
        /*
         * CRYSTAL REPORTS CONNECTION INFORMATION NONSENSE
         * 
         * This data is hard-coded because I haven't found any good or performant way to specify
         * the connection properties for our Crystal Reports files programmatically. Oh, I've found
         * several articles that basically have you create a new connection information object, then
         * set that into every table in the report object. But that takes MINUTES to accomplish for
         * some unknown reason.
         * 
         * The only performant way I've found to make things work correctly is by updating the
         * connection information in the saved report file itself, then calling the SetDatabaseLogon
         * method on the report object with the following hard-coded values. It's ugly, but at least
         * it prevents the report viewer from popping up and prompting the user for a password.
         * 
         * For future reference, I discovered this during the migration from SQL4 to SQL16 at MHX.
         * The invoices were coming up blank, and only by digging into it did I discover that all the
         * report files were still pointing to SQL4 and expecting to use integrated security. The
         * only change I think that might yet be worth making is moving the details into the app config
         * file, but the problem is that it's more than a bit misleading to do so: it's not like it's
         * going to let you change them and have it work without rebuilding all the damned report 
         * files anyway. I figure as long as the one is hard-coded, the other may as well be too.
         * 
         * JBW, 2018-09-10 16:04 hrs.
         */

        private const string CrystlReportsServer = "sql.mhx.cloud";
        private const string CrystalReportsDatabase = "DWS No Rep Data";
        private const string CrystalReportsUser = "CrystalReportsUser";
        private const string CrystalReportsPassword = "s3cu4e.c4ystal.acc3ss!";

        public const string DefaultInvoiceType = "budway";
        private readonly InvoiceConfigurationSection _sectionData;

        public InvoiceFactory()
        {
            _sectionData = (InvoiceConfigurationSection)ConfigurationManager.GetSection("invoicetypes");
        }

        public IList<InvoiceElement> InvoiceTypes
        {
            get
            {
                var returnValue = new List<InvoiceElement>();
                foreach (InvoiceElement invoice in _sectionData.Invoices)
                {
                    returnValue.Add(invoice);
                }
                return returnValue;
            }
        }

        private InvoiceElement LookupInvoiceFromKey(string key)
        {
            foreach (InvoiceElement invoice in _sectionData.Invoices)
            {
                if (key == invoice.Key)
                    return invoice;
            }

            return null;
        }

        public CrystalDecisions.CrystalReports.Engine.ReportDocument ManufactureCrystalReport(string key)
        {
            var invoice = LookupInvoiceFromKey(key);
            var className = $"RFS_Invoice_Utility.{invoice.Value}";
            var reportDocument = System.Reflection.Assembly.GetExecutingAssembly().CreateInstance(className) as CrystalDecisions.CrystalReports.Engine.ReportDocument;

            // Without this line of code, it will prompt the user for the password.

            reportDocument?.SetDatabaseLogon(CrystalReportsUser, CrystalReportsPassword, CrystlReportsServer, CrystalReportsDatabase);

            return reportDocument;
        }
    }
}
