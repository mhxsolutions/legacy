using System.Configuration;

namespace RFS_Invoice_Utility
{
    [ConfigurationCollection(typeof(InvoiceElement), AddItemName = "add")]
    public class InvoiceCollection : ConfigurationElementCollection
    {
        protected override ConfigurationElement CreateNewElement()
        {
            return new InvoiceElement();
        }

        protected override object GetElementKey(ConfigurationElement Element)
        {

            return ((InvoiceElement)(Element)).Key;

        }

        public InvoiceElement this[int Idx]
        {
            get
            {
                return (InvoiceElement)BaseGet(Idx);
            }
        }
    }
}
