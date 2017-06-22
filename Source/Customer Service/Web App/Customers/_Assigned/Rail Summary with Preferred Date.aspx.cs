using System;
using System.Diagnostics;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customers__Assigned_Rail_Summary_with_Preferred_Date : System.Web.UI.Page
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";

    protected void ServerValidateClientPreferredDate(object Sender, ServerValidateEventArgs E)
    {
        // This is an ugly bit of stuff, but it's necessary to get to the current row in the grid
        // view in order to get the proper instance of the textbox control. The custom validator 
        // is passed in as the sender, so a quick cast gets us that, after which we can get the
        // row from the validator's naming container, after which we can then find the control
        // by its ID. At that point it's a simple matter of parsing and comparing.

        CustomValidator CurrentValidator = Sender as CustomValidator;
        Debug.Assert(CurrentValidator != null);
        GridViewRow CurrentRow = CurrentValidator.NamingContainer as GridViewRow;
        Debug.Assert(CurrentRow != null);
        TextBox DateTextbox = CurrentRow.FindControl("_ClientPreferredDateTextbox") as TextBox;
        Debug.Assert(DateTextbox != null);

        DateTime NewPreferredDate;
        if (DateTime.TryParse(DateTextbox.Text, out NewPreferredDate))
            E.IsValid = NewPreferredDate >= DateTime.Now.Date;
        else
            E.IsValid = false;
    }

    // As hard as it might be to believe, the standard ASP.NET control find method still has no
    // option to recurse into child controls. This method is necessary to overcome that limitation.

    private static Control FindControlRecursive(Control Root, string ControlId)
    {
        if (Root.ID == ControlId)
            return Root;

        foreach (Control Child in Root.Controls)
        {
            Debug.Print(Child.UniqueID);

            Control Target = FindControlRecursive(Child, ControlId);
            if (Target != null)
                return Target;
        }

        return null;
    } 

    protected void Page_Load(object Sender, EventArgs E)
    {
        if (Session[_ContextClientId] != null)
        {
            int ClientId = Convert.ToInt32(Session[_ContextClientId]);

            // If the user is not a Budway employee, strip the leading client column. Our
            // external clients presumably know who they are already.

            if (ClientId != _BudwayDestinationId)
                _GridView1.Columns[1].Visible = false;
        }
        else
        {
            Response.Redirect("~/");
        }
    }

    protected void _GridView1_RowDataBound(object Sender, GridViewRowEventArgs E)
    {
        // So here's the support code that makes it possible to do client-side JavaScript 
        // validation of the preferred date, which is entered in a TextBox control inside
        // an EditItemTemplate. You can't just use an ASP.NET code block in the JavaScript
        // as with normal controls, so this bit of code tracks down the TextBox and spits
        // out a script block that declares a variable whose value is the control's client
        // ID. That way, other JavaScript may simply find the control directly.

        // Step one: if we're not in an editing mode, we bail becuase the control won't exist.

        if ((E.Row.RowState & DataControlRowState.Edit) != DataControlRowState.Edit) return;

        // Step two: if we're in an editing mode, then we should be able to find the control.
        // If we can't, for any reason, the assert will cause an ugly stack trace. It's not
        // pretty, but it will help us find errors if somebody changes things incorrectly.

        TextBox PreferredDateTextboxControl = FindControlRecursive(_GridView1, "_ClientPreferredDateTextbox") as TextBox;
        Debug.Assert(PreferredDateTextboxControl != null);

        // Step three: now that we have the control, we can get its client ID and spit out
        // the requisite block of JavaScript.

        StringBuilder S = new StringBuilder(
            "<script type=\"text/javascript\">" + Environment.NewLine +
            "var PreferredDateControlId = '" + PreferredDateTextboxControl.ClientID + "';" + Environment.NewLine
            );

        S.AppendLine("</script>");
        ClientScript.RegisterClientScriptBlock(GetType(), "PreferredDateControlAssignment", S.ToString());
    }
}
