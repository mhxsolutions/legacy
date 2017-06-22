using System.Configuration;

namespace RFS_Invoice_Utility
{
    public class InvoiceConfigurationSection : ConfigurationSection
    {
        [ConfigurationProperty("invoices")]

        public InvoiceCollection Invoices
        {
            get { return ((InvoiceCollection)(base["invoices"])); }
        }
    }
}
