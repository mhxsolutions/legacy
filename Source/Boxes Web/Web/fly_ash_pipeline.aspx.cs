using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

using DevExpress.Web;
//
//using DevExpress.Data;
//using DevExpress.Web.Internal;


public partial class fly_ash_pipeline : System.Web.UI.Page
{
    #region Properties
    public int SummaryBalance { get; set; }
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["PrevBalanceValues"] = null;
        gridFlyAsh.SettingsPager.PageSize = GetLastDayOfMonth();
    }
    #endregion

    #region ASPxridView Events 
    protected void gridFlyAsh_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
    {
        if (e.Column.FieldName == "Balance")
        {
            ASPxGridView grid = sender as ASPxGridView;
            object keyValue = e.GetListSourceFieldValue(grid.KeyFieldName);
            int visibleIndex = GetVisibleRowIndexByKeyValue(grid, keyValue);
            object tempVal = e.GetListSourceFieldValue("Est In");
            int estIn = 0;
            if ((tempVal != null) && (tempVal != DBNull.Value) && (!string.IsNullOrWhiteSpace(tempVal.ToString()))) { estIn = Convert.ToInt32(tempVal); }

            tempVal = e.GetListSourceFieldValue("Avg Out");
            int avgOut = 0;
            if ((tempVal != null) && (tempVal != DBNull.Value) && (!string.IsNullOrWhiteSpace(tempVal.ToString()))) { avgOut = Convert.ToInt32(tempVal); }
            e.Value = estIn - avgOut;
            List<int> values = Session["PrevBalanceValues"] as List<int>;
            if (values == null) { Session["PrevBalanceValues"] = values = new List<int>(); }
            if (visibleIndex > 0)
            {
                if (values.Count > visibleIndex - 1)
                    e.Value = (int)e.Value + values[visibleIndex - 1];
                else
                    e.Value = (int)e.Value + (int)grid.GetRowValues(visibleIndex - 1, new string[] { "Balance" });
            }
            if (values.Count > visibleIndex)
                values[visibleIndex] = (int)e.Value;
            else
                values.Insert(visibleIndex, (int)e.Value);
            this.SummaryBalance = (int)e.Value;
        }
    }

    protected void gridFlyAsh_CustomSummaryCalculate(object sender, DevExpress.Data.CustomSummaryEventArgs e)
    {
        if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
        {
            ASPxSummaryItem item = e.Item as ASPxSummaryItem;
            if (item != null)
            {
                if (item.FieldName == "Date") { e.TotalValue = "Totals:"; e.TotalValueReady = true; }
                if (item.FieldName == "Balance") { e.TotalValue = this.SummaryBalance; e.TotalValueReady = true; }
            }
        }
    }
    #endregion

    #region ASPxGridViewExporter Events

    protected void btnPdfExport_Click(object sender, EventArgs e)
    {
        gridExportFlyAsh.WritePdfToResponse("FlyAshPipeline.pdf", true);
    }
    protected void btnXlsExport_Click(object sender, EventArgs e)
    {
        gridExportFlyAsh.WriteXlsToResponse("FlyAshPipeline.xls", true);
    }
    protected void btnXlsxExport_Click(object sender, EventArgs e)
    {
        gridExportFlyAsh.WriteXlsxToResponse();
    }
    protected void btnRtfExport_Click(object sender, EventArgs e)
    {
        gridExportFlyAsh.WriteRtfToResponse();
    }
    #endregion


    #region private helper methods
    private int GetVisibleRowIndexByKeyValue(ASPxGridView grid, object keyValue)
    {
        string[] keyfield = new string[] { grid.KeyFieldName };
        for (int i = 0; i < grid.VisibleRowCount; i++)
            if (grid.GetRowValues(i, keyfield).Equals(keyValue))
                return i;
        return -1;
    }

    private int GetLastDayOfMonth()
    {
        int days = DateTime.Now.Day;
        if (days >= 31) { return 31; }
        int index = 0; int month = DateTime.Now.Month;
        while (index < 31) { if (DateTime.Now.AddDays(++index).Month != month) { return (days + index - 1); } }
        return 31;
    }
    #endregion
}