using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUiRfs;
using BopsUtilities;
using log4net;
using RFS_Invoice_Utility.Properties;
using Scm.OpsCore.Legacy.DataLayer;
using Scm.OpsCore.Legacy.NHibernate;


namespace RFS_Invoice_Utility
{
    public partial class InvoicePreview : Form
    {
        
        public InvoicePreview(int invoiceId, string InvoiceType, string filePath) 
        {
            InitializeComponent();
            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var dtGetReportDetails = rfsDataContext.GetInvoiceDetail(invoiceId);
            this.reportViewer1.Reset();
            this.reportViewer1.LocalReport.ReportEmbeddedResource = GetInvoiceFormKey(InvoiceType);// "RFS_Invoice_Utility.Invoice.rdlc";
            if (dtGetReportDetails.Count > 0)
            {
                ReportParameter rp = new ReportParameter("Invoice", invoiceId.ToString());
                ReportDataSource rds = new ReportDataSource("SP_RDLCInvoice", dtGetReportDetails);
                this.reportViewer1.LocalReport.DataSources.Clear();
                this.reportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp });
                this.reportViewer1.LocalReport.DataSources.Add(rds);
                this.reportViewer1.LocalReport.Refresh();
                this.reportViewer1.RefreshReport();

                if (!string.IsNullOrEmpty(filePath))
                {
                    SaveInvoicePDF(reportViewer1,filePath);
                }
            }
        }

        private string GetInvoiceFormKey(string InvoiceType)
        {
            string InvoiceForm = "";
            switch (InvoiceType)
            {
                case "mhx":
                    InvoiceForm = "RFS_Invoice_Utility.Mhx-Invoice.rdlc";
                    break;
                case "budway":
                    InvoiceForm = "RFS_Invoice_Utility.Budway-Invoice.rdlc";
                    break;
                case "ttran":
                    InvoiceForm = "RFS_Invoice_Utility.Ttran-Invoice.rdlc";
                    break;
                case "hydra":
                    InvoiceForm = "RFS_Invoice_Utility.Hydra-Invoice.rdlc";
                    break;
                case "budwayeast":
                    InvoiceForm = "RFS_Invoice_Utility.Budwayeast-Invoice.rdlc";
                    break;
                case "newx":
                    InvoiceForm = "RFS_Invoice_Utility.Newx-Invoice.rdlc";
                    break;
                case "scls":
                    InvoiceForm = "RFS_Invoice_Utility.Scls-Invoice.rdlc";
                    break;
                case "scm":
                    InvoiceForm = "RFS_Invoice_Utility.Scm-Invoice.rdlc";
                    break;
                case "pulse":
                    InvoiceForm = "RFS_Invoice_Utility.Pulse-Invoice.rdlc";
                    break;
                default:
                    InvoiceForm = "RFS_Invoice_Utility.Budway-Invoice.rdlc";
                    break;

            }
            return InvoiceForm;
        }
        public void SaveInvoicePDF(ReportViewer viewer, string savePath)
        {
            string mimeType, encoding, extension;
            string[] streamids;
            Warning[] warnings = null;
            //Microsoft.Reporting.WebForms.Warning[] warnings;
            string format = "PDF";

            byte[] bytes = viewer.LocalReport.Render(format, "", out mimeType, out encoding, out extension, out streamids, out warnings);
            //save the pdf byte to the folder
            FileStream fs = new FileStream(savePath, FileMode.OpenOrCreate);
            byte[] data = new byte[fs.Length];
            fs.Write(bytes, 0, bytes.Length);
            fs.Close();

            //System.Diagnostics.Process p = new System.Diagnostics.Process();
            //p.StartInfo.FileName = savePath;
            //p.Start();
        }
    }
}
