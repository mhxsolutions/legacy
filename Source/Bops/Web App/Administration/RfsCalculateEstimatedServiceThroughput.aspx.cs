using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI.HtmlControls;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

public partial class Administration_RfsCalculateEstimatedServiceThroughput : System.Web.UI.Page
{
    private const string _DwsRepData = "NHibernateDwsRepData.xml.config";
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
        HtmlForm FormObject = (HtmlForm)Master.FindControl("form1");
        FormObject.Attributes.Add("onsubmit", "BeginOperation()");
    }

    private void CopyRateDetails(RfsEstimatedThroughputDetails Details, BopsRfsRateDetails Rate)
    {
        if (Details != null)
        {
            Rate.EstimatedRevenue = Details.EstimatedRevenue;
            Rate.EstimatedMinutes = Details.EstimatedMinutes;
            Rate.EstimatedThroughput = Details.EstimatedThroughput;
        }
        else
        {
            Rate.EstimatedRevenue = null;
            Rate.EstimatedMinutes = null;
            Rate.EstimatedThroughput = null;
        }
    }

    protected void CalculateButton_Click(object sender, EventArgs e)
    {
        bool Commit = false;
        CalculateButton.Enabled = false;
        SessionManager<string> Mgr = new SessionManager<string>();

        try
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsRepData);
            ISession DwsRepData = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

            ICriteria ServicesCriteria = DwsNoRepData.CreateCriteria(typeof(BopsRfsServicesRequested));

            if (OperationRadioButtonList.SelectedValue == "CalculateMissing")
                ServicesCriteria.Add(Expression.IsNull("PrivateRate.EstimatedThroughput"));

            IList<BopsRfsServicesRequested> Services = ServicesCriteria.List<BopsRfsServicesRequested>();
            IRfsEstimatedThroughputCalculator Estc = RfsFactory.GetRfsEstimatedServiceThroughputCalculator(DwsNoRepData, DwsRepData);

            Mgr.BeginTransaction(_DwsNoRepData);

            foreach (BopsRfsServicesRequested Service in Services)
            {
                RfsEstimatedServiceThroughput Details = Estc.CalculateEstimatedServiceThroughput(Service);

                CopyRateDetails(Details.PrivateRate, Service.PrivateRate);
                CopyRateDetails(Details.PublicRate, Service.PublicRate);

                DwsNoRepData.Update(Service);
            }

            Commit = true;
        }
        finally
        {
            Mgr.RemoveAllSessions(Commit);
        }

        CalculateButton.Enabled = true;
    }
}
