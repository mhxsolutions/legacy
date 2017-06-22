using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUtilities;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class StorageBillingSummaryForm : Form
    {
        #region Helper Classes
        private class StorageSummaryItem
        {
            public StorageSummaryItem(int profile, int billToClientRef, int totalItems, double totalRevenue)
            {
                Profile = profile;
                BillToClientRef = billToClientRef;
                TotalItems = totalItems;
                TotalRevenue = totalRevenue;
            }

            public int Profile { get; private set; }

            public int BillToClientRef { get; private set; }

            public int TotalItems { get; set; }

            public double TotalRevenue { get; set; }
        }
        #endregion

        private readonly RfsStorageBillingResult _result;
        private Dictionary<int, BopsDestination> _clientMap;
        private Dictionary<int, BopsProductProfile> _profileMap;
        private ListViewComparerFactory _storageSummaryCompareFactory;
        private ListViewComparerFactory _storageDetailsCompareFactory;
        private bool _uiEnabled;

        public StorageBillingSummaryForm(RfsStorageBillingResult result)
        {
            InitializeComponent();
            _result = result;
        }

        private void EnableUi(bool enableUi)
        {
            Enabled = enableUi;
            Cursor = enableUi ? Cursors.Default : Cursors.WaitCursor;
            _uiEnabled = enableUi;
        }

        private void StorageBillingSummaryForm_Load(object sender, EventArgs e)
        {
            EnableUi(false);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                PopulateStorageListviews(rfsDataContext);
            }
            finally
            {
                // TODO: free the RFS data context
                EnableUi(true);
            }
        }

        private void AddSummaryLineToStorageSummaryListview(int totalItems, double totalRevenue)
        {
            var newItem = new ListViewItem("(all)");
            newItem.SubItems.Add("(all)");
            newItem.SubItems.Add("(all)");
            newItem.SubItems.Add(totalItems.ToString());
            newItem.SubItems.Add(string.Format("{0:c}", totalRevenue));

            newItem.Selected = true;
            _StorageSummaryListview.Items.Add(newItem);
        }

        private void PopulateStorageListviews(IRfsDataContext rfsDataContext)
        {
            _StorageSummaryListview.Items.Clear();
            _StorageSummaryListview.SuspendLayout();

            _StorageDetailsListview.Items.Clear();
            _StorageDetailsListview.SuspendLayout();

            CacheStorageBillingDetails(rfsDataContext, _result);

            var totalItems = 0;
            var totalRevenue = 0.0;

            // Details listview columns:
            //
            //  0   Inventory Id
            //  1   Receiver Id
            //  2   Profile Id
            //  3   Quantity
            //  4   Cycles
            //  5   Revenue
            //  6   Details

            _storageDetailsCompareFactory = new ListViewComparerFactory(7);
            _storageDetailsCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _storageDetailsCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _storageDetailsCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _storageDetailsCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Double;
            _storageDetailsCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Double;
            _storageDetailsCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            var summary = new Dictionary<string, StorageSummaryItem>();

            foreach (var item in _result.Items)
            {
                // Fetch the objects.

                var profile = _profileMap[item.Receiver.ProductProfileRef.Value];

                // Update the summary row.

                var summaryKey = string.Format("{0}:{1}", profile.ProfileId, item.BillingDetail.BillToClientRef);

                if (summary.ContainsKey(summaryKey))
                {
                    var summaryItem = summary[summaryKey];
                    summaryItem.TotalRevenue += item.BillingDetail.Revenue;
                    summaryItem.TotalItems++;
                }
                else
                {
                    summary.Add(summaryKey, new StorageSummaryItem(profile.ProfileId, item.BillingDetail.BillToClientRef, 1, item.BillingDetail.Revenue));
                }

                // Add the item to the detail listview.

                var newItem = new ListViewItem(item.BillingDetail.InventoryRef.ToString());
                newItem.SubItems.Add(item.InventoryDetail.ReceiverRef.ToString());
                newItem.SubItems.Add(profile.ProfileId.ToString());
                newItem.SubItems.Add(item.BillingDetail.Quantity.ToString());
                newItem.SubItems.Add(item.BillingDetail.CyclesBilled.ToString("N2"));
                newItem.SubItems.Add(string.Format("{0:c}", item.BillingDetail.Revenue));
                newItem.SubItems.Add(item.BillingDetail.PublicDetails);

                _StorageDetailsListview.Items.Add(newItem);

                totalRevenue += item.BillingDetail.Revenue;
                totalItems++;
            }

            // Summary listview columns
            //
            //  0   Profile
            //  1   Bill-to Client
            //  2   Description
            //  3   Items
            //  4   Revenue

            _storageSummaryCompareFactory = new ListViewComparerFactory(7);
            _storageSummaryCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _storageSummaryCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _storageSummaryCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _storageSummaryCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            AddSummaryLineToStorageSummaryListview(totalItems, totalRevenue);

            foreach (var pair in summary)
            {
                var profile = _profileMap[pair.Value.Profile];

                var newItem = new ListViewItem(pair.Value.Profile.ToString());
                newItem.SubItems.Add(_clientMap[pair.Value.BillToClientRef].ToString());
                newItem.SubItems.Add(profile.ProductClassDescription);
                newItem.SubItems.Add(pair.Value.TotalItems.ToString());
                newItem.SubItems.Add(string.Format("{0:c}", pair.Value.TotalRevenue));
                newItem.Tag = pair.Value;

                _StorageSummaryListview.Items.Add(newItem);
            }

            _StorageSummaryListview.ListViewItemSorter = _storageSummaryCompareFactory.CreateComparerForColumn(0);
            _StorageSummaryListview.Sort();

            foreach (ColumnHeader hdr in _StorageDetailsListview.Columns)
                hdr.Width = -2;
            _StorageDetailsListview.ResumeLayout();

            foreach (ColumnHeader hdr in _StorageSummaryListview.Columns)
                hdr.Width = -2;
            _StorageSummaryListview.ResumeLayout();
        }

        private void PopulateFilteredStorageDetailList()
        {
            // This is a guard against all the calls that will occur while populating.

            if (!_uiEnabled)
                return;

            _StorageDetailsListview.Items.Clear();
            _StorageDetailsListview.SuspendLayout();

            // If there is no selected item, then merely make sure the listview is empty.

            if (_StorageSummaryListview.SelectedItems.Count == 0)
            {
                _StorageDetailsListview.ResumeLayout();
                return;
            }

            // Otherwise, we need to show some or all of the items.

            var profileFilter = 0;
            var clientFilter = 0;

            if (_StorageSummaryListview.SelectedItems.Count == 1)
            {
                var summary = _StorageSummaryListview.SelectedItems[0].Tag as StorageSummaryItem;
                if (summary != null)
                {
                    profileFilter = summary.Profile;
                    clientFilter = summary.BillToClientRef;
                }
            }

            //foreach (BopsRfsStorageBillingDetail Detail in _StorageDetails)
            for (var i = 0; i < _result.Items.Count; i++)
            {

                var item = _result.Items[i];

                // Fetch the objects.

                var profile = _profileMap[item.Receiver.ProductProfileRef.Value];

                // Skip the item if it fails to match the filter.

                if (profileFilter != 0 && profileFilter != profile.ProfileId)
                    continue;
                if (clientFilter != 0 && clientFilter != item.BillingDetail.BillToClientRef)
                    continue;

                // Otherwise, add the item to the detail listview.

                var newItem = new ListViewItem(item.BillingDetail.InventoryRef.ToString(CultureInfo.InvariantCulture));
                newItem.SubItems.Add(item.InventoryDetail.ReceiverRef.ToString());
                newItem.SubItems.Add(profile.ProfileId.ToString(CultureInfo.InvariantCulture));
                newItem.SubItems.Add(item.BillingDetail.Quantity.ToString(CultureInfo.InvariantCulture));
                newItem.SubItems.Add(item.BillingDetail.CyclesBilled.ToString(CultureInfo.InvariantCulture));
                newItem.SubItems.Add(string.Format("{0:c}", item.BillingDetail.Revenue));
                newItem.SubItems.Add(item.BillingDetail.PublicDetails);

                _StorageDetailsListview.Items.Add(newItem);
            }

            foreach (ColumnHeader hdr in _StorageDetailsListview.Columns)
                hdr.Width = -2;
            _StorageDetailsListview.ResumeLayout();
        }

        private void CacheStorageBillingDetails(IRfsDataContext rfsDataContext, RfsStorageBillingResult result)
        {
            // Use the receivers to get the corresponding product profiles.

            var profileIds = new Dictionary<int, int>();
            foreach (var item in result.Items)
            {
                if (!profileIds.ContainsKey(item.Receiver.ProductProfileRef.Value))
                    profileIds.Add(item.Receiver.ProductProfileRef.Value, 0);
            }

            _profileMap = rfsDataContext.GetProductProfilesByIDs(profileIds.Keys.ToArray())
                .ToDictionary(p => p.ProfileId, p => p);

            var clientIds = new Dictionary<int, int>();

            foreach (var detail in _result.Items)
            {
                if (clientIds.ContainsKey(detail.BillingDetail.BillToClientRef))
                    continue;
                clientIds.Add(detail.BillingDetail.BillToClientRef, 0);
            }

            _clientMap = rfsDataContext.GetDestinationsByIds(clientIds.Keys.ToArray())
                .ToDictionary(d => d.DestinationId, d => d);
        }

        private void _StorageSummaryListview_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            PopulateFilteredStorageDetailList();
        }

        private void _StorageSummaryListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (_StorageSummaryListview.Items.Count <= 0) return;

            _StorageSummaryListview.ListViewItemSorter = _storageSummaryCompareFactory.CreateComparerForColumn(e.Column);
            _StorageSummaryListview.Sort();
        }

        private void _StorageDetailsListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (_StorageDetailsListview.Items.Count <= 0) return;

            _StorageDetailsListview.ListViewItemSorter = _storageDetailsCompareFactory.CreateComparerForColumn(e.Column);
            _StorageDetailsListview.Sort();
        }
    }
}
