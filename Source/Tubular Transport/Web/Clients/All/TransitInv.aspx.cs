using System;

public partial class Customers__All_TransitInv : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Car_Number"] != null)
            ASPxGridView1.AutoFilterByColumn(ASPxGridView1.Columns["Car_Number"], Request.QueryString["Car_Number"]);
           // ASPxGridView1.FilterEnabled = false;// = Request.QueryString["Car_Number"];
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        TransInvExport.WriteXlsxToResponse();
    }
    
    protected void ASPxGridView1_FilterControlCustomValueDisplayText(object sender, DevExpress.Web.FilterControlCustomValueDisplayTextEventArgs e)
    {
            //e.DisplayText = Request.QueryString["Car_Number"];
    }

    protected void ASPxGridView1_ProcessColumnAutoFilter(object sender, DevExpress.Web.ASPxGridViewAutoFilterEventArgs e)
    {

    }
}
