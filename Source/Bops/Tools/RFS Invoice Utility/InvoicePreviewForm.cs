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
        /// <param name="InvoiceId">The unique ID of the invoice to be previewed.</param>
        /// <param name="InvoiceType">The type of the invoice to be previewed.</param>
        public InvoicePreviewForm(int InvoiceId, string InvoiceType) : this()
        {
            InvoiceFactory Factory = new InvoiceFactory();
            CrystalDecisions.CrystalReports.Engine.ReportDocument Report = Factory.ManufactureCrystalReport(InvoiceType);

            Report.SetParameterValue("InvoiceId", InvoiceId);
            Report.SetParameterValue("ForceFinal", false);

            crystalReportViewer1.ReportSource = Report;
        }
    }
}
