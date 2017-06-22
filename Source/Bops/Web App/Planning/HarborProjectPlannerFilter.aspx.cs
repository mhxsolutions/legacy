using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;

public partial class Planning_HarborProjectPlannerFilter : Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Planning_HarborProjectPlannerFilter));
    
    private string GetCheckBoxList(CheckBoxList Target, char Delimeter)
    {
        StringBuilder Builder = new StringBuilder();
        
        foreach (ListItem li in Target.Items)
        {
            if (li.Selected)
            {
                Builder.Append(li.Value);
                Builder.Append(Delimeter);
            }
        }

        if (Builder.Length > 0)
        {
            Builder.Length = Builder.Length - 1;
            return Builder.ToString();
        }

        return string.Empty;
    }
    
    private void SetCheckBoxList(CheckBoxList Target, string Values, char[] Delimeters)
    {
        Target.ClearSelection();

        if (Values != string.Empty)
        {
            string[] ValueArray = Values.Split(Delimeters);
            foreach (string Value in ValueArray)
            {
                foreach (ListItem li in StatusCodes.Items)
                {
                    if (li.Value == Value)
                    {
                        li.Selected = true;
                        break;
                    }
                }
            }
        }
    }
    
    private string ProjectStatusFilter
    {
        get
        {
            object ProjStatus = Session["ProjectStatusFilter"];
            if (ProjStatus == null)
                return string.Empty;
            else
                return ProjStatus.ToString();
        }

        set { Session["ProjectStatusFilter"] = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
            _Log.DebugFormat("Page_Load using connection string: {0}", DbServer);
            
            using (SqlConnection Connection = new SqlConnection(DbServer))
            {
                string Query = "SELECT [Project Status ID], [Status] FROM [Proj Status] ORDER BY Status";
                SqlCommand Select = new SqlCommand(Query, Connection);
                Connection.Open();

                using (SqlDataReader Reader = Select.ExecuteReader())
                {
                    StatusCodes.DataSource = Reader;
                    StatusCodes.DataTextField = "Status";
                    StatusCodes.DataValueField = "Project Status ID";
                    StatusCodes.DataBind();

                    Reader.Close();
                }

                Connection.Close();

                string StartingProjectStatusFilter = ProjectStatusFilter;
                _Log.DebugFormat("Page_Load starting project status filter: {0}", StartingProjectStatusFilter);
                SetCheckBoxList(StatusCodes, StartingProjectStatusFilter, new char[] { ',' });
                Connection.Close();
            }
        }
    }
    protected void ApplyFilter_Click(object sender, EventArgs e)
    {
        string NewProjectStatusFilter = GetCheckBoxList(StatusCodes, ',');
        
        if (NewProjectStatusFilter == string.Empty)
        {
            ErrorMessage.Visible = true;
            _Log.Debug("ApplyFilter_Click no projects; showing error message.");
        }
        else
        {
            ProjectStatusFilter = NewProjectStatusFilter;
            string RedirectPage = "~/Planning/HarborProjectPlanner.aspx";
            _Log.DebugFormat("ApplyFilter_Click redirecting to: {0}", RedirectPage);
            Context.Response.Redirect(RedirectPage);
        }
    }
}
