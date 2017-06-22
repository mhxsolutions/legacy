using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Power_Users_LoginCount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            deStart.Date = DateTime.Today.AddMonths(-1);
            deEnd.Date = DateTime.Today;
            tbInfo.Text = (deEnd.Date - deStart.Date).TotalDays.ToString();
            BindRoles();
        }
    }

    private void BindRoles()
    {
        cmbUserRole.Items.Clear();
        if (User.IsInRole("Administrators"))
        {
            cmbUserRole.Items.Add("Administrators");
        }
        cmbUserRole.Items.Add("Power Users");
        cmbUserRole.Items.Add("Users");
        cmbUserRole.SelectedItem = cmbUserRole.Items.FindByValue("Users");
    }
}