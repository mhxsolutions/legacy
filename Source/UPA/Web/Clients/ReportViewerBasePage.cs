using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Clients
{
    public class ReportViewerBasePage : System.Web.UI.Page
    {
        private const string _ContextClientId = "CONTEXT_CLIENTID";

        protected int? ContextClientID
        {
            get
            {
                return Session[_ContextClientId] != null ? (int?)Session[_ContextClientId] : null; 
            }
        }

        protected string GetReportFullPath(string filename)
        {
            return HttpContext.Current.Server.MapPath("~/rdlc/" + filename);
        }
    }
}