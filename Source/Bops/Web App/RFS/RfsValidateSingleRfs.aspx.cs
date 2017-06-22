using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using BopsBusinessLogicRfs;
using NHibernate;
using NHibernateUtilities;

public partial class RFS_RfsValidateSingleRfs : System.Web.UI.Page
{
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";
    private const string _DwsRepData = "NHibernateDwsRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["RfsId"] == null)
            Response.Redirect("RfsWizardSelect.aspx");

        int RfsId = Convert.ToInt32(Request.QueryString["RfsId"]);

        SessionManager<string> Mgr = new SessionManager<string>();
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
        ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
        ISession DwsRepData = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

        IRfsValidator Validator = RfsFactory.GetRfsValidator(DwsNoRepData, DwsRepData);
        List<RfsValidationError> RfsValidationErrorList = Validator.ValidateSingleRfs(RfsId);

        if (RfsValidationErrorList != null)
        {
            DataTable NewTable = new DataTable();
            NewTable.Columns.Add("Error", typeof (string));

            foreach (RfsValidationError Error in RfsValidationErrorList)
            {
                NewTable.Rows.Add(new object[] {Error.GetErrorTypeStringDescription()});
            }

            GridView1.DataSource = NewTable;
            GridView1.DataBind();

            ResultsSummaryLabel.Text = string.Format("A total of {0} error(s) were found for RFS {1}. Details follow.",
                                                     RfsValidationErrorList.Count, RfsId);
        }
        else
        {
            ResultsSummaryLabel.Text = string.Format("No errors detected for RFS {0}.", RfsId);
        }
    }
}
