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
    public partial class MasterParts : ReportViewerBasePage
    {
        private const string REPORT_FILE = "MasterPartsList.rdlc";

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

                ReportDataSource rds = new ReportDataSource("MasterPartsListDS");
                rds.Value = GetReportData();
                rvReportViewer.LocalReport.DataSources.Add(rds);

                rvReportViewer.LocalReport.Refresh();
            }
        }

        private Web.Datasets.MasterPartsList.DataTable1DataTable GetReportData()
        {
            Web.Datasets.MasterPartsListTableAdapters.DataTable1TableAdapter tableAdaptor 
                = new Datasets.MasterPartsListTableAdapters.DataTable1TableAdapter();
            var dt = new Web.Datasets.MasterPartsList.DataTable1DataTable();
            tableAdaptor.Fill(dt, (int)this.ContextClientID);
            return dt;
        }
    }
}