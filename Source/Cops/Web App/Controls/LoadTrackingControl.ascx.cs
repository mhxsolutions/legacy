using System;
using System.Web.UI;

namespace Web_App.Controls
{
    public partial class LoadTrackingControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TrackingButton_Click(object sender, EventArgs e)
        {
            var targetUrl = "~/Customers/_All/LoadTrackingReport.aspx?LoadRef=" + LoadReference.Text.Trim();
            Response.Redirect(targetUrl);
        }
    }
}
