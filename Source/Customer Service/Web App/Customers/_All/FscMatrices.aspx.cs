using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web;
using System.Drawing;
using System.Collections.Generic;
using DevExpress.Data;

public partial class Customers__All_FscMatrices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        
        //if (Int32.TryParse(srowIndex, out rowIndex)) 
     
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //e.Row.RowType
        string NavigateUrl;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink hl = new HyperLink();
            hl = e.Row.Cells[5].Controls[0] as HyperLink;
            string FscMatrixId = e.Row.Cells[0].Text.ToString().Trim();

            switch (hl.Text)
            {
                case "1":   // fuel price indexed percent lookup
                    NavigateUrl = string.Format("FscPercentMatrix.aspx?FSCID={0}", FscMatrixId);
                    break;
                case "2":   // fuel price indexed cents per mile lookup
                    NavigateUrl = string.Format("FscCentsPerMileMatrix.aspx?FSCID={0}", FscMatrixId);
                    break;
                default:    // unknown and something has gone wrong
                    NavigateUrl = string.Empty;
                    break;
            }

            if (NavigateUrl != string.Empty)
            {
                hl.Text = "Details";
                hl.NavigateUrl = NavigateUrl;
            }
            else
            {
                hl.Text = string.Empty;
            }
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    public void ASPxGridView1_DataBound(object sender, EventArgs e)
    {
        


    }
    protected void ASPxGridView1_RowCommand(object sender, DevExpress.Web.ASPxGridViewRowCommandEventArgs e)
    {

        
    }
    protected void ASPxGridView1_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
    {
        
    }
    protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
     //      string str = ASPxGridView1.Columns[e.].Cells[1].Text;
        
        
         
       }
    protected void  ASPxGridView1_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
{
        
}
protected void  ASPxGridView1_HtmlRowCreated(object sender, ASPxGridViewTableRowEventArgs e)
{
    /*string NavigateUrl;
    if (e.RowType == DevExpress.Web.GridViewRowType.Data)
    {
      //e.Row.Cells[]
        HyperLink hl=new HyperLink();
         hl = e.Row.Cells[5].Controls[0] as HyperLink;

        string FscMatrixId = e.Row.Cells[0].Text.ToString().Trim();
        if (hl == null)
            return;
        switch (hl.Text)
        {
            case "1":   // fuel price indexed percent lookup
                NavigateUrl = string.Format("FscPercentMatrix.aspx?FSCID={0}", FscMatrixId);
                break;
            case "2":   // fuel price indexed cents per mile lookup
                NavigateUrl = string.Format("FscCentsPerMileMatrix.aspx?FSCID={0}", FscMatrixId);
                break;
            default:    // unknown and something has gone wrong
                NavigateUrl = string.Empty;
                break;
        }

        if (NavigateUrl != string.Empty)
        {
            hl.Text = "Details";
            hl.NavigateUrl = NavigateUrl;
        }
        else
        {
            hl.Text = string.Empty;
        }
    }*/
}
protected void ASPxGridView1_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
{
    
}
protected void ASPxGridView1_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
{
   /* string NavigateUrl;
    if (e.RowType == DevExpress.Web.GridViewRowType.Data)
    {
        //e.Row.Cells[]
      //  e.Row.Cells[0].
        var hl = e.Row.Cells[5].Controls[0] as ASPxHyperLink;
        string FscMatrixId = e.Row.Cells[0].Text.ToString().Trim();
        if (hl == null)
            return;
        switch (hl.Text)
        {
            case "1":   // fuel price indexed percent lookup
                NavigateUrl = string.Format("FscPercentMatrix.aspx?FSCID={0}", FscMatrixId);
                break;
            case "2":   // fuel price indexed cents per mile lookup
                NavigateUrl = string.Format("FscCentsPerMileMatrix.aspx?FSCID={0}", FscMatrixId);
                break;
            default:    // unknown and something has gone wrong
                NavigateUrl = string.Empty;
                break;
        }

        if (NavigateUrl != string.Empty)
        {
            hl.Text = "Details";
            hl.NavigateUrl = NavigateUrl;
        }
        else
        {
            hl.Text = string.Empty;
        }
    }*/
}
protected void ASPxGridView1_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
{
   // e.Column.
}
private HyperLink FindControl(ControlCollection page)
{
    foreach (Control c in page)
    {
        if ((HyperLink)c != null)
        {
            return (HyperLink)c;
        }
        if (c.HasControls())
        {
            FindControl(c.Controls);
        }
    }
    return null; //may need to exclude this line
}
protected void ASPxGridView1_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
{
    if (e.DataColumn.Caption == "Column")
    {
       
        string NavigateUrl;
       
            //e.Row.Cells[]
            //  e.Row.Cells[0].
       // HyperLink hl = new HyperLink();
        //if (e.Cell.Controls[0] == null)
          //  return;
        //hl = e.Cell.Controls[0] as HyperLink;
            string FscMatrixId = e.KeyValue.ToString();
            DevExpress.Web.Internal.HyperLinkDisplayControl hl =
                       (e.Cell.Controls[0] as DevExpress.Web.Internal.HyperLinkDisplayControl);
            if (hl == null)
                return;
       
            switch (hl.Text)
            {
                case "1":   // fuel price indexed percent lookup
                    NavigateUrl = string.Format("FscPercentMatrix.aspx?FSCID={0}", FscMatrixId);
                    break;
                case "2":   // fuel price indexed cents per mile lookup
                    NavigateUrl = string.Format("FscCentsPerMileMatrix.aspx?FSCID={0}", FscMatrixId);
                    break;
                default:    // unknown and something has gone wrong
                    NavigateUrl = string.Empty;
                    break;
            }

            if (NavigateUrl != string.Empty)
            {
                hl.Text = "Details";
                hl.NavigateUrl = NavigateUrl;
            }
            else
            {
                hl.Text = string.Empty;
            }
        
    }
}
}

