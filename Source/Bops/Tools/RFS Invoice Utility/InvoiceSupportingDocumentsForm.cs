using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Reflection;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class InvoiceSupportingDocumentsForm : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(InvoiceSupportingDocumentsForm));

        private readonly int _invoiceId;

        private IList<BopsRfsServiceCalculationResult> _results;
        ListViewComparerFactory _documentsCompareFactory;

        private int _resultsWithoutDocuments;
        private int _filesNotFound;

        public InvoiceSupportingDocumentsForm(int invoiceId)
        {
            _invoiceId = invoiceId;

            InitializeComponent();
        }

        private void InvoiceSupportingDocumentsForm_Load(object sender, EventArgs e)
        {
            Text = string.Format("Invoice {0} Supporting Documents", _invoiceId);

            PopulateSupportingDocumentsListview();
        }

        private void CacheServiceCalculationResults(IRfsDataContext rfsDataContext)
        {
            var details = rfsDataContext.GetInvoiceDetailsByInvoiceId(_invoiceId);

            var idCount = 0;
            var resultIds = new int[details.Count];
            foreach (var detail in details)
            {
                if (detail.IsServiceBill)
                    resultIds[idCount++] = detail.ServiceCalculationResultRef.Value;
            }

            if (idCount <= 0) return;

            if (idCount != resultIds.Length)
                Array.Resize(ref resultIds, idCount);

            _results = rfsDataContext.GetServiceCalculationResultsByIds(resultIds);
        }

        IList<BopsScan> GetCalculationResultPodScans(IRfsDataContext rfsDataContext)
        {
            if (_results != null)
            {
                var loadCount = 0;
                var loadRefs = new string[_results.Count];
                foreach (var result in _results)
                {
                    if (result.IsLoad)
                        loadRefs[loadCount++] = result.LoadRef;
                }

                if (loadCount > 0)
                {
                    var scans = rfsDataContext.GetScansByDocumentIdsSignedAndReject(loadRefs, true, 0);

                    // Sadly, the process that records the scans in the database often provides multiple
                    // records for the same PDF file. As such, we need to filter the list. It's completely
                    // arbitrary which records get pruned, but it's better than dying like Buridan's ass.

                    var lookup = new Dictionary<string, BopsScan>();

                    foreach (var scan in scans)
                    {
                        if (!lookup.ContainsKey(scan.CombinedFileName))
                            lookup.Add(scan.CombinedFileName, scan);
                    }

                    return new List<BopsScan>(lookup.Values);
                }
            }

            return null;
        }

        private void AddRowToListview(BopsRfsServiceCalculationResult result, BopsScan scan)
        {
            if (!result.IsLoad) return;

            var newItem = new ListViewItem("Load");
            newItem.SubItems.Add(result.LoadRef);

            if (scan != null)
            {
                newItem.SubItems.Add("POD");

                if (File.Exists(scan.CombinedFileName))
                {
                    newItem.SubItems.Add(scan.FileName);
                    newItem.Tag = scan;
                }
                else
                {
                    newItem.SubItems.Add(string.Format("File not found: {0}", scan.FileName));
                    newItem.BackColor = Color.LightCoral;
                    newItem.Tag = null;
                    _filesNotFound++;
                }
            }
            else
            {
                newItem.SubItems.Add("No document found");
                newItem.SubItems.Add("N/A");
                newItem.BackColor = Color.Yellow;
                newItem.Tag = null;
                _resultsWithoutDocuments++;
            }

            SupportingDocumentsListview.Items.Add(newItem);
        }

        private void PopulateSupportingDocumentsListview()
        {
            // Columns:
            //
            //  0   Billing Document Type
            //  1   Billing Document ID
            //  2   Document Type
            //  3   Document File Name

            _filesNotFound = 0;
            _resultsWithoutDocuments = 0;
            _documentsCompareFactory = new ListViewComparerFactory(4);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                CacheServiceCalculationResults(rfsDataContext);
                var podScans = GetCalculationResultPodScans(rfsDataContext);

                SupportingDocumentsListview.Items.Clear();
                SupportingDocumentsListview.SuspendLayout();

                foreach (var result in _results)
                {
                    if (!result.IsLoad) continue;

                    var matchingScans = new List<BopsScan>();
                    foreach (var scan in podScans)
                    {
                        if (String.Compare(result.LoadRef, scan.LoadRef, System.StringComparison.OrdinalIgnoreCase) == 0)
                            matchingScans.Add(scan);
                    }

                    if (matchingScans.Count > 0)
                    {
                        foreach (var scan in matchingScans)
                            AddRowToListview(result, scan);
                    }
                    else
                    {
                        AddRowToListview(result, null);
                    }
                }

                foreach (ColumnHeader hdr in SupportingDocumentsListview.Columns)
                    hdr.Width = -2;
                SupportingDocumentsListview.ResumeLayout();
            }
            catch (Exception ex)
            {
                Log.Error("Couldn't populate supporting documents listview.", ex);
            }
            finally
            {
                // TODO: free the RFS data context
            }
       }

        private void SupportingDocumentsListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (SupportingDocumentsListview.Items.Count <= 0) return;
            SupportingDocumentsListview.ListViewItemSorter = _documentsCompareFactory.CreateComparerForColumn(e.Column);
            SupportingDocumentsListview.Sort();
        }

        private void OpenSelectedButton_Click(object sender, EventArgs e)
        {
            if (SupportingDocumentsListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select a single document to view.");
                return;
            }

            var selectedScan = SupportingDocumentsListview.SelectedItems[0].Tag as BopsScan;
            if (selectedScan == null)
            {
                MessageHelper.ShowInvalidOperation("The selected row refers to a document that doesn't exist or whose file could not be found.");
                return;
            }

            // If we've made it this far, then we have a single row selected that has a valid scan.

            Process.Start(selectedScan.CombinedFileName);
        }

        private void OpenMergedButton_Click(object sender, EventArgs e)
        {
            if (SupportingDocumentsListview.Items.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("There are no documents to merge and open.");
                return;
            }

            var sourceFileCount = 0;
            var sourceFileNames = new string[SupportingDocumentsListview.Items.Count];

            foreach (ListViewItem lvi in SupportingDocumentsListview.Items)
            {
                var scan = lvi.Tag as BopsScan;
                if (scan != null)
                {
                    if (File.Exists(scan.CombinedFileName))
                        sourceFileNames[sourceFileCount++] = scan.CombinedFileName;
                }
            }

            if (sourceFileCount < 1)
            {
                MessageHelper.ShowInvalidOperation("There are no documents to merge and open.");
                return;
            }

            if (sourceFileCount != sourceFileNames.Length)
                Array.Resize(ref sourceFileNames, sourceFileCount);

            var applicationPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetModules()[0].FullyQualifiedName);
            var fileNameToOpen = Path.Combine(applicationPath, "DocumentsLastMerged.pdf");

            if (sourceFileCount == 1)
                fileNameToOpen = sourceFileNames[0];
            else
                PdfMerger.MergeFiles(fileNameToOpen, sourceFileNames);

            Process.Start(fileNameToOpen);
        }
    }
}