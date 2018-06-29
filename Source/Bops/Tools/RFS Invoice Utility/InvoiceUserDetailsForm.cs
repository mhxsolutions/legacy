using System.Windows.Forms;
using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    public partial class InvoiceUserDetailsForm : Form
    {
        public BopsRfsInvoice Invoice { get; set; }

        public InvoiceUserDetailsForm()
        {
            InitializeComponent();
        }

        private void InvoiceUserDetailsForm_Load(object sender, System.EventArgs e)
        {
            if (Invoice == null)
                return;

            invoiceIdTextbox.Text = Invoice.InvoiceId.ToString();
            userCreatedTextbox.Text = Invoice.UserCreated;
            userFinalizedTextbox.Text = Invoice.UserFinalized;
        }
    }
}
