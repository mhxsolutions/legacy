using System;
using System.Collections.Generic;
using System.IO;
using BopsDataAccess;
using BopsDataConnector;
using BopsUtilities;
using NHibernate.Criterion;
using log4net;

public partial class Customers__All_InvoiceSupportingDocumentsDisplay : System.Web.UI.Page
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Customers__All_InvoiceSupportingDocumentsDisplay));

    protected void Page_Load(object Sender, EventArgs E)
    {
        int InvoiceId;
        if ((Request.Params["InvoiceId"] == null) || !int.TryParse(Request.Params["InvoiceId"], out InvoiceId))
        {
            _Log.Error("No invoice number provided.");
            return;
        }

        if (Request == null || string.IsNullOrEmpty(Request.PhysicalApplicationPath))
        {
            _Log.Error("Can't get physical application path to find temp folder");
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

                string TempFolder = Path.Combine(Request.PhysicalApplicationPath, "Temp");
                string FileName = string.Format("Invoice {0} Supporting Documents.pdf", Invoice.InvoiceId);
                string OutputFileName = Path.Combine(TempFolder, FileName);
                OutputFileName = MergeSupportingDocuments(Connector, Invoice, OutputFileName);

                if (string.IsNullOrEmpty(OutputFileName) || !File.Exists(OutputFileName)) return;

                Response.Clear();
                Response.ClearHeaders();
                Response.ClearContent();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + FileName);
                Response.ContentType = "application/pdf";
                Response.Flush();
                Response.WriteFile(OutputFileName);
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

    private static IList<BopsRfsServiceCalculationResult> GetServiceCalculationResults(IBopsDataConnector Connector, int InvoiceId)
    {
        IList<BopsRfsInvoiceDetail> Details = Connector.DwsNoRepData.CreateCriteria(typeof(BopsRfsInvoiceDetail))
            .Add(Expression.Eq("InvoiceRef", InvoiceId))
            .List<BopsRfsInvoiceDetail>();

        int IdCount = 0;
        int[] ResultIds = new int[Details.Count];
        foreach (BopsRfsInvoiceDetail Detail in Details)
        {
            if (Detail.ServiceCalculationResultRef.HasValue)
                ResultIds[IdCount++] = Detail.ServiceCalculationResultRef.Value;
        }

        if (IdCount <= 0) return null;

        if (IdCount != ResultIds.Length)
            Array.Resize(ref ResultIds, IdCount);

        return Connector.DwsNoRepData.CreateCriteria(typeof(BopsRfsServiceCalculationResult))
             .Add(Expression.In("ResultId", ResultIds))
             .List<BopsRfsServiceCalculationResult>();
    }


    static IList<BopsScan> GetCalculationResultPodScans(IBopsDataConnector Connector, ICollection<BopsRfsServiceCalculationResult> Results)
    {
        if (Results == null) return null;

        int LoadCount = 0;
        string[] LoadRefs = new string[Results.Count];
        foreach (BopsRfsServiceCalculationResult Result in Results)
        {
            if (Result.IsLoad)
                LoadRefs[LoadCount++] = Result.LoadRef;
        }

        if (LoadCount < 1) return null;

        IList<BopsScan> Scans = Connector.DwsNoRepData.CreateCriteria(typeof(BopsScan))
            .Add(Expression.In("LoadRef", LoadRefs))
            .Add(Expression.Eq("Comment", "POD"))
            .Add(Expression.Eq("Signed", true))
            .Add(Expression.Eq("RejectRef", 0))
            .List<BopsScan>();

        // Sadly, the process that records the scans in the database often provides multiple
        // records for the same PDF file. As such, we need to filter the list. It's completely
        // arbitrary which records get pruned, but it's better than dying like Buridan's ass.

        Dictionary<string, BopsScan> Lookup = new Dictionary<string, BopsScan>();

        foreach (BopsScan Scan in Scans)
        {
            if (!Lookup.ContainsKey(Scan.CombinedFileName))
                Lookup.Add(Scan.CombinedFileName, Scan);
        }

        return new List<BopsScan>(Lookup.Values);
    }


    private static string MergeSupportingDocuments(IBopsDataConnector Connector, BopsRfsInvoice Invoice, string OutputFileName)
    {
        IList<BopsRfsServiceCalculationResult> Results = GetServiceCalculationResults(Connector, Invoice.InvoiceId);
        if (Results == null) return null;

        IList<BopsScan> Scans = GetCalculationResultPodScans(Connector, Results);
        if (Scans == null) return null;

        if (Scans.Count < 1) return null;

        int SourceFileCount = 0;
        string[] SourceFileNames = new string[Scans.Count];

        foreach (BopsScan Scan in Scans)
        {
            if (Scan == null) continue;

            if (File.Exists(Scan.CombinedFileName))
                SourceFileNames[SourceFileCount++] = Scan.CombinedFileName;
        }

        if (SourceFileCount < 1) return null;
        if (SourceFileCount != SourceFileNames.Length)
            Array.Resize(ref SourceFileNames, SourceFileCount);

        if (SourceFileCount == 1)
            OutputFileName = SourceFileNames[0];
        else
            PdfMerger.MergeFiles(OutputFileName, SourceFileNames);

        return OutputFileName;
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
