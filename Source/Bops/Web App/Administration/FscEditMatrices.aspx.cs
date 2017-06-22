using System;

public partial class Administration_FscEditMatrices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            FscMatricesList.InsertParameters["Name"].DefaultValue = NewNameTextbox.Text;
            FscMatricesList.InsertParameters["Description"].DefaultValue = NewDescriptionTextbox.Text;
            FscMatricesList.InsertParameters["CostMethod"].DefaultValue = NewCostMethodDropdown.SelectedValue;
            FscMatricesList.InsertParameters["BeginDate"].DefaultValue = DateTime.Now.Date.ToShortDateString();
            FscMatricesList.Insert();
        }
    }
}
