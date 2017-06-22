using System;
using System.Web.UI;

public partial class Customers__All_LoadTrackingReportInvalidLoadError : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadReferenceNumberLabel.Text = Request.Params["LoadRef"];
        }
    }
}
