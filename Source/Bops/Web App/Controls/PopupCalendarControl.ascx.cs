using System;
using System.Web.UI;

[ValidationProperty("Text")]
public partial class Controls_PopupCalendarControl : UserControl
{
    /// <summary>
    /// Exposes the date value of the popup calendar control as a nullable DateTime.
    /// </summary>
    public DateTime? DateValue
    {
        get 
        {
            DateTime ParsedValue;

            if (DateTime.TryParse(DateTextbox.Text, out ParsedValue))
                return ParsedValue;
            else
                return null;
        }

        set
        {
            if (value.HasValue)
                DateTextbox.Text = value.Value.ToShortDateString();
            else
                DateTextbox.Text = string.Empty;
        }
    }

    public string Text
    {
        get { return DateTextbox.Text; }
        set { DateTextbox.Text = value; }
    }

    /// <summary>
    /// Retrieves the client ID of the control that causes the postback. This method does not work correctly
    /// for buttons, image buttons, and the like, because ASP.NET doesn't set the __EVENTTARGET key for the
    /// more "standard" form submission postbacks.
    /// </summary>
    /// <returns>The control client ID if successful or the empty string otherwise.</returns>
    private string GetPostbackClientId(Page AspPage)
    {
        string ReturnValue = string.Empty;
        string EventTarget = Page.Request.Form["__EVENTTARGET"];

        /// Another tricky bit is that ASP.NET uses certain control naming conventions within master pages. The
        /// name of a control will typically be delimited with a dollar sign (or a colon in the case of legacy
        /// mode), whereas the ID will be delimited with an underscore. So before the string can be returned, the
        /// delimiter--the value in use for which is stored in the Page.IdSeparator field--must be replaced with
        /// an underscore.

        if (EventTarget != null && EventTarget != string.Empty)
            ReturnValue = Page.Request.Form["__EVENTTARGET"].Replace(AspPage.IdSeparator, '_');

        return ReturnValue;
    }

    private void ShowCalendar(bool Visibility)
    {
        if (Visibility)
            PopupCalendarPanel.Attributes.Add("style", "position: absolute");
        else
            PopupCalendarPanel.Attributes.Add("style", "display: none; position: absolute");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PopupCalendarPanel.Attributes.Add("style", "display: none; position: absolute");
        }
        else
        {
            string PostbackControlClientId = GetPostbackClientId(Page);
            ShowCalendar(PostbackControlClientId == PopupCalendar.ClientID);
        }

        Page.ClientScript.RegisterClientScriptBlock(GetType(), "ScriptPanel" + ID, 
            "<script> function On" + ID + "Click() {  if(" 
            + PopupCalendarPanel.ClientID + ".style.display == \"none\")       "
            + PopupCalendarPanel.ClientID + ".style.display = \"\";   else    "
            + PopupCalendarPanel.ClientID + ".style.display = \"none\"; } </script>");
        CalendarImage.Attributes.Add("OnClick", "On" + ID + "Click()");
    }

    protected void PopupCalendar_SelectionChanged(object sender, EventArgs e)
    {
        DateTextbox.Text = PopupCalendar.SelectedDate.ToShortDateString();
        ShowCalendar(false);
    }
}
