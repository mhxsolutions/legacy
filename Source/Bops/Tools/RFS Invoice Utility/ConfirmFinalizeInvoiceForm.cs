using System.Windows.Forms;

namespace RFS_Invoice_Utility
{
    public partial class ConfirmFinalizeInvoiceForm : Form
    {
        private bool _ShowFinalizedInvoice;

        public bool ShowFinalizedInvoice
        {
            get { return _ShowFinalizedInvoice; }
            set { _ShowFinalizedInvoice = value; }
        }

        public ConfirmFinalizeInvoiceForm(bool ShowFinalizedInvoice)
        {
            _ShowFinalizedInvoice = ShowFinalizedInvoice;

            InitializeComponent();

            QuestionIconPicturebox.Image = System.Drawing.SystemIcons.Question.ToBitmap();
            ShowInvoiceCheckbox.Checked = _ShowFinalizedInvoice;
        }

        private void YesButton_Click(object Sender, System.EventArgs E)
        {
            _ShowFinalizedInvoice = ShowInvoiceCheckbox.Checked;
            DialogResult = DialogResult.Yes;
            Close();
        }

        private void NoButton_Click(object Sender, System.EventArgs E)
        {
            DialogResult = DialogResult.No;
            Close();
        }
    }
}