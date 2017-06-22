using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI.WebControls;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

public partial class Administration_FscEditFuelPriceHistory : System.Web.UI.Page
{
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            GridView1.Sort("BeginDate", SortDirection.Ascending);
    }

    protected void ServerValidateOnlyOneNullEndDate(object sender, ServerValidateEventArgs e)
    {
        DateTime NewBeginDate;

        if (DateTime.TryParse(NewBeginDateTextbox.Text, out NewBeginDate))
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            IList<BopsFscFuelPriceHistory> LastPrice = DwsNoRepSession.CreateCriteria(typeof(BopsFscFuelPriceHistory))
                .Add(Expression.IsNull("EndDate"))
                .List<BopsFscFuelPriceHistory>();
            e.IsValid = (LastPrice.Count == 1 && LastPrice[0].BeginDate < NewBeginDate);
            Mgr.RemoveAllSessions(false);
        }
        else
        {
            e.IsValid = false;    
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

            IList<BopsFscFuelPriceHistory> LastPrice = DwsNoRepSession.CreateCriteria(typeof (BopsFscFuelPriceHistory))
                .Add(Expression.IsNull("EndDate"))
                .List<BopsFscFuelPriceHistory>();

            Mgr.BeginTransaction(_DwsNoRepData);

            DateTime BeginDate;
            double Price;
            DateTime.TryParse(NewBeginDateTextbox.Text, out BeginDate);
            double.TryParse(NewFuelPriceTextbox.Text, out Price);

            LastPrice[0].EndDate = BeginDate;
            BopsFscFuelPriceHistory NewHistory = new BopsFscFuelPriceHistory();
            NewHistory.BeginDate = BeginDate;
            NewHistory.FuelPrice = Price;

            DwsNoRepSession.Update(LastPrice[0]);
            DwsNoRepSession.Save(NewHistory);

            Mgr.RemoveAllSessions(true);
            NewBeginDateTextbox.Text = string.Empty;
            NewFuelPriceTextbox.Text = string.Empty;
            GridView1.DataBind();
        }
    }
}
