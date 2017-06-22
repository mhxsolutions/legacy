using System;
using System.Web;
using BopsDataAccess;
using BopsDataConnector;
using log4net;
using NHibernate;

public partial class RFS_RfsStorageBillingEditAssignment : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(RFS_RfsStorageBillingEditAssignment));

    protected void Page_Load(object Sender, EventArgs E)
    {
        // Necessary to ensure that the page options get set correctly every time, even when the
        // back/forward buttons are used for navigation.

        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            string Mode = Request.QueryString["mode"];

            if (Mode.ToLower() == "edit")
            {
                IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

                try
                {
                    int AssignmentId = Convert.ToInt32(Request.QueryString["AssignmentId"]);
                    BopsRfsStorageRateAssignment TargetAssignment = DataConnector.DwsNoRepData.Get<BopsRfsStorageRateAssignment>(AssignmentId);

                    _RateList.SelectedValue = TargetAssignment.StorageRateRef.ToString();
                    _ProfileList.SelectedValue = TargetAssignment.ProfileRef.ToString();
                    _BeginDateTextbox.Text = TargetAssignment.BeginDate.ToString("d");
                    _EndDateTextbox.Text = TargetAssignment.EndDate.ToString("d");
                    _DescriptionTextbox.Text = TargetAssignment.Description;

                    _SaveButton.Text = "Update Rate";
                }
                finally
                {
                    DataConnector.CloseSessions();
                }
            }
            else
            {
                _BeginDateTextbox.Text = DateTime.Now.ToString("d");            // Default begins today
                _EndDateTextbox.Text = DateTime.Now.AddYears(1).ToString("d");  // Default ends one year from today
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
            DateTime NewDateTime;

            if (Mode.ToLower() == "edit")
            {
                int AssignmentId = Convert.ToInt32(Request.QueryString["AssignmentId"]);
                BopsRfsStorageRateAssignment TargetAssignment = DataConnector.DwsNoRepData.Get<BopsRfsStorageRateAssignment>(AssignmentId);

                TargetAssignment.StorageRateRef = Convert.ToInt32(_RateList.SelectedValue);
                TargetAssignment.ProfileRef = Convert.ToInt32(_ProfileList.SelectedValue);
                DateTime.TryParse(_BeginDateTextbox.Text, out NewDateTime);
                TargetAssignment.BeginDate = NewDateTime;
                DateTime.TryParse(_EndDateTextbox.Text, out NewDateTime);
                TargetAssignment.EndDate = NewDateTime;
                TargetAssignment.Description = _DescriptionTextbox.Text;

                DataConnector.DwsNoRepData.Update(TargetAssignment);
            }
            else
            {
                BopsRfsStorageRateAssignment NewAssignment = new BopsRfsStorageRateAssignment();
                NewAssignment.StorageRateRef = Convert.ToInt32(_RateList.SelectedValue);
                NewAssignment.ProfileRef = Convert.ToInt32(_ProfileList.SelectedValue);
                DateTime.TryParse(_BeginDateTextbox.Text, out NewDateTime);
                NewAssignment.BeginDate = NewDateTime;
                DateTime.TryParse(_EndDateTextbox.Text, out NewDateTime);
                NewAssignment.EndDate = NewDateTime;
                NewAssignment.Description = _DescriptionTextbox.Text;

                DataConnector.DwsNoRepData.Save(NewAssignment);
            }

            Tx.Commit();
            RedirectPage = "RfsStorageBillingRates.aspx";
        }
        catch (Exception Ex)
        {
            _Log.Error("An exception occurred adding/editing storage billing rate assignment.", Ex);
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
