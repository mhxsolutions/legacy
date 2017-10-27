using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security;
using System.Text;
using System.Windows.Forms;
using BopsAuthentication;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUtilities;
using CrystalDecisions.Shared;
using log4net;
using log4net.Config;
using Scm.OpsCore.Legacy.DataLayer;

[assembly: XmlConfigurator(Watch = true)]

namespace RFS_Invoice_Utility
{
    public partial class RfsInvoiceUtilityMainForm : Form
    {
        #region Helper Classes
        private class StorageSummaryItem
        {
            private readonly int _Profile;
            private readonly int _BillToClientRef;
            private int _TotalItems;
            private double _TotalRevenue;

            public StorageSummaryItem(int Profile, int BillToClientRef, int TotalItems, double TotalRevenue)
            {
                _Profile = Profile;
                _BillToClientRef = BillToClientRef;
                _TotalItems = TotalItems;
                _TotalRevenue = TotalRevenue;
            }

            public int Profile
            {
                get { return _Profile; }
            }

            public int BillToClientRef
            {
                get { return _BillToClientRef; }
            }

            public int TotalItems
            {
                get { return _TotalItems; }
                set { _TotalItems = value; }
            }

            public double TotalRevenue
            {
                get { return _TotalRevenue; }
                set { _TotalRevenue = value; }
            }
        }
        #endregion

        #region Fields

        private static readonly ILog _Log = LogManager.GetLogger(typeof(RfsInvoiceUtilityMainForm));
        private bool _UiEnabled;
        private SystemMenuHelper _systemMenu;

        // Permissions stuff.

        private const string _BopsAdministratorGroupName = @"SCMCloud\Bops Administrators";
        private const string _BopsPowerUserGroupName = @"SCMCloud\Bops Power Users";
        private bool _IsBopsAdministrator;
        private bool _IsBopsPowerUser;

        // Global caches (i.e., they include all records from the relevant tables).

        private Dictionary<int, BopsDestination> _DestinationsMap;
        private Dictionary<int, BopsRfsStakeholder> _StakeholdersMap;
        private Dictionary<int, BopsRfsServicesOffered> _ServicesOfferedMap;
        private Dictionary<int, BopsRfsServicesRequested> _ServicesRequestedMap;
        private Dictionary<int, BopsRfs> _RfsMap;
        private Dictionary<string, BopsRfsLocation> _RfsLocationMap;

        // Used by the bill review tab.

        private IList<BopsRfsServiceCalculationResult> _BillsToApprove;
        private Dictionary<string, BopsLoad> _ReviewLoadMap;
        private Dictionary<int, BopsReceivingRecord> _ReviewReceiverMap;
        private Dictionary<int, BopsShippingRecord> _ReviewShipperMap;
        private ListViewComparerFactory _ReviewCompareFactory;

        // Used by the create invoice tab.

        private IList<BopsRfsServiceCalculationResult> _BillsToInvoice;
        private Dictionary<string, BopsLoad> _CreateInvoiceLoadMap;
        private Dictionary<int, BopsReceivingRecord> _CreateInvoiceReceiverMap;
        private Dictionary<int, BopsShippingRecord> _CreateInvoiceShipperMap;
        private ListViewComparerFactory _BillsAvailableCompareFactory;
        private ListViewComparerFactory _BillsSelectedCompareFactory;

        // Used by the invoice review tab.

        private Dictionary<RfsInvoiceStatus, BopsRfsInvoiceStatus> _InvoiceStatusMap;
        private IList<BopsRfsInvoice> _InvoicesToReview;
        private Dictionary<int, List<BopsRfsInvoiceDetail>> _InvoiceDetailsMap;
        private ListViewComparerFactory _InvoicesCompareFactory;
        private ListViewComparerFactory _InvoiceDetailsCompareFactory;
        private bool _ShowInvoiceAfterFinalize;

        // Used by the storage tab.

        private BopsRfsStorageBilling _StorageCurrentBilling;
        private IList<BopsRfsStorageBillingDetail> _StorageDetails;
        private Dictionary<int, BopsInventoryDetail> _StorageInventoryMap;
        private Dictionary<int, BopsReceivingRecord> _StorageReceiverMap;
        private Dictionary<int, BopsProductProfile> _StorageProfileMap;
        private ListViewComparerFactory _StorageSummaryCompareFactory;
        private ListViewComparerFactory _StorageDetailsCompareFactory;

        // Used by the administration tab.

        private IList<BopsRfsInvoiceXferBatch> _InvoiceXferBatchesToPost;
        private ListViewComparerFactory _InvoiceXferBatchesFactory;
        private Dictionary<int, List<BopsRfsInvoice>> _InvoicesMap;

        #endregion

        #region Properties

        public CompanyDetails UserCompanyDetails { get; set; }

        #endregion

        #region Constructor

        public RfsInvoiceUtilityMainForm()
        {
            InitializeComponent();

            // Initialize the bootstrap kernel and services.

            Scm.OpsCore.Bootstrap.Bootstrap.Startup();

            _systemMenu = new SystemMenuHelper(this);
            _systemMenu.AddCommand("&About...", OnSysMenuAbout, true);
        }

        #endregion

        #region User Company Methods

        private void ClearAllPopulatedControls()
        {
            ReviewListview.Items.Clear();
            BillsAvailableListview.Items.Clear();
            BillsSelectedListview.Items.Clear();
            InvoiceListview.Items.Clear();
            InvoiceDetailsListview.Items.Clear();
            StorageSummaryListview.Items.Clear();
            StorageDetailsListview.Items.Clear();
            InvoiceXferBatchListView.Items.Clear();
        }

        private void ClearAllCachedData()
        {
            // Let go of basic global caches.

            _DestinationsMap = null;
            _StakeholdersMap = null;
            _ServicesOfferedMap = null;
            _ServicesRequestedMap = null;
            _RfsMap = null;
            _InvoiceStatusMap = null;
            _RfsLocationMap = null;

            // Let go of data for the bill review tab.

            _BillsToApprove = null;
            _ReviewLoadMap = null;
            _ReviewReceiverMap = null;
            _ReviewShipperMap = null;
            _ReviewCompareFactory = null;

            // Let go of data for the create invoice tab.

            _BillsToInvoice = null;
            _CreateInvoiceLoadMap = null;
            _CreateInvoiceReceiverMap = null;
            _CreateInvoiceShipperMap = null;
            _BillsAvailableCompareFactory = null;
            _BillsSelectedCompareFactory = null;

            // Let go of data for the invoice review tab.

            _InvoiceStatusMap = null;
            _InvoicesToReview = null;
            _InvoiceDetailsMap = null;
            _InvoicesCompareFactory = null;
            _InvoiceDetailsCompareFactory = null;

            // Let go of data for the storage tab.

            _StorageCurrentBilling = null;
            _StorageDetails = null;
            _StorageInventoryMap = null;
            _StorageReceiverMap = null;
            _StorageProfileMap = null;
            _StorageSummaryCompareFactory = null;
            _StorageDetailsCompareFactory = null;

            // Let go of data for the administration tab.

            _InvoiceXferBatchesToPost = null;
            _InvoiceXferBatchesFactory = null;
            _InvoicesMap = null;
        }

        private CompanyDetails DetermineUserCompanyDetails(CompanyDetails originalDetails)
        {
            _Log.Debug("Determining user and company details.");

            // If the company filtering has been disabled by undocumented setting, then we'll just
            // fake a set of company details and use zero for the company ID. That will get passed
            // into the data layer, which will ignore it.

            var disableCompanyFiltering = false;
            var disableCompanyFilteringSetting = ConfigurationManager.AppSettings["DisableCompanyFiltering"];
            bool.TryParse(disableCompanyFilteringSetting, out disableCompanyFiltering);
            if (disableCompanyFiltering)
            {
                return new CompanyDetails { Company = new BopsCompany { City = "No Company Filter", CompanyId = 0, Name = "Showing All Data" } };
            }

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            try
            {
                var companiesMap = rfsDataContext.GetCompanies().ToDictionary(c => c.CompanyId, c => c);
                var allCompanyUsers = rfsDataContext.GetCompanyUsers();
                var permissionsMap = rfsDataContext.GetCompanyUserPermissions().ToDictionary(p => p.PermissionId, p => p);

                var windowsUserId = Environment.UserName;

                var loginOptions = new List<CompanyDetails>();
                foreach (var user in allCompanyUsers)
                {
                    if (string.Compare(windowsUserId, user.WindowsUserId, StringComparison.OrdinalIgnoreCase) == 0)
                        loginOptions.Add(new CompanyDetails { User = user, Company = companiesMap[user.CompanyRef], Permission = permissionsMap[user.UserPermissionRef] });
                }

                if (loginOptions.Count == 1)
                {
                    return loginOptions[0];
                }
                else if (loginOptions.Count > 1)
                {
                    var loginForm = new ChooseLoginForm { LoginOptions = loginOptions, FinalChoice = originalDetails };
                    loginForm.ShowDialog();
                    if (loginForm.FinalChoice != null)
                        loginForm.FinalChoice.MultipleOptions = true;
                    return loginForm.FinalChoice;
                }
            }
            catch (Exception e)
            {
                _Log.Error("An exception occurred determining user and company details.", e);
            }
            finally
            {
                // TODO: free the RFS data context
            }

            _Log.Error("Could not determine user and company details.");
            return null;
        }



        #endregion

        #region Caching Methods

        private bool CacheServiceData()
        {
            _Log.Debug("Caching service data.");

            var returnValue = true;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                _DestinationsMap = rfsDataContext.GetDestinations(UserCompanyDetails.Company.CompanyId, 0, 0)
                    .ToDictionary(d => d.DestinationId, d => d);
                _StakeholdersMap = rfsDataContext.GetStakeholders(UserCompanyDetails.Company.CompanyId, 0, 0)
                    .ToDictionary(s => s.StakeholderId, s => s);
                _ServicesOfferedMap = rfsDataContext.GetServicesOffered(UserCompanyDetails.Company.CompanyId)
                    .ToDictionary(s => s.Id, s => s);
                _ServicesRequestedMap = rfsDataContext.GetServicesRequested(UserCompanyDetails.Company.CompanyId, 0, 0)
                    .ToDictionary(s => s.ServiceRequestedId, s => s);
                _RfsMap = rfsDataContext.GetRfs(UserCompanyDetails.Company.CompanyId, 0, 0)
                    .ToDictionary(r => r.RfsId, r => r);
                _InvoiceStatusMap = rfsDataContext.GetInvoiceStatuses()
                    .ToDictionary(i => i.StatusEnum, i => i);
                _RfsLocationMap = rfsDataContext.GetLocations(UserCompanyDetails.Company.CompanyId)
                    .ToDictionary(l => l.LocationCode, l => l);

                PopulateInvoiceFilter();

                StorageUpdateOrphansLabel(rfsDataContext);
            }
            catch (Exception e)
            {
                returnValue = false;
                _Log.Error("An error occurred caching service data. Details follow.", e);
            }
            finally
            {
                // TODO: free the RFS data context
            }

            return returnValue;
        }

        private void CacheBillsToInvoice()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                // First, fetch all the relevant service calculation results.

                _BillsToInvoice = rfsDataContext.GetServiceCalculationResultsByDatesAndBillingStatus(
                    BeginDatePicker.Value, EndDatePicker.Value, RfsBillingStatus.Approved,
                    UserCompanyDetails.Company.CompanyId);

                // Next, load up dictionaries with the load, receiver, and shipper IDs.

                _CreateInvoiceLoadMap = new Dictionary<string, BopsLoad>();
                _CreateInvoiceReceiverMap = new Dictionary<int, BopsReceivingRecord>();
                _CreateInvoiceShipperMap = new Dictionary<int, BopsShippingRecord>();

                foreach (var result in _BillsToInvoice)
                {
                    if (result.IsReceiver)
                    {
                        if (!_CreateInvoiceReceiverMap.ContainsKey(result.DocumentId.Value))
                            _CreateInvoiceReceiverMap.Add(result.DocumentId.Value, null);
                    }
                    else if (result.IsBillOfLading)
                    {
                        if (!_CreateInvoiceShipperMap.ContainsKey(result.DocumentId.Value))
                            _CreateInvoiceShipperMap.Add(result.DocumentId.Value, null);
                    }
                    else
                    {
                        if (!_CreateInvoiceLoadMap.ContainsKey(result.LoadRef))
                            _CreateInvoiceLoadMap.Add(result.LoadRef, null);
                    }
                }

                // Fetch the loads into the map.

                if (_CreateInvoiceLoadMap.Count > 0)
                {
                    var index = 0;
                    var loadIds = new string[_CreateInvoiceLoadMap.Count];
                    foreach (var pair in _CreateInvoiceLoadMap)
                        loadIds[index++] = pair.Key;
                    _CreateInvoiceLoadMap = rfsDataContext.GetLoadsByReferences(loadIds)
                        .ToDictionary(l => l.LoadReference, l => l);
                }
                else
                {
                    _CreateInvoiceLoadMap.Clear();
                }

                // Fetch the receivers into the map.

                if (_CreateInvoiceReceiverMap.Count > 0)
                {
                    var index = 0;
                    var receiverIds = new int[_CreateInvoiceReceiverMap.Count];
                    foreach (var pair in _CreateInvoiceReceiverMap)
                        receiverIds[index++] = pair.Key;
                    _CreateInvoiceReceiverMap = rfsDataContext.GetReceiversByIDs(receiverIds)
                        .ToDictionary(r => r.ReceiverId, r => r);
                }
                else
                {
                    _CreateInvoiceReceiverMap.Clear();
                }

                // Fetch the shippers into the map.

                if (_CreateInvoiceShipperMap.Count > 0)
                {
                    var index = 0;
                    var shipperIds = new int[_CreateInvoiceShipperMap.Count];
                    foreach (var pair in _CreateInvoiceShipperMap)
                        shipperIds[index++] = pair.Key;
                    _CreateInvoiceShipperMap = rfsDataContext.GetShippersByIDs(shipperIds)
                        .ToDictionary(s => s.LoadId, s => s);
                }
                else
                {
                    _CreateInvoiceShipperMap.Clear();
                }

                // Finally, strip out and log any billing documents that don't have a corresponding row in the 
                // primary tables. This should prevent users from putting non-existent items on invoices.

