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
    public partial class ReceivingLoadDeliveryReview : ReportViewerBasePage
    {
        private const string REPORT_FILE = "LoadDeliveryReview.rdlc";

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

                ReportDataSource rds = new ReportDataSource("LoadDelivery");
                rds.Value = GetReportData();
                rvReportViewer.LocalReport.DataSources.Add(rds);

                rvReportViewer.LocalReport.Refresh();
            }
        }

        private Web.Datasets.LoadDelivery.spUPALoadDeliveryReportDataTable GetReportData()
        {
            Web.Datasets.LoadDeliveryTableAdapters.spUPALoadDeliveryReportTableAdapter tableAdaptor
                = new Datasets.LoadDeliveryTableAdapters.spUPALoadDeliveryReportTableAdapter();
            var dt = new Web.Datasets.LoadDelivery.spUPALoadDeliveryReportDataTable();
            tableAdaptor.Fill(dt, (int)this.ContextClientID);
            return dt;
        }
    }


}