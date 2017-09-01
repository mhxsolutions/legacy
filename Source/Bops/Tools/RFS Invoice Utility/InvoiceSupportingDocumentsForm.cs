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
            Text = $"Invoice {_invoiceId} Supporting Documents";
            PopulateSupportingDocumentsListview();
        }

        private void AddRowToListview(BopsScan scan)
        {
            string typeString;
            if (scan.IsReceiverScan)
                typeString = "Receiver";
            else if (scan.IsBillOfLadingScan)
                typeString = "BOL";
            else
                typeString = "Load";

            var newItem = new ListViewItem(typeString);

            newItem.SubItems.Add(scan.DocScanned);

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

            SupportingDocumentsListview.Items.Add(newItem);
        }

        private void PopulateSupportingDocumentsListview()
        {
            // Columns:
            //
            //  0   Billing Document Type
            //  1   Billing Document ID
            //  2   Document File Name

            _filesNotFound = 0;
            _resultsWithoutDocuments = 0;
            _documentsCompareFactory = new ListViewComparerFactory(3);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var scans = rfsDataContext.GetInvoiceSupportingDocuments(_invoiceId);

                SupportingDocumentsListview.Items.Clear();
                SupportingDocumentsListview.SuspendLayout();

                foreach (var scan in scans)
                {
                    AddRowToListview(scan);
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