using System.Windows.Forms;
using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    public partial class ViewShipperDetailsForm : Form
    {
        private BopsShippingRecord _ShipperDetails;
        private BopsRfsServicesRequested _ServiceRequested;
        private string _CalculationDetails;

        public BopsShippingRecord ShipperDetails
        {
            get { return _ShipperDetails; }
            set { _ShipperDetails = value; }
        }

        public BopsRfsServicesRequested ServiceRequested
        {
            get { return _ServiceRequested; }
            set { _ServiceRequested = value; }
        }

        public string CalculationDetails
        {
            get { return _CalculationDetails; }
            set { _CalculationDetails = value; }
        }

        public ViewShipperDetailsForm()
        {
            InitializeComponent();
        }

        private void ViewShipperDetailsForm_Load(object sender, System.EventArgs e)
        {
            if (_ShipperDetails != null)
            {
                ShipperIdTextbox.Text = _ShipperDetails.LoadId.ToString();
                if (_ShipperDetails.RfsRef.HasValue)
                    RfsTextbox.Text = _ShipperDetails.RfsRef.Value.ToString();
                if (_ShipperDetails.ShipmentDate.HasValue)
                    DateShippedTextbox.Text = _ShipperDetails.ShipmentDate.Value.ToString("d");
                TypeTextbox.Text = _ShipperDetails.LoadType;
                ShippingAddressTextbox.Text = _ShipperDetails.ShipperAddress;
                DestinationAddressTextbox.Text = _ShipperDetails.DeliveryAddress;
            }

            if (_ServiceRequested != null)
                ServiceTextbox.Text = _ServiceRequested.ServiceRequestedId.ToString();

            if (!string.IsNullOrEmpty(_CalculationDetails))
                CalculationDetailsTextbox.Text = _CalculationDetails;
        }
    }
}
