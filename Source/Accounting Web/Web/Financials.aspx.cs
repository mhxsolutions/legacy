using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Financials : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.Sort("Created", SortDirection.Descending);
            NewDateTextbox.Text = DateTime.Now.ToShortDateString();
            NewCurrentTextbox.Text = null;
        }
    }
    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            SqlDataSource1.InsertParameters["Cash"].DefaultValue = NewCurrentTextbox.Text;
            SqlDataSource1.InsertParameters["Money_Market"].DefaultValue = NewThirtyTextBox.Text;
            SqlDataSource1.InsertParameters["AR"].DefaultValue = NewFortyfiveTextbox.Text;
            SqlDataSource1.InsertParameters["AP"].DefaultValue = NewSixtyTextbox.Text;
            SqlDataSource1.InsertParameters["Created"].DefaultValue = NewDateTextbox.Text;
            SqlDataSource1.Insert();
        }
    }
}
