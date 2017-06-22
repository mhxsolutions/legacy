using System;
using System.Web.UI.WebControls;

// I got the details ofr the focus trick from the following blog entry:
// http://mudnug.evolvingweb.com/portal/blogs/all_in_a_days_work/archive/2007/08/15/set-defaultbutton-for-enter-keypress-in-asp-net.aspx

public partial class Authentication_PasswordReminder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Wrap the following in an !IsPostback block if the page is more complicated
        // than a simple password recovery.

        // The first time our page loads we place the cursor in the User Name textbox
        // and make the Submit button the default button 

        Page.Form.DefaultButton = PasswordRecovery1.FindControl("UserNameContainerID$SubmitButton").UniqueID;
        Page.Form.DefaultFocus = PasswordRecovery1.FindControl("UserNameContainerID$UserName").ClientID;
    }

    protected void PasswordRecovery1_VerifyingUser(object sender, LoginCancelEventArgs e)
    {
        // This event fires after the User Name is entered; we'll use it to place the cursor 
        // in the answer textbox and make the Submit button the default button 

        Page.Form.DefaultButton = PasswordRecovery1.FindControl("QuestionContainerID$SubmitButton").UniqueID;
        Page.Form.DefaultFocus = PasswordRecovery1.FindControl("QuestionContainerID$Answer").ClientID;
    }

    protected void PasswordRecovery1_UserLookupError(object sender, EventArgs e)
    {
        Page.Form.DefaultButton = PasswordRecovery1.FindControl("UserNameContainerID$SubmitButton").UniqueID;
        Page.Form.DefaultFocus = PasswordRecovery1.FindControl("UserNameContainerID$UserName").ClientID;
    }
}
