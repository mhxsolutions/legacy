using System;
using System.Collections.Generic;
using System.Windows.Forms;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class StorageBillingHistoryForm : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(StorageBillingHistoryForm));

        private BopsRfsStorageBilling _lastBilling;
        private IList<BopsRfsStorageBilling> _billings;
        private ListViewComparerFactory _billingsCompareFactory;

        public bool RolledBack { get; private set; }

        public StorageBillingHistoryForm()
        {
            InitializeComponent();
            RolledBack = false;
        }

        private void LoadBillingData()
        {
            _billings = null;
            var success = true;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var sbc = RfsFactory.GetRfsStorageBillingCalculator();

            try
            {
                _lastBilling = sbc.GetLastStorageBilling(rfsDataContext);
                RollbackButton.Enabled = (_lastBilling != null && !_lastBilling.DateInvoiced.HasValue);
                _billings = rfsDataContext.GetStorageBillings();
            }
            catch (Exception E1)
            {
                Log.Error("An error occurred while loading storage billings. Details follow.", E1);
                success = false;
            }
            finally
            {
                // TODO: free RFS data context
            }

            if (!success)
                MessageHelper.ShowError("An error occurred while loading storage billings. Please contact IT support.");
        }

        private void PopulateBillingsListview()
        {
            // Columns:
            //
            //  0   Id
            //  1   Date Generated
            //  2   User Id
            //  3   Date Billed Through
            //  4   Total Items
            //  5   Total Revenue
            //  6   Date Invoiced

            _billingsCompareFactory = new ListViewComparerFactory(7);
            _billingsCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _billingsCompareFactory[0].SortDirection = ListViewComparerFactory.ColumnSortDirection.Descending;
            _billingsCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _billingsCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _billingsCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _billingsCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Currency;
            _billingsCompareFactory[6].SortType = ListViewComparerFactory.ColumnSortType.Date;

            BillingsListview.Items.Clear();
            BillingsListview.SuspendLayout();

            foreach (var billing in _billings)
            {
                var newItem = new ListViewItem(billing.BillingId.ToString());
                newItem.SubItems.Add(billing.DateGenerated.ToString("d"));
                newItem.SubItems.Add(billing.UserId);
                newItem.SubItems.Add(billing.DateBilledThrough.ToString("d"));
                newItem.SubItems.Add(billing.TotalItemsProcessed.ToString());
                newItem.SubItems.Add(string.Format("{0:c}", billing.TotalRevenue));
                newItem.SubItems.Add(billing.DateInvoiced.HasValue ? billing.DateInvoiced.Value.ToString("d") : string.Empty);
                newItem.Tag = billing;

                BillingsListview.Items.Add(newItem);
            }

            // Reverse sort the list by billing ID by default.

            BillingsListview.ListViewItemSorter = _billingsCompareFactory.CreateComparerForColumn(0);
            BillingsListview.Sort();

            foreach (ColumnHeader hdr in BillingsListview.Columns)
                hdr.Width = -2;
            BillingsListview.ResumeLayout();
        }

        private void StorageBillingHistoryForm_Load(object sender, EventArgs e)
        {
            LoadBillingData();
            PopulateBillingsListview();
        }

        private void BillingsListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (BillingsListview.Items.Count <= 0) return;

            BillingsListview.ListViewItemSorter = _billingsCompareFactory.CreateComparerForColumn(e.Column);
            BillingsListview.Sort();
        }

        private void RollbackButton_Click(object sender, EventArgs e)
        {
            if (_lastBilling == null)
            {
                MessageHelper.ShowError("No last storage billing found.");
                return;
            }

            if (_lastBilling.DateInvoiced.HasValue)
            {
                MessageHelper.ShowInvalidOperation("The last storage billing is already invoiced; it cannot be rolled back.");
                return;
            }

            if (MessageHelper.ShowConfirm("Are you sure you want to roll back the last storage billing?") != DialogResult.Yes)
                return;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var sbc = RfsFactory.GetRfsStorageBillingCalculator();

            try
            {
                sbc.RollBackLastStorageBilling(rfsDataContext);
                RolledBack = true;
            }
            finally
            {
                // TODO: free the RFS data context
            }

            LoadBillingData();
            PopulateBillingsListview();
        }
    }
}
