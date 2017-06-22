using System;
using BopsDataAccess;

public partial class Auditing_AuditRfsCalculationResultsForwardToResolution : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string RedirectPage = "AuditRfsCalculationResultsNoResolution.aspx";

        if (Request.Params["RfsId"] != null && 
            Request.Params["ResultCode"] != null && 
            Request.Params["DocumentId"] != null &&
            Request.Params["ServiceCategory"] != null)
        {
            string RfsId = Request.Params["RfsId"];
            string DocumentId = Request.Params["DocumentId"];
            
            RfsCalculationResultType Result = (RfsCalculationResultType)Convert.ToInt32(Request.Params["ResultCode"]);
            RfsServiceCategories ServiceCategory = (RfsServiceCategories)Enum.Parse(typeof(RfsServiceCategories), Request.Params["ServiceCategory"]);

            if (ServiceCategory == RfsServiceCategories.Transportation)
            {
                switch (Result)
                {
                    case RfsCalculationResultType.Success:
                    case RfsCalculationResultType.ManualCalculation:
                    case RfsCalculationResultType.ZeroRfs:
                    case RfsCalculationResultType.WillCall:
                    case RfsCalculationResultType.NullRfs:
                    case RfsCalculationResultType.InvalidCostMethod:
                    case RfsCalculationResultType.SoftwareException:
                    case RfsCalculationResultType.InvalidRfs:
                        break;

                    case RfsCalculationResultType.NoServiceMatch:
                        RedirectPage = string.Format("AuditRfsCalculationResultsResolveNoService.aspx?RfsId={0}&DocumentId={1}", RfsId, DocumentId);
                        break;

                    case RfsCalculationResultType.ServiceCalculationErrors:
                        RedirectPage = string.Format("AuditRfsCalculationResultsResolveServiceCalculationError.aspx?RfsId={0}&DocumentId={1}", RfsId, DocumentId);
                        break;
                }
            }
            else if (ServiceCategory == RfsServiceCategories.Warehouse)
            {
                string DocumentType = Request.Params["DocumentType"];

                switch (Result)
                {
                    case RfsCalculationResultType.Success:
                    case RfsCalculationResultType.ManualCalculation:
                    case RfsCalculationResultType.ZeroRfs:
                    case RfsCalculationResultType.WillCall:
                    case RfsCalculationResultType.NullRfs:
                    case RfsCalculationResultType.InvalidCostMethod:
                    case RfsCalculationResultType.SoftwareException:
                    case RfsCalculationResultType.InvalidRfs:
                    case RfsCalculationResultType.ServiceCalculationErrors:
                        break;

                    case RfsCalculationResultType.NoServiceMatch:
                        RedirectPage = string.Format("AuditRfsWarehouseCalculationResultsResolveNoService.aspx?RfsId={0}&DocumentId={1}&DocumentType={2}", 
                            RfsId, DocumentId, DocumentType);
                        break;
                }
            }
        }

        Context.Response.Redirect(RedirectPage);
    }
}
