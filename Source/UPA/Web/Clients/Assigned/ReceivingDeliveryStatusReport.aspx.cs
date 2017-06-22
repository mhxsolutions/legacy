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
    public partial class ReceivingDeliveryStatusReport : ReportViewerBasePage
    {
        private const string REPORT_FILE = "ReceivingDeliveryStatusReport.rdlc";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && ContextClientID.HasValue)
            {
                ShowReport();
            }
        }

        //View.aspx.cs
        protected void ShowReport()
        {
            System.IO.FileInfo reportFullPath = new System.IO.FileInfo(GetReportFullPath(REPORT_FILE));

            //check to make sure the file ACTUALLY exists, before we start working on it
            if (reportFullPath != null)
            {
                rvReportViewer.LocalReport.ReportPath = reportFullPath.FullName;

                rvReportViewer.LocalReport.DataSources.Clear();

                ReportDataSource rds = new ReportDataSource("DeliveryStatus");
                rds.Value = GetReportData();
                rvReportViewer.LocalReport.DataSources.Add(rds);

                rvReportViewer.LocalReport.Refresh();
            }
        }

        private Web.Datasets.DeliveryStatus.spUPADeliveryStatusReportDataTable GetReportData()
        {
            Web.Datasets.DeliveryStatusTableAdapters.spUPADeliveryStatusReportTableAdapter tableAdaptor
                = new Datasets.DeliveryStatusTableAdapters.spUPADeliveryStatusReportTableAdapter();
            var dt = new Web.Datasets.DeliveryStatus.spUPADeliveryStatusReportDataTable();
            tableAdaptor.Fill(dt, (int)this.ContextClientID);
            return dt;
        }
    }
}