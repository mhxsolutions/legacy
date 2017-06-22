using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customers__All_Transactions : BasePage
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (!IsPostBack)
        {
            //GridView gv = new GridView();
            //Page.Controls.Add(gv);
            //gv.DataSourceID = "SqlDataSource2";
            //gv.DataBind();
            //gv.Visible = false;


            //DataView dv = SqlDataSource2.Select(DataSourceSelectArguments.Empty) as DataView;

            //DropDownList2.DataBind();
            //DropDownList1.DataBind();
            //ASPxGridView1.DataBind();
        }

    }


    int CountTotal = 0;

    protected void ASPxGridView1_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
    {
        ASPxGridView grid = (ASPxGridView)sender;
        int visibleIndex = grid.FindVisibleIndexByKeyValue(e.GetListSourceFieldValue("RowNo"));

        if (e.Column.FieldName == "CtBalance")
        {
            int itemIn = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(visibleIndex, "Item_Ct_In"))) ? Convert.ToInt32(grid.GetRowValues(visibleIndex, "Item_Ct_In")) : 0;
            int itemOut = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(visibleIndex, "Item_Ct_Out"))) ? Convert.ToInt32(grid.GetRowValues(visibleIndex, "Item_Ct_Out")) : 0;
            int previousItemBalance = (visibleIndex != 0) ? Convert.ToInt32(grid.GetRowValues(visibleIndex - 1, "CtBalance")) : 0;

            e.Value = previousItemBalance + itemIn - itemOut;
        }
        else if (e.Column.FieldName == "FtBalance")
        {
            int linerFtIn = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(visibleIndex, "Linear Ft In"))) ? Convert.ToInt32(grid.GetRowValues(visibleIndex, "Linear Ft In")) : 0;
            int linerFtOut = !string.IsNullOrWhiteSpace(Convert.ToString(grid.GetRowValues(visibleIndex, "Linear Ft Out"))) ? Convert.ToInt32(grid.GetRowValues(visibleIndex, "Linear Ft Out")) : 0;
            int previousLinerFtBalance = (visibleIndex != 0) ? Convert.ToInt32(grid.GetRowValues(visibleIndex - 1, "FtBalance")) : 0;

            e.Value = previousLinerFtBalance + linerFtIn - linerFtOut;
        }
    }
    protected void ASPxGridView1_DataBinding(object sender, EventArgs e)
    {
        ASPxGridView1.DataSource = GetData();
    }

    private DataTable GetData()
    {
        string sql = "SELECT Terminal, Date, [Group 1] AS Group_1, [Group 2] AS Group_2, [Group 3] AS Group_3, [Item Ct In] AS Item_Ct_In, [Item Ct Out] AS Item_Ct_Out, Profile, [Linear Ft In], [Linear Ft Out], 0 AS Count_Total, 0 AS Feet_Total, sort FROM [Cache COPS Transaction Log view with sort] WHERE ([Client ref] = @Client_ref) AND (Profile = @Profile_1) AND (sort = @sort) ORDER BY Date, Terminal, sort";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("Client_ref", Convert.ToInt32(Session["context_clientid"]));
        cmd.Parameters.AddWithValue("Profile_1", DropDownList2.SelectedValue);
        cmd.Parameters.AddWithValue("sort", DropDownList1.SelectedValue);

        DataSet ds = new DataSet();

        if (con.State != ConnectionState.Open)
        {
            con.Open();
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
        }
        return ds.Tables.Count > 0 ? ds.Tables[0] : new DataTable();
    }



}