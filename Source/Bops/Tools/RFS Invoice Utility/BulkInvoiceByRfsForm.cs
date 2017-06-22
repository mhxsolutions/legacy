using System;
using System.Windows.Forms;
using BopsUtilities;

namespace RFS_Invoice_Utility
{
    public partial class BulkInvoiceByRfsForm : Form
    {
        private int _RfsNumber;
        private bool _IncludeBillsOfLading;
        private bool _IncludeLoads;
        private bool _IncludeReceivers;

        #region Properties

        public int RfsNumber
        {
            get { return _RfsNumber; }
            set { _RfsNumber = value; }
        }

        public bool IncludeBillsOfLading
        {
            get { return _IncludeBillsOfLading; }
            set { _IncludeBillsOfLading = value; }
        }

        public bool IncludeLoads
        {
            get { return _IncludeLoads; }
            set { _IncludeLoads = value; }
        }

        public bool IncludeReceivers
        {
            get { return _IncludeReceivers; }
            set { _IncludeReceivers = value; }
        }

        #endregion

        public BulkInvoiceByRfsForm()
        {
            InitializeComponent();
        }

        private void BulkInvoiceByRfsForm_Load(object Sender, EventArgs E)
        {
            LoadsCheckbox.Checked = true;
        }

        private void OkButton_Click(object Sender, EventArgs E)
        {
            int TmpRfs;
            if (string.IsNullOrEmpty(RfsNumberTextbox.Text) || 
                !int.TryParse(RfsNumberTextbox.Text, out TmpRfs))
            {
                MessageHelper.ShowInvalidOperation("RFS number must be an integer.");
                return;
            }

            if (!BillsOfLadingCheckbox.Checked && !LoadsCheckbox.Checked && !ReceiversCheckbox.Checked)
            {
                MessageHelper.ShowInvalidOperation("At least one type of bill must be included.");
                return;
            }

            _RfsNumber = TmpRfs;
            _IncludeBillsOfLading = BillsOfLadingCheckbox.Checked;
            _IncludeLoads = LoadsCheckbox.Checked;
            _IncludeReceivers = ReceiversCheckbox.Checked;

            DialogResult = DialogResult.OK;
            Close();
        }
    }
}