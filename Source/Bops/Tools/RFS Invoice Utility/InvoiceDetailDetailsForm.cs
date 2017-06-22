using System;
using System.Windows.Forms;
using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    public partial class InvoiceDetailDetailsForm : Form
    {
        private BopsRfsInvoiceDetail _InvoiceLine;

        public BopsRfsInvoiceDetail InvoiceLine
        {
            get { return _InvoiceLine; }
            set { _InvoiceLine = value; }
        }

        public string ItemDescription
        {
            get { return _InvoiceLine.ItemDescription; }
            set { _InvoiceLine.ItemDescription = value; }
        }

        public InvoiceDetailDetailsForm()
        {
            InitializeComponent();
        }

        private void InvoiceDetailDetailsForm_Load(object sender, EventArgs e)
        {
            DescriptionTextbox.DataBindings.Add("Text", this, "ItemDescription");
        }

        private void OkButton_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.OK;
            Close();
        }
    }
}
