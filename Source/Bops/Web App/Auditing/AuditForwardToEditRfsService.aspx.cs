using System;

public partial class Auditing_AuditForwardToEditRfsService : System.Web.UI.Page
{
    private const string _ContextRfsId = "CONTEXT_RFSID";

    protected void Page_Load(object sender, EventArgs e)
    {
        string RedirectPage = "AuditRfsCalculationResultsNoResolution.aspx";

        if (Request.Params["RfsId"] != null && Request.Params["ServiceCategoryId"] != null && Request.Params["ServiceId"] != null)
        {
            int RfsId = Convert.ToInt32(Request.Params["RfsId"]);
            int Category = Convert.ToInt32(Request.Params["ServiceCategoryId"]);
            int ServiceId = Convert.ToInt32(Request.Params["ServiceId"]);

            Session[_ContextRfsId] = RfsId;
            RedirectPage = string.Format("~/RFS/RfsWizardRouteServiceRequest.aspx?mode=Edit&ServiceCategoryId={0}&ServiceId={1}", Category, ServiceId);
        }

        Context.Response.Redirect(RedirectPage);
    }
}
