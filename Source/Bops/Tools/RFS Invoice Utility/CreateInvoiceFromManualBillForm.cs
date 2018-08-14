using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;

namespace RFS_Invoice_Utility
{
    public partial class CreateInvoiceFromManualBillForm : Form
    {
        private class ComboHelper
        {
            public ComboHelper(BopsRfsServicesOffered serviceOffered)
            {
                Service = serviceOffered;
            }

            public BopsRfsServicesOffered Service { get; }

            public override string ToString()
            {
                return string.Format("{0} (GL: {1})", Service.Name, Service.GeneralLedgerCode);
            }
        }

        public BopsRfsInvoice Invoice { get; private set; }
        public BopsRfsInvoiceDetail ManualBill { get; private set; }
        public CompanyDetails UserCompanyDetails { get; set; }

        public CreateInvoiceFromManualBillForm(IEnumerable<BopsDestination> destinations, IEnumerable<BopsRfsServicesOffered> servicesOffered, 
            IEnumerable<BopsRfsLocation> rfsLocations, CompanyDetails companyDetails)
        {
            InitializeComponent();

            UserCompanyDetails = companyDetails;

            var factory = new InvoiceFactory();
            foreach (var invoiceType in factory.InvoiceTypes)
            {
                var index = _InvoiceTypeCombobox.Items.Add(invoiceType);
                if (invoiceType.Key == UserCompanyDetails.Company.InvoiceType)
                    _InvoiceTypeCombobox.SelectedIndex = index;
            }

            foreach (var destination in destinations)
            {
                if (destination.CompanyRef == UserCompanyDetails.Company.CompanyId)
                {
                    InvoiceShipperCombobox.Items.Add(destination);

                    if (destination.PaysTransportation)
                        InvoiceBillToCombobox.Items.Add(destination);
                }
            }

            foreach (var location in rfsLocations)
            {
                if (location.CompanyRef == UserCompanyDetails.Company.CompanyId)
                    LocationCombobox.Items.Add(location);
            }

            // Should probably update this.

            var defaultIndex = LocationCombobox.FindString("Fontana");
            if (defaultIndex > -1)
                LocationCombobox.SelectedIndex = defaultIndex;

            foreach (var offered in servicesOffered)
            {
                if (offered.CompanyRef == UserCompanyDetails.Company.CompanyId)
                    ManualBillServiceOfferedCombobox.Items.Add(new ComboHelper(offered));
            }

            InvoiceDatePicker.Value = DateTime.Today;
            ManualBillDatePicker.Value = DateTime.Today;
            ManualBillAmountTextbox.Text = "0.00";

            if (UserCompanyDetails != null)
                _InvoiceTypeCombobox.Enabled = false;
        }

        private void OkButton_Click(object sender, EventArgs e)
        {
            var selectedType = _InvoiceTypeCombobox.SelectedItem as InvoiceElement;
            if (selectedType == null)
            {
                MessageHelper.ShowInvalidOperation("You must select an invoice type.");
                return;
            }

            var shipperDestination = InvoiceShipperCombobox.SelectedItem as BopsDestination;
            if (shipperDestination == null)
            {
                MessageHelper.ShowInvalidOperation("You must select a shipper client.");
                return;
            }

            var billToDestination = InvoiceBillToCombobox.SelectedItem as BopsDestination;
            if (billToDestination == null)
            {
                MessageHelper.ShowInvalidOperation("You must select a bill-to client.");
                return;
            }

            double manualBillAmount;
            if (!double.TryParse(ManualBillAmountTextbox.Text, out manualBillAmount))
            {
                MessageHelper.ShowInvalidOperation("The manual bill amount is invalid.");
                return;
            }

            var serviceOffered = ManualBillServiceOfferedCombobox.SelectedItem as ComboHelper;
            if (serviceOffered == null)
            {
                MessageHelper.ShowInvalidOperation("You must select a service for the manual bill.");
                return;
            }

            if (string.IsNullOrEmpty(ManualBillDescriptionTextbox.Text))
            {
                MessageHelper.ShowInvalidOperation("You must provide a description for the manual bill.");
                return;
            }

            var windowsUserId = Environment.UserName;
            Invoice = new BopsRfsInvoice
            {
                InvoiceType = selectedType.Key,
                ShipperRef = shipperDestination.DestinationId,
                BillToRef = billToDestination.DestinationId,
                InvoiceStatus = RfsInvoiceStatus.Open,
                InvoiceTotal = manualBillAmount,
                InvoiceDate = InvoiceDatePicker.Value,
                DateCreated = DateTime.Now,
                PublicNotes = PublicNotesTextbox.Text,
                PrivateNotes = PrivateNotesTextbox.Text,
                CompanyRef = UserCompanyDetails.Company.CompanyId,
                UserCreated = windowsUserId,
            };

            ManualBill = new BopsRfsInvoiceDetail();
            ManualBill.LineNumber = ManualBill.LineNumberDisplayed = 1;
            ManualBill.ItemDate = ManualBillDatePicker.Value;
            ManualBill.ItemDescription = ManualBillDescriptionTextbox.Text;
            ManualBill.ItemTotal = manualBillAmount;
            ManualBill.ServiceOfferedRef = serviceOffered.Service.Id;
            var rfsLocation = LocationCombobox.SelectedItem as BopsRfsLocation;
            Debug.Assert(rfsLocation != null);
            ManualBill.LocationCode = rfsLocation.LocationCode;

            DialogResult = DialogResult.OK;
            Close();
        }
    }
}