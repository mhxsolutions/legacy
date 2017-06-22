using System.Windows.Forms;
using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    public partial class ViewReceiverDetailsForm : Form
    {
        private BopsReceivingRecord _ReceiverDetails;
        private BopsRfsServicesRequested _ServiceRequested;
        private string _CalculationDetails;

        public BopsReceivingRecord ReceiverDetails
        {
            get { return _ReceiverDetails; }
            set { _ReceiverDetails = value; }
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

        public ViewReceiverDetailsForm()
        {
            InitializeComponent();
        }

        private void ViewReceiverDetailsForm_Load(object sender, System.EventArgs e)
        {
            if (_ReceiverDetails != null)
            {
                ReceiverIdTextbox.Text = _ReceiverDetails.ReceiverId.ToString();
                if (_ReceiverDetails.RfsRef.HasValue)
                    RfsTextbox.Text = _ReceiverDetails.RfsRef.Value.ToString();
                if (_ReceiverDetails.DateReceived.HasValue)
                    DateReceivedTextbox.Text = _ReceiverDetails.DateReceived.Value.ToString("d");
                TypeTextbox.Text = _ReceiverDetails.ReceiverType;
                ShippingAddressTextbox.Text = _ReceiverDetails.ShippingAddress;
                ReceivingAddressTextbox.Text = _ReceiverDetails.ReceiverAddress;
                SourceRefTextbox.Text = _ReceiverDetails.SourceRef;
            }

            if (_ServiceRequested != null)
                ServiceTextbox.Text = _ServiceRequested.ServiceRequestedId.ToString();

            if (!string.IsNullOrEmpty(_CalculationDetails))
                CalculationDetailsTextbox.Text = _CalculationDetails;
        }
    }
}
