﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CopsUtilities;

public partial class Customers__All_Product_Transactions_RunningTotals : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.Refresh();
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.Refresh();
    }
}