using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

namespace Web.Clients.Assigned
{
    public partial class QAQC_Entry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void QAQC_Grid_detail_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void QAQC_Grid_detail_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
        {
            e.NewValues["QAQC_ID_Ref"] = Session["PID"];
        }

        protected void QAQC_Grid_detail_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            e.NewValues["QAQC_ID_Ref"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            e.NewValues["QA_Accept"] = true;
        }

        
    }
}