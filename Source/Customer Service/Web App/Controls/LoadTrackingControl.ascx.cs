using System;
using System.Web.UI;

public partial class Controls_LoadTrackingControl : UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void TrackingButton_Click(object sender, EventArgs e)
    {
        string TargetUrl = "~/Customers/_All/LoadTrackingReport.aspx?LoadRef=" + LoadReference.Text.Trim();
        Response.Redirect(TargetUrl);
    }
}
