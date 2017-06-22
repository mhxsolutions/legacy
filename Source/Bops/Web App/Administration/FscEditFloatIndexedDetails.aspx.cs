using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI.WebControls;
using BopsDataAccess;
using log4net;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

public partial class Administration_FscEditFloatIndexedDetails : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Administration_FscEditFloatIndexedDetails));

    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void ServerValidateNewValue(object sender, ServerValidateEventArgs e)
    {
        bool Valid = false;
        string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
        SessionManager<string> Mgr = new SessionManager<string>();

        try
        {
            ISession DwsNoRepSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

            int FscRef = Convert.ToInt32(Request.QueryString["FSCID"]);
            IList<BopsFscDetailFloatIndexed> Rows = DwsNoRepSession.CreateCriteria(typeof(BopsFscDetailFloatIndexed))
                .Add(Expression.Eq("FscRef", FscRef))
                .List<BopsFscDetailFloatIndexed>();

            double Minimum, Maximum, Value;

            if (double.TryParse(NewMinimumTextbox.Text, out Minimum) &&
                double.TryParse(NewMaximumTextBox.Text, out Maximum) &&
                double.TryParse(NewValueTextbox.Text, out Value))
            {
                foreach (BopsFscDetailFloatIndexed row in Rows)
                {
                    if ((row.IndexMinimum <= Minimum && Minimum <= row.IndexMaximum) ||
                        (row.IndexMinimum <= Maximum && Maximum <= row.IndexMaximum))
                    {
                        return;
                    }
                }

                Valid = true;
            }
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }
        finally
        {
            e.IsValid = Valid;
            Mgr.RemoveAllSessions(false);
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string FscRef = Request.QueryString["FSCID"];
        FscMatrixDetailsList.InsertParameters["FscRef"].DefaultValue = FscRef;
        FscMatrixDetailsList.InsertParameters["IndexMinimum"].DefaultValue = NewMinimumTextbox.Text;
        FscMatrixDetailsList.InsertParameters["IndexMaximum"].DefaultValue = NewMaximumTextBox.Text;
        FscMatrixDetailsList.InsertParameters["FscValue"].DefaultValue = NewValueTextbox.Text;
        FscMatrixDetailsList.Insert();
    }
}
