using System.Windows.Forms;
using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    public partial class ViewLoadDetailsForm : Form
    {
        private BopsLoad _LoadDetails;
        private BopsRfsServicesRequested _ServiceRequested;
        private BopsDestination _OriginDetails;
        private BopsDestination _DestinationDetails;
        private string _CalculationDetails;

        public BopsLoad LoadDetails
        {
            get { return _LoadDetails; }
            set { _LoadDetails = value; }
        }

        public BopsDestination OriginDetails
        {
            get { return _OriginDetails; }
            set { _OriginDetails = value; }
        }

        public BopsDestination DestinationDetails
        {
            get { return _DestinationDetails; }
            set { _DestinationDetails = value; }
        }

        public string CalculationDetails
        {
            get { return _CalculationDetails; }
            set { _CalculationDetails = value; }
        }

        public BopsRfsServicesRequested ServiceRequested
        {
            get { return _ServiceRequested; }
            set { _ServiceRequested = value; }
        }

        public ViewLoadDetailsForm()
        {
            InitializeComponent();
        }

        private void ViewLoadDetailsForm_Load(object sender, System.EventArgs e)
        {
            if (_LoadDetails != null)
            {
                LoadReferenceTextbox.Text = _LoadDetails.LoadReference;
                if (_LoadDetails.RfsRef.HasValue)
                    RfsTextbox.Text = _LoadDetails.RfsRef.ToString();
                if (_LoadDetails.ChargedWeight.HasValue)
                    ChargedWeightTextbox.Text = _LoadDetails.ChargedWeight.Value.ToString();
                BillOfLadingTextbox.Text = _LoadDetails.BillOfLading;
                if (_LoadDetails.LogOutDate.HasValue)
                    LogoutDateTextbox.Text = _LoadDetails.LogOutDate.Value.ToString("d");
            }

            if (_ServiceRequested != null)
                ServiceTextbox.Text = _ServiceRequested.ServiceRequestedId.ToString();

            if (_OriginDetails != null)
                OriginTextbox.Text = _OriginDetails.ToString();

            if (_DestinationDetails != null)
                DestinationTextbox.Text = _DestinationDetails.ToString();

            if (!string.IsNullOrEmpty(_CalculationDetails))
                CalculationDetailsTextbox.Text = _CalculationDetails;
        }
    }
}