using System;
using System.Web;
using BopsDataAccess;
using BopsDataConnector;
using log4net;
using NHibernate;

public partial class RFS_RfsStorageBillingEditRate : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(RFS_RfsStorageBillingEditRate));

    protected void Page_Load(object Sender, EventArgs E)
    {
        // Necessary to ensure that the page options get set correctly every time, even when the
        // back/forward buttons are used for navigation.

        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            _BillingTypeList.Attributes.Add("onchange", "OnUpdateBillingType(this.options[this.selectedIndex].value);");
            _UnitList.Attributes.Add("onchange", "OnUpdateUnitType(this.options[this.selectedIndex].value);");

            string Mode = Request.QueryString["mode"];

            if (Mode.ToLower() == "edit")
            {
                IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

                try
                {
                    int RateId = Convert.ToInt32(Request.QueryString["RateId"]);
                    BopsRfsStorageRate TargetRate = DataConnector.DwsNoRepData.Get<BopsRfsStorageRate>(RateId);
                    _BillToClientList.SelectedValue = TargetRate.BillToClientRef.ToString();
                    _BillingTypeList.SelectedValue = Convert.ToInt32(TargetRate.BillingType).ToString();
                    _DaysInCycleTextbox.Text = TargetRate.DaysInCycle.ToString();
                    _CostPerCycleTextbox.Text = TargetRate.UnitCostPerCycle.ToString();
                    _UnitList.SelectedValue = Convert.ToInt32(TargetRate.UnitRef).ToString();
                    _DescriptionTextbox.Text = TargetRate.Description;
                    _SaveButton.Text = "Update Rate";
                }
                finally
                {
                    DataConnector.CloseSessions();
                }
            }
            else
            {
                _BillingTypeList.SelectedValue = "1";   // Default is per weight
                _UnitList.SelectedValue = "6";          // Default is tons
                _DaysInCycleTextbox.Text = "30";        // Default is 30 days
                _SaveButton.Text = "Save New Rate";
            }
        }
    }

    protected void _SaveButton_Click(object Sender, EventArgs E)
    {
        string RedirectPage = null;
        string Mode = Request.QueryString["mode"];
        IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();
        ITransaction Tx = DataConnector.DwsNoRepData.BeginTransaction();

        try
        {
            if (Mode.ToLower() == "edit")
            {
                int RateId = Convert.ToInt32(Request.QueryString["RateId"]);
                BopsRfsStorageRate TargetRate = DataConnector.DwsNoRepData.Load<BopsRfsStorageRate>(RateId);
                TargetRate.BillToClientRef = Convert.ToInt32(_BillToClientList.SelectedValue);
                TargetRate.BillingType = (RfsStorageBillingType) Convert.ToInt32(_BillingTypeList.SelectedValue);
                TargetRate.DaysInCycle = Convert.ToInt32(_DaysInCycleTextbox.Text);
                TargetRate.UnitCostPerCycle = Convert.ToDouble(_CostPerCycleTextbox.Text);
                TargetRate.UnitRef = Convert.ToInt32(_UnitList.SelectedValue);
                TargetRate.Description = _DescriptionTextbox.Text;
                DataConnector.DwsNoRepData.Update(TargetRate);
            }
            else
            {
                BopsRfsStorageRate NewRate = new BopsRfsStorageRate();
                NewRate.BillToClientRef = Convert.ToInt32(_BillToClientList.SelectedValue);
                NewRate.BillingType = (RfsStorageBillingType)Convert.ToInt32(_BillingTypeList.SelectedValue);
                NewRate.DaysInCycle = Convert.ToInt32(_DaysInCycleTextbox.Text);
                NewRate.UnitCostPerCycle = Convert.ToDouble(_CostPerCycleTextbox.Text);
                NewRate.UnitRef = Convert.ToInt32(_UnitList.SelectedValue);
                NewRate.Description = _DescriptionTextbox.Text;
                DataConnector.DwsNoRepData.Save(NewRate);
            }

            Tx.Commit();
            RedirectPage = "RfsStorageBillingRates.aspx";
        }
        catch(Exception E1)
        {
            _Log.Error("An error occurred while editing/adding a storage rate.", E1);
            Tx.Rollback();
        }
        finally
        {
            DataConnector.CloseSessions();
        }

        if (RedirectPage != null)
            Context.Response.Redirect(RedirectPage);
    }
}
