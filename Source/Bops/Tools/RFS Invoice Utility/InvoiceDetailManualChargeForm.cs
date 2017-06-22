using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Windows.Forms;
using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    public partial class InvoiceDetailManualChargeForm : Form
    {
        class ComboHelper
        {
            private readonly BopsRfsServicesOffered _Service;

            public ComboHelper(BopsRfsServicesOffered Service)
            {
                _Service = Service;
            }

            public BopsRfsServicesOffered Service
            {
                get { return _Service; }
            }

            public override string ToString()
            {
                return string.Format("{0} (GL: {1})", _Service.Name, _Service.GeneralLedgerCode);
            }
        }

        private BopsRfsInvoiceDetail _InvoiceLine;
        private readonly IEnumerable<BopsRfsServicesOffered> _ServicesOffered;
        private readonly IEnumerable<BopsRfsLocation> _Locations;

        public BopsRfsInvoiceDetail InvoiceLine
        {
            get { return _InvoiceLine; }
            set { _InvoiceLine = value; }
        }

        /*
         * HACK:    I don't know why these two properties are necessary, but without them the code will
         *          throw an exception on attempting to bind using strings like "InvoiceLine.ItemDate" or
         *          "InvoiceLine.ItemDescription". Even stranger, they work fine on Windows 7 machines but
         *          seem to fail only when running on a session in Terminal Server. Go figure.
         */

        public DateTime ItemDate
        {
            get { return _InvoiceLine.ItemDate; }
            set { _InvoiceLine.ItemDate = value; }
        }

        public string ItemDescription
        {
            get { return _InvoiceLine.ItemDescription; }
            set { _InvoiceLine.ItemDescription = value; }
        }

        public InvoiceDetailManualChargeForm(IEnumerable<BopsRfsServicesOffered> ServicesOffered, IEnumerable<BopsRfsLocation> Locations)
        {
            InitializeComponent();

            _ServicesOffered = ServicesOffered;
            _Locations = Locations;
        }

        private void InvoiceDetailManualChargeForm_Load(object Sender, EventArgs E)
        {
            // If the user hasn't set a line item yet, we create a new object.

            if (_InvoiceLine == null)
                _InvoiceLine = new BopsRfsInvoiceDetail();

            foreach (BopsRfsLocation RfsLocation in _Locations)
            {
                int Index = LocationCombobox.Items.Add(RfsLocation);
                if (RfsLocation.LocationCode == _InvoiceLine.LocationCode)
                    LocationCombobox.SelectedIndex = Index;
            }

            foreach (BopsRfsServicesOffered Offered in _ServicesOffered)
            {
                int Index = ServiceOfferedCombobox.Items.Add(new ComboHelper(Offered));
                if (Offered.Id == _InvoiceLine.ServiceOfferedRef)
                    ServiceOfferedCombobox.SelectedIndex = Index;
            }

            DatePicker.DataBindings.Add("Value", this, "ItemDate");
            AmountTextbox.Text = _InvoiceLine.ItemTotal.ToString();
            DescriptionTextbox.DataBindings.Add("Text", this, "ItemDescription");
        }

        private void OkButton_Click(object Sender, EventArgs E)
        {
            StringBuilder Sb = new StringBuilder();

            if (string.IsNullOrEmpty(_InvoiceLine.ItemDescription))
            {
                Sb.Append("The description cannot be blank. ");
            }

            double Amount;
            IFormatProvider Culture = new CultureInfo("En-US", true);
            if (double.TryParse(AmountTextbox.Text, NumberStyles.Currency, Culture, out Amount))
            {
                _InvoiceLine.ItemTotal = Amount;
            }
            else
            {
                Sb.Append("The amount must be a valid number. ");
            }

            if (ServiceOfferedCombobox.SelectedItem != null)
            {
                ComboHelper H = ServiceOfferedCombobox.SelectedItem as ComboHelper;
                Debug.Assert(H != null);
                _InvoiceLine.ServiceOfferedRef = H.Service.Id;
            }
            else
            {
                Sb.Append("A service must be selected. ");
            }

            if (Sb.Length > 0)
            {
                MessageBox.Show(Sb.ToString(), "Invalid Data", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                _InvoiceLine.ServiceCalculationResultRef = null;
                _InvoiceLine.StorageBillingDetailRef = null;

                BopsRfsLocation RfsLocation = LocationCombobox.SelectedItem as BopsRfsLocation;
                Debug.Assert(RfsLocation != null);
                _InvoiceLine.LocationCode = RfsLocation.LocationCode;

                DialogResult = DialogResult.OK;
                Close();
            }
        }
    }
}
