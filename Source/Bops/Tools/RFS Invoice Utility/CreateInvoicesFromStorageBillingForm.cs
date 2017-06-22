using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;

namespace RFS_Invoice_Utility
{
    public partial class CreateInvoicesFromStorageBillingForm : Form
    {
        private const string DefaultRfsLocationCode = "201";

        private class ComboHelper
        {
            public ComboHelper(BopsRfsServicesOffered service)
            {
                Service = service;
            }

            public BopsRfsServicesOffered Service { get; }

            public override string ToString()
            {
                return string.Format("{0} (GL: {1})", Service.Name, Service.GeneralLedgerCode);
            }
        }

        private readonly IEnumerable<BopsRfsServicesOffered> _servicesOffered;
        private readonly IEnumerable<BopsRfsLocation> _locations;

        public DateTime InvoiceDate { get; set; }
        public int ServiceOfferedRef { get; set; }
        public string LocationCode { get; set; }
        public string InvoiceType { get; set; }
        public CompanyDetails UserCompanyDetails { get; set; }

        public CreateInvoicesFromStorageBillingForm(IEnumerable<BopsRfsServicesOffered> servicesOffered, IEnumerable<BopsRfsLocation> locations)
        {
            InitializeComponent();

            InvoiceType = InvoiceFactory.DefaultInvoiceType;
            InvoiceDate = DateTime.Now.Date;
            _servicesOffered = servicesOffered;
            _locations = locations;

            LocationCode = DefaultRfsLocationCode;
        }

        private void CreateInvoicesFromStorageBillingForm_Load(object sender, EventArgs e)
        {
            var factory = new InvoiceFactory();
            foreach (var invoice in factory.InvoiceTypes)
            {
                var index = _InvoiceTypeCombobox.Items.Add(invoice);
                if (invoice.Key == UserCompanyDetails.Company.InvoiceType)
                    _InvoiceTypeCombobox.SelectedIndex = index;
            }

            if (UserCompanyDetails != null)
                _InvoiceTypeCombobox.Enabled = false;

            foreach (var location in _locations)
            {
                var index = _LocationCombobox.Items.Add(location);
                if (location.LocationCode == LocationCode)
                    _LocationCombobox.SelectedIndex = index;
            }

            foreach (var offered in _servicesOffered)
            {
                var index = _ServiceCombobox.Items.Add(new ComboHelper(offered));
                if (offered.Id == ServiceOfferedRef)
                    _ServiceCombobox.SelectedIndex = index;
            }

            _InvoiceDatepicker.DataBindings.Add("Value", this, "InvoiceDate");
        }

        private void _OkButton_Click(object sender, EventArgs e)
        {
            var selectedType = _InvoiceTypeCombobox.SelectedItem as InvoiceElement;

            if (selectedType == null || _ServiceCombobox.SelectedItem == null || _LocationCombobox.SelectedItem == null)
            {
                MessageHelper.ShowError("You must select an invoice type, service, and location to create invoices.");
                return;
            }
            
            InvoiceType = selectedType.Key;
            var h = _ServiceCombobox.SelectedItem as ComboHelper;
            Debug.Assert(h != null);
            ServiceOfferedRef = h.Service.Id;

            var location = _LocationCombobox.SelectedItem as BopsRfsLocation;
            Debug.Assert(location != null);
            LocationCode = location.LocationCode;

            DialogResult = DialogResult.OK;
            Close();
        }
    }
}