                for (var index = 0; index < _BillsToInvoice.Count; )   // NB: The index is updated selectively within the loop body.
                {
                    bool stripResult;
                    var result = _BillsToInvoice[index];

                    if (result.IsReceiver)
                        stripResult = !_CreateInvoiceReceiverMap.ContainsKey(result.DocumentId.Value);
                    else if (result.IsBillOfLading)
                        stripResult = !_CreateInvoiceShipperMap.ContainsKey(result.DocumentId.Value);
                    else
                        stripResult = !_CreateInvoiceLoadMap.ContainsKey(result.LoadRef);

                    if (stripResult)
                    {
                        _BillsToInvoice.RemoveAt(index);
                        _Log.WarnFormat("Billing document has no corresponding row in the primary table: {0}", result);
                    }
                    else
                    {
                        index++;
                    }
                }
            }
            catch(Exception ex)
            {
                _Log.Error("An error occurred caching bills to invoice. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context.
            }
        }

        private void CacheBillsToApprove()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                _BillsToApprove = rfsDataContext.GetServiceCalculationResultsByDatesAndBillingStatus(
                    ReviewBeginDatePicker.Value, ReviewEndDatePicker.Value, RfsBillingStatus.PendingReview,
                    UserCompanyDetails.Company.CompanyId);
                    
                // Next, load up dictionaries with the load, receiver, and shipper IDs.

                _ReviewLoadMap = new Dictionary<string, BopsLoad>();
                _ReviewReceiverMap = new Dictionary<int, BopsReceivingRecord>();
                _ReviewShipperMap = new Dictionary<int, BopsShippingRecord>();

                foreach (var result in _BillsToApprove)
                {
                    if (result.IsReceiver)
                    {
                        if (!_ReviewReceiverMap.ContainsKey(result.DocumentId.Value))
                            _ReviewReceiverMap.Add(result.DocumentId.Value, null);
                    }
                    else if (result.IsBillOfLading)
                    {
                        if (!_ReviewShipperMap.ContainsKey(result.DocumentId.Value))
                            _ReviewShipperMap.Add(result.DocumentId.Value, null);
                    }
                    else
                    {
                        if (!_ReviewLoadMap.ContainsKey(result.LoadRef))
                            _ReviewLoadMap.Add(result.LoadRef, null);
                    }
                }

                // Fetch the loads into the map.

                if (_ReviewLoadMap.Count > 0)
                {
                    var index = 0;
                    var loadIds = new string[_ReviewLoadMap.Count];
                    foreach (var pair in _ReviewLoadMap)
                        loadIds[index++] = pair.Key;
                    _ReviewLoadMap = rfsDataContext.GetLoadsByReferences(loadIds)
                        .ToDictionary(l => l.LoadReference, l => l);
                }
                else
                {
                    _ReviewLoadMap.Clear();
                }

                // Fetch the receivers into the map.

                if (_ReviewReceiverMap.Count > 0)
                {
                    var index = 0;
                    var receiverIds = new int[_ReviewReceiverMap.Count];
                    foreach (var pair in _ReviewReceiverMap)
                        receiverIds[index++] = pair.Key;
                    _ReviewReceiverMap = rfsDataContext.GetReceiversByIDs(receiverIds)
                        .ToDictionary(r => r.ReceiverId, r => r);
                }
                else
                {
                    _ReviewReceiverMap.Clear();
                }

                // Fetch the shippers into the map.

                if (_ReviewShipperMap.Count > 0)
                {
                    var index = 0;
                    var shipperIds = new int[_ReviewShipperMap.Count];
                    foreach (var pair in _ReviewShipperMap)
                        shipperIds[index++] = pair.Key;
                    _ReviewShipperMap = rfsDataContext.GetShippersByIDs(shipperIds)
                        .ToDictionary(s => s.LoadId, s => s);
                }
                else
                {
                    _ReviewShipperMap.Clear();
                }

                // Finally, strip out and log any billing documents that don't have a corresponding row in the 
                // primary tables. This should prevent users from putting non-existent items on invoices. We also
                // enforce certain conditions for the various types of billing documents:
                //
                //  1. Receivers must be locked.
                //  2. BOLs must have a [Ship Rec Lock] value of four, a "magic number" specified by Dan.
                //  3. Loads must be logged out and have POD.

                for (var index = 0; index < _BillsToApprove.Count; )   // NB: The index is updated selectively within the loop body.
                {
                    bool stripResult;
                    var result = _BillsToApprove[index];

                    if (result.IsReceiver)
                    {
                        //130430 Filter out Receiver that are Correction
                        stripResult = !_ReviewReceiverMap.ContainsKey(result.DocumentId.Value) ||
                                      !_ReviewReceiverMap[result.DocumentId.Value].RecordLock.HasValue ||
                                      _ReviewReceiverMap[result.DocumentId.Value].RecordLock.Value == false ||
                                      _ReviewReceiverMap[result.DocumentId.Value].ReceiverType == "Correction";
                    }
                    else if (result.IsBillOfLading)
                    {
                        stripResult = !_ReviewShipperMap.ContainsKey(result.DocumentId.Value) ||
                                      !_ReviewShipperMap[result.DocumentId.Value].ShipRecLock.HasValue ||
                                      _ReviewShipperMap[result.DocumentId.Value].ShipRecLock.Value != 4;
                    }
                    else
                    {
                        stripResult = !_ReviewLoadMap.ContainsKey(result.LoadRef) ||
                                      !_ReviewLoadMap[result.LoadRef].LogOutDate.HasValue ||
                                      !_ReviewLoadMap[result.LoadRef].ProofOfDelivery.HasValue ||
                                      _ReviewLoadMap[result.LoadRef].ProofOfDelivery != true;
                    }

                    if (stripResult)
                    {
                        _BillsToApprove.RemoveAt(index);
                        _Log.WarnFormat("Billing document has no corresponding row in the primary table: {0}", result.ToString());
                    }
                    else
                    {
                        index++;
                    }
                }
            }
            catch (Exception ex)
            {
                _Log.Error("An error occurred caching bills to approve. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context.
            }
        }

        private void CacheInvoicesToReview()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                _InvoicesToReview = rfsDataContext.GetInvoicesByDates(
                    InvoiceBeginDatePicker.Value, InvoiceEndDatePicker.Value,
                    UserCompanyDetails.Company.CompanyId);

                _InvoiceDetailsMap = new Dictionary<int, List<BopsRfsInvoiceDetail>>();
                if (_InvoicesToReview.Count > 0)
                {
                    var index = 0;
                    var invoiceIds = new int[_InvoicesToReview.Count];
                    foreach (var invoice in _InvoicesToReview)
                        invoiceIds[index++] = invoice.InvoiceId;
                    var allDetails = rfsDataContext.GetInvoiceDetailsByInvoiceIds(invoiceIds);
                        
                    foreach (var detail in allDetails)
                    {
                        CacheInvoiceLine(detail);
                    }
                }
            }
            catch (Exception ex)
            {
                _Log.Error("An exception occurred caching invoices to review. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context.
            }
        }

        private void CacheInvoiceLine(BopsRfsInvoiceDetail newLine)
        {
            List<BopsRfsInvoiceDetail> currentDetails;

            if (_InvoiceDetailsMap.ContainsKey(newLine.InvoiceRef))
            {
                currentDetails = _InvoiceDetailsMap[newLine.InvoiceRef];
            }
            else
            {
                currentDetails = new List<BopsRfsInvoiceDetail>();
                _InvoiceDetailsMap[newLine.InvoiceRef] = currentDetails;
            }

            currentDetails.Add(newLine);
        }

        private void CacheStorageBillingDetails(IRfsDataContext rfsDataContext, BopsRfsStorageBilling billing)
        {
            // Get the storage billing detail rows.

            _StorageDetails = rfsDataContext.GetStorageBillingDetailsByBillingId(billing.BillingId);

            if (_StorageDetails.Count < 1)
            {
                _StorageInventoryMap = new Dictionary<int, BopsInventoryDetail>();
                _StorageReceiverMap = new Dictionary<int, BopsReceivingRecord>();
                return;
            }

            // Use the storage billing detail rows to get the corresponding inventory items.

            var inventoryIds = new int[_StorageDetails.Count];
            for (var i = 0; i < _StorageDetails.Count; i++)
            {
                inventoryIds[i] = _StorageDetails[i].InventoryRef;
            }

            _StorageInventoryMap = rfsDataContext.GetInventoryDetailsByIDs(inventoryIds)
                .ToDictionary(i => i.DetailId, i => i);

            // Use the inventory items to get the corresponding receivers.

            var receiversMap = new Dictionary<int, int>();
            foreach (var map in _StorageInventoryMap)
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

            _StorageReceiverMap = rfsDataContext.GetReceiversByIDs(receiverIds)
                .ToDictionary(r => r.ReceiverId, r => r);

            // Use the receivers to get the corresponding product profiles.

            var profilesMap = new Dictionary<int, int>();
            foreach (var map in _StorageReceiverMap)
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

            _StorageProfileMap = rfsDataContext.GetProductProfilesByIDs(profileIds)
                .ToDictionary(p => p.ProfileId, p => p);
        }

        private void InvoiceClearFiltersButton_Click(object Sender, EventArgs E)
        {
            if (_InvoicesToReview == null) return;

            EnableUi(false);
            InvoiceShipperCombobox.SelectedIndex = 0;
            InvoiceBillToCombobox.SelectedIndex = 0;
            InvoiceFilterCombobox.SelectedIndex = 0;
            PopulateInvoicesToReview(false);
            EnableUi(true);
        }

        private void InvoiceShipperCombobox_SelectedIndexChanged(object Sender, EventArgs E)
        {
            if (!_UiEnabled) return;

            EnableUi(false);
            PopulateInvoicesToReview(false);
            EnableUi(true);
        }

        #endregion

        #region Population Methods

        private void PopulateBillsToApprove(bool RepopulateFilters)
        {
            // Columns:
            //
            //  0   Document Type
            //  1   Document ID
            //  2   RFS
            //  3   Date
            //  4   Revenue
            //  5   FSC
            //  6   Shipper
            //  7   Destination

            _ReviewCompareFactory = new ListViewComparerFactory(8)
            {
                [2] = {SortType = ListViewComparerFactory.ColumnSortType.Integer},
                [3] = {SortType = ListViewComparerFactory.ColumnSortType.Date},
                [4] = {SortType = ListViewComparerFactory.ColumnSortType.Currency},
                [5] = {SortType = ListViewComparerFactory.ColumnSortType.Currency}
            };

            ReviewListview.Items.Clear();
            ReviewListview.SuspendLayout();

            var shipperList = new Dictionary<int, BopsDestination>();
            BopsDestination selectedShipper = null;
            if (!RepopulateFilters)
            {
                selectedShipper = ReviewShipperCombobox.SelectedItem as BopsDestination;
            }

            foreach (var result in _BillsToApprove)
            {
                var isLoad = false;
                ListViewItem newItem;
                BopsRfsServicesRequested service = null;
                BopsDestination shipperStakeholder = null;
                BopsDestination destinationStakeholder = null;

                if (result.IsReceiver)
                {
                    newItem = new ListViewItem("Receiver");
                    newItem.SubItems.Add(result.DocumentId.ToString());
                }
                else if (result.IsBillOfLading)
                {
                    newItem = new ListViewItem("BOL");
                    newItem.SubItems.Add(result.DocumentId.ToString());
                }
                else
                {
                    isLoad = true;
                    newItem = new ListViewItem("Load");
                    newItem.SubItems.Add(result.LoadRef);
                }

                if (_ServicesRequestedMap.ContainsKey(result.ServiceId))
                {
                    service = _ServicesRequestedMap[result.ServiceId];
                    newItem.SubItems.Add(service.RfsRef.ToString());
                }
                else
                {
                    newItem.SubItems.Add("?");
                }

                if (result.BillingDate.HasValue)
                    newItem.SubItems.Add(result.BillingDate.Value.ToString("d"));
                else
                    newItem.SubItems.Add("?");

                newItem.SubItems.Add(string.Format("{0:c}", result.PublicRate.RfsRevenue));
                newItem.SubItems.Add(string.Format("{0:c}", result.PublicRate.FscRevenue));

                string destinationString;
                var shipperString = destinationString = "?";

                if (service != null)
                {
                    if (_RfsMap.ContainsKey(service.RfsRef) && _DestinationsMap.ContainsKey(_RfsMap[service.RfsRef].ShipperRef))
                    {
                        shipperStakeholder = _DestinationsMap[_RfsMap[service.RfsRef].ShipperRef];

                        if (!shipperList.ContainsKey(shipperStakeholder.DestinationId))
                            shipperList.Add(shipperStakeholder.DestinationId, shipperStakeholder);

                        shipperString = shipperStakeholder.ToString();
                    }

                    if (isLoad && (_ReviewLoadMap != null) && _ReviewLoadMap.ContainsKey(result.LoadRef))
                    {
                        var load = _ReviewLoadMap[result.LoadRef];
                        if (load.DeliveryLocationRef.HasValue && _DestinationsMap.ContainsKey(load.DeliveryLocationRef.Value))
                        {
                            destinationStakeholder = _DestinationsMap[load.DeliveryLocationRef.Value];
                            destinationString = destinationStakeholder.ToString();
                        }
                    }
                    else if (service.DestinationRef.HasValue && _StakeholdersMap.ContainsKey(service.DestinationRef.Value))
                    {
                        var clientId = _StakeholdersMap[service.DestinationRef.Value].ClientRef;
                        if (_DestinationsMap.ContainsKey(clientId))
                        {
                            destinationStakeholder = _DestinationsMap[clientId];
                            destinationString = destinationStakeholder.ToString();
                        }
                    }
                }

                newItem.SubItems.Add(shipperString);
                newItem.SubItems.Add(destinationString);

                var passesShipperFilter = true;
                if (selectedShipper != null)
                {
                    if (shipperStakeholder == null || shipperStakeholder.DestinationId != selectedShipper.DestinationId)
                        passesShipperFilter = false;
                }

                if (!passesShipperFilter) continue;

                var newBd = new BopsRfsBillDetail(result, shipperStakeholder, destinationStakeholder);

                if (result.IsReceiver)
                {
                    if (_ReviewReceiverMap.ContainsKey(result.DocumentId.Value))
                        newBd.Receiver = _ReviewReceiverMap[result.DocumentId.Value];
                }
                else if (result.IsBillOfLading)
                {
                    if (_ReviewShipperMap.ContainsKey(result.DocumentId.Value))
                        newBd.Shipper = _ReviewShipperMap[result.DocumentId.Value];
                }
                else
                {
                    Debug.Assert(_ReviewLoadMap != null);
                    if (_ReviewLoadMap.ContainsKey(result.LoadRef))
                        newBd.Load = _ReviewLoadMap[result.LoadRef];
                }

                newItem.Tag = newBd;
                ReviewListview.Items.Add(newItem);
            }

            if (RepopulateFilters)
            {
                ReviewShipperCombobox.Items.Clear();
                ReviewShipperCombobox.Items.Add("(show all)");
                foreach (var pair in shipperList)
                {
                    ReviewShipperCombobox.Items.Add(pair.Value);
                }
                ReviewShipperCombobox.SelectedIndex = 0;
            }

            foreach (ColumnHeader hdr in ReviewListview.Columns)
                hdr.Width = -2;
            ReviewListview.ResumeLayout();
        }

        private void PopulateBillsToInvoice(bool RepopulateFilters)
        {
            // Columns:
            //
            //  0   Document Type
            //  1   Document ID
            //  2   RFS
            //  3   Date
            //  4   Revenue
            //  5   FSC
            //  6   Shipper
            //  7   Bill-To
            //  8   Destination
            //  9   Product profile description

            _BillsAvailableCompareFactory = new ListViewComparerFactory(10)
            {
                [2] = {SortType = ListViewComparerFactory.ColumnSortType.Integer},
                [3] = {SortType = ListViewComparerFactory.ColumnSortType.Date},
                [4] = {SortType = ListViewComparerFactory.ColumnSortType.Currency},
                [5] = {SortType = ListViewComparerFactory.ColumnSortType.Currency}
            };

            var selectedBills = new Dictionary<int, ListViewItem>();
            foreach (ListViewItem item in BillsSelectedListview.Items)
            {
                var bd = item.Tag as BopsRfsBillDetail;
                if (bd == null) continue;

                if (!selectedBills.ContainsKey(bd.ServiceResult.ResultId))
                    selectedBills.Add(bd.ServiceResult.ResultId, item);
            }

            var shipperList = new Dictionary<int, BopsDestination>();
            var billToList = new Dictionary<int, BopsDestination>();

            BopsDestination selectedShipper = null, selectedBillTo = null;
            if (!RepopulateFilters)
            {
                selectedShipper = ShipperCombobox.SelectedItem as BopsDestination;
                selectedBillTo = BillToCombobox.SelectedItem as BopsDestination;
            }

            BillsAvailableListview.Items.Clear();
            BillsAvailableListview.SuspendLayout();

            foreach (var result in _BillsToInvoice)
            {
                // If the result is already included on the to-invoice list, do not include it in the available list.
                if (selectedBills.ContainsKey(result.ResultId))
                    continue;

                ListViewItem newItem;
                BopsRfsServicesRequested service = null;
                BopsDestination shipperStakeholder = null;
                BopsDestination billToStakeholder = null;
                BopsDestination destinationStakeholder;

                if (result.IsReceiver)
                {
                    newItem = new ListViewItem("Receiver");
                    newItem.SubItems.Add(result.DocumentId.ToString());
                }
                else if (result.IsBillOfLading)
                {
                    newItem = new ListViewItem("BOL");
                    newItem.SubItems.Add(result.DocumentId.ToString());
                }
                else
                {
                    newItem = new ListViewItem("Load");
                    newItem.SubItems.Add(result.LoadRef);
                }

                if (_ServicesRequestedMap.ContainsKey(result.ServiceId))
                {
                    service = _ServicesRequestedMap[result.ServiceId];
                    newItem.SubItems.Add(service.RfsRef.ToString());
                }
                else
                {
                    newItem.SubItems.Add("?");
                }

                if (result.BillingDate.HasValue)
                    newItem.SubItems.Add(result.BillingDate.Value.ToString("d"));
                else
                    newItem.SubItems.Add("?");

                newItem.SubItems.Add(string.Format("{0:c}", result.PublicRate.RfsRevenue));
                newItem.SubItems.Add(string.Format("{0:c}", result.PublicRate.FscRevenue));

                string billToString, destinationString, profileString = string.Empty;
                string shipperString = billToString = destinationString = "?";

                if (service != null)
                {
                    if (_RfsMap.ContainsKey(service.RfsRef) && _DestinationsMap.ContainsKey(_RfsMap[service.RfsRef].ShipperRef))
                    {
                        shipperStakeholder = _DestinationsMap[_RfsMap[service.RfsRef].ShipperRef];

                        if (!shipperList.ContainsKey(shipperStakeholder.DestinationId))
                            shipperList.Add(shipperStakeholder.DestinationId, shipperStakeholder);

                        shipperString = shipperStakeholder.ToString();
                    }

                    if (service.BillToRef.HasValue && _StakeholdersMap.ContainsKey(service.BillToRef.Value))
                    {
                        var clientId = _StakeholdersMap[service.BillToRef.Value].ClientRef;
                        if (_DestinationsMap.ContainsKey(clientId))
                        {
                            billToStakeholder = _DestinationsMap[clientId];

                            if (!billToList.ContainsKey(billToStakeholder.DestinationId))
                                billToList.Add(billToStakeholder.DestinationId, billToStakeholder);

                            billToString = billToStakeholder.ToString();
                        }
                    }

                    if (service.DestinationRef.HasValue && _StakeholdersMap.ContainsKey(service.DestinationRef.Value))
                    {
                        var clientId = _StakeholdersMap[service.DestinationRef.Value].ClientRef;
                        if (_DestinationsMap.ContainsKey(clientId))
                        {
                            destinationStakeholder = _DestinationsMap[clientId];
                            destinationString = destinationStakeholder.ToString();
                        }
                    }
                }

                newItem.SubItems.Add(shipperString);
                newItem.SubItems.Add(billToString);
                newItem.SubItems.Add(destinationString);

                var passesShipperFilter = true;
                if (selectedShipper != null)
                {
                    if (shipperStakeholder == null || shipperStakeholder.DestinationId != selectedShipper.DestinationId)
                        passesShipperFilter = false;
                }

                var passesBillToFilter = true;
                if (selectedBillTo != null)
                {
                    if (billToStakeholder == null || billToStakeholder.DestinationId != selectedBillTo.DestinationId)
                        passesBillToFilter = false;
                }

                if (!passesShipperFilter || !passesBillToFilter) continue;

                var newBd = new BopsRfsBillDetail(result, shipperStakeholder, billToStakeholder);
                if (result.IsReceiver)
                {
                    if (_CreateInvoiceReceiverMap.ContainsKey(result.DocumentId.Value))
                    {
                        newBd.Receiver = _CreateInvoiceReceiverMap[result.DocumentId.Value];
                        profileString = newBd.Receiver.ProductProfileDescription;
                    }
                }
                else if (result.IsBillOfLading)
                {
                    if (_CreateInvoiceShipperMap.ContainsKey(result.DocumentId.Value))
                        newBd.Shipper = _CreateInvoiceShipperMap[result.DocumentId.Value];
                }
                else
                {
                    if (_CreateInvoiceLoadMap.ContainsKey(result.LoadRef))
                        newBd.Load = _CreateInvoiceLoadMap[result.LoadRef];
                }

                newItem.SubItems.Add(profileString);
                newItem.Tag = newBd;
                BillsAvailableListview.Items.Add(newItem);
            }

            if (RepopulateFilters)
            {
                ShipperCombobox.Items.Clear();
                ShipperCombobox.Items.Add("(show all)");
                foreach (KeyValuePair<int, BopsDestination> Pair in shipperList)
                {
                    ShipperCombobox.Items.Add(Pair.Value);
                }
                ShipperCombobox.SelectedIndex = 0;

                BillToCombobox.Items.Clear();
                BillToCombobox.Items.Add("(show all)");
                foreach (var pair in billToList)
                {
                    BillToCombobox.Items.Add(pair.Value);
                }
                BillToCombobox.SelectedIndex = 0;
            }

            foreach (ColumnHeader hdr in BillsAvailableListview.Columns)
                hdr.Width = -2;
            BillsAvailableListview.ResumeLayout();
        }

        private void PopulateInvoiceFilter()
        {
            InvoiceFilterCombobox.Items.Clear();
            InvoiceFilterCombobox.Items.Add("(show all)");
            foreach (KeyValuePair<RfsInvoiceStatus, BopsRfsInvoiceStatus> Pair in _InvoiceStatusMap)
                InvoiceFilterCombobox.Items.Add(Pair.Value);
            InvoiceFilterCombobox.SelectedIndex = 0;
        }

        private void PopulateInvoiceDetails()
        {
            InvoiceDetailsListview.Items.Clear();
            if (InvoiceListview.SelectedItems.Count != 1) return;

            InvoiceDetails Id = InvoiceListview.SelectedItems[0].Tag as InvoiceDetails;
            if (Id == null) return;

            InvoiceDetailsListview.SuspendLayout();

            if (_InvoiceDetailsMap.ContainsKey(Id.Invoice.InvoiceId))
            {
                List<BopsRfsInvoiceDetail> Details = _InvoiceDetailsMap[Id.Invoice.InvoiceId];

                // Columns:
                //
                //  0	Line
                //  1	Manual
                //  2	Group
                //  3	Date
                //  4	Amount
                //  5	Description

                _InvoiceDetailsCompareFactory = new ListViewComparerFactory(6);
                _InvoiceDetailsCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
                _InvoiceDetailsCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Date;
                _InvoiceDetailsCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Currency;

                string CurrentGroup = string.Empty;
                Dictionary<string, double> GroupTotals = GetGroupTotals(Details);

                foreach (BopsRfsInvoiceDetail Detail in Details)
                {
                    // TODO: uncomment the last predicate if we add a show group details checkbox to the form.

                    if (!string.IsNullOrEmpty(Detail.GroupName)/* && !ShowGroupDetailCheckbox.Checked*/)
                    {
                        if (CurrentGroup == Detail.GroupName)
                            continue;

                        BopsRfsInvoiceDetail LineToAdd = new BopsRfsInvoiceDetail(Detail);
                        LineToAdd.ItemTotal = GroupTotals[Detail.GroupName];
                        CurrentGroup = Detail.GroupName;

                        AddInvoiceLineToListview(LineToAdd, Detail);
                    }
                    else
                    {
                        CurrentGroup = string.Empty;
                        AddInvoiceLineToListview(Detail, null);
                    }
                }
            }

            foreach (ColumnHeader Hdr in InvoiceDetailsListview.Columns)
                Hdr.Width = -2;
            InvoiceDetailsListview.ResumeLayout();
        }

        #endregion

        private void EnableUi(bool EnableUi)
        {
            MainTabControl.Enabled = EnableUi;
            Cursor = EnableUi ? Cursors.Default : Cursors.WaitCursor;
            _UiEnabled = EnableUi;
        }

        private void ConfigureBillsSelectedListview()
        {
            _BillsSelectedCompareFactory = new ListViewComparerFactory(9);
            _BillsSelectedCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _BillsSelectedCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _BillsSelectedCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Currency;
            _BillsSelectedCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Currency;
        }

        [Conditional("DEBUG")] 
        private void GrantDebuggingAdministrativeRights()
        {
            _IsBopsAdministrator = true;
            //_IsBopsPowerUser = true;
        }

        protected override void OnLoad(EventArgs e)
        {
            if (e == null) throw new ArgumentNullException();
            _Log.Info("RFS Invoice Utility form loading.");

            // Make the picture box the parent of the login label to make proper transparency work.

            loginLabel.Parent = pictureBox1;
            loginLabel.BackColor = Color.Transparent;

            // Read application settings.

            var showInvoiceSetting = ConfigurationManager.AppSettings["ShowInvoiceAfterFinalize"];
            if (!bool.TryParse(showInvoiceSetting, out _ShowInvoiceAfterFinalize))
                _ShowInvoiceAfterFinalize = true;
            _Log.DebugFormat("ShowInvoiceAfterFinalize set to {0}.", _ShowInvoiceAfterFinalize);
            
            DocumentTypeCombobox.Text = @"Load";

            _IsBopsAdministrator = ActiveDirectoryUtility.ValidateCurrentUserIsGroupMember(_BopsAdministratorGroupName);
            _IsBopsPowerUser = ActiveDirectoryUtility.ValidateCurrentUserIsGroupMember(_BopsPowerUserGroupName);
            GrantDebuggingAdministrativeRights();

            if (!_IsBopsAdministrator)
                StripAdministrativeControls();
            if (!_IsBopsAdministrator && !_IsBopsPowerUser)
                StripPowerUserControls();

            // The administrative tab is for the non-functional Solomon export,
            // so I'm stripping it entirely for now. JBW 04/06/2017

            MainTabControl.TabPages.RemoveByKey("AdministrationPage");

            var readyForUse = false;
            EnableUi(false);
            try
            {
                UserCompanyDetails = DetermineUserCompanyDetails(null);
                readyForUse = (UserCompanyDetails != null) && CacheServiceData();
            }
            catch (Exception ex)
            {
                _Log.Error(ex);
            }
            EnableUi(true);

            if (readyForUse)
            {
                loginLabel.Text = UserCompanyDetails.ToString();
                changeLoginButton.Visible = UserCompanyDetails.MultipleOptions;
                EndDatePicker.Value = ReviewEndDatePicker.Value = DateTime.Now.Date.AddDays(1);
                BeginDatePicker.Value = ReviewBeginDatePicker.Value = EndDatePicker.Value.AddDays(-30);
                InvoiceBeginDatePicker.Value = DateTime.Now.Date.AddDays(-7);
                InvoiceEndDatePicker.Value = InvoiceBeginDatePicker.Value.AddDays(14);

                ConfigureBillsSelectedListview();

                base.OnLoad(e);
            }
            else
            {
                MessageHelper.ShowError("Could not initialize main form; the application will now close.");
                DialogResult = DialogResult.Cancel;
                Close();
            }
        }

        private void StripPowerUserControls()
        {
            ReviewPage.Controls.RemoveByKey("SaveApprovalsButton");
            ReviewPage.Controls.RemoveByKey("ApproveSelectedBillsButton");
            ReviewPage.Controls.RemoveByKey("UnapproveSelectedBillsButton");

            panel1.Controls.RemoveByKey("AddBillsToInvoiceButton");
            panel1.Controls.RemoveByKey("AddAllBillsToInvoiceButton");
            panel2.Controls.RemoveByKey("RemoveBillsFromInvoiceButton");
            panel2.Controls.RemoveByKey("RemoveAllBillsFromInvoiceButton");
            panel2.Controls.RemoveByKey("BulkInvoiceButton");
            panel2.Controls.RemoveByKey("CreateInvoiceButton");

            panel3.Controls.RemoveByKey("EditInvoiceDetailsButton");
            panel3.Controls.RemoveByKey("SubmitInvoiceForReviewButton");
            panel3.Controls.RemoveByKey("FinalizeInvoiceButton");
            panel4.Controls.RemoveByKey("EditInvoiceLineButton");
            panel4.Controls.RemoveByKey("AddManualChargeButton");
            panel4.Controls.RemoveByKey("EditInvoiceLinesButton");
        }

        private void StripAdministrativeControls()
        {
            MainTabControl.TabPages.RemoveByKey("AdministrationPage");
            panel1.Controls.RemoveByKey("ResetApprovedBillButton");
            panel4.Controls.RemoveByKey("ExportInvoicesButton");
            panel4.Controls.RemoveByKey("VoidInvoiceButton");
        }

        protected override void OnClosed(EventArgs e)
        {
            _Log.Info("RFS Invoice Utility form closing.");
            // TODO: free the whole RFS data context layer if necessary
            base.OnClosed(e);
        }

        private void ShowBillsButton_Click(object sender, EventArgs e)
        {
            if (BeginDatePicker.Value < EndDatePicker.Value)
            {
                EnableUi(false);
                CacheBillsToInvoice();
                PopulateBillsToInvoice(true);
                EnableUi(true);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("The end date must be greater than the begin date.");
            }
        }

        private void ShipperCombobox_SelectedIndexChanged(object Sender, EventArgs E)
        {
            if (!_UiEnabled) return;

            EnableUi(false);
            PopulateBillsToInvoice(false);
            EnableUi(true);
        }

        private void BillToCombobox_SelectedIndexChanged(object Sender, EventArgs E)
        {
            if (!_UiEnabled) return;

            EnableUi(false);
            PopulateBillsToInvoice(false);
            EnableUi(true);
        }

        private void ClearFiltersButton_Click(object Sender, EventArgs E)
        {
            if (!_UiEnabled) return;

            EnableUi(false);
            ShipperCombobox.SelectedIndex = 0;
            BillToCombobox.SelectedIndex = 0;
            PopulateBillsToInvoice(false);
            EnableUi(true);
        }

        private void AddBillsToInvoiceButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to add bills to an invoice.");
                return;
            }

            if (BillsAvailableListview.SelectedItems.Count > 0)
            {
                EnableUi(false);
                int BillsWithoutDates = 0;

                foreach (ListViewItem Item in BillsAvailableListview.SelectedItems)
                {
                    // Can't invoice a bill that doesn't yet have a date.

                    BopsRfsBillDetail Bd = Item.Tag as BopsRfsBillDetail;
                    if ((Bd != null) && !Bd.ServiceResult.BillingDate.HasValue)
                    {
                        BillsWithoutDates++;
                        continue;
                    }

                    BillsAvailableListview.Items.Remove(Item);
                    Item.Selected = false;
                    BillsSelectedListview.Items.Add(Item);
                }

                foreach (ColumnHeader Hdr in BillsSelectedListview.Columns)
                    Hdr.Width = -2;

                EnableUi(true);

                if (BillsWithoutDates > 0)
                    MessageHelper.ShowWarning(string.Format("{0} of the selected items could not be added to the invoice because they have no dates.", BillsWithoutDates));
            }
            else
            {
                MessageHelper.ShowInvalidOperation("You must select one or more bills to add to the invoice.");
            }
        }

        private void AddAllBillsToInvoiceButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to add bills to an invoice.");
                return;
            }

            if (BillsAvailableListview.Items.Count > 0)
            {
                EnableUi(false);
                int BillsWithoutDates = 0;

                foreach (ListViewItem Item in BillsAvailableListview.Items)
                {
                    // Can't invoice a bill that doesn't yet have a date.

                    BopsRfsBillDetail Bd = Item.Tag as BopsRfsBillDetail;
                    if ((Bd != null) && !Bd.ServiceResult.BillingDate.HasValue)
                    {
                        BillsWithoutDates++;
                        continue;
                    }

                    BillsAvailableListview.Items.Remove(Item);
                    Item.Selected = false;
                    BillsSelectedListview.Items.Add(Item);
                }

                foreach (ColumnHeader Hdr in BillsSelectedListview.Columns)
                    Hdr.Width = -2;

                EnableUi(true);

                if (BillsWithoutDates > 0)
                    MessageHelper.ShowWarning(string.Format("{0} of the selected items could not be added to the invoice because they have no dates.", BillsWithoutDates));
            }
            else
            {
                MessageHelper.ShowInvalidOperation("No bills available to add to the invoice.");
            }
        }

        private void RemoveBillsFromInvoiceButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to remove bills from an invoice.");
                return;
            }

            if (BillsSelectedListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You must select one or more bills to remove from the invoice.");
                return;
            }

            EnableUi(false);
            foreach (ListViewItem Item in BillsSelectedListview.SelectedItems)
                BillsSelectedListview.Items.Remove(Item);
            PopulateBillsToInvoice(false);
            EnableUi(true);
        }

        private void RemoveAllBillsFromInvoiceButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to remove bills from an invoice.");
                return;
            }

            if (BillsSelectedListview.Items.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("No bills available to remove from the invoice.");
                return;
            }

            EnableUi(false);
            BillsSelectedListview.Items.Clear();
            PopulateBillsToInvoice(false);
            EnableUi(true);
        }

        private string ValidateInvoice()
        {
            if (BillsSelectedListview.Items.Count < 1)
                return "At least one bill must be addd to the invoice contents.";

            var sb = new StringBuilder();
            bool singleShipper = true, singleBillTo = true;
            int invoiceShipper = 0, invoiceBillTo = 0;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                foreach (ListViewItem item in BillsSelectedListview.Items)
                {
                    var bd = item.Tag as BopsRfsBillDetail;
                    if (bd == null) continue;

                    var primaryDocumentStillExists = PrimaryBillingDocumentExists(rfsDataContext, bd.ServiceResult);

                    // Enforcing dates.

                    if (bd.ServiceResult.IsReceiver)
                    {
                        if (!primaryDocumentStillExists)
                            sb.AppendFormat("Receiver {0} no longer exists. ", bd.Receiver.ReceiverId);
                        else if (!bd.Receiver.DateReceived.HasValue)
                            sb.AppendFormat("Receiver {0} has no date. ", bd.Receiver.ReceiverId);
                    }
                    else if (bd.ServiceResult.IsBillOfLading)
                    {
                        if (!primaryDocumentStillExists)
                            sb.AppendFormat("BOL {0} no longer exists. ", bd.Shipper.LoadId);
                        else if (!bd.Shipper.ShipmentDate.HasValue)
                            sb.AppendFormat("BOL {0} has no date. ", bd.Shipper.LoadId);
                    }
                    else
                    {
                        if (!primaryDocumentStillExists)
                            sb.AppendFormat("Load {0} no longer exists. ", bd.Load.LoadReference);
                        else if (!bd.Load.LogOutDate.HasValue)
                            sb.AppendFormat("Load {0} has no logout date. ", bd.Load.LoadReference);
                    }

                    // Enforce single shipper/bill-to.

                    if (invoiceShipper == 0)
                        invoiceShipper = bd.ShipperClient.DestinationId;
                    if (invoiceBillTo == 0)
                        invoiceBillTo = bd.BillToClient.DestinationId;

                    if (bd.ShipperClient.DestinationId != invoiceShipper)
                        singleShipper = false;
                    if (bd.BillToClient.DestinationId != invoiceBillTo)
                        singleBillTo = false;
                }
            }
            catch (Exception ex)
            {
                _Log.Error("An exception occurred while validating invoice. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context.
            }

            if (!singleShipper)
                sb.Append("The invoice includes bills from more than one shipper stakeholder. ");
            if (!singleBillTo)
                sb.Append("The invoice includes bills for more than one bill-to stakeholder. ");

            return sb.ToString();
        }

        private void CreateInvoiceButton_Click(object sender, EventArgs e)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to create an invoice.");
                return;
            }

            if (string.IsNullOrEmpty(UserCompanyDetails.Company.InvoiceType))
            {
                MessageHelper.ShowSecurityError("Sorry, but the current login can't create invoices.");
                return;
            }

            // In the event that the user hasn't added any bills, we give them the option to create an invoice
            // from a single, manual bill.

            if (BillsSelectedListview.Items.Count == 0)
            {
                var result = MessageHelper.ShowConfirm("You have added no bills to the invoice. Would you like to create an invoice with a manual bill?");
                if (result != DialogResult.Yes)
                    return;

                var destinations = (from pair in _DestinationsMap
                                    where pair.Value.CompanyRef == UserCompanyDetails.Company.CompanyId
                                    select pair.Value).ToList();
                var servicesOffered = (from pair in _ServicesOfferedMap
                                       where pair.Value.CompanyRef == UserCompanyDetails.Company.CompanyId
                                       select pair.Value).ToList();
                var rfsLocations = (from pair in _RfsLocationMap
                                    where pair.Value.CompanyRef == UserCompanyDetails.Company.CompanyId
                                    select pair.Value).ToList();

                var newManualBillForm = new CreateInvoiceFromManualBillForm(destinations, servicesOffered, 
                    rfsLocations, UserCompanyDetails);

                if (newManualBillForm.ShowDialog() != DialogResult.OK)
                    return;

                // Initialize the data context by retrieving the relevant interface through the kernel.

                var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

                try
                {
                    // TODO: Improve this so the parent-child dual commit is more robust.
                    //
                    // The parent/child relationship between invoice and detail could possibly be 
                    // screwed up if one completes but the other fails, yet I don't have a good way
                    // with the new design (yet) to enforce saving children with parents.

                    rfsDataContext.AddInvoice(newManualBillForm.Invoice);
                    newManualBillForm.ManualBill.InvoiceRef = newManualBillForm.Invoice.InvoiceId;
                    rfsDataContext.AddInvoiceDetail(newManualBillForm.ManualBill);
                    rfsDataContext.SaveChanges();
                }
                catch (Exception exception)
                {
                    _Log.Error("An exception occurred creating a new invoice. Details follow.", exception);
                    MessageHelper.ShowError("An error occurred during the save. Contact IT support.");
                }
                finally
                {
                    // TODO: free the RFS data context.
                }

                return;
            }

            string errorString;

            try
            {
                errorString = ValidateInvoice();
            }
            catch (Exception e1)
            {
                _Log.Error("An error occurred while validating the invoice. Details follow.", e1);
                errorString = "An exception occurred while validating the invoice.";
            }

            if (errorString != string.Empty)
            {
                MessageHelper.ShowError(string.Format("The invoice cannot be created because of the following errors.\n\n{0}", errorString));
            }
            else
            {
                var result = MessageHelper.ShowConfirm("The invoice contents will be created in the order displayed. Are you sure you want to create the invoice now?");
                if (result != DialogResult.Yes)
                    return;

                var newForm = new CreateInvoiceDetailsForm
                {
                    UserCompanyDetails = UserCompanyDetails,
                    InvoiceType = UserCompanyDetails.Company.InvoiceType,
                    InvoiceDate = DateTime.Today
                };

                if (newForm.ShowDialog() != DialogResult.OK) return;

                EnableUi(false);
                CreateInvoice(newForm.InvoiceType, newForm.InvoiceDate, newForm.PublicNotes, newForm.PrivateNotes);
                EnableUi(true);
            }
        }

        private void ShowBillsToReviewButton_Click(object Sender, EventArgs E)
        {
            List<BopsRfsServiceCalculationResult> Approved = GetBillsMarkedApproved();
            if (Approved.Count > 0)
            {
                DialogResult Result = MessageHelper.ShowConfirm("You have approved bills without saving them; are you sure you want to reload and lose that work?");
                if (Result != DialogResult.Yes)
                    return;
            }

            if (ReviewBeginDatePicker.Value < ReviewEndDatePicker.Value)
            {
                EnableUi(false);
                CacheBillsToApprove();
                PopulateBillsToApprove(true);
                EnableUi(true);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("The end date must be greater than the begin date.");
            }
        }

        private void ApproveSelectedBillsButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to approve bills.");
                return;
            }

            foreach (ListViewItem Item in ReviewListview.SelectedItems)
            {
                BopsRfsBillDetail Bd = Item.Tag as BopsRfsBillDetail;
                if (Bd == null) continue;

                Bd.ServiceResult.BillingStatus = RfsBillingStatus.Approved;
                Item.BackColor = Color.LightGreen;
            }
        }

        private void UnapproveSelectedBillsButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to unapprove bills.");
                return;
            }

            foreach (ListViewItem Item in ReviewListview.SelectedItems)
            {
                BopsRfsBillDetail Bd = Item.Tag as BopsRfsBillDetail;
                if (Bd == null) continue;

                Bd.ServiceResult.BillingStatus = RfsBillingStatus.PendingReview;
                Item.BackColor = Color.FromKnownColor(KnownColor.Window);
            }
        }

        private List<BopsRfsServiceCalculationResult> GetBillsMarkedApproved()
        {
            List<BopsRfsServiceCalculationResult> ReturnValue = new List<BopsRfsServiceCalculationResult>();

            foreach (ListViewItem Item in ReviewListview.Items)
            {
                BopsRfsBillDetail Bd = Item.Tag as BopsRfsBillDetail;
                if (Bd != null && Bd.ServiceResult.BillingStatus == RfsBillingStatus.Approved)
                    ReturnValue.Add(Bd.ServiceResult);
            }

            return ReturnValue;
        }

        private static bool PrimaryBillingDocumentExists(IRfsDataContext rfsDataContext, BopsRfsServiceCalculationResult result)
        {
            object primaryBillingDocument;

            if (result.IsReceiver)
                primaryBillingDocument = rfsDataContext.GetReceiverById(result.DocumentId.Value);
            else if (result.IsBillOfLading)
                primaryBillingDocument = rfsDataContext.GetShipperById(result.DocumentId.Value);
            else
                primaryBillingDocument = rfsDataContext.GetLoadByReference(result.LoadRef);

            return primaryBillingDocument != null;
        }

        private void SaveApprovalsButton_Click(object sender, EventArgs e)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to save billing approval changes.");
                return;
            }

            var approved = GetBillsMarkedApproved();

            if (approved.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You have to mark at least one approval to save.");
                return;
            }
                
            var confirmResult = MessageHelper.ShowConfirm("Are you sure you want to approve the marked bills?");
            if (confirmResult != DialogResult.Yes) return;

            // At this point we know we have the right permissions, have bills to approve, and the user has
            // confirmed the operation. We're good to start working.

            var success = true;
            EnableUi(false);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var failureMessage = "An error occurred while saving approvals. Contact IT support.";

            try
            {
                foreach (var result in approved)
                {
                    // One last check before we go putting the billing document on an invoice.

                    if (!PrimaryBillingDocumentExists(rfsDataContext, result))
                    {
                        success = false;
                        failureMessage = "At least one of the bills cannot be approved because the load/receiver/BOL has been deleted. Contact IT support.";
                        break;
                    }

                    _Log.InfoFormat("Approving {0}", result);
                    UpdateResultAndBillStatus(rfsDataContext, result, RfsBillingStatus.Approved);
                }

                foreach (ListViewItem item in ReviewListview.Items)
                {
                    var bd = item.Tag as BopsRfsBillDetail;
                    if (bd != null && bd.ServiceResult.BillingStatus == RfsBillingStatus.Approved)
                        ReviewListview.Items.Remove(item);
                }
            }
            catch (Exception ex)
            {
                _Log.ErrorFormat("An exception occurred. Details follow.", ex);
                success = false;
            }
            finally
            {
                // TODO: free the RFS data context.
            }

            EnableUi(true);

            if (!success)
                MessageHelper.ShowError(failureMessage);
        }

        private static void UpdateResultAndBillStatus(IRfsDataContext rfsDataContext, 
            BopsRfsServiceCalculationResult serviceResult, RfsBillingStatus newStatus)
        {
            var freshResult = rfsDataContext.GetServiceCalculationResultById(serviceResult.ResultId);

            if (serviceResult.IsReceiver)
            {
                var receiverRecord = rfsDataContext.GetReceiverById(serviceResult.DocumentId.Value);
                receiverRecord.BillingStatus = newStatus;
            }
            else if (serviceResult.IsBillOfLading)
            {
                var shipperRecord = rfsDataContext.GetShipperById(serviceResult.DocumentId.Value);
                shipperRecord.BillingStatus = newStatus;
            }
            else
            {
                var load = rfsDataContext.GetLoadByReference(serviceResult.LoadRef);
                load.BillingStatus = newStatus;
            }

            freshResult.BillingStatus = serviceResult.BillingStatus = newStatus;
            rfsDataContext.SaveChanges();
        }

        private void UpdateResultAndBillStatus(IRfsDataContext rfsDataContext, 
            BopsRfsStorageBillingDetail storageDetail, RfsBillingStatus newStatus)
        {
            var freshDetail = rfsDataContext.GetStorageBillingDetailById(storageDetail.DetailId);
            freshDetail.BillingStatus = storageDetail.BillingStatus = newStatus;
            rfsDataContext.SaveChanges();
        }

        private BopsDestination LookupParentDestination(int ChildDestinationId)
        {
            BopsDestination ReturnValue = null;

            if (_DestinationsMap.ContainsKey(ChildDestinationId))
            {
                ReturnValue = _DestinationsMap[ChildDestinationId];

                if ((ReturnValue != null) && ReturnValue.ParentRef.HasValue && (ReturnValue.ParentRef.Value != ReturnValue.DestinationId) && _DestinationsMap.ContainsKey(ReturnValue.ParentRef.Value))
                    ReturnValue = _DestinationsMap[ReturnValue.ParentRef.Value];
            }

            return ReturnValue;
        }

        private void CreateInvoice(string InvoiceType, DateTime InvoiceDate, string PublicNotes, string PrivateNotes)
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var billDetails = new List<BopsRfsBillDetail>();
                var loadsToInvoice = new Dictionary<string, int>();

                foreach (ListViewItem item in BillsSelectedListview.Items)
                {
                    var bd = item.Tag as BopsRfsBillDetail;
                    Debug.Assert(bd != null);

                    if (bd.Load != null && !loadsToInvoice.ContainsKey(bd.Load.LoadReference))
                        loadsToInvoice.Add(bd.Load.LoadReference, 0);

                    billDetails.Add(bd);
                }

                var lifecycleManager = RfsFactory.GetRfsInvoiceLifecycleManager(rfsDataContext);
                var descriptionGenerator = new RfsInvoiceDescriptionGenerator(rfsDataContext, loadsToInvoice.Keys); 
                var invoicePackage = lifecycleManager.CreateInvoice(InvoiceType, InvoiceDate, PublicNotes, PrivateNotes, billDetails, 
                    descriptionGenerator, UserCompanyDetails.Company.CompanyId);
                Debug.Assert(invoicePackage != null);
                
                switch (invoicePackage.ErrorType)
                {
                    case InvoiceErrorType.None:
                        BillsSelectedListview.Items.Clear();
                        break;
                    case InvoiceErrorType.DetailsAlreadyInvoiced:
                        var newForm = new InvoiceDuplicatesForm
                        {
                            InvoiceDetails = new List<BopsRfsInvoiceDetail>(invoicePackage.Details)
                        };
                        newForm.ShowDialog();
                        return;
                    case InvoiceErrorType.UnknownException:
                        MessageHelper.ShowError("An error occurred while creating the invoice. Contact IT support.");
                        break;
                }                    
            }
            catch (Exception e)
            {
                _Log.Error("An exception occurred creating a new invoice. Details follow.", e);
                MessageHelper.ShowError("An error occurred while creating the invoice. Contact IT support.");
            }
            finally
            {
                // TODO: free the RFS data context
            }
        }

        #region Review Dates Context Menu

        private void last30DaysToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ReviewEndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            ReviewBeginDatePicker.Value = ReviewEndDatePicker.Value.AddDays(-30);
        }

        private void last15DaysToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ReviewEndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            ReviewBeginDatePicker.Value = ReviewEndDatePicker.Value.AddDays(-15);
        }

        private void last7DaysToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ReviewEndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            ReviewBeginDatePicker.Value = ReviewEndDatePicker.Value.AddDays(-7);
        }

        private void lastMonthToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ReviewEndDatePicker.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            ReviewBeginDatePicker.Value = ReviewEndDatePicker.Value.AddMonths(-1);
        }

        private void currentMonthToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ReviewBeginDatePicker.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            ReviewEndDatePicker.Value = ReviewBeginDatePicker.Value.AddMonths(1);
        }

        // The Alcoa current date option goes from last Wednesday through this Wednesday.

        private void alcoaCurrentToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            DateTime Today = DateTime.Now.Date;
            int DaysUntilWednesday = (int)DayOfWeek.Wednesday - (int)Today.DayOfWeek;

            if (DaysUntilWednesday >= 0)
            {
                ReviewEndDatePicker.Value = Today.AddDays(DaysUntilWednesday + 1);
                ReviewBeginDatePicker.Value = ReviewEndDatePicker.Value.AddDays(-8);
            }
            else
            {
                ReviewBeginDatePicker.Value = Today.AddDays(DaysUntilWednesday);
                ReviewEndDatePicker.Value = ReviewBeginDatePicker.Value.AddDays(8);
            }
        }

        #endregion

        #region Create Invoice Dates Context Menu

        private void last30DaysToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            EndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            BeginDatePicker.Value = EndDatePicker.Value.AddDays(-30);
        }

        private void last15DaysToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            EndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            BeginDatePicker.Value = EndDatePicker.Value.AddDays(-15);
        }

        private void lasy7DaysToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            EndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            BeginDatePicker.Value = EndDatePicker.Value.AddDays(-7);
        }

        private void lastMonthToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            EndDatePicker.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            BeginDatePicker.Value = EndDatePicker.Value.AddMonths(-1);
        }

        private void currentMonthToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            BeginDatePicker.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            EndDatePicker.Value = BeginDatePicker.Value.AddMonths(1);
        }

        private void alcoaCurrentToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            DateTime Today = DateTime.Now.Date;
            int DaysUntilWednesday = (int)DayOfWeek.Wednesday - (int)Today.DayOfWeek;

            if (DaysUntilWednesday >= 0)
            {
                EndDatePicker.Value = Today.AddDays(DaysUntilWednesday + 1);
                BeginDatePicker.Value = EndDatePicker.Value.AddDays(-8);
            }
            else
            {
                BeginDatePicker.Value = Today.AddDays(DaysUntilWednesday);
                EndDatePicker.Value = BeginDatePicker.Value.AddDays(8);
            }
        }

        #endregion

        #region Review Invoice Dates Context Menu

        private void last30DaysToolStripMenuItem2_Click(object Sender, EventArgs E)
        {
            InvoiceEndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            InvoiceBeginDatePicker.Value = InvoiceEndDatePicker.Value.AddDays(-30);
        }

        private void last15DaysToolStripMenuItem2_Click(object Sender, EventArgs E)
        {
            InvoiceEndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            InvoiceBeginDatePicker.Value = InvoiceEndDatePicker.Value.AddDays(-15);
        }

        private void last7DaysToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            InvoiceEndDatePicker.Value = DateTime.Now.AddDays(1).Date;
            InvoiceBeginDatePicker.Value = InvoiceEndDatePicker.Value.AddDays(-7);
        }

        private void lastMonthToolStripMenuItem2_Click(object Sender, EventArgs E)
        {
            InvoiceEndDatePicker.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            InvoiceBeginDatePicker.Value = InvoiceEndDatePicker.Value.AddMonths(-1);
        }

        private void currentMonthToolStripMenuItem2_Click(object Sender, EventArgs E)
        {
            InvoiceBeginDatePicker.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            InvoiceEndDatePicker.Value = InvoiceBeginDatePicker.Value.AddMonths(1);
        }

        private void alcoaCurrentToolStripMenuItem2_Click(object Sender, EventArgs E)
        {
            DateTime Today = DateTime.Now.Date;
            int DaysUntilWednesday = (int)DayOfWeek.Wednesday - (int)Today.DayOfWeek;

            if (DaysUntilWednesday >= 0)
            {
                InvoiceEndDatePicker.Value = Today.AddDays(DaysUntilWednesday + 1);
                InvoiceBeginDatePicker.Value = InvoiceEndDatePicker.Value.AddDays(-8);
            }
            else
            {
                InvoiceBeginDatePicker.Value = Today.AddDays(DaysUntilWednesday);
                InvoiceEndDatePicker.Value = InvoiceBeginDatePicker.Value.AddDays(8);
            }
        }

        #endregion

        private void ShowInvoicesButton_Click(object Sender, EventArgs E)
        {
            if (InvoiceBeginDatePicker.Value < InvoiceEndDatePicker.Value)
            {
                EnableUi(false);
                CacheInvoicesToReview();
                PopulateInvoicesToReview(true);
                EnableUi(true);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("The end date must be greater than the begin date.");
            }
        }

        private void PopulateInvoicesToReview(bool RepopulateFilters)
        {
            // Columns:
            //
            //  0   ID
            //  1   Date
            //  2   Type
            //  3   Total
            //  4   Status
            //  5   Shipper
            //  6   Bill To
            //  7   Private Notes

            _InvoicesCompareFactory = new ListViewComparerFactory(8);
            _InvoicesCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _InvoicesCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _InvoicesCompareFactory[6].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            // Populate a map of invoice types for quick lookup below

            var invoiceConfiguration = (InvoiceConfigurationSection)ConfigurationManager.GetSection("invoicetypes");
            var invoiceTypeMap = new Dictionary<string, string>();
            foreach (InvoiceElement invoiceElement in invoiceConfiguration.Invoices)
            {
                invoiceTypeMap.Add(invoiceElement.Key, invoiceElement.Name);
            }

            InvoiceDetailsListview.Items.Clear();

            Dictionary<int, BopsDestination> ShipperList = new Dictionary<int, BopsDestination>();
            Dictionary<int, BopsDestination> BillToList = new Dictionary<int, BopsDestination>();

            BopsDestination SelectedShipper = null, SelectedBillTo = null;
            BopsRfsInvoiceStatus SelectedStatus = InvoiceFilterCombobox.SelectedItem as BopsRfsInvoiceStatus;
            if (!RepopulateFilters)
            {
                SelectedShipper = InvoiceShipperCombobox.SelectedItem as BopsDestination;
                SelectedBillTo = InvoiceBillToCombobox.SelectedItem as BopsDestination;
            }

            InvoiceListview.Items.Clear();
            InvoiceListview.SuspendLayout();

            foreach (BopsRfsInvoice Invoice in _InvoicesToReview)
            {
                ListViewItem NewItem = new ListViewItem(Invoice.InvoiceId.ToString());
                NewItem.SubItems.Add(Invoice.InvoiceDate.ToString("d"));
                NewItem.SubItems.Add(invoiceTypeMap[Invoice.InvoiceType]);

                BopsDestination ShipperStakeholder = null;
                BopsDestination BillToStakeholder = null;
                string BillToString;
                string ShipperString = BillToString = "?";

                if (_DestinationsMap.ContainsKey(Invoice.ShipperRef))
                {
                    ShipperStakeholder = _DestinationsMap[Invoice.ShipperRef];

                    if (!ShipperList.ContainsKey(ShipperStakeholder.DestinationId))
                        ShipperList.Add(ShipperStakeholder.DestinationId, ShipperStakeholder);

                    ShipperString = ShipperStakeholder.ToString();
                }

                if (_DestinationsMap.ContainsKey(Invoice.BillToRef))
                {
                    BillToStakeholder = _DestinationsMap[Invoice.BillToRef];

                    if (!BillToList.ContainsKey(BillToStakeholder.DestinationId))
                        BillToList.Add(BillToStakeholder.DestinationId, BillToStakeholder);

                    BillToString = BillToStakeholder.ToString();
                }

                NewItem.SubItems.Add(string.Format("{0:c}", Invoice.InvoiceTotal));
                NewItem.SubItems.Add(_InvoiceStatusMap[Invoice.InvoiceStatus].Status);
                NewItem.SubItems.Add(ShipperString);
                NewItem.SubItems.Add(BillToString);
                NewItem.SubItems.Add(Invoice.PrivateNotes);

                NewItem.BackColor = Invoice.HideFromClients ? Color.LightGray : Color.FromKnownColor(KnownColor.Window);

                bool PassesShipperFilter = true;
                if (SelectedShipper != null)
                {
                    if (ShipperStakeholder == null || ShipperStakeholder.DestinationId != SelectedShipper.DestinationId)
                        PassesShipperFilter = false;
                }

                bool PassesBillToFilter = true;
                if (SelectedBillTo != null)
                {
                    if (BillToStakeholder == null || BillToStakeholder.DestinationId != SelectedBillTo.DestinationId)
                        PassesBillToFilter = false;
                }

                bool PassesInvoiceFilter = true;
                if (SelectedStatus != null)
                {
                    if (SelectedStatus.StatusEnum != Invoice.InvoiceStatus)
                        PassesInvoiceFilter = false;
                }

                if (!PassesShipperFilter || !PassesBillToFilter || !PassesInvoiceFilter) continue;

                NewItem.Tag = new InvoiceDetails(Invoice, ShipperStakeholder, BillToStakeholder);
                InvoiceListview.Items.Add(NewItem);
            }

            foreach (ColumnHeader Hdr in InvoiceListview.Columns)
                Hdr.Width = -2;
            InvoiceListview.ResumeLayout();

            if (!RepopulateFilters) return;

            InvoiceShipperCombobox.Items.Clear();
            InvoiceShipperCombobox.Items.Add("(show all)");
            foreach (KeyValuePair<int, BopsDestination> Pair in ShipperList)
            {
                InvoiceShipperCombobox.Items.Add(Pair.Value);
            }
            InvoiceShipperCombobox.SelectedIndex = 0;

            InvoiceBillToCombobox.Items.Clear();
            InvoiceBillToCombobox.Items.Add("(show all)");
            foreach (KeyValuePair<int, BopsDestination> Pair in BillToList)
            {
                InvoiceBillToCombobox.Items.Add(Pair.Value);
            }
            InvoiceBillToCombobox.SelectedIndex = 0;
        }

        private void InvoiceBillToCombobox_SelectedIndexChanged(object Sender, EventArgs E)
        {
            if (!_UiEnabled) return;

            EnableUi(false);
            PopulateInvoicesToReview(false);
            EnableUi(true);
        }

        private void InvoiceFilterCombobox_SelectedIndexChanged(object Sender, EventArgs E)
        {
            if (!_UiEnabled || (_InvoicesToReview == null)) return;

            EnableUi(false);
            PopulateInvoicesToReview(false);
            EnableUi(true);
        }

        private void InvoiceListview_SelectedIndexChanged(object Sender, EventArgs E)
        {
            PopulateInvoiceDetails();
        }

        static Dictionary<string, double> GetGroupTotals(IEnumerable<BopsRfsInvoiceDetail> DetailLines)
        {
            Dictionary<string, double> ReturnValue = new Dictionary<string, double>();

            foreach (BopsRfsInvoiceDetail Line in DetailLines)
            {
                if (string.IsNullOrEmpty(Line.GroupName)) continue;

                if (ReturnValue.ContainsKey(Line.GroupName))
                    ReturnValue[Line.GroupName] += Line.ItemTotal;
                else
                    ReturnValue.Add(Line.GroupName, Line.ItemTotal);
            }

            return ReturnValue;
        }

        private void AddInvoiceLineToListview(BopsRfsInvoiceDetail NewLine, BopsRfsInvoiceDetail TagLine)
        {
            ListViewItem NewItem = new ListViewItem(NewLine.LineNumberDisplayed.ToString());
            NewItem.SubItems.Add(NewLine.DetailTypeString);
            NewItem.SubItems.Add(NewLine.GroupName);
            NewItem.SubItems.Add(NewLine.ItemDate.ToString("d"));
            NewItem.SubItems.Add(string.Format("{0:c}", NewLine.ItemTotal));

            // TODO: uncomment the last predicate if we add a show group details checkbox to the form.

            if (!string.IsNullOrEmpty(NewLine.GroupName)/* && !ShowGroupDetailCheckbox.Checked*/)
                NewItem.SubItems.Add(NewLine.GroupName);
            else
                NewItem.SubItems.Add(NewLine.ItemDescription);

            NewItem.Tag = TagLine ?? NewLine;

            if (!string.IsNullOrEmpty(NewLine.GroupName))
                NewItem.BackColor = Color.LightGray;

            InvoiceDetailsListview.Items.Add(NewItem);
        }

        private void ShowBillDetails(BopsRfsBillDetail Bd)
        {
            if (Bd.ServiceResult.IsReceiver)
            {
                ViewReceiverDetailsForm NewForm = new ViewReceiverDetailsForm();
                NewForm.ReceiverDetails = Bd.Receiver;
                if (_ServicesRequestedMap.ContainsKey(Bd.ServiceResult.ServiceId))
                    NewForm.ServiceRequested = _ServicesRequestedMap[Bd.ServiceResult.ServiceId];
                NewForm.CalculationDetails = Bd.ServiceResult.PublicRate.CalculationDetails;
                NewForm.ShowDialog();
            }
            else if (Bd.ServiceResult.IsBillOfLading)
            {
                ViewShipperDetailsForm NewForm = new ViewShipperDetailsForm();
                NewForm.ShipperDetails = Bd.Shipper;
                if (_ServicesRequestedMap.ContainsKey(Bd.ServiceResult.ServiceId))
                    NewForm.ServiceRequested = _ServicesRequestedMap[Bd.ServiceResult.ServiceId];
                NewForm.CalculationDetails = Bd.ServiceResult.PublicRate.CalculationDetails;
                NewForm.ShowDialog();
            }
            else
            {
                ViewLoadDetailsForm NewForm = new ViewLoadDetailsForm();

                // TODO: fix this code not to fault when the load doesn't exist? They should be filtered now.

                NewForm.LoadDetails = Bd.Load;
                if (_ServicesRequestedMap.ContainsKey(Bd.ServiceResult.ServiceId))
                    NewForm.ServiceRequested = _ServicesRequestedMap[Bd.ServiceResult.ServiceId];
                if (Bd.Load.OriginRef.HasValue && _DestinationsMap.ContainsKey(Bd.Load.OriginRef.Value))
                    NewForm.OriginDetails = _DestinationsMap[Bd.Load.OriginRef.Value];
                if (Bd.Load.DeliveryLocationRef.HasValue && _DestinationsMap.ContainsKey(Bd.Load.DeliveryLocationRef.Value))
                    NewForm.DestinationDetails = _DestinationsMap[Bd.Load.DeliveryLocationRef.Value];
                NewForm.CalculationDetails = Bd.ServiceResult.PublicRate.CalculationDetails;
                NewForm.ShowDialog();
            }
        }

        private void ShowListViewBillDetails(ListView Lv)
        {
            if (Lv.SelectedItems.Count == 1)
            {
                ListViewItem Item = Lv.SelectedItems[0];
                BopsRfsBillDetail Bd = Item.Tag as BopsRfsBillDetail;
                if (Bd != null)
                    ShowBillDetails(Bd);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("Select a single bill to view its details.");
            }
        }

        private void ReviewListview_MouseDoubleClick(object Sender, MouseEventArgs E)
        {
            ShowListViewBillDetails(ReviewListview);
        }

        private void ShowBillDetailsButton_Click(object Sender, EventArgs E)
        {
            ShowListViewBillDetails(ReviewListview);
        }

        private void BillsAvailableListview_DoubleClick(object Sender, EventArgs E)
        {
            ShowListViewBillDetails(BillsAvailableListview);
        }

        private void ShowAvailableBillDetails_Click(object Sender, EventArgs E)
        {
            ShowListViewBillDetails(BillsAvailableListview);
        }

        private void BillsSelectedListview_DoubleClick(object Sender, EventArgs E)
        {
            ShowListViewBillDetails(BillsSelectedListview);
        }

        private void ShowSelectedBillDetails_Click(object Sender, EventArgs E)
        {
            ShowListViewBillDetails(BillsSelectedListview);
        }

        private void ReviewListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (ReviewListview.Items.Count <= 0) return;

            ReviewListview.ListViewItemSorter = _ReviewCompareFactory.CreateComparerForColumn(E.Column);
            ReviewListview.Sort();
        }

        private void BillsAvailableListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (BillsAvailableListview.Items.Count <= 0) return;

            BillsAvailableListview.ListViewItemSorter = _BillsAvailableCompareFactory.CreateComparerForColumn(E.Column);
            BillsAvailableListview.Sort();
        }

        private void BillsSelectedListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (BillsSelectedListview.Items.Count <= 0) return;

            BillsSelectedListview.ListViewItemSorter = _BillsSelectedCompareFactory.CreateComparerForColumn(E.Column);
            BillsSelectedListview.Sort();
        }

        private void InvoiceListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (InvoiceListview.Items.Count <= 0) return;

            InvoiceListview.ListViewItemSorter = _InvoicesCompareFactory.CreateComparerForColumn(E.Column);
            InvoiceListview.Sort();
        }

        private void InvoiceDetailsListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (InvoiceDetailsListview.Items.Count <= 0) return;

            InvoiceDetailsListview.ListViewItemSorter = _InvoiceDetailsCompareFactory.CreateComparerForColumn(E.Column);
            InvoiceDetailsListview.Sort();
        }

        private void EditSelectedInvoiceDetails()
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to edit an invoice.");
                return;
            }

            if (InvoiceListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("To edit invoice details, select a single invoice and then click the button.");
            }
            else
            {
                var invoiceItem = InvoiceListview.SelectedItems[0];
                var id = invoiceItem.Tag as InvoiceDetails;
                Debug.Assert(id != null);

                if (id.Invoice.InvoiceStatus >= RfsInvoiceStatus.Closed)
                {
                    MessageHelper.ShowInvalidOperation("The invoice has already been finalized and may not be changed.");
                    return;
                }

                var newForm = new CreateInvoiceDetailsForm
                {
                    InvoiceType = id.Invoice.InvoiceType,
                    InvoiceDate = id.Invoice.InvoiceDate,
                    PrivateNotes = id.Invoice.PrivateNotes,
                    PublicNotes = id.Invoice.PublicNotes,
                    UserCompanyDetails = UserCompanyDetails
                };

                var result = newForm.ShowDialog();
                if (result == DialogResult.OK)
                {
                    var success = false;
                    EnableUi(false);

                    // Initialize the data context by retrieving the relevant interface through the kernel.

                    var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
                    
                    try
                    {
                        var invoice = rfsDataContext.GetInvoiceById(id.Invoice.InvoiceId);

                        invoice.InvoiceType = id.Invoice.InvoiceType = newForm.InvoiceType;
                        invoice.InvoiceDate = id.Invoice.InvoiceDate = newForm.InvoiceDate;
                        invoice.PrivateNotes = id.Invoice.PrivateNotes = newForm.PrivateNotes;
                        invoice.PublicNotes = id.Invoice.PublicNotes = newForm.PublicNotes;

                        // TODO: make sure the new invoice gets saved.
                        rfsDataContext.SaveChanges();

                        // Populate a map of invoice types to set the text in the list view properly

                        var invoiceConfiguration = (InvoiceConfigurationSection)ConfigurationManager.GetSection("invoicetypes");
                        var invoiceTypeMap = new Dictionary<string, string>();
                        foreach (InvoiceElement invoiceElement in invoiceConfiguration.Invoices)
                        {
                            invoiceTypeMap.Add(invoiceElement.Key, invoiceElement.Name);
                        }

                        // Column reference (copied from PopulateInvoicesToReview method)
                        //
                        //  0   ID
                        //  1   Date
                        //  2   Type
                        //  3   Total
                        //  4   Status
                        //  5   Shipper
                        //  6   Bill To
                        //  7   Private Notes

                        invoiceItem.SubItems[1] = new ListViewItem.ListViewSubItem(invoiceItem, id.Invoice.InvoiceDate.ToString("d"));
                        invoiceItem.SubItems[2] = new ListViewItem.ListViewSubItem(invoiceItem, invoiceTypeMap[id.Invoice.InvoiceType]);
                        invoiceItem.SubItems[7] = new ListViewItem.ListViewSubItem(invoiceItem, id.Invoice.PrivateNotes);

                        success = true;
                    }
                    catch (Exception e1)
                    {
                        _Log.ErrorFormat("An exception occurred trying to update invoice {0}. Details follow.", id.Invoice.InvoiceId);
                        _Log.Error(e1);
                    }
                    finally
                    {
                        EnableUi(true);
                        // TODO: free the RFS data context.
                    }

                    if (!success)
                        MessageHelper.ShowError("An error occurred during the invoice update. Contact IT support.");
                }
            }
        }

        private void EditInvoiceDetailsButton_Click(object Sender, EventArgs E)
        {
            EditSelectedInvoiceDetails();
        }

        private void InvoiceListview_DoubleClick(object Sender, EventArgs E)
        {
            EditSelectedInvoiceDetails();
        }

        private void InvoiceDetailsListview_DoubleClick(object Sender, EventArgs E)
        {
            EditInvoiceLines();
        }

        private void PrintPreviewInvoiceButton_Click(object Sender, EventArgs E)
        {
            if (InvoiceListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("To preview an invoice, select a single line and then click the button.");
            }
            else
            {
                ListViewItem InvoiceItem = InvoiceListview.SelectedItems[0];
                InvoiceDetails Id = InvoiceItem.Tag as InvoiceDetails;
                Debug.Assert(Id != null);

                // Code to set the report into a Crystal Reports viewer. The try/catch block will catch any
                // exception that may occur if the reporting framework isn't installed correctly.

                try
                {
                    InvoicePreviewForm NewForm = new InvoicePreviewForm(Id.Invoice.InvoiceId, Id.Invoice.InvoiceType);
                    NewForm.ShowDialog();
                }
                catch (Exception E1)
                {
                    _Log.Error("An exception occurred, which may mean Crystal Reports is not installed properly. Details follow.", E1);
                    MessageHelper.ShowError("An exception occurred, which may mean Crystal Reports is not installed properly. Contact IT.");
                }
            }
        }

        private void ResetApprovedBillButton_Click(object sender, EventArgs e)
        {
            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to unapprove bills.");
                return;
            }

            if (BillsAvailableListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You must select at least one bill to unapprove.");
                return;
            }

            var success = false;
            const string failureMessage = "An error occurred while unapproving the bill(s). Contact IT support.";
            var result = MessageHelper.ShowConfirm("Are you sure you want to unapprove the bill(s)?");
            if (result != DialogResult.Yes)
                return;

            // At this point we have the right permissions, we have bills to unapprove, and the user has confirmed.
            // We're good to go to work.

            EnableUi(false);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var doomedItems = new List<ListViewItem>();

            try
            {
                foreach (ListViewItem item in BillsAvailableListview.SelectedItems)
                {
                    var bd = item.Tag as BopsRfsBillDetail;
                    if (bd == null) continue;

                    _Log.InfoFormat("Unapproving {0}", bd.ServiceResult.ToString());
                    UpdateResultAndBillStatus(rfsDataContext, bd.ServiceResult, RfsBillingStatus.PendingReview);
                    doomedItems.Add(item);
                }

                // We only remove the items in case of success, insofar as the rollback makes
                // the operation atomic. They're either all good or unchanged.

                foreach (var item in doomedItems)
                    BillsAvailableListview.Items.Remove(item);

                success = true;
            }
            catch (Exception e1)
            {
                _Log.ErrorFormat("An exception occurred while unapproving a bill. Details follow.", e1);
            }
            finally
            {
                // TODO: free the RFS data context.
            }

            EnableUi(true);

            if (!success)
                MessageHelper.ShowError(failureMessage);
        }

        private void FinalizeInvoiceButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to finalize an invoice.");
                return;
            }

            // Make sure we have one and only one invoice selected.

            if (InvoiceListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select a single invoice to finalize.");
                return;
            }

            ListViewItem InvoiceItem = InvoiceListview.SelectedItems[0];
            InvoiceDetails Id = InvoiceItem.Tag as InvoiceDetails;
            Debug.Assert(Id != null);

            // Prevent finalization until the invoice has been submitted for review.

            if (Id.Invoice.InvoiceStatus != RfsInvoiceStatus.PendingReview)
            {
                if (Id.Invoice.InvoiceStatus < RfsInvoiceStatus.PendingReview)
                    MessageHelper.ShowInvalidOperation("An invoice must be submitted for review before it can be finalized.");
                else
                    MessageHelper.ShowInvalidOperation("The invoice has already been finalized.");

                return;
            }

            // Confirm that the user really wants to finalize the invoice.

            ConfirmFinalizeInvoiceForm ConfirmForm = new ConfirmFinalizeInvoiceForm(_ShowInvoiceAfterFinalize);
            DialogResult Result = ConfirmForm.ShowDialog();
            //DialogResult Result = MessageHelper.ShowConfirm("Are you sure you want to finalize the invoice?");
            if (Result != DialogResult.Yes)
                return;
            _ShowInvoiceAfterFinalize = ConfirmForm.ShowFinalizedInvoice;

            EnableUi(false);
            string FinalInvoiceFilename;
            bool Success = FinalizeInvoice(Id.Invoice, out FinalInvoiceFilename);
            EnableUi(true);

            if (Success)
            {
                string NewStatusText = _InvoiceStatusMap[RfsInvoiceStatus.Closed].Status;
                InvoiceItem.SubItems[3] = new ListViewItem.ListViewSubItem(InvoiceItem, NewStatusText);
                _Log.InfoFormat("Invoice {0} successfully finalized.", Id.Invoice.InvoiceId);
            }
            else
            {
                MessageHelper.ShowError("An error occurred while finalizing the invoice. Contact IT support.");
            }

            try
            {
                if (Success && _ShowInvoiceAfterFinalize)
                    Process.Start(FinalInvoiceFilename);
            }
            catch (Exception E2)
            {
                _Log.ErrorFormat("An exception occurred while displaying invoice {0}. Details follow.", Id.Invoice.InvoiceId);
                _Log.Error(E2);

                MessageHelper.ShowError("The invoice PDF file could not be opened. This often means a PDF reader application is not installed. Contact IT support.");
            }
        }

        private bool FinalizeInvoice(BopsRfsInvoice invoice, out string finalInvoiceFilename)
        {
            /*
             * The steps involved in finalizing an invoice are:
             * 
             *      Recompute and validate that the total is correct.
             *      Generate the final PDF.
             *      Copy the final PDF to the proper share location.
             *      If that has all succeeded, then update the database:
             *          Update the invoice folder/filename (and total if needed).
             *          Update all the corresponding billing documents.
             *          Lock the invoice.
             */

            bool success;
            var invoiceOnFileShare = false;
            finalInvoiceFilename = null;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var freshInvoice = rfsDataContext.GetInvoiceById(invoice.InvoiceId);

                // This should never happen, but this is my attempt at preventing multiple documents for the same invoice.

                if (freshInvoice.DocumentFolder != null && freshInvoice.DocumentFileName != null)
                {
                    var doomedFile = Path.Combine(freshInvoice.DocumentFolder, freshInvoice.DocumentFileName);
                    _Log.WarnFormat("Invoice {0} was already finalized. Deleting previous document: {0}", doomedFile);
                    File.Delete(doomedFile);
                }

                var applicationPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetModules()[0].FullyQualifiedName);
                var temporaryFilename = Path.Combine(applicationPath, "InvoiceLastFinalized.pdf");

                // The Crystal Report object must be closed and disposed, or else the runtime will eventually
                // throw a System.Runtime.InteropServices.COMException. The using block should ensure that the
                // object is disposed properly.

                var factory = new InvoiceFactory();
                using (var report = factory.ManufactureCrystalReport(freshInvoice.InvoiceType))
                {
                    report.SetParameterValue("InvoiceId", freshInvoice.InvoiceId);
                    report.SetParameterValue("ForceFinal", true);
                    report.ExportToDisk(ExportFormatType.PortableDocFormat, temporaryFilename);
                    report.Close();
                }

                var invoiceShareRoot = ConfigurationManager.AppSettings["InvoicePublishingRoot"];
                var invoiceFolder = Path.Combine(invoiceShareRoot, freshInvoice.InvoiceDate.ToString("yyyy-MM-dd"));
                if (!Directory.Exists(invoiceFolder))
                    Directory.CreateDirectory(invoiceFolder);
                var invoiceFilename = string.Format("RFS Invoice {0:d8}.pdf", freshInvoice.InvoiceId);
                finalInvoiceFilename = Path.Combine(invoiceFolder, invoiceFilename);
                File.Copy(temporaryFilename, finalInvoiceFilename, true);

                invoiceOnFileShare = true;

                var freshInvoiceDetails = rfsDataContext.GetInvoiceDetailsByInvoiceId(freshInvoice.InvoiceId);

                var detailTotal = 0.0;
                foreach (var detail in freshInvoiceDetails)
                {
                    detailTotal += detail.ItemTotal;

                    if (detail.IsServiceBill)
                    {
                        var freshResult = rfsDataContext.GetServiceCalculationResultById(detail.ServiceCalculationResultRef.Value);
                        UpdateResultAndBillStatus(rfsDataContext, freshResult, RfsBillingStatus.Invoiced);
                    }
                    else if (detail.IsStorageBill)
                    {
                        var freshDetail = rfsDataContext.GetStorageBillingDetailById(detail.StorageBillingDetailRef.Value);
                        UpdateResultAndBillStatus(rfsDataContext, freshDetail, RfsBillingStatus.Invoiced);
                    }
                }

                // This should never happen, but this is my attempt at making sure the invoice total is correct.

                if (detailTotal != freshInvoice.InvoiceTotal)
                {
                    _Log.WarnFormat("Invoice {0} total ({1:c}) does not match detail total ({2:c}); correcting invoice during finalize.",
                                    freshInvoice.InvoiceId, freshInvoice.InvoiceTotal, detailTotal);
                    freshInvoice.InvoiceTotal = detailTotal;
                }

                freshInvoice.DateClosed = DateTime.Now;
                freshInvoice.InvoiceStatus = RfsInvoiceStatus.Closed;
                freshInvoice.DocumentFolder = invoiceFolder;
                freshInvoice.DocumentFileName = invoiceFilename;
                rfsDataContext.SaveChanges();
                success = true;
            }
            catch (Exception ex)
            {
                success = false;
                if (invoiceOnFileShare)
                    File.Delete(finalInvoiceFilename);
                _Log.ErrorFormat("An exception occurred while finalizing invoice {0}. Details follow.", invoice.InvoiceId);
                _Log.Error(ex);
            }
            finally
            {
                // TODO: free the RFS data context.
            }

            return success;
        }

        private void SubmitInvoiceForReviewButton_Click(object sender, EventArgs e)
        {
            // The user must have at least power user privileges.

            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to submit an invoice for review.");
                return;
            }

            // Make sure we have at least one invoice selected.

            if (InvoiceListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You must select at least one invoice to submit for review.");
                return;
            }

            // Check to ensure that only open invoices are selected.

            foreach (ListViewItem item in InvoiceListview.SelectedItems)
            {
                var id = item.Tag as InvoiceDetails;
                Debug.Assert(id != null);
                if (id.Invoice.InvoiceStatus == RfsInvoiceStatus.Open) continue;
                MessageHelper.ShowInvalidOperation("Only open invoices may be submitted for review.");
                return;
            }

            // Confirm that the user wants to finalize the invoice(s).

            var result = MessageHelper.ShowConfirm("Are you sure you want to submit the invoice for review?");
            if (result != DialogResult.Yes)
            {
                return;
            }

            // Set invoice(s) ready to be reviewed.

            bool success;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            const string failureMessage = "An error occurred while marking the invoice(s) ready for review. Contact IT support.";
            string newStatusText = _InvoiceStatusMap[RfsInvoiceStatus.PendingReview].Status;

            try
            {
                EnableUi(false);

                var index = 0;
                var invoiceIds = new int[InvoiceListview.SelectedItems.Count];
                foreach (ListViewItem item in InvoiceListview.SelectedItems)
                {
                    var id = item.Tag as InvoiceDetails;
                    Debug.Assert(id != null);
                    invoiceIds[index++] = id.Invoice.InvoiceId;
                }

                var freshInvoices = rfsDataContext.GetInvoicesByIds(invoiceIds);
                foreach (var invoice in freshInvoices)
                {
                    invoice.InvoiceStatus = RfsInvoiceStatus.PendingReview;
                }
                rfsDataContext.SaveChanges();

                foreach (ListViewItem item in InvoiceListview.SelectedItems)
                    item.SubItems[3] = new ListViewItem.ListViewSubItem(item, newStatusText);
                foreach (ColumnHeader hdr in InvoiceListview.Columns)
                    hdr.Width = -2;
                InvoiceListview.ResumeLayout();

                success = true;
            }
            catch (Exception e1)
            {
                success = false;
                _Log.ErrorFormat("An exception occurred while marking invoice(s) ready for review. Details follow.");
                _Log.Error(e1);
            }
            finally
            {
                // TODO: free the RFS data context.
            }

            EnableUi(true);

            if (success)
                _Log.InfoFormat("Invoice(s) successfully submitted for review.");
            else
                MessageHelper.ShowError(failureMessage);
        }

        private void showBillDetailsToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ShowListViewBillDetails(ReviewListview);
        }

        private void selectByRFSToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            if (ReviewListview.Items.Count > 0)
            {
                StringRepresentationComparer Comparer = new StringRepresentationComparer(StringRepresentationComparer.SortType.Integer,
                    StringRepresentationComparer.SortDirection.Ascending);
                ListViewSelectByColumnForm NewForm = new ListViewSelectByColumnForm(ReviewListview, 2, Comparer);
                NewForm.ShowDialog();
            }
            else
            {
                MessageHelper.ShowInvalidOperation("There are no bills displayed; you may not select by RFS.");
            }
        }

        private void investigateBillToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            InvestigateFromListview(ReviewListview);
        }

        private void EditInvoiceLinesButton_Click(object Sender, EventArgs E)
        {
            EditInvoiceLines();
        }

        private void EditInvoiceLines()
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to edit an invoice.");
                return;
            }

            if (InvoiceListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("To edit invoice lines you must select a single invoice.");
                return;
            }

            var invoiceItem = InvoiceListview.SelectedItems[0];
            var id = invoiceItem.Tag as InvoiceDetails;
            Debug.Assert(id != null);

            var readOnly = (id.Invoice.InvoiceStatus >= RfsInvoiceStatus.Closed);
            var servicesOffered = new List<BopsRfsServicesOffered>();
            foreach (var pair in _ServicesOfferedMap)
                servicesOffered.Add(pair.Value);
            var newForm = new InvoiceEditLinesForm(id.Invoice.InvoiceId, _IsBopsAdministrator, readOnly, UserCompanyDetails);
            var result = newForm.ShowDialog();
            if (readOnly || (result != DialogResult.OK)) return;

            var success = false;
            const string failureMessage = "An error occurred while unapproving the bill(s). Contact IT support.";

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            EnableUi(false);

            try
            {
                var freshInvoice = rfsDataContext.GetInvoiceById(id.Invoice.InvoiceId);

                // Unapprove any bills that have been marked as such within the dialog.

                foreach (var doomedDetail in newForm.UnapprovedBills)
                {
                    if (doomedDetail.IsServiceBill)
                    {
                        var serviceResult = rfsDataContext.GetServiceCalculationResultById(doomedDetail.ServiceCalculationResultRef.Value);
                        _Log.InfoFormat("Unapproving {0} from invoice", serviceResult);
                        UpdateResultAndBillStatus(rfsDataContext, serviceResult, RfsBillingStatus.PendingReview);
                    }
                    else if (doomedDetail.IsStorageBill)
                    {
                        var storageDetail = rfsDataContext.GetStorageBillingDetailById(doomedDetail.StorageBillingDetailRef.Value);
                        _Log.InfoFormat("Unapproving {0} from invoice", storageDetail.ToString());
                        UpdateResultAndBillStatus(rfsDataContext, storageDetail, RfsBillingStatus.Approved);
                    }
                }

                // Now delete the existing invoice lines as a prelude to saving the new set. Technically, we have the 
                // current invoice lines in memory, but I'm using HQL to delete all lines for the invoice, just to be safe.

                rfsDataContext.RemoveInvoiceDetails(id.Invoice.InvoiceId);

                var invoiceTotal = 0.0;
                foreach (var newLine in newForm.Lines)
                {
                    newLine.InvoiceRef = id.Invoice.InvoiceId;  // Should be set by the dialog but setting here just to be safe.
                    invoiceTotal += Math.Round(newLine.ItemTotal, 2);
                    rfsDataContext.AddInvoiceDetail(newLine);
                }

                // Now update the invoice record in case the total has changed.

                freshInvoice.InvoiceTotal = id.Invoice.InvoiceTotal = Math.Round(invoiceTotal, 2);

                // We're done with the database stuff, so commit the transaction.

                // TODO: make sure it gets saved properly
                rfsDataContext.SaveChanges();

                // Now set the new batch of lines into the cache and update the UI.

                _InvoiceDetailsMap[id.Invoice.InvoiceId] = newForm.Lines;
                invoiceItem.SubItems[3].Text = string.Format("{0:c}", id.Invoice.InvoiceTotal);
                PopulateInvoiceDetails();
                success = true;
            }
            catch (Exception e1)
            {
                _Log.ErrorFormat("An exception occurred while unapproving an invoice detail line. Details follow.", e1);
            }
            finally
            {
                // TODO: free the RFS data context.
                EnableUi(true);
            }

            if (!success)
                MessageHelper.ShowError(failureMessage);
        }

        private static string GetExportFileName()
        {
            SaveFileDialog SaveDialog = new SaveFileDialog();
            SaveDialog.DefaultExt = "csv";
            SaveDialog.Filter = "CSV files (*.csv)|*.csv|All files (*.*)|*.*";
            SaveDialog.FileName = string.Format("RFS Invoice Export {0:yyyy-MM-dd HH-mm-ss}.csv", DateTime.Now);
            return SaveDialog.ShowDialog() == DialogResult.OK ? SaveDialog.FileName : null; 
        }

        private void TransferInvoicesButton_Click(object sender, EventArgs e)
        {
            /*
             * This addition is perhaps a short-term fix for the inability to transfer
             * invoices to Solomon. It's a resurrection of the code from long ago that
             * used to spit out a CSV file for import after the transfer process.
             */

            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to export invoices.");
                return;
            }

            if (InvoiceListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("To export invoices you must select at least one invoice.");
                return;
            }

            // Validate the invoice(s) can be exported before asking the user for confirmation or the filename.

            var index = 0;
            var invoiceMonth = 0;
            var invoicesInMoreThanOneMonth = false;
            var invoiceIds = new int[InvoiceListview.SelectedItems.Count];

            foreach (ListViewItem item in InvoiceListview.SelectedItems)
            {
                var id = item.Tag as InvoiceDetails;
                Debug.Assert(id != null);
                invoiceIds[index++] = id.Invoice.InvoiceId;

                if (invoiceMonth == 0)
                    invoiceMonth = id.Invoice.InvoiceDate.Month;
                else if (invoiceMonth != id.Invoice.InvoiceDate.Month)
                    invoicesInMoreThanOneMonth = true;
            }

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var exporter = RfsFactory.GetRfsInvoiceExporter(rfsDataContext);

            try
            {
                var validationErrors = exporter.ValidateExportInvoices(invoiceIds);
                if (validationErrors != null)
                {
                    MessageHelper.ShowError(string.Format("The invoice(s) cannot be exported because of the following errors:\n\n{0}", validationErrors));
                    return;
                }

                // If the invoices to be exported fall in more than one calendar month, warn the user. MAS90 won't be able
                // to post the revenue to the correct month without it, so it's pretty important, but Dan didn't want to 
                // make the decision to prohibit outright at this point.

                if (invoicesInMoreThanOneMonth)
                {
                    const string prompt = "The invoices fall in more than one calendar month. If you export them, you may not be able to post them all to their correct months. Are you sure you want to proceed?";
                    if (MessageHelper.ShowConfirm(prompt) != DialogResult.Yes)
                        return;
                }

                // Confirm that the user really wants to export the invoice(s).

                var result = MessageHelper.ShowConfirm("Are you sure you want to export the selected invoice(s)?");
                if (result != DialogResult.Yes)
                    return;

                // Get the filename the user wants to use for export, bailing if they don't provide one.

                var exportFileName = GetExportFileName();
                if (exportFileName == null)
                    return;

                // If we've made it this far, we should be able to run the export procedure.

                var results = exporter.ExportInvoices(invoiceIds);
                EnableUi(false);

                if (results == null)
                {
                    MessageHelper.ShowError("An error occurred while exporting the invoices. Contact IT support.");
                    return;
                }

                var csvFileContents = exporter.CreateSolomonCsvImportText(results.ExportId);
                if (string.IsNullOrEmpty(csvFileContents))
                {
                    MessageHelper.ShowError("An error occurred while converting the export to a CSV file. Contact IT support.");
                    return;
                }

                // Dump the file contents.

                using (var sw = new StreamWriter(exportFileName, false))
                    sw.Write(csvFileContents);

                var resultsForm = new InvoiceExportResultsForm(results, exportFileName, csvFileContents);
                resultsForm.ShowDialog();
            }
            finally
            {
                // TODO: free the RFS data context
                EnableUi(true);
            }



            /*
             * The following code is what was formerly used to transfer to Solomon. 
             * I don't know why it stopped working. But I'm leaving it here for 
             * future reference.
             */

            /*

            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to transfer invoices.");
                return;
            }

            if (InvoiceListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("To transfer invoices you must select at least one invoice.");
                return;
            }

            EnableUi(false);
            int Index = 0;
            int[] InvoiceIds = new int[InvoiceListview.SelectedItems.Count];
            foreach (ListViewItem Item in InvoiceListview.SelectedItems)
            {
                InvoiceDetails Id = Item.Tag as InvoiceDetails;
                Debug.Assert(Id != null);
                InvoiceIds[Index++] = Id.Invoice.InvoiceId;
            }

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            var transferrer = RfsFactory.GetRfsInvoiceTransferrer(rfsDataContext);
            EnableUi(true);

            try
            {
                string ValidationErrors = transferrer.ValidateTransferInvoices(InvoiceIds);
                if (ValidationErrors != null)
                {
                    MessageHelper.ShowError(string.Format("The invoice(s) cannot be transferred because of the following errors:\n\n{0}", ValidationErrors));
                    return;
                }

                // Confirm that the user really wants to export the invoice(s).

                DialogResult Result = MessageHelper.ShowConfirm("Are you sure you want to transfer the selected invoice(s)?");
                if (Result != DialogResult.Yes)
                    return;

                // If we've made it this far, we should be able to run the transfer procedure.

                bool Results = transferrer.TransferInvoices(InvoiceIds);
                EnableUi(false);

                if (!Results)
                {
                    MessageHelper.ShowError("An error occurred while transferring the invoices. Contact IT support.");
                    return;
                }

                CacheInvoicesToReview();
                PopulateInvoicesToReview(true);
            }
            finally
            {
                // TODO: free the RFS data context
                EnableUi(true);
            }
            */
        }

        private void VoidInvoiceButton_Click(object Sender, EventArgs E)
        {
            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to void an invoice.");
                return;
            }

            if (InvoiceListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select one invoice to void.");
                return;
            }

            ListViewItem InvoiceItem = InvoiceListview.SelectedItems[0];
            InvoiceDetails Id = InvoiceItem.Tag as InvoiceDetails;
            Debug.Assert(Id != null);

            if (Id.Invoice.InvoiceStatus >= RfsInvoiceStatus.Exported)
            {
                MessageHelper.ShowInvalidOperation("Sorry, but an invoice cannot be voided once it's exported to MAS90.");
                return;
            }

            if (MessageHelper.ShowConfirm("Voiding the invoice will unapprove all bills and delete all manual bills. Are you sure you want to void it?") != DialogResult.Yes)
                return;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var manager = RfsFactory.GetRfsInvoiceLifecycleManager(rfsDataContext);
                var errorMessage = manager.VoidInvoice(Id.Invoice.InvoiceId);

                if (string.IsNullOrEmpty(errorMessage))
                {
                    _InvoicesToReview.Remove(Id.Invoice);
                    Debug.Assert(_InvoiceDetailsMap.ContainsKey(Id.Invoice.InvoiceId));
                    _InvoiceDetailsMap.Remove(Id.Invoice.InvoiceId);
                    PopulateInvoicesToReview(false);
                }
                else
                {
                    MessageHelper.ShowError(errorMessage);
                }
            }
            finally
            {
                // TODO: free the RFS data context
            }
        }

        private void InvestigateInvoice(int invoiceId)
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var invoice = rfsDataContext.GetInvoiceById(invoiceId);

                if (invoice != null)
                {
                    MainTabControl.SelectTab("ReviewInvoicesPage");
                    InvoiceBeginDatePicker.Value = invoice.InvoiceDate.Date;
                    InvoiceEndDatePicker.Value = invoice.InvoiceDate.Date.AddDays(1);

                    CacheInvoicesToReview();
                    PopulateInvoicesToReview(true);

                    for (var i = 0; i < InvoiceListview.Items.Count; i++)
                    {
                        var id = InvoiceListview.Items[i].Tag as InvoiceDetails;
                        Debug.Assert(id != null);

                        if (id.Invoice.InvoiceId == invoiceId)
                        {
                            InvoiceListview.Items[i].Selected = true;
                            InvoiceListview.Focus();
                            InvoiceListview.EnsureVisible(i);
                            break;
                        }
                    }
                }
                else
                {
                    MessageHelper.ShowError(string.Format("Invoice {0} could not be found.", invoiceId));
                }
            }
            finally
            {
                // TODO: free the RFS data context.
            }
        }

        private void InvestigateButton_Click(object Sender, EventArgs E)
        {
            if (string.IsNullOrWhiteSpace(DocumentIdTextbox.Text))
            {
                MessageHelper.ShowError("Must provide an invoice ID.");
            }
            else if (DocumentTypeCombobox.Text == "Invoice")
            {
                int InvoiceId;
                if (int.TryParse(DocumentIdTextbox.Text, out InvoiceId))
                    InvestigateInvoice(InvoiceId);
                else
                    MessageHelper.ShowError("Invoice ID must be an integer.");
            }
            else
            {
                RfsDetectiveForm NewForm = new RfsDetectiveForm(DocumentTypeCombobox.Text, DocumentIdTextbox.Text, true, _IsBopsAdministrator || _IsBopsPowerUser);
                NewForm.ShowDialog();

                if (NewForm.RfsReassigned)
                    MessageHelper.ShowWarning("At least one RFS number was reassigned; you may wish to refresh the displayed data.");
            }
        }

        void InvestigateBillingDetails(BopsRfsBillDetail Bd)
        {
            if (Bd.ServiceResult.IsReceiver)
            {
                DocumentTypeCombobox.Text = "Receiver";
                DocumentIdTextbox.Text = Bd.Receiver.ReceiverId.ToString();
            }
            else if (Bd.ServiceResult.IsBillOfLading)
            {
                DocumentTypeCombobox.Text = "BOL";
                DocumentIdTextbox.Text = Bd.Shipper.LoadId.ToString();
            }
            else
            {
                DocumentTypeCombobox.Text = "Load";
                DocumentIdTextbox.Text = Bd.Load.LoadReference;
            }

            RfsDetectiveForm NewForm = new RfsDetectiveForm(DocumentTypeCombobox.Text, DocumentIdTextbox.Text, true, _IsBopsAdministrator);
            NewForm.ShowDialog();

            if (NewForm.RfsReassigned)
                MessageHelper.ShowWarning("At least one RFS number was reassigned; you may wish to refresh the displayed data.");
        }

        void InvestigateFromListview(ListView Lv)
        {
            if (Lv.SelectedItems.Count == 1)
            {
                ListViewItem Item = Lv.SelectedItems[0];
                BopsRfsBillDetail Bd = Item.Tag as BopsRfsBillDetail;
                if (Bd != null)
                    InvestigateBillingDetails(Bd);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("Select a single bill to investigate.");
            }
        }

        private void RfsInvoiceUtilityMainForm_KeyDown(object Sender, KeyEventArgs E)
        {
            if (!E.Control || (E.KeyCode != Keys.F)) return;
            DocumentIdTextbox.Focus();
            DocumentIdTextbox.SelectAll();
        }

        private void ShowSupportingDocuments_Click(object Sender, EventArgs E)
        {
            if (InvoiceListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select a single invoice to view supporting documents.");
                return;
            }
            
            var id = InvoiceListview.SelectedItems[0].Tag as InvoiceDetails;
            if (id == null)
            {
                MessageHelper.ShowError("An internal error has occurred when trying to view invoice supporting documents. Please contact IT support.");
                return;
            }

            var newDialog = new InvoiceSupportingDocumentsForm(id.Invoice.InvoiceId);
            newDialog.ShowDialog();
        }

        private void hideUnhideFromClientsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (InvoiceListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You must select at least one invoice to view supporting documents.");
                return;
            }

            var result = MessageHelper.ShowConfirm("Are you sure you want to hide/unhide the selected invoices from clients?");
            if (result != DialogResult.Yes)
                return;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            EnableUi(false);

            try
            {
                // TODO: Optimize this routine for the new data layer
                //
                // The current approach is a bit brain dead, but only because I'm trying 
                // to make as few changes as are necessary to preserve proper function.
                // Here's the problem: it used to save the updates then update the display,
                // but it did so using disconnected objects. I'm using connected objects
                // now to be more ORM-ish, but that then means I have to update two sets
                // of data, both the stuff on the display and the fresh invoices that will
                // actually be committed to the database. Thus the following uses three
                // separate loops to preserve a single batch commit to the database when
                // optimally it would be one. It's a low priority, but it could stand to
                // be improved.

                // First we build an array of invoice IDs to fetch from the data layer.

                var index = 0;
                var invoiceIds = new int[InvoiceListview.SelectedItems.Count];
                foreach (ListViewItem item in InvoiceListview.SelectedItems)
                {
                    var id = item.Tag as InvoiceDetails;
                    Debug.Assert(id != null);
                    invoiceIds[index++] = id.Invoice.InvoiceId;
                }

                var freshInvoices = rfsDataContext.GetInvoicesByIds(invoiceIds)
                    .ToDictionary(i => i.InvoiceId, i => i);

                // Now we go and toggle the hidden values in the fresh data and save our
                // changes in bulk via one database call.

                foreach (ListViewItem item in InvoiceListview.SelectedItems)
                {
                    var id = item.Tag as InvoiceDetails;
                    Debug.Assert(id != null);

                    var freshInvoice = freshInvoices[id.Invoice.InvoiceId];
                    freshInvoice.HideFromClients = !freshInvoice.HideFromClients;
                }

                rfsDataContext.SaveChanges();

                // If we've made it this far, the database update succeeded, so we can
                // update the UI on the basis of the changes we just made.

                foreach (ListViewItem item in InvoiceListview.SelectedItems)
                {
                    var id = item.Tag as InvoiceDetails;
                    Debug.Assert(id != null);

                    var freshInvoice = freshInvoices[id.Invoice.InvoiceId];
                    id.Invoice.HideFromClients = freshInvoice.HideFromClients;
                    item.BackColor = id.Invoice.HideFromClients ? Color.LightGray : Color.FromKnownColor(KnownColor.Window);
                }
            }
            catch (Exception ex)
            {
                _Log.Error("An error occurred while hiding/unhiding invoices from clients. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context.
            }

            EnableUi(true);
        }

        private void StorageRefreshButton_Click(object Sender, EventArgs E)
        {
            DoStorageRefresh();
        }

        private void DoStorageRefresh()
        {
            EnableUi(false);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var lastBilling = rfsDataContext.GetLastStorageBilling();

                if (lastBilling != null)
                {
                    _StorageCurrentBilling = lastBilling;

                    // It's been rendered invisible, since it should basically no longer be possible 
                    // to invoice all storage billing details on a single invoice. JBW 04/04/2017
                    //
                    //StorageCreateInvoicesButton.Enabled = !_StorageCurrentBilling.DateInvoiced.HasValue;

                    StorageBillingDetailsTextbox.Text =
                        string.Format("ID {0} billed through {1:d} with {2} items for a total of {3:c}",
                                      _StorageCurrentBilling.BillingId, _StorageCurrentBilling.DateBilledThrough,
                                      _StorageCurrentBilling.TotalItemsProcessed, _StorageCurrentBilling.TotalRevenue);

                    PopulateStorageListviews(rfsDataContext);
                }
                else
                {
                    // Because we're not calling the population function, we need to clear the list views here.

                    StorageSummaryListview.Items.Clear();
                    StorageDetailsListview.Items.Clear();

                    StorageBillingDetailsTextbox.Text = "(sorry, there are no saved storage billing results)";
                }

                StorageUpdateOrphansLabel(rfsDataContext);
            }
            finally
            {
                // TODO: free the RFS data context
                EnableUi(true);
            }
        }

        private void AddSummaryLineToStorageSummaryListview(int TotalItems, double TotalRevenue)
        {
            ListViewItem NewItem = new ListViewItem("(all)");
            NewItem.SubItems.Add("(all)");
            NewItem.SubItems.Add("(all)");
            NewItem.SubItems.Add(TotalItems.ToString());
            NewItem.SubItems.Add(string.Format("{0:c}", TotalRevenue));

            NewItem.Selected = true;
            StorageSummaryListview.Items.Add(NewItem);
        }

        private void PopulateStorageListviews(IRfsDataContext rfsDataContext)
        {
            StorageSummaryListview.SuspendLayout();
            StorageSummaryListview.Items.Clear();

            StorageDetailsListview.SuspendLayout();
            StorageDetailsListview.Items.Clear();

            CacheStorageBillingDetails(rfsDataContext, _StorageCurrentBilling);

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

            _StorageDetailsCompareFactory = new ListViewComparerFactory(7);
            _StorageDetailsCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _StorageDetailsCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _StorageDetailsCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _StorageDetailsCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Double;
            _StorageDetailsCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Double;
            _StorageDetailsCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            var summary = new Dictionary<string, StorageSummaryItem>();

            foreach (var detail in _StorageDetails)
            {
                // Fetch the objects.

                var inventoryItem = _StorageInventoryMap[detail.InventoryRef];
                var receiver = _StorageReceiverMap[inventoryItem.ReceiverRef.Value];
                var profile = _StorageProfileMap[receiver.ProductProfileRef.Value];

                // Update the summary row.

                var summaryKey = string.Format("{0}:{1}", profile.ProfileId, detail.BillToClientRef);

                if (summary.ContainsKey(summaryKey))
                {
                    var summaryItem = summary[summaryKey];
                    summaryItem.TotalRevenue += detail.Revenue;
                    summaryItem.TotalItems++;
                }
                else
                {
                    summary.Add(summaryKey, new StorageSummaryItem(profile.ProfileId, detail.BillToClientRef, 1, detail.Revenue));
                }

                // Add the item to the detail listview.

                var newItem = new ListViewItem(detail.InventoryRef.ToString());
                newItem.SubItems.Add(inventoryItem.ReceiverRef.ToString());
                newItem.SubItems.Add(profile.ProfileId.ToString());
                newItem.SubItems.Add(detail.Quantity.ToString());
                newItem.SubItems.Add(detail.CyclesBilled.ToString("N2"));
                newItem.SubItems.Add(string.Format("{0:c}", detail.Revenue));
                newItem.SubItems.Add(detail.PublicDetails);
                newItem.Tag = detail;

                StorageDetailsListview.Items.Add(newItem);

                totalRevenue += detail.Revenue;
                totalItems++;
            }

            // Summary listview columns
            //
            //  0   Bill-to Client
            //  1   Profile
            //  2   Description
            //  3   Items
            //  4   Revenue

            _StorageSummaryCompareFactory = new ListViewComparerFactory(7);
            _StorageSummaryCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _StorageSummaryCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _StorageSummaryCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            AddSummaryLineToStorageSummaryListview(totalItems, totalRevenue);

            foreach (var pair in summary)
            {
                ListViewItem newItem;
                if (_DestinationsMap.ContainsKey(pair.Value.BillToClientRef))
                {
                    newItem = new ListViewItem(_DestinationsMap[pair.Value.BillToClientRef].ToString());
                }
                else
                {
                    newItem = new ListViewItem("(invalid bill-to client)");
                    _Log.WarnFormat("PopulateStorageListviews has invalid bill-to client {0} for current company Id {1}",
                        pair.Value.BillToClientRef, UserCompanyDetails.Company.CompanyId);
                }

                var profile = _StorageProfileMap[pair.Value.Profile];
                newItem.SubItems.Add(pair.Value.Profile.ToString());
                newItem.SubItems.Add(profile.ProductClassDescription);
                newItem.SubItems.Add(pair.Value.TotalItems.ToString());
                newItem.SubItems.Add(string.Format("{0:c}", pair.Value.TotalRevenue));
                newItem.Tag = pair.Value;

                StorageSummaryListview.Items.Add(newItem);
            }

            StorageSummaryListview.ListViewItemSorter = _StorageSummaryCompareFactory.CreateComparerForColumn(0);
            StorageSummaryListview.Sort();

            foreach (ColumnHeader hdr in StorageDetailsListview.Columns)
                hdr.Width = -2;
            StorageDetailsListview.ResumeLayout();

            foreach (ColumnHeader hdr in StorageSummaryListview.Columns)
                hdr.Width = -2;
            StorageSummaryListview.ResumeLayout();
        }

        private void StorageSummaryListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (!_UiEnabled)
                return;

            if (StorageSummaryListview.Items.Count <= 0) return;

            StorageSummaryListview.ListViewItemSorter = _StorageSummaryCompareFactory.CreateComparerForColumn(E.Column);
            StorageSummaryListview.Sort();
        }

        private void StorageDetailsListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (!_UiEnabled)
                return;

            if (StorageDetailsListview.Items.Count <= 0) return;

            StorageDetailsListview.ListViewItemSorter = _StorageDetailsCompareFactory.CreateComparerForColumn(E.Column);
            StorageDetailsListview.Sort();
        }

        private void StorageSummaryListview_SelectedIndexChanged(object Sender, EventArgs E)
        {
            if (!_UiEnabled)
                return;

            PopulateFilteredStorageDetailList();
        }

        private void PopulateFilteredStorageDetailList()
        {
            // This is a guard against all the calls that will occur while populating.

            if (!_UiEnabled)
                return;

            StorageDetailsListview.Items.Clear();
            StorageDetailsListview.SuspendLayout();

            // If there is no selected item, then merely make sure the listview is empty.

            if (StorageSummaryListview.SelectedItems.Count == 0)
            {
                StorageDetailsListview.ResumeLayout();
                return;
            }

            // Otherwise, we need to show some or all of the items.

            int ProfileFilter = 0, ClientFilter = 0;

            if (StorageSummaryListview.SelectedItems.Count == 1)
            {
                StorageSummaryItem Summary = StorageSummaryListview.SelectedItems[0].Tag as StorageSummaryItem;
                if (Summary != null)
                {
                    ProfileFilter = Summary.Profile;
                    ClientFilter = Summary.BillToClientRef;
                }
            }

            //foreach (BopsRfsStorageBillingDetail Detail in _StorageDetails)
            for (int I = 0; I < _StorageDetails.Count; I++)
            {
                BopsRfsStorageBillingDetail Detail = _StorageDetails[I];

                // Fetch the objects.

                BopsInventoryDetail InventoryItem = _StorageInventoryMap[Detail.InventoryRef];
                BopsReceivingRecord Receiver = _StorageReceiverMap[InventoryItem.ReceiverRef.Value];
                BopsProductProfile Profile = _StorageProfileMap[Receiver.ProductProfileRef.Value];

                // Skip the item if it fails to match the filter.

                if (ProfileFilter != 0 && ProfileFilter != Profile.ProfileId)
                    continue;
                if (ClientFilter != 0 && ClientFilter != Detail.BillToClientRef)
                    continue;

                // Otherwise, add the item to the detail listview.

                ListViewItem NewItem = new ListViewItem(Detail.InventoryRef.ToString());
                NewItem.SubItems.Add(InventoryItem.ReceiverRef.ToString());
                NewItem.SubItems.Add(Profile.ProfileId.ToString());
                NewItem.SubItems.Add(Detail.Quantity.ToString());
                NewItem.SubItems.Add(Detail.CyclesBilled.ToString());
                NewItem.SubItems.Add(string.Format("{0:c}", Detail.Revenue));
                NewItem.SubItems.Add(Detail.PublicDetails);
                NewItem.Tag = Detail;

                StorageDetailsListview.Items.Add(NewItem);
            }

            foreach (ColumnHeader Hdr in StorageDetailsListview.Columns)
                Hdr.Width = -2;
            StorageDetailsListview.ResumeLayout();
        }

        private void StorageCreateInvoicesButton_Click(object sender, EventArgs e)
        {
            return;

            // It's been rendered invisible, since it should basically no longer be possible 
            // to invoice all storage billing details on a single invoice. JBW 04/04/2017


            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to create invoices for storage billing.");
                return;
            }

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            List<BopsRfsInvoicePackage> result = null;

            try
            {
                EnableUi(false);
                var newForm = new CreateInvoicesFromStorageBillingForm(_ServicesOfferedMap.Values, _RfsLocationMap.Values)
                {
                    InvoiceDate = _StorageCurrentBilling.DateBilledThrough.AddDays(1),
                    UserCompanyDetails = UserCompanyDetails
                };

                if (newForm.ShowDialog() != DialogResult.OK)
                    return;

                var lm = RfsFactory.GetRfsInvoiceLifecycleManager(rfsDataContext);
                result = lm.CreateInvoiceFromStorageBilling(_StorageCurrentBilling.BillingId, newForm.ServiceOfferedRef, 
                    newForm.InvoiceDate, newForm.LocationCode, newForm.InvoiceType);
            }
            catch (Exception ex)
            {
                _Log.ErrorFormat("An exception occurred while creating invoices from storage billing {0}. Details follow.", _StorageCurrentBilling.BillingId);
                _Log.Error(ex);
            }
            finally
            {
                // TODO: free the RFS data context
                EnableUi(true);
            }

            if (result == null)
            {
                MessageHelper.ShowError("An error occurred while creating invoices. Please contact IT support.");
            }
            else
            {
                StorageCreateInvoicesButton.Enabled = false;

                var newForm = new InvoicePackageForm(result);
                newForm.Text = "Storage Billing Invoices Created";
                newForm.ShowDialog();
            }
        }

        private void StorageGenerateBillingButton_Click(object sender, EventArgs e)
        {
            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to generate storage billing.");
                return;
            }

            var newForm = new StorageBillingForm(_IsBopsAdministrator);
            if (newForm.ShowDialog() == DialogResult.OK)
                DoStorageRefresh();
        }

        private void StorageBillingHistoryButton_Click(object Sender, EventArgs E)
        {
            if (!_UiEnabled)
                return;

            StorageBillingHistoryForm NewForm = new StorageBillingHistoryForm();
            NewForm.ShowDialog();

            if (NewForm.RolledBack)
                DoStorageRefresh();
        }

        private void StorageUpdateOrphansLabel(IRfsDataContext rfsDataContext)
        {
            var storageBillsToInvoice = rfsDataContext.GetStorageBillsToInvoice();

            if (storageBillsToInvoice > 0)
            {
                OrphansLabel.Text = string.Format("{0} To Invoice", storageBillsToInvoice);
                OrphansLabel.Visible = true;
                StorageCreateSingleInvoiceButton.Enabled = true;
            }
            else
            {
                OrphansLabel.Text = string.Empty;
                OrphansLabel.Visible = false;
                StorageCreateSingleInvoiceButton.Enabled = false;
            }
        }

        private void StorageCreateSingleInvoiceButton_Click(object sender, EventArgs e)
        {
            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to create an invoice from storage bills.");
                return;
            }

            var newForm = new CreateInvoiceFromStorageBills {UserCompanyDetails = UserCompanyDetails};
            newForm.ShowDialog();

            EnableUi(false);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                StorageUpdateOrphansLabel(rfsDataContext);
            }
            finally
            {
                // TODO: free the RFS data context
                EnableUi(true);
            }
        }

        private void copyAllToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ListViewExportUtility.ExportToClipboard(InvoiceListview, true, false);
        }

        private void copySelectedToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            ListViewExportUtility.ExportToClipboard(InvoiceListview, true, true);
        }

        private void editInvoiceLinesToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            EditInvoiceLines();
        }

        private void copyAllToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            ListViewExportUtility.ExportToClipboard(InvoiceDetailsListview, true, false);
        }

        private void copySelectedToolStripMenuItem1_Click(object Sender, EventArgs E)
        {
            ListViewExportUtility.ExportToClipboard(InvoiceDetailsListview, true, true);
        }

        private void BulkInvoiceButton_Click(object sender, EventArgs e)
        {
            var currentIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (currentIdentity == null)
                throw new SecurityException("Could not obtain Windows identity.");

            // Bail if insufficient privileges.

            if (!_IsBopsPowerUser && !_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have at least Bops Power Users access to use the bulk invoice feature.");
                return;
            }

            // Ask the user for the RFS number and what types of bills to include.

            var rfsForm = new BulkInvoiceByRfsForm();
            if (rfsForm.ShowDialog() != DialogResult.OK)
                return;

            // Ask the user for the invoice type, date, and notes (public and private).

            var invoiceDetailsForm = new CreateInvoiceDetailsForm
            {
                UserCompanyDetails = UserCompanyDetails,
                InvoiceType = UserCompanyDetails.Company.InvoiceType
            };
            if (invoiceDetailsForm.ShowDialog() != DialogResult.OK)
                return;

            var bulkInvoiceTime = DateTime.Now;
            var outputFileName = string.Format("Bulk Invoice Report {0:yyyy-MM-dd HH-mm-ss}.csv", bulkInvoiceTime);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            var privateNotesAppended = new StringBuilder(invoiceDetailsForm.PrivateNotes);
            if (privateNotesAppended.Length > 0)
                privateNotesAppended.Append(" ");
            privateNotesAppended.AppendFormat("Bulk invoiced RFS {0} by {1} at {2}.", rfsForm.RfsNumber, currentIdentity.Name, bulkInvoiceTime);

            try
            {
                var invoicer = new BulkInvoicer(rfsForm.RfsNumber, rfsForm.IncludeBillsOfLading, 
                    rfsForm.IncludeLoads, rfsForm.IncludeReceivers, invoiceDetailsForm.InvoiceType, 
                    invoiceDetailsForm.InvoiceDate, invoiceDetailsForm.PublicNotes, 
                    privateNotesAppended.ToString(), rfsDataContext);

                var totalBills = invoicer.PrepareForBulkInvoicing();
                if (totalBills < 1)
                {
                    MessageHelper.ShowWarning("No bills were found that could be bulk invoiced.");
                    return;
                }
                else
                {
                    if (MessageHelper.ShowConfirm(string.Format("{0} bills were found to bulk invoice for RFS {1}. Are you sure you wish to continue?",
                        totalBills, rfsForm.RfsNumber)) != DialogResult.Yes)
                    {
                        return;
                    }
                }

                var total = invoicer.TotalBillsCount;
                var progress = new ProgressForm();
                progress.Text = @"Bulk Invoicing";
                progress.TopLevelText =
                    @"The bulk invoicing process is now underway. Each bill will be used to generate an invoice one at a time. This may take some time.";
                progress.WorkText = "Initializing...";
                progress.Progress.Minimum = 0;
                progress.Progress.Maximum = total;
                progress.Show();
                Application.DoEvents();

                EnableUi(false);

                var abort = false;
                var finalizedCount = 0;
                var finalizeFailures = 0;
                var outputFiles = new string[total];

                for (var i = 0; i < total; i++)
                {
                    if (abort)
                        break;

                    var billDetail = invoicer.GetBillDetail(i);

                    progress.Progress.Value = i;
                    progress.WorkText = string.Format("Invoicing {0} ({1} / {2})", billDetail.ServiceResult, i + 1, totalBills);
                    Application.DoEvents();

                    var result = invoicer.InvoiceBill(i, UserCompanyDetails.Company.CompanyId);
                    if (result.ErrorType != InvoiceErrorType.None)
                        continue;

                    progress.WorkText = string.Format("Finalizing invoice {0} for {1} ({2} / {3})", result.Invoice.InvoiceId, 
                        billDetail.ServiceResult, i + 1, totalBills);
                    Application.DoEvents();

                    string finalInvoiceFilename;
                    if (FinalizeInvoice(result.Invoice, out finalInvoiceFilename))
                    {
                        finalizedCount++;
                        outputFiles[i] = finalInvoiceFilename;
                    }
                    else
                    {
                        outputFiles[i] = null;
                        finalizeFailures++;
                    }

                    Application.DoEvents();

                    if (progress.Abort)
                    {
                        if (MessageHelper.ShowConfirm("Aborting will not roll back the changes already made. Are you sure you wish to abort?") == DialogResult.Yes)
                        {
                            abort = true;
                        }
                        else
                        {
                            progress.ClearAbort();
                            Application.DoEvents();
                        }
                    }
                }

                progress.Close();

                WriteBulkInvoiceResults(outputFileName, invoicer, outputFiles);

                var outputSummary =
                    string.Format(
                        "Of the {0} bills found, {1} were processed to create {2} invoices, ({3} failed), of which {4} were finalized ({5} failed). " +
                        "Results have been written to file {6}. Would you like to open it now?",
                        invoicer.TotalBillsCount, invoicer.BillsProcessedCount,
                        invoicer.BillsInvoicedCount, invoicer.BillsFailedCount, finalizedCount, finalizeFailures, outputFileName);

                if (MessageHelper.ShowConfirm(outputSummary) != DialogResult.Yes)
                    return;

                try
                {
                    Process.Start(outputFileName);
                }
                catch (Exception ex)
                {
                    _Log.Error("An exception occurred while displaying bulk invoice summary results. Details follow.", ex);
                    MessageHelper.ShowError("The bulk invoice results could not be opened. This often means a CSV reader application is not installed. Contact IT support.");
                }
            }
            catch (Exception ex)
            {
                _Log.Error("An exception occurred while bulk invoicing. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context

                BillsAvailableListview.Items.Clear();
                BillsSelectedListview.Items.Clear();

                EnableUi(true);
            }
        }

        IDictionary<string, string> GetInvoiceTypeMap()
        {
            InvoiceFactory Factory = new InvoiceFactory();
            IList<InvoiceElement> InvoiceTypes = Factory.InvoiceTypes;

            IDictionary<string, string> ReturnValue = new Dictionary<string, string>();
            foreach (InvoiceElement Element in InvoiceTypes)
                ReturnValue.Add(Element.Key, Element.ToString());

            return ReturnValue;
        }

        private void WriteBulkInvoiceResults(string OutputFileName, BulkInvoicer Invoicer, string[] OutputFiles)
        {
            IDictionary<string, string> InvoiceTypeMap = GetInvoiceTypeMap();
            StringBuilder Sb = new StringBuilder("Number,Result ID,Bill Type,Bill ID,Invoice ID,Total,Type,PDF File Name\n");

            for (int I = 0; I < Invoicer.TotalBillsCount; I++ )
            {
                BopsRfsBillDetail Detail = Invoicer.GetBillDetail(I);
                BopsRfsInvoicePackage Result = Invoicer.GetInvoiceResult(I);

                if (Result == null)
                    continue;

                Sb.AppendFormat("{0},{1},", I + 1, Detail.ServiceResult.ResultId);

                if (Detail.ServiceResult.IsLoad)
                    Sb.AppendFormat("Load,{0},", Detail.Load.LoadReference);
                else if (Detail.ServiceResult.IsReceiver)
                    Sb.AppendFormat("Receiver,{0},", Detail.Receiver.ReceiverId);
                else if (Detail.ServiceResult.IsBillOfLading)
                    Sb.AppendFormat("BOL,{0},", Detail.Shipper.LoadId);

                if (Result.ErrorType == InvoiceErrorType.None)
                {
                    Sb.AppendFormat("{0},{1:c},{2},", Result.Invoice.InvoiceId, Result.Invoice.InvoiceTotal, InvoiceTypeMap[Result.Invoice.InvoiceType]);

                    if (string.IsNullOrEmpty(OutputFiles[I]))
                        Sb.Append("Invoice could not be finalized\n");
                    else
                        Sb.AppendFormat("{0}\n", OutputFiles[I]);
                }
                else
                {
                    string ErrorString;

                    switch (Result.ErrorType)
                    {
                        case InvoiceErrorType.DetailsAlreadyInvoiced:
                            ErrorString = "bill was already invoiced";
                            break;
                        case InvoiceErrorType.BillingError:
                            ErrorString = "an error occurred during billing (usually means data didn't exist or was invalid)";
                            break;
                        case InvoiceErrorType.UnknownException:
                            ErrorString = "an unknown exception was thrown while creating the invoice";
                            break;

                        default:
                            ErrorString = "unknown error";
                            break;
                    }

                    Sb.AppendFormat("Invoicing failed: {0}", ErrorString);
                }
            }

            using (StreamWriter Sw = new StreamWriter(OutputFileName, false))
            {
                Sw.Write(Sb.ToString());
            }
        }

        private void ShowBatchesButton_Click(object sender, EventArgs e)
        {
            EnableUi(false);
            CacheBatchesToPost();
            PopulateInvoiceXferBatchesToPost();
            EnableUi(true);
        }

        private void CacheBatchesToPost()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                // Get unposted batches for the specified number of days.

                const int numberOfDays = 90;
                var now = DateTime.Now;
                var rawBatches = rfsDataContext.GetInvoiceTransferBatchesToPostByDates(now.AddDays(-numberOfDays), now);
                _InvoiceXferBatchesToPost = new List<BopsRfsInvoiceXferBatch>();
                foreach (var batch in rawBatches)
                {
                    if (_RfsLocationMap.ContainsKey(batch.LocationCode))
                        _InvoiceXferBatchesToPost.Add(batch);
                }

                _InvoicesMap = new Dictionary<int, List<BopsRfsInvoice>>();
                if (_InvoiceXferBatchesToPost.Count > 0)
                {
                    var index = 0;
                    var batchIds = new int[_InvoiceXferBatchesToPost.Count];
                    foreach (var batch in _InvoiceXferBatchesToPost)
                        batchIds[index++] = batch.BatchId;
                    var allInvoices = rfsDataContext.GetInvoicesByBatchIds(batchIds);

                    foreach (var invoice in allInvoices)
                    {
                        CacheBatchInvoice(invoice);
                    }
                }
            }
            catch (Exception ex)
            {
                _Log.Error("An exception occurred caching invoice xfer batches to post. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context.
            }
        }

        private void CacheBatchInvoice(BopsRfsInvoice NewInvoice)
        {
            List<BopsRfsInvoice> CurrentInvoices;
            if (_InvoicesMap.ContainsKey(NewInvoice.BatchId.Value))
            {
                CurrentInvoices = _InvoicesMap[NewInvoice.BatchId.Value];
            }
            else
            {
                CurrentInvoices = new List<BopsRfsInvoice>();
                _InvoicesMap[NewInvoice.BatchId.Value] = CurrentInvoices;
            }

            CurrentInvoices.Add(NewInvoice);
        }

        private void PopulateInvoiceXferBatchesToPost()
        {
            // Columns:
            //
            //  0   Batch Id
            //  1   TransferDate
            //  2   InvoiceCount
            //  3   InvoiceAmount
            //  4   DatabaseName
            //  5   PostedDate

            _InvoiceXferBatchesFactory = new ListViewComparerFactory(8);
            _InvoiceXferBatchesFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _InvoiceXferBatchesFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _InvoiceXferBatchesFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _InvoiceXferBatchesFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Currency;
            _InvoiceXferBatchesFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Date;

            InvoiceXferBatchListView.SuspendLayout();
            InvoiceXferBatchListView.Items.Clear();

            foreach (BopsRfsInvoiceXferBatch Batch in _InvoiceXferBatchesToPost)
            {
                int InvoiceCount = 0;
                if (_InvoicesMap.ContainsKey(Batch.BatchId))
                {
                    InvoiceCount = _InvoicesMap[Batch.BatchId].Count;
                }

                double InvoiceTotal = 0.0;
                List<BopsRfsInvoice> Invoices = _InvoicesMap[Batch.BatchId];
                foreach (BopsRfsInvoice Invoice in Invoices)
                {
                    InvoiceTotal = InvoiceTotal + Invoice.InvoiceTotal;
                }
                
                BopsRfsLocation Location = _RfsLocationMap[Batch.LocationCode];

                string PostedDate = Batch.PostedDate == null ? string.Empty : Batch.PostedDate.Value.ToString("d");

                ListViewItem NewItem = new ListViewItem(Batch.BatchId.ToString());
                NewItem.SubItems.Add(Batch.CreatedDate.ToString("d"));
                NewItem.SubItems.Add(InvoiceCount.ToString());
                NewItem.SubItems.Add(string.Format("{0:c}", InvoiceTotal));
                NewItem.SubItems.Add(Location.DatabaseName);
                NewItem.SubItems.Add(PostedDate);
                NewItem.Tag = Batch;
                InvoiceXferBatchListView.Items.Add(NewItem);

            }

            foreach (ColumnHeader Hdr in InvoiceXferBatchListView.Columns)
                Hdr.Width = -2;
            InvoiceXferBatchListView.ResumeLayout();
        }

        private void InvoiceXferBatchListView_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (InvoiceXferBatchListView.Items.Count <= 0) return;

            InvoiceXferBatchListView.ListViewItemSorter = _InvoiceXferBatchesFactory.CreateComparerForColumn(E.Column);
            InvoiceXferBatchListView.Sort();
        }

        private void PostInSolomonButton_Click(object sender, EventArgs e)
        {
            // The button has been rendered invisible, because the Solomon process is
            // no longer working. JBW 04/06/2017

            return;


            if (!_IsBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to post batches.");
                return;
            }

            if (InvoiceXferBatchListView.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("To post batch you must select at least one batch.");
                return;
            }

            EnableUi(false);
            int Index = 0;
            int[] BatchIds = new int[InvoiceXferBatchListView.SelectedItems.Count];
            foreach (ListViewItem Item in InvoiceXferBatchListView.SelectedItems)
            {
                BopsRfsInvoiceXferBatch Batch = Item.Tag as BopsRfsInvoiceXferBatch;
                Debug.Assert(Batch != null);
                BatchIds[Index++] = Batch.BatchId;
            }

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            var transferrer = RfsFactory.GetRfsInvoiceTransferrer(rfsDataContext);
            EnableUi(true);

            try
            {
                EnableUi(false);
                var validationErrors = transferrer.ValidatePostBatches(BatchIds);
                EnableUi(true);

                if (validationErrors != null)
                {
                    MessageHelper.ShowError(string.Format("The batch(es) cannot be posted because of the following errors:\n\n{0}", validationErrors));
                    return;
                }

                // Confirm that the user really wants to export the invoice(s).

                var result = MessageHelper.ShowConfirm("Are you sure you want to post the selected batch(es)?");
                if (result != DialogResult.Yes)
                    return;

                // If we've made it this far, we should be able to run the transfer procedure.

                EnableUi(false);

                if (!transferrer.PostTransferBatch(BatchIds))
                {
                    MessageHelper.ShowError("An error occurred while posting the batch(es). Contact IT support.");
                    EnableUi(true);
                    return;
                }

                CacheBatchesToPost();
                PopulateInvoiceXferBatchesToPost();
            }
            finally
            {
                // TODO: free the RFS data context

                EnableUi(true);
            }
        }

        private void showBillDetailsToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            ShowListViewBillDetails(BillsAvailableListview);
        }

        private void investigateBillToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            InvestigateFromListview(BillsAvailableListview);
        }

        private void showBillDetailsToolStripMenuItem2_Click(object sender, EventArgs e)
        {
            ShowListViewBillDetails(BillsSelectedListview);
        }

        private void investigateBillToolStripMenuItem2_Click(object sender, EventArgs e)
        {
            InvestigateFromListview(BillsSelectedListview);
        }

        private void changeLoginButton_Click(object sender, EventArgs e)
        {
            var newUserCompanyDetails = DetermineUserCompanyDetails(UserCompanyDetails);
            if (newUserCompanyDetails == null) return;

            ClearAllPopulatedControls();
            ClearAllCachedData();

            UserCompanyDetails = newUserCompanyDetails;
            loginLabel.Text = UserCompanyDetails.ToString();
            changeLoginButton.Visible = UserCompanyDetails.MultipleOptions;

            CacheServiceData();
        }

        private void ReviewClearFiltersButton_Click(object sender, EventArgs e)
        {
            if (!_UiEnabled) return;

            EnableUi(false);
            ReviewShipperCombobox.SelectedIndex = 0;
            PopulateBillsToApprove(false);
            EnableUi(true);

        }

        private void ReviewShipperCombobox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!_UiEnabled) return;

            EnableUi(false);
            PopulateBillsToApprove(false);
            EnableUi(true);
        }

        protected override void WndProc(ref Message msg)
        {
            base.WndProc(ref msg);
            _systemMenu.HandleMessage(ref msg);
        }

        private void OnSysMenuAbout()
        {
            MessageBox.Show(this, "RFS Invoice Utility v1.1.2", "RFS Invoice Utility");
        }
    }
}
