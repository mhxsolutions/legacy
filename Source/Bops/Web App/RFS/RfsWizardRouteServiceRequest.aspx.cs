using System;
using System.Web.UI;

public partial class RFS_RfsWizardRouteServiceRequest : Page
{
    private const string _ContextRfsId = "CONTEXT_RFSID";

    protected void Page_Load(object Sender, EventArgs E)
    {
        string TargetUrl;
        string Mode = Request.QueryString["Mode"];
        int ServiceId = Convert.ToInt32(Request.QueryString["ServiceId"]);
        int ServiceCategoryId = Convert.ToInt32(Request.QueryString["ServiceCategoryId"]);

        // Set the working RFS if specified.

        if (Request.QueryString["RfsId"] != null)
        {
            int RfsId = Convert.ToInt32(Request.QueryString["RfsId"]);
            Session[_ContextRfsId] = RfsId;
        }

        switch (ServiceCategoryId)
        {
            case 1:     // Transportation
                TargetUrl = string.Format("RfsWizardRequestTransporation.aspx?Mode={0}&ServiceId={1}", Mode, ServiceId);
                break;
            case 2:     // Warehouse
                TargetUrl = string.Format("RfsWizardRequestWarehouse.aspx?Mode={0}&ServiceId={1}", Mode, ServiceId);
                break;
            case 3:     // Assessorial
                TargetUrl = string.Format("RfsWizardRequestAssessorial.aspx?Mode={0}&ServiceId={1}", Mode, ServiceId);
                break;

            default:    // No clue what to do with this.
                TargetUrl = "RfsWizardServices.aspx";
                break;
        }

        Response.Redirect(TargetUrl);
    }
}
