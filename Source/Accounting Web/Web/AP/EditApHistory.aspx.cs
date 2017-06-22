using System;
using System.Web.UI.WebControls;

public partial class AR_EditApHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.Sort("Date", SortDirection.Ascending);
            NewDateTextbox.Text = DateTime.Now.ToShortDateString();
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            ApHistoryDatasource.InsertParameters["Current"].DefaultValue = NewCurrentTextbox.Text;
            ApHistoryDatasource.InsertParameters["Thirty"].DefaultValue = NewThirtyTextBox.Text;
            ApHistoryDatasource.InsertParameters["Fortyfive"].DefaultValue = NewFortyfiveTextbox.Text;
            ApHistoryDatasource.InsertParameters["Sixty"].DefaultValue = NewSixtyTextbox.Text;
            ApHistoryDatasource.InsertParameters["Ninety"].DefaultValue = NewNinetyTextbox.Text;
            ApHistoryDatasource.InsertParameters["Date"].DefaultValue = NewDateTextbox.Text;
            ApHistoryDatasource.Insert();
        }
    }
}
