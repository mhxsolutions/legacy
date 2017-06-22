using System;
using System.ComponentModel;
using System.Web.UI.WebControls;
using CopsUtilities;
using DevExpress.Data;

public partial class Customers__All_ContainerProjectDetail : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        //ASPxGridView1.Sort() ;
     //   _ProjectDatasource.Sort("Container Id", SortDirection.Ascending);
       // ASPxGridView1.("Contianer Id", SortDirection.Ascending);
       // _ExportToExcelButton.Visible = (ASPxGridView1.Rows.Count > 0);
        //ASPxGridView1.SortBy(, (ColumnSortOrder) SortDirection.Ascending);
        //ASPxGridView1.sor
    }

    protected void _ExportToExcelButton_Click(object Sender, EventArgs E)
    {
        //GridViewExporter.Export("BudwayDirect_ContainerProjectDetails.xls", _ContainerGridview);
        GridViewExporter.WriteXlsxToResponse();
    }
}
