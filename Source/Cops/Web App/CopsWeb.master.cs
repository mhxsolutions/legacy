using System;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Web_App
{
    public partial class CopsWeb : System.Web.UI.MasterPage
    {
        private const string ContextClientId = "CONTEXT_CLIENTID";

        public HtmlGenericControl BodyControl
        {
            get { return Body; }
        }

        public Menu TreeViewControl
        {
            get { return _TopMenu; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            if (Session[ContextClientId] == null) return;

            var clientId = Convert.ToInt32(Session[ContextClientId]);
            try
            {
                var rfsDataContext = TemporaryKernel.GetRfsDataContext();
                var client = rfsDataContext.GetDestinationById(clientId);
                _UserLabel.Text = client.ToString();
            }
            finally
            {
                // TODO: free the data context
            }
        }
    }
}