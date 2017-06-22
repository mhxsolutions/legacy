using System;
using System.IO;
using BopsDataAccess;
using BopsDataConnector;
using log4net;

public partial class Customers__All_InvoiceDisplay : System.Web.UI.Page
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Customers__All_InvoiceDisplay));

    protected void Page_Load(object Sender, EventArgs E)
    {
        int InvoiceId;
        if ((Request.Params["InvoiceId"] == null) || !int.TryParse(Request.Params["InvoiceId"], out InvoiceId))
        {
            _Log.Error("No invoice number provided.");
            return;
        }

        IBopsDataConnector Connector = BopsDataConnectorFactory.GetDataConnector();

        try
        {
            BopsRfsInvoice Invoice = Connector.DwsNoRepData.Get<BopsRfsInvoice>(InvoiceId);

            if (Invoice != null)
            {
                // Make sure that the user is authorized to view the invoice.

                if (!SessionUserIsAuthorizedForInvoice(Connector, Invoice))
                    return;

                string Filename = Path.Combine(Invoice.DocumentFolder, Invoice.DocumentFileName);
                if (!File.Exists(Filename)) return;

                Response.Clear();
                Response.ClearHeaders();
                Response.ClearContent();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + Invoice.DocumentFileName);
                Response.ContentType = "application/pdf";
                Response.Flush();
                Response.WriteFile(Filename);
            }
        }
        catch (Exception E1)
        {
            _Log.ErrorFormat("An exception occurred while attempting to display invoice {0}. Details follow.", InvoiceId);
            _Log.Error(E1);
        }
        finally
        {
            Connector.CloseSessions();
        }
    }

    private bool SessionUserIsAuthorizedForInvoice(IBopsDataConnector Connector, BopsRfsInvoice Invoice)
    {
        // If the user is a Budway-appointed administrator or power user, permission is granted for any load.

        if (User.IsInRole("Administrators") || User.IsInRole("Power Users"))
            return true;

        if (Session[_ContextClientId] != null)
        {
            int ClientId = Convert.ToInt32(Session[_ContextClientId]);

            // If the user is a Budway employee, permission is granted for any load.

            if (ClientId == _BudwayDestinationId)
                return true;

            // If the bill-to matches the user's client ID, then permission is granted.

            if (ClientId == Invoice.BillToRef)
                return true;
        }

        return false;
    }
}
