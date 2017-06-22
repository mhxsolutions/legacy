using System;
using System.Web;
using BopsBusinessLogicDestinations;

public partial class Administration_DestinationSetAssignments : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        int SetId = Convert.ToInt32(Request.QueryString["SetId"]);
        IDestinationSets Sets = DestinationFactory.GetDestinationSets();
        DestinationSetDetails Dsd = Sets.GetSetDetails(SetId);
        _HeaderLabel.Text = string.Format("Set {0}: {1}", Dsd.Set.Id, Dsd.Set.Name);
    }

    protected void _AddButton_Click(object Sender, EventArgs E)
    {
        _AssignmentsDatasource.Insert();
    }

    protected void _DestinationsGridView_RowDeleted(object Sender, System.Web.UI.WebControls.GridViewDeletedEventArgs E)
    {
        _DestinationsDropdownlist.DataBind();
    }

    protected void _DestinationsGridView_RowCreated(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        _DestinationsDropdownlist.DataBind();
    }
}
