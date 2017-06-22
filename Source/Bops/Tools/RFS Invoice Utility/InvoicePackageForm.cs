using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class InvoicePackageForm : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(InvoicePackageForm));

        private Dictionary<int, BopsDestination> _destinationMap;
        private readonly IList<BopsRfsInvoicePackage> _packages;

        private ListViewComparerFactory _invoicesCompareFactory;

        public InvoicePackageForm(IEnumerable<BopsRfsInvoicePackage> packages)
        {
            _packages = new List<BopsRfsInvoicePackage>(packages);

            InitializeComponent();
        }

        private void InvoicePackageForm_Load(object sender, EventArgs e)
        {
            CacheData();
            PopulateListview();
        }

        private void CacheData()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var destinationsNeeded = new Dictionary<int, int>();
                foreach (var package in _packages)
                {
                    if (!destinationsNeeded.ContainsKey(package.Invoice.BillToRef))
                        destinationsNeeded.Add(package.Invoice.BillToRef, 0);
                    if (!destinationsNeeded.ContainsKey(package.Invoice.ShipperRef))
                        destinationsNeeded.Add(package.Invoice.ShipperRef, 0);
                }

                _destinationMap = rfsDataContext.GetDestinationsByIds(destinationsNeeded.Keys.ToArray())
                    .ToDictionary(d => d.DestinationId, d => d);
            }
            catch (Exception ex)
            {
                Log.Error("An exception occurred while caching data. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context
            }
        }

        private void PopulateListview()
        {
            // Columns:
            //
            //  0   ID
            //  1   Date
            //  2   Bill-To
            //  3   Revenue

            _invoicesCompareFactory = new ListViewComparerFactory(7);
            _invoicesCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _invoicesCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _invoicesCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            _InvoicesListview.Items.Clear();
            _InvoicesListview.SuspendLayout();

            foreach (var package in _packages)
            {
                var newItem = new ListViewItem(package.Invoice.InvoiceId.ToString());
                newItem.SubItems.Add(package.Invoice.InvoiceDate.ToString("d"));
                newItem.SubItems.Add(_destinationMap[package.Invoice.BillToRef].ToString());
                newItem.SubItems.Add(string.Format("{0:c}", package.Invoice.InvoiceTotal));
                newItem.Tag = package;

                _InvoicesListview.Items.Add(newItem);
            }

            foreach (ColumnHeader hdr in _InvoicesListview.Columns)
                hdr.Width = -2;
            _InvoicesListview.ResumeLayout();
        }

        private void _InvoicesListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (_InvoicesListview.Items.Count <= 0) return;

            _InvoicesListview.ListViewItemSorter = _invoicesCompareFactory.CreateComparerForColumn(e.Column);
            _InvoicesListview.Sort();
        }

        private void _CopyButton_Click(object sender, EventArgs e)
        {
            try
            {
                ListViewExportUtility.ExportToClipboard(_InvoicesListview, true, false);
                MessageBox.Show("Data copied to clipboard successfully.", "Success");
            }
            catch (Exception Exception)
            {
                Log.Error("An error occurred copying the invoice package to the clipboard. Details follow.", Exception);
                MessageHelper.ShowError("An error occurred while copying the data to the clipboard. Please contact IT support.");
            }
        }

        private static string GetExportFileName()
        {
            var saveDialog = new SaveFileDialog();
            saveDialog.DefaultExt = "csv";
            saveDialog.Filter = "CSV files (*.csv)|*.csv|All files (*.*)|*.*";
            saveDialog.FileName = string.Format("RFS Storage Billing Invoices {0:yyyy-MM-dd HH-mm-ss}.csv", DateTime.Now);
            return saveDialog.ShowDialog() == DialogResult.OK ? saveDialog.FileName : null;
        }

        private void _SaveButton_Click(object sender, EventArgs e)
        {
            try
            {
                var exportFileName = GetExportFileName();
                if (exportFileName == null)
                    return;
                ListViewExportUtility.ExportDelimitedFile(_InvoicesListview, true, false, ",", exportFileName);
                MessageBox.Show("Data exported to file successfully.", "Success");
            }
            catch (Exception Exception)
            {
                Log.Error("An error occurred saving the invoice package to a file. Details follow.", Exception);
                MessageHelper.ShowError("An error occurred while exporting the data to a file. Please contact IT support.");
            }
        }
    }
}
