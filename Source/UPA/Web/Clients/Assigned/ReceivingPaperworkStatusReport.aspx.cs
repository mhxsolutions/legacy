using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.Datasets;
using Web.Clients;
using Microsoft.Reporting.WebForms;

namespace Web.Clients.Assigned
{
    public partial class ReceivingPaperworkStatusReport : ReportViewerBasePage
    {
        private const string REPORT_FILE = "ReceivingPaperworkStatusReport.rdlc";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && ContextClientID.HasValue)
            {
                ShowReport();
            }
        }

        protected void ShowReport()
        {
            System.IO.FileInfo reportFullPath = new System.IO.FileInfo(GetReportFullPath(REPORT_FILE));

            if (reportFullPath != null)
            {
                rvReportViewer.LocalReport.ReportPath = reportFullPath.FullName;

                rvReportViewer.LocalReport.DataSources.Clear();

                ReportDataSource rds = new ReportDataSource("PaperworkStatus");
                rds.Value = GetReportData();
                rvReportViewer.LocalReport.DataSources.Add(rds);

                rvReportViewer.LocalReport.Refresh();
            }
        }

        private Web.Datasets.PaperworkStatus.spUPAPaperWorkStatusDataTable GetReportData()
        {
            Web.Datasets.PaperworkStatusTableAdapters.spUPAPaperWorkStatusTableAdapter tableAdaptor
                = new Datasets.PaperworkStatusTableAdapters.spUPAPaperWorkStatusTableAdapter();
            var dt = new Web.Datasets.PaperworkStatus.spUPAPaperWorkStatusDataTable();
            tableAdaptor.Fill(dt, (int)this.ContextClientID);
            return dt;
        }
    }
}