using System;
using System.Web.UI;
using CopsUtilities;

public partial class Customers__All_inventoryatFON : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void ASPxButton1_Click(object sender, EventArgs e)
    {
        GridViewExporter1.WriteXlsxToResponse();
    }

    
}
