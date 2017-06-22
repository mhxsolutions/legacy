using System;
using System.Web.UI.WebControls;

public partial class AR_EditArHistory : System.Web.UI.Page
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
            ArHistoryDatasource.InsertParameters["Current"].DefaultValue = NewCurrentTextbox.Text;
            ArHistoryDatasource.InsertParameters["Thirty"].DefaultValue = NewThirtyTextBox.Text;
            ArHistoryDatasource.InsertParameters["Fortyfive"].DefaultValue = NewFortyfiveTextbox.Text;
            ArHistoryDatasource.InsertParameters["Sixty"].DefaultValue = NewSixtyTextbox.Text;
            ArHistoryDatasource.InsertParameters["Ninety"].DefaultValue = NewNinetyTextbox.Text;
            ArHistoryDatasource.InsertParameters["Date"].DefaultValue = NewDateTextbox.Text;
            ArHistoryDatasource.Insert();
        }
    }
}
