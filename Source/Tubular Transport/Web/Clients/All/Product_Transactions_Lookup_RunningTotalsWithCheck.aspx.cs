using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Customers__All_Product_Transactions_Lookup_RunningTotalsWithCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    [System.Web.Services.WebMethod()] 
    [System.Web.Script.Services.ScriptMethod()]
    public static void setCheckValues(String pReceiverID, Boolean pChecked, String pReceiverNote)
    {
        try
        {
            if(!String.IsNullOrEmpty((pReceiverID)))
            {
                String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;
                using (var oConnection = new SqlConnection(connectionString))
                {
                    oConnection.Open();
                    using (SqlCommand oCommand = new SqlCommand("UPDATE [Receivers S] SET [Client A] = @Checked, [Client Note] = @ReceiverNote WHERE [Receiver ID] = @ReceiverID"))
                    {
                        oCommand.Connection = oConnection;
                        oCommand.Parameters.AddWithValue("@Checked", pChecked);
                        oCommand.Parameters.AddWithValue("@ReceiverNote", pReceiverNote);
                        oCommand.Parameters.AddWithValue("@ReceiverID", pReceiverID);
                        //Execute
                        int rowCnt = oCommand.ExecuteNonQuery();
                    }
                }
            }
        }
        catch (Exception oEx)
        {
            throw;
        }
    }
}