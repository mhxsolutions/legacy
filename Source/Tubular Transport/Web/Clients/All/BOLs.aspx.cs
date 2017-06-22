using System;
using DevExpress.Web;

public partial class Customers__All_BOLs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        BOLGgrid1.WriteXlsxToResponse();
    }

    protected void ASPxGridView1_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
    {

    }
    protected void ASPxGridView1_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
    {
/*        DataRowView rv;
        for (int i = 0; i < ASPxGridView1.VisibleRowCount; i++)
        {
            if (ASPxGridView1.Selection.IsRowSelected(i))
            {
                rv = (DataRowView)ASPxGridView1.GetRow(i);
                string temp = rv.Row[0].ToString().Trim();
                if (temp != "")
                {
                    // ASPxGridView1.
                    string[] array = temp.Split('"');
                    //array[1]
                    e.Cell.Text = "PDF";
                   // ASPxGridView1.Rows[i]
                    e.Cell.ToolTip = ASPxGridView1.Rows[i][e.DataColumn.Index].ToString();
                } 
                //array[1]
                e.Cell.Text = "PDF";
                e.Cell.ToolTip = ASPxGridView1.Rows[i][e.DataColumn.Index].ToString();
            }
        }*/
       
    }

    protected void ASPxGridView1_Init1(object sender, EventArgs e)
    {
            /*GridViewDataHyperLinkColumn colLink = new GridViewDataHyperLinkColumn();

    colLink.Caption = "Edition";

    colLink.FieldName = "PDF File";      //Column parameter, "Id" is URL link ("<a href="3">Edit</a> ")

    colLink.PropertiesHyperLinkEdit.Text = "PDF";      // Display text

    //colLink.PropertiesHyperLinkEdit.TextField = "Load ID";   //Display content of column "Content", alternative to PropertiesHyperLinkEdit.Text

    //colLink.PropertiesHyperLinkEdit.ImageUrl = "~/images/edit.gif";   //Display image, alternative to PropertiesHyperLinkEdit.Text

   // colLink.PropertiesHyperLinkEdit.NavigateUrlFormatString = "/PODs/Indexed PODs/152409BUD BOL no BC-CAPTIVA-20120806-083124_3.pdf";   //The URL is replaced {0} to "Id" to especific Row ("/Default.aspx?=3")

    colLink.Visible = true;

    colLink.Width = 50;

    ASPxGridView1.Columns.Add(colLink);    */  //Add column to ASPxGrid
    }
}