using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class CreateInvoiceFromStorageBills : Form
    {
        #region Helper Classes
        private class StorageSummaryItem
        {
            private readonly int _billToClientRef;

            public StorageSummaryItem(int billToClientRef, int totalItems, double totalRevenue)
            {
                _billToClientRef = billToClientRef;
                TotalItems = totalItems;
                TotalRevenue = totalRevenue;
            }

            public int BillToClientRef
            {
                get { return _billToClientRef; }
            }

            public int TotalItems { get; set; }

            public double TotalRevenue { get; set; }
        }
        #endregion

        private static readonly ILog Log = LogManager.GetLogger(typeof(CreateInvoiceFromStorageBills));

        private bool _uiEnabled;
        private bool _needToUpdateStatusBarTotals;
        private IList<BopsRfsStorageBillingDetail> _storageDetails;
        private Dictionary<int, BopsDestination> _storageDestinationsMap;
        private Dictionary<int, BopsInventoryDetail> _storageInventoryMap;
        private Dictionary<int, BopsReceivingRecord> _storageReceiverMap;
        private Dictionary<int, BopsProductProfile> _storageProfileMap;
        private Dictionary<int, BopsRfsStorageBilling> _storageBillingMap;
        private ListViewComparerFactory _storageSummaryCompareFactory;
        private ListViewComparerFactory _storageDetailsCompareFactory;
        private readonly EventHandler _idleEventHandler;
        private int _totalItems;
        private double _totalRevenue;

        public CompanyDetails UserCompanyDetails { get; set; }

        public CreateInvoiceFromStorageBills()
        {
            InitializeComponent();

            _needToUpdateStatusBarTotals = false;
            _idleEventHandler = new EventHandler(OnIdle);
            Application.Idle += _idleEventHandler;
        }

        private void EnableUi(bool enableUi)
        {
            Enabled = enableUi;
            Cursor = enableUi ? Cursors.Default : Cursors.WaitCursor;
            _uiEnabled = enableUi;
        }

        private void CreateInvoiceFromStorageBills_Load(object sender, EventArgs e)
        {
            EnableUi(false);
            
            // Initialize a data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                PopulateListviews(rfsDataContext);
            }
            finally
            {
                // TODO: close the RFS data context
                EnableUi(true);
            }
        }

        private void CacheStorageBillingDetails(IRfsDataContext rfsDataContext)
        {
            // BUG: For some weird reason, I can't use the simple .Where technique with an IList of 
            //      BopsRfsStorageBillingDetail objects like I can with every IList of other objects
            //      below. The following code does the same thing, but it would be much simpler to
            //      use the obvious LINQ formulation:
            //
            //      _storageDetails = rfsDataContext.GetStorageBillingDetailsUpToBillingStatus(RfsBillingStatus.OnInvoice)
            //          .Where(d => d.CompanyRef == UserCompanyDetails.Company.CompanyId);
            //
            //      I feel certain there must be something going on here that's worth taking up later.

            // Get the storage billing detail rows.

            _storageDetails = new List<BopsRfsStorageBillingDetail>();
            var rawDetails = rfsDataContext.GetStorageBillingDetailsUpToBillingStatus(RfsBillingStatus.OnInvoice);
            foreach (var detail in rawDetails)
            {
                if (detail.CompanyRef == UserCompanyDetails.Company.CompanyId)
                    _storageDetails.Add(detail);
            }

            if (_storageDetails.Count < 1)
            {
                _storageInventoryMap = new Dictionary<int, BopsInventoryDetail>();
                _storageReceiverMap = new Dictionary<int, BopsReceivingRecord>();
                return;
            }

            // Use the storage billing detail rows to get the corresponding storage billing header records.

            var billingIds = new Dictionary<int, int>();
            foreach (var detail in _storageDetails)
            {
                if (!billingIds.ContainsKey(detail.BillingRef))
                    billingIds.Add(detail.BillingRef, 0);
            }
            var storageBillings = rfsDataContext.GetStorageBillingsByIDs(billingIds.Keys.ToArray());
            _storageBillingMap = storageBillings.ToDictionary(b => b.BillingId, b => b);

            // Use the storage billing detail rows to get the corresponding bill-to clients.

            var destinationIds = new Dictionary<int, int>();
            foreach (var detail in _storageDetails)
            {
                if (!destinationIds.ContainsKey(detail.BillToClientRef))
                    destinationIds.Add(detail.BillToClientRef, 0);
            }
            var destinations = rfsDataContext.GetDestinationsByIds(destinationIds.Keys.ToArray())
                .Where(d => d.CompanyRef == UserCompanyDetails.Company.CompanyId);
            _storageDestinationsMap = destinations.ToDictionary(d => d.DestinationId, d => d);

            // Use the storage billing detail rows to get the corresponding inventory items.

            var inventoryIds = new Dictionary<int, int>();
            foreach (var detail in _storageDetails)
            {
                if (!inventoryIds.ContainsKey(detail.InventoryRef))
                    inventoryIds.Add(detail.InventoryRef, 0);
            }
            var inventoryDetails = rfsDataContext.GetInventoryDetailsByIDs(inventoryIds.Keys.ToArray());
            _storageInventoryMap = inventoryDetails.ToDictionary(i => i.DetailId, i => i);

            // Use the inventory items to get the corresponding receivers.

            var receiversMap = new Dictionary<int, int>();
            foreach (var map in _storageInventoryMap)
            {
                Debug.Assert(map.Value.ReceiverRef.HasValue);

                if (!receiversMap.ContainsKey(map.Value.ReceiverRef.Value))
                    receiversMap.Add(map.Value.ReceiverRef.Value, 1);
            }

            var index = 0;
            var receiverIds = new int[receiversMap.Count];
            foreach (var map in receiversMap)
            {
                receiverIds[index++] = map.Key;
            }
            var receivers = rfsDataContext.GetReceiversByIDs(receiverIds)
                .Where(r => r.CompanyRef == UserCompanyDetails.Company.CompanyId);
            _storageReceiverMap = receivers.ToDictionary(r => r.ReceiverId, r => r);

            // Use the receivers to get the corresponding product profiles.

            var profilesMap = new Dictionary<int, int>();
            foreach (var map in _storageReceiverMap)
            {
                Debug.Assert(map.Value.ProductProfileRef.HasValue);
                if (!profilesMap.ContainsKey(map.Value.ProductProfileRef.Value))
                    profilesMap.Add(map.Value.ProductProfileRef.Value, 1);
            }
            index = 0;
            var profileIds = new int[profilesMap.Count];
            foreach (var map in profilesMap)
            {
                profileIds[index++] = map.Key;
            }
            var productProfiles = rfsDataContext.GetProductProfilesByIDs(profileIds);
            _storageProfileMap = productProfiles.ToDictionary(p => p.ProfileId, p => p);
        }

        private void PopulateListviews(IRfsDataContext rfsDataContext)
        {
            try
            {
                _StorageSummaryListview.SuspendLayout();
                _StorageDetailsListview.SuspendLayout();

                _StorageSummaryListview.Items.Clear();
                _StorageDetailsListview.Items.Clear();

                CacheStorageBillingDetails(rfsDataContext);

                if (_storageDetails.Count < 1)
                    return;

                _StorageSummaryListview.SuspendLayout();
                _StorageDetailsListview.SuspendLayout();

                // Details listview columns:
                //
                //  0   Inventory Id
                //  1   Date
                //  2   Receiver Id
                //  3   Profile Id
                //  4   Quantity
                //  5   Cycles
                //  6   Revenue
                //  7   Details

                _storageDetailsCompareFactory = new ListViewComparerFactory(8);
                _storageDetailsCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
                _storageDetailsCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Date;
                _storageDetailsCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;
                _storageDetailsCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Integer;
                _storageDetailsCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Double;
                _storageDetailsCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Integer;
                _storageDetailsCompareFactory[6].SortType = ListViewComparerFactory.ColumnSortType.Currency;

                var summary = new Dictionary<string, StorageSummaryItem>();

                foreach (var detail in _storageDetails)
                {
                    // Update the summary row.

                    var summaryKey = detail.BillToClientRef.ToString(CultureInfo.InvariantCulture);

                    if (summary.ContainsKey(summaryKey))
                    {
                        var summaryItem = summary[summaryKey];
                        summaryItem.TotalRevenue += detail.Revenue;
                        summaryItem.TotalItems++;
                    }
                    else
                    {
                        summary.Add(summaryKey, new StorageSummaryItem(detail.BillToClientRef, 1, detail.Revenue));
                    }

                    _totalRevenue += detail.Revenue;
                    _totalItems++;
                }

                // Summary listview columns
                //
                //  0   Bill-to Client
                //  1   Items
                //  2   Revenue

                _storageSummaryCompareFactory = new ListViewComparerFactory(3);
                _storageSummaryCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
                _storageSummaryCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Currency;

                foreach (var pair in summary)
                {
                    var newItem = new ListViewItem(_storageDestinationsMap[pair.Value.BillToClientRef].ToString());
                    newItem.SubItems.Add(pair.Value.TotalItems.ToString());
                    newItem.SubItems.Add(string.Format("{0:c}", pair.Value.TotalRevenue));
                    newItem.Tag = pair.Value;

                    _StorageSummaryListview.Items.Add(newItem);
                }

                _StorageSummaryListview.ListViewItemSorter = _storageSummaryCompareFactory.CreateComparerForColumn(0);
                _StorageSummaryListview.Sort();

                foreach (ColumnHeader hdr in _StorageDetailsListview.Columns)
                    hdr.Width = -2;
                foreach (ColumnHeader hdr in _StorageSummaryListview.Columns)
                    hdr.Width = -2;
            }
            catch (Exception ex)
            {
                Log.Error("An error occurred while populating listviews. Details follow.", ex);
            }
            finally
            {
                _StorageSummaryListview.ResumeLayout();
                _StorageDetailsListview.ResumeLayout();
                _needToUpdateStatusBarTotals = true;
            }
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

        private void _StorageSummaryListview_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            PopulateFilteredStorageDetailList();
        }

        private void PopulateFilteredStorageDetailList()
        {
            // This is a guard against all the calls that will occur while populating.

            if (!_uiEnabled)
                return;

            try
            {
                _StorageDetailsListview.Items.Clear();
                _StorageDetailsListview.SuspendLayout();

                // If there is no selected item, then merely make sure the listview is empty.

                if (_StorageSummaryListview.SelectedItems.Count == 0)
                    return;

                // Otherwise, we need to show some or all of the items.

                var clientFilter = 0;

                if (_StorageSummaryListview.SelectedItems.Count == 1)
                {
                    var summary = _StorageSummaryListview.SelectedItems[0].Tag as StorageSummaryItem;
                    if (summary != null)
                        clientFilter = summary.BillToClientRef;
                }

                //foreach (BopsRfsStorageBillingDetail Detail in _StorageDetails)
                for (var i = 0; i < _storageDetails.Count; i++)
                {
                    var detail = _storageDetails[i];

                    // Fetch the objects.

                    var inventoryItem = _storageInventoryMap[detail.InventoryRef];
                    var receiver = _storageReceiverMap[inventoryItem.ReceiverRef.Value];
                    var profile = _storageProfileMap[receiver.ProductProfileRef.Value];

                    // Skip the item if it fails to match the filter.

                    if (clientFilter != 0 && clientFilter != detail.BillToClientRef)
                        continue;

                    // Otherwise, add the item to the detail listview.

                    var newItem = new ListViewItem(detail.InventoryRef.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(_storageBillingMap[detail.BillingRef].DateBilledThrough.ToString("d"));
                    newItem.SubItems.Add(inventoryItem.ReceiverRef.ToString());
                    newItem.SubItems.Add(profile.ProfileId.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(detail.Quantity.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(detail.CyclesBilled.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(string.Format("{0:c}", detail.Revenue));
                    newItem.SubItems.Add(detail.PublicDetails);
                    newItem.Tag = detail;

                    _StorageDetailsListview.Items.Add(newItem);
                }

                foreach (ColumnHeader hdr in _StorageDetailsListview.Columns)
                    hdr.Width = -2;
            }
            catch (Exception ex)
            {
                Log.Error("An error occurred while populating the details listview. Details follow.", ex);
            }
            finally
            {
                _StorageDetailsListview.ResumeLayout();
                _needToUpdateStatusBarTotals = true;
            }
        }

        private void _StorageDetailsListview_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            _needToUpdateStatusBarTotals = true;
        }

        private void OnIdle(object sender, EventArgs e)
        {
            if (_needToUpdateStatusBarTotals)
                UpdateStatusBarTotals();
        }

        private void UpdateStatusBarTotals()
        {
            if (_StorageDetailsListview.SelectedItems.Count == 0)
            {
                _Status.Items[0].Text = string.Format("{0} items for a total revenue of {1:c}", _totalItems, _totalRevenue);
            }
            else
            {
                double selectedRevenue = 0;
                foreach (ListViewItem item in _StorageDetailsListview.SelectedItems)
                {
                    var detail = item.Tag as BopsRfsStorageBillingDetail;
                    Debug.Assert(detail != null);
                    selectedRevenue += detail.Revenue;
                }

                _Status.Items[0].Text = string.Format("{0} selected, {1:c} revenue", _StorageDetailsListview.SelectedItems.Count, selectedRevenue);
            }

            _needToUpdateStatusBarTotals = false;
        }

        private void CreateInvoiceFromStorageBills_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Idle -= _idleEventHandler;
        }

        private void CreateInvoice(IEnumerable<BopsRfsStorageBillingDetail> detailsToInvoice)
        {
            // Initialize a data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var servicesOffered = rfsDataContext.GetServicesOffered(UserCompanyDetails.Company.CompanyId);
                var rfsLocations = rfsDataContext.GetLocations(UserCompanyDetails.Company.CompanyId);
                var newForm = new CreateInvoicesFromStorageBillingForm(servicesOffered, rfsLocations)
                {
                    UserCompanyDetails = UserCompanyDetails
                };
                if (newForm.ShowDialog() != DialogResult.OK)
                    return;

                EnableUi(false);
                var ilm = RfsFactory.GetRfsInvoiceLifecycleManager(rfsDataContext);
                var newPackage = ilm.CreateInvoiceFromStorageBillingDetails(detailsToInvoice, newForm.ServiceOfferedRef, newForm.InvoiceDate, 
                    newForm.LocationCode, newForm.InvoiceType);

                if (newPackage == null)
                {
                    MessageHelper.ShowError("The invoice could not be created. Please contact IT support.");
                }
                else
                {
                    MessageBox.Show(string.Format("Created invoice {0}.", newPackage.Invoice.InvoiceId), @"Success");
                    PopulateListviews(rfsDataContext);
                }
            }
            catch (Exception ex)
            {
                Log.Error("An exception occurred while creating a storage invoice. Details follow.", ex);
            }
            finally
            {
                // TODO: free the IRfsDataContext
                EnableUi(true);
            }
        }

        private void RollbackDetails(IEnumerable<BopsRfsStorageBillingDetail> details)
        {
            var returnValue = false;

            // Initialize a data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                EnableUi(false);
                var sbc = RfsFactory.GetRfsStorageBillingCalculator();
                returnValue = sbc.RollbackStorageBillingDetails(rfsDataContext, details);
            }
            catch (Exception ex)
            {
                Log.Error("An exception occurred while rolling back storage billing details. Details follow.", ex);
            }
            finally
            {
                // TODO: free the IRfsDataContext
                EnableUi(true);
            }

            if (returnValue)
            {
                MessageBox.Show("Details rolled back successfully.", "Success");
                PopulateListviews(rfsDataContext);
            }
            else
            {
                MessageHelper.ShowError("The storage billing details could not be rolled back. Please contact IT support.");
            }
        }

        private void _InvoiceAllButton_Click(object sender, EventArgs e)
        {
            if (_StorageDetailsListview.Items.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("No details available. Use the summary list to select a bill-to client to invoice.");
                return;
            }

            var detailsToInvoice = new List<BopsRfsStorageBillingDetail>();
            foreach (ListViewItem item in _StorageDetailsListview.Items)
            {
                var detail = item.Tag as BopsRfsStorageBillingDetail;
                Debug.Assert(detail != null);
                detailsToInvoice.Add(detail);
            }

            CreateInvoice(detailsToInvoice);
        }

        private void _InvoiceSelectedButton_Click(object sender, EventArgs e)
        {
            if (_StorageDetailsListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("Select items from the storage billing details list to invoice them.");
                return;
            }

            var detailsToInvoice = new List<BopsRfsStorageBillingDetail>();
            foreach (ListViewItem item in _StorageDetailsListview.SelectedItems)
            {
                var detail = item.Tag as BopsRfsStorageBillingDetail;
                Debug.Assert(detail != null);
                detailsToInvoice.Add(detail);
            }

            CreateInvoice(detailsToInvoice);
        }

        private void _RollbackSelectedButton_Click(object sender, EventArgs e)
        {
            // This code is disabled because under a multi-company system it all has to be 
            // calculated or rolled back as a whole.

            return;

            if (_StorageDetailsListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("Select items from the storage billing details list to roll them back.");
                return;
            }

            if (MessageHelper.ShowConfirm("Are you sure you wish to roll back the selected storage billing details?") != DialogResult.Yes)
                return;

            var detailsToRollback = new List<BopsRfsStorageBillingDetail>();
            foreach (ListViewItem item in _StorageDetailsListview.SelectedItems)
            {
                var detail = item.Tag as BopsRfsStorageBillingDetail;
                Debug.Assert(detail != null);
                detailsToRollback.Add(detail);
            }

            RollbackDetails(detailsToRollback);
        }
    }
}
