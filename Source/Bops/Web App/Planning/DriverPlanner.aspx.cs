using System;
using System.Collections.Generic;
using BopsDataAccess;
using BopsDataConnector;
using NHibernate.Criterion;

public partial class Planning_DriverPlanner : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        Page.Form.DefaultButton = _NextButton.UniqueID;
        _DriverDropdownlist.Focus();
        _PlanDateTextbox.Text = DateTime.Now.Date.ToShortDateString();
    }

    protected void _NextButton_Click(object Sender, EventArgs E)
    {
        string NextPage;
        IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

        int DriverRef = Convert.ToInt32(_DriverDropdownlist.SelectedValue);
        DateTime PlanDate = Convert.ToDateTime(_PlanDateTextbox.Text);

        try
        {
            IList<BopsDriverPlan> Plans = DataConnector.DwsNoRepData.CreateCriteria(typeof (BopsDriverPlan))
                .Add(Expression.Eq("DriverRef", DriverRef))
                .Add(Expression.Eq("PlanDate", PlanDate))
                .List<BopsDriverPlan>();

            if (Plans.Count == 0)
                NextPage = string.Format("DriverPlannerCreate.aspx?DriverId={0}&PlanDate={1}", DriverRef, PlanDate.ToShortDateString());
            else
                NextPage = string.Format("DriverPlannerEdit2.aspx?PlanId={0}", Plans[0].PlanId);
        }
        finally
        {
            DataConnector.CloseSessions();
        }

        Response.Redirect(NextPage);
    }
}
