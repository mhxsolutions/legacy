using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsCallback && Session["CONTEXT_CLIENTID"] == null)
        //{
        //    Response.Redirect("~/Default.aspx");
        //}
    }

    protected void ASPxNavBar1_ItemDataBound(object source, DevExpress.Web.NavBarItemEventArgs e)
    {
        SiteMapNode node = (SiteMapNode)e.Item.DataItem;
        if (node["target"] != null)
            e.Item.Target = node["target"];
    }
}