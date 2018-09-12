using System.Windows.Forms;

namespace RFS_Invoice_Utility
{
    public partial class InvoicePreviewForm : Form
    {
        private InvoicePreviewForm()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Instantiates a new preview form for the specified invoice.
        /// </summary>
        /// <param name="invoiceId">The unique ID of the invoice to be previewed.</param>
        /// <param name="invoiceType">The type of the invoice to be previewed.</param>
        public InvoicePreviewForm(int invoiceId, string invoiceType) : this()
        {
            var factory = new InvoiceFactory();
            var report = factory.ManufactureCrystalReport(invoiceType);

            report.SetParameterValue("InvoiceId", invoiceId);
            report.SetParameterValue("ForceFinal", false);

            crystalReportViewer1.ReportSource = report;
        }
    }
}
