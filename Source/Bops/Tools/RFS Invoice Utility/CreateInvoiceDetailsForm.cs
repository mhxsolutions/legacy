using System;
using System.Windows.Forms;
using BopsUtilities;

namespace RFS_Invoice_Utility
{
    public partial class CreateInvoiceDetailsForm : Form
    {
        public DateTime InvoiceDate { get; set; }
        public string PublicNotes { get; set; }
        public string PrivateNotes { get; set; }
        public string InvoiceType { get; set; }
        public CompanyDetails UserCompanyDetails { get; set; }

        public CreateInvoiceDetailsForm()
        {
            InvoiceDate = DateTime.Now;
            PublicNotes = string.Empty;
            PrivateNotes = string.Empty;
            InvoiceType = InvoiceFactory.DefaultInvoiceType;

            InitializeComponent();

            PublicNotesTextbox.AcceptsReturn = true;
            PrivateNotesTextbox.AcceptsReturn = true;
        }

        private void CreateInvoiceDetailsForm_Load(object sender, EventArgs e)
        {
            if (UserCompanyDetails == null || UserCompanyDetails.Company.CompanyId == 0)
                throw new ArgumentException("A null or zero-value company ID cannot create invoices");

            var factory = new InvoiceFactory();

            foreach (var invoice in factory.InvoiceTypes)
            {
                var index = _InvoiceTypeCombobox.Items.Add(invoice);
                if (invoice.Key == InvoiceType)
                    _InvoiceTypeCombobox.SelectedIndex = index;
            }

            if (UserCompanyDetails != null)
                _InvoiceTypeCombobox.Enabled = false;

            InvoiceDatePicker.DataBindings.Add("Value", this, "InvoiceDate");
            PublicNotesTextbox.DataBindings.Add("Text", this, "PublicNotes");
            PrivateNotesTextbox.DataBindings.Add("Text", this, "PrivateNotes");
        }

        private void OkButton_Click(object sender, EventArgs e)
        {
            var selectedType = _InvoiceTypeCombobox.SelectedItem as InvoiceElement;
            if (selectedType == null)
            {
                MessageHelper.ShowInvalidOperation("You must select an invoice type.");
                return;
            }
            
            InvoiceType = selectedType.Key;
            DialogResult = DialogResult.OK;
            Close();
        }
   }
}