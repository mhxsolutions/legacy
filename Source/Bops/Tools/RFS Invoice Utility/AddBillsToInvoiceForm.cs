using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class AddBillsToInvoiceForm : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(AddBillsToInvoiceForm));

        private readonly BopsRfsInvoice _invoice;

        private ListViewComparerFactory _billsAvailableCompareFactory;
        private IList<BopsRfsServiceCalculationResult> _billsToInvoice;
        private Dictionary<string, BopsLoad> _createInvoiceLoadMap;
        private Dictionary<int, BopsReceivingRecord> _createInvoiceReceiverMap;
        private Dictionary<int, BopsShippingRecord> _createInvoiceShipperMap;
        private Dictionary<int, BopsRfsServicesRequested> _servicesRequestedMap;
        private Dictionary<int, BopsRfs> _rfsMap;
        private Dictionary<int, BopsDestination> _destinationsMap;
        private Dictionary<int, BopsRfsStakeholder> _stakeholdersMap;

        private List<BopsRfsBillDetail> _selectedBills;

        internal List<BopsRfsBillDetail> SelectedBills
        {
            get { return _selectedBills; }
        }

        private void CacheBillsToInvoice()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                // Load up the most basic data for RFS, services requested, destinations, stakeholders, etc.

                // TODO: Update this to use user company detail if appropriate.

                _servicesRequestedMap = rfsDataContext.GetServicesRequested(0, 0, 0)
                    .ToDictionary(s => s.ServiceRequestedId, s => s);
                _rfsMap = rfsDataContext.GetRfs(0, 0, 0)
                    .ToDictionary(r => r.RfsId, r => r);
                _destinationsMap = rfsDataContext.GetDestinations(0, 0, 0)
                    .ToDictionary(d => d.DestinationId, d => d);
                _stakeholdersMap = rfsDataContext.GetStakeholders(0, 0, 0)
                    .ToDictionary(s => s.StakeholderId, s => s);

                // Now fetch all service calculation results for the period in question.

                _billsToInvoice = rfsDataContext.GetServiceCalculationResultsByDatesAndBillingStatus(
                    BeginDatePicker.Value, EndDatePicker.Value, RfsBillingStatus.Approved, 0 /* TODO: Update if dialog is ever used again */ );

                // Next, load up dictionaries with the load, receiver, and shipper IDs.

                _createInvoiceLoadMap = new Dictionary<string, BopsLoad>();
                _createInvoiceReceiverMap = new Dictionary<int, BopsReceivingRecord>();
                _createInvoiceShipperMap = new Dictionary<int, BopsShippingRecord>();

                foreach (var result in _billsToInvoice)
                {
                    // If the service no longer exists, we filter it out.

                    if (!_servicesRequestedMap.ContainsKey(result.ServiceId))
                        continue;
                    var service = _servicesRequestedMap[result.ServiceId];

                    // If the RFS no longer exists (this shouldn't be possible), we filter it out.

                    if (!_rfsMap.ContainsKey(service.RfsRef))
                        continue;
                    var rfs = _rfsMap[service.RfsRef];

                    // If the bill-to stakeholder no longer exists (this shouldn't be possible), we filter it out.

                    if (!service.BillToRef.HasValue || !_stakeholdersMap.ContainsKey(service.BillToRef.Value))
                        continue;
                    var billToStakeholder = _stakeholdersMap[service.BillToRef.Value];

                    // If the service's shipper or bill-to don't match the invoice, we filter it out.

                    if (rfs.ShipperRef != _invoice.ShipperRef || billToStakeholder.ClientRef != _invoice.BillToRef)
                        continue;
                
                    // If we've made it this far, then we need to add the receiver, BOL, or load to the relevant map.

                    if (result.IsReceiver)
                    {
                        if (!_createInvoiceReceiverMap.ContainsKey(result.DocumentId.Value))
                            _createInvoiceReceiverMap.Add(result.DocumentId.Value, null);
                    }
                    else if (result.IsBillOfLading)
                    {
                        if (!_createInvoiceShipperMap.ContainsKey(result.DocumentId.Value))
                            _createInvoiceShipperMap.Add(result.DocumentId.Value, null);
                    }
                    else
                    {
                        if (!_createInvoiceLoadMap.ContainsKey(result.LoadRef))
                            _createInvoiceLoadMap.Add(result.LoadRef, null);
                    }
                }

                // Fetch the loads into the map.

                if (_createInvoiceLoadMap.Count > 0)
                {
                    var index = 0;
                    var loadIds = new string[_createInvoiceLoadMap.Count];
                    foreach (var pair in _createInvoiceLoadMap)
                        loadIds[index++] = pair.Key;

                    _createInvoiceLoadMap = rfsDataContext.GetLoadsByReferences(loadIds)
                        .ToDictionary(l => l.LoadReference, l => l);
                }
                else
                {
                    _createInvoiceLoadMap.Clear();
                }

                // Fetch the receivers into the map.

                if (_createInvoiceReceiverMap.Count > 0)
                {
                    var index = 0;
                    var receiverIds = new int[_createInvoiceReceiverMap.Count];
                    foreach (var pair in _createInvoiceReceiverMap)
                        receiverIds[index++] = pair.Key;

                    _createInvoiceReceiverMap = rfsDataContext.GetReceiversByIDs(receiverIds)
                        .ToDictionary(r => r.ReceiverId, r => r);
                }
                else
                {
                    _createInvoiceReceiverMap.Clear();
                }

                // Fetch the shippers into the map.

                if (_createInvoiceShipperMap.Count > 0)
                {
                    var index = 0;
                    var shipperIds = new int[_createInvoiceShipperMap.Count];
                    foreach (var pair in _createInvoiceShipperMap)
                        shipperIds[index++] = pair.Key;

                    _createInvoiceShipperMap = rfsDataContext.GetShippersByIDs(shipperIds)
                        .ToDictionary(s => s.LoadId, s => s);
                }
                else
                {
                    _createInvoiceShipperMap.Clear();
                }

                // Finally, strip out and log any billing documents that don't have a corresponding row in the 
                // primary tables. This should prevent users from putting non-existent items on invoices.

                for (var index = 0; index < _billsToInvoice.Count;)
                    // NB: The index is updated selectively within the loop body.
                {
                    bool stripResult;
                    var result = _billsToInvoice[index];

                    if (result.IsReceiver)
                        stripResult = !_createInvoiceReceiverMap.ContainsKey(result.DocumentId.Value);
                    else if (result.IsBillOfLading)
                        stripResult = !_createInvoiceShipperMap.ContainsKey(result.DocumentId.Value);
                    else
                        stripResult = !_createInvoiceLoadMap.ContainsKey(result.LoadRef);

                    if (stripResult)
                    {
                        _billsToInvoice.RemoveAt(index);
                        Log.WarnFormat("Billing document has no corresponding row in the primary table: {0}",
                                        result.ToString());
                    }
                    else
                    {
                        index++;
                    }
                }
            }
            catch(Exception E)
            {
                Log.Error("An exception occurred while caching bills to invoice. Details follow.", E);
            }
            finally
            {
                // TODO: Close the RFS data context
            }
        }

        private void PopulateBillsAvailable()
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

            _billsAvailableCompareFactory = new ListViewComparerFactory(9);
            _billsAvailableCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _billsAvailableCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _billsAvailableCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Currency;
            _billsAvailableCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            BillsAvailableListview.Items.Clear();
            BillsAvailableListview.SuspendLayout();

            foreach (var result in _billsToInvoice)
            {
                ListViewItem newItem;
                BopsRfsServicesRequested service = null;
                BopsDestination shipperStakeholder = null;
                BopsDestination billToStakeholder = null;

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

                if (_servicesRequestedMap.ContainsKey(result.ServiceId))
                {
                    service = _servicesRequestedMap[result.ServiceId];
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

                string billToString, destinationString;
                string shipperString = billToString = destinationString = "?";

                if (service != null)
                {
                    if (_rfsMap.ContainsKey(service.RfsRef) && _destinationsMap.ContainsKey(_rfsMap[service.RfsRef].ShipperRef))
                    {
                        shipperStakeholder = _destinationsMap[_rfsMap[service.RfsRef].ShipperRef];
                        shipperString = shipperStakeholder.ToString();
                    }

                    if (service.BillToRef.HasValue && _stakeholdersMap.ContainsKey(service.BillToRef.Value))
                    {
                        var clientId = _stakeholdersMap[service.BillToRef.Value].ClientRef;
                        if (_destinationsMap.ContainsKey(clientId))
                        {
                            billToStakeholder = _destinationsMap[clientId];
                            billToString = billToStakeholder.ToString();
                        }
                    }

                    if (service.DestinationRef.HasValue && _stakeholdersMap.ContainsKey(service.DestinationRef.Value))
                    {
                        var clientId = _stakeholdersMap[service.DestinationRef.Value].ClientRef;
                        if (_destinationsMap.ContainsKey(clientId))
                        {
                            var destinationStakeholder = _destinationsMap[clientId];
                            destinationString = destinationStakeholder.ToString();
                        }
                    }
                }

                newItem.SubItems.Add(shipperString);
                newItem.SubItems.Add(billToString);
                newItem.SubItems.Add(destinationString);

                var newBd = new BopsRfsBillDetail(result, shipperStakeholder, billToStakeholder);

                if (result.IsReceiver)
                {
                    if (_createInvoiceReceiverMap.ContainsKey(result.DocumentId.Value))
                        newBd.Receiver = _createInvoiceReceiverMap[result.DocumentId.Value];
                }
                else if (result.IsBillOfLading)
                {
                    if (_createInvoiceShipperMap.ContainsKey(result.DocumentId.Value))
                        newBd.Shipper = _createInvoiceShipperMap[result.DocumentId.Value];
                }
                else
                {
                    if (_createInvoiceLoadMap.ContainsKey(result.LoadRef))
                        newBd.Load = _createInvoiceLoadMap[result.LoadRef];
                }

                newItem.Tag = newBd;
                BillsAvailableListview.Items.Add(newItem);
            }

            foreach (ColumnHeader hdr in BillsAvailableListview.Columns)
                hdr.Width = -2;
            BillsAvailableListview.ResumeLayout();
        }

        public AddBillsToInvoiceForm(BopsRfsInvoice invoice)
        {
            InitializeComponent();

            _invoice = invoice;
        }

        private void ShowBillsButton_Click(object sender, System.EventArgs e)
        {
            CacheBillsToInvoice();
            PopulateBillsAvailable();
        }

        private void BillsAvailableListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (BillsAvailableListview.Items.Count <= 0) return;
            BillsAvailableListview.ListViewItemSorter = _billsAvailableCompareFactory.CreateComparerForColumn(e.Column);
            BillsAvailableListview.Sort();
        }

        private void OkButton_Click(object sender, System.EventArgs e)
        {
            if (BillsAvailableListview.SelectedItems.Count > 0)
            {
                _selectedBills = new List<BopsRfsBillDetail>();

                foreach (ListViewItem item in BillsAvailableListview.SelectedItems)
                {
                    var bd = item.Tag as BopsRfsBillDetail;
                    Debug.Assert(bd != null);
                    _selectedBills.Add(bd);
                }
            }

            DialogResult = DialogResult.OK;
            Close();
        }
    }
}