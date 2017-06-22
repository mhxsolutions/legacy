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
    public partial class StorageBillingForm : Form
    {
        #region Fields

        private static readonly ILog Log = LogManager.GetLogger(typeof(StorageBillingForm));

        private bool _uiEnabled;
        private readonly bool _isBopsAdministrator;
        private bool _needToUpdateStatusBarTotals;
        private double _totalRevenue;
        private RfsStorageBillingResult _result;
        private ListViewComparerFactory _resultsComparerFactory;
        private readonly EventHandler _idleEventHandler;
        private Dictionary<int, BopsDestination> _clientMap;

        #endregion

        #region Open, Close, and UI Update

        public StorageBillingForm(bool isBopsAdministrator)
        {
            InitializeComponent();

            _uiEnabled = true;
            SaveBillingButton.Enabled = false;
            _needToUpdateStatusBarTotals = false;
            _isBopsAdministrator = isBopsAdministrator;

            _idleEventHandler = new EventHandler(OnIdle);
            Application.Idle += _idleEventHandler;
        }

        private void EnableUi(bool enableUi)
        {
            Enabled = enableUi;
            Cursor = enableUi ? Cursors.Default : Cursors.WaitCursor;
            _uiEnabled = enableUi;
        }

        private void OnIdle(object sender, EventArgs e)
        {
            if (_needToUpdateStatusBarTotals)
                UpdateStatusBarTotals();
        }

        private void StorageBillingForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Idle -= _idleEventHandler;
        }

        private void UpdateStatusBarTotals()
        {
            if (ResultsListview.SelectedItems.Count == 0)
            {
                _Status.Items[0].Text = string.Format("{0} items for a total revenue of {1:c}", _result.Items.Count, _totalRevenue);
            }
            else
            {
                var selectedRevenue = 0.0;
                foreach (ListViewItem item in ResultsListview.SelectedItems)
                {
                    var id = item.Tag as RfsStorageBillingResult.ItemDetails;
                    Debug.Assert(id != null);
                    selectedRevenue += id.BillingDetail.Revenue;
                }

                _Status.Items[0].Text = string.Format("{0} selected, {1:c} revenue", ResultsListview.SelectedItems.Count, selectedRevenue);
            }

            _needToUpdateStatusBarTotals = false;
        }

        #endregion

        #region Data Population

        private static string GetBillingTypeDescription(RfsStorageBillingType billingType)
        {
            switch (billingType)
            {
                case RfsStorageBillingType.PerWeightUnit:
                    return "Weight";
                case RfsStorageBillingType.PerCount:
                    return "Count";
                case RfsStorageBillingType.PerUnit:
                    return "Unit";         
                case RfsStorageBillingType.PerThousandBoardFeet:
                    return "MBF";
            }

            return "None";
        }

        private Dictionary<int, BopsDestination> CreateClientMap(IRfsDataContext rfsDataContext)
        {
            var clientIds = new Dictionary<int, int>();

            foreach (var detail in _result.Items)
            {
                if (clientIds.ContainsKey(detail.BillingDetail.BillToClientRef))
                    continue;
                clientIds.Add(detail.BillingDetail.BillToClientRef, 0);
            }

            return clientIds.Count > 0
                ? rfsDataContext.GetDestinationsByIds(clientIds.Keys.ToArray())
                .ToDictionary(d => d.DestinationId, d => d) : null;
        }

        private void PopulateListview()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            ResultsListview.Items.Clear();
            ResultsListview.SuspendLayout();

            _clientMap = CreateClientMap(rfsDataContext);

            try
            {
                // Columns:
                //
                //  00  Client
                //  01  Profile ID
                //  02  Inventory Detail Id
                //  03  Prior Billed Through
                //  04  Receiver Id
                //  05  Date Received
                //  06  Billing Type
                //  07  RFS
                //  08  Quantity
                //  09  Rate
                //  10  Cycles
                //  11  Revenue
                //  12  Company

                for (var i = 0; i < _result.Items.Count; i++)
                {
                    Log.DebugFormat("Populating inventory item {0}", _result.Items[i].InventoryDetail.DetailId);

                    var newItem = new ListViewItem(_clientMap[_result.Items[i].BillingDetail.BillToClientRef].ToString());
                    newItem.SubItems.Add(_result.Items[i].Receiver.ProductProfileRef.Value.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(_result.Items[i].InventoryDetail.DetailId.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(_result.Items[i].BillingDetail.PriorDateBilledThrough.ToShortDateString());
                    newItem.SubItems.Add(_result.Items[i].Receiver.ReceiverId.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(_result.Items[i].Receiver.DateReceived.Value.ToShortDateString());
                    newItem.SubItems.Add(GetBillingTypeDescription(_result.Items[i].Rate.BillingType));
                    newItem.SubItems.Add(_result.Items[i].Receiver.RfsRef.Value.ToString(CultureInfo.InvariantCulture));

                    switch (_result.Items[i].Rate.BillingType)
                    {
                        case RfsStorageBillingType.PerWeightUnit:
                            newItem.SubItems.Add(_result.Items[i].InventoryDetail.Weight.Value.ToString());
                            break;
                        case RfsStorageBillingType.PerCount:
                            newItem.SubItems.Add(_result.Items[i].InventoryDetail.CountInPackage.Value.ToString());
                            break;
                        case RfsStorageBillingType.PerUnit:
                            newItem.SubItems.Add("1");
                            break;
                        case RfsStorageBillingType.PerThousandBoardFeet:
                            newItem.SubItems.Add(_result.Items[i].InventoryDetail.CountInPackage.Value.ToString());
                            break;
                    }

                    newItem.SubItems.Add(string.Format("{0:c}", _result.Items[i].Rate.UnitCostPerCycle));
                    // TODO: add the unit!
                    newItem.SubItems.Add(_result.Items[i].BillingDetail.CyclesBilled.ToString("N2"));
                    newItem.SubItems.Add(string.Format("{0:c}", _result.Items[i].BillingDetail.Revenue));
                    newItem.SubItems.Add(_result.Items[i].BillingDetail.CompanyRef.ToString(CultureInfo.InvariantCulture));
                    newItem.ToolTipText = _result.Items[i].BillingDetail.PublicDetails;
                    newItem.Tag = _result.Items[i];

                    ResultsListview.Items.Add(newItem);
                }
            }
            catch (Exception ex)
            {
                Log.Error("An exception occurred while populating the listview. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context
            }

            foreach (ColumnHeader hdr in ResultsListview.Columns)
                hdr.Width = -2;
            ResultsListview.ResumeLayout();

            CreateResultsComparer();
        }

        private void CreateResultsComparer()
        {
            _resultsComparerFactory = new ListViewComparerFactory(15);
                                                                                                    //  00  Client (string)
            _resultsComparerFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;   //  01  Profile ID
            _resultsComparerFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;   //  02  Inventory Detail ID
            _resultsComparerFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Date;      //  03  Prior Billed Through
            _resultsComparerFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Integer;   //  04  Receiver ID
            _resultsComparerFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Date;      //  05  Date Received
                                                                                                    //  06  Billing Type (string)
            _resultsComparerFactory[9].SortType = ListViewComparerFactory.ColumnSortType.Integer;   //  07  RFS
            _resultsComparerFactory[10].SortType = ListViewComparerFactory.ColumnSortType.Double;   //  08  Quantity
            _resultsComparerFactory[11].SortType = ListViewComparerFactory.ColumnSortType.Currency; //  09  Rate
            _resultsComparerFactory[12].SortType = ListViewComparerFactory.ColumnSortType.Double;   //  10  Cycles
            _resultsComparerFactory[13].SortType = ListViewComparerFactory.ColumnSortType.Currency; //  11  Revenue
            _resultsComparerFactory[14].SortType = ListViewComparerFactory.ColumnSortType.Integer;  //  12  Company
        }

        #endregion

        #region Control Handlers

        private void GenerateBillingButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            try
            {
                EnableUi(false);
                _Status.Items[0].Text = "Generating storage billing...";
                _Status.Update();

                var calculator = RfsFactory.GetRfsStorageBillingCalculator();
                _result = calculator.CalculateStorageBilling(BillThroughDatepicker.Value);

                _Status.Items[0].Text = "Preparing results for display...";
                _Status.Update();
                PopulateListview();

                _totalRevenue = 0;
                foreach (var detail in _result.Items)
                {
                    _totalRevenue += detail.BillingDetail.Revenue;
                }

                _Status.Items[0].Text = string.Format("{0} items for a total revenue of {1:c}", 
                    _result.Items.Count, _totalRevenue);
            }
            catch (Exception ex)
            {
                _Status.Items[0].Text = "An error occurred while generating storage billing.";
                Log.Error("An error occurred while generating storage billing. Details follow.", ex);
            }
            finally
            {
                EnableUi(true);
            }

            SaveBillingButton.Enabled = (_result != null && _result.Items.Count > 0);
            if (_result == null)
                MessageHelper.ShowError("An error occurred while generating storage billing. The most likely cause is items in inventory with expired rate assignments.");
            else if (_result.Items.Count < 1)
                MessageBox.Show("Sorry, but no inventory items were found to process.", "Empty Results");
            else
                SaveBillingButton.Enabled = true;
        }

        private void SaveBillingButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (_result == null || _result.Items.Count < 0)
            {
                MessageHelper.ShowInvalidOperation("There are no results to be saved.");
                return;
            }

            if (_result.Billing.BillingId > 0)
            {
                MessageHelper.ShowInvalidOperation(string.Format("The results have already been saved as storage billing ID {0}.", _result.Billing.BillingId));
                return;
            }

            if (GetBillingResultErrors() > 0)
            {
                MessageHelper.ShowError("The billing cannot be saved due to multi-company errors. Check the log for details.");
                return;
            }

            if (MessageHelper.ShowConfirm("Are you sure you wish to save the current storage billing results?") != DialogResult.Yes)
                return;

            var success = true;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                EnableUi(false);
                rfsDataContext.AddStorageBilling(_result.Billing);

                foreach (ListViewItem item in ResultsListview.Items)
                {
                    var id = item.Tag as RfsStorageBillingResult.ItemDetails;
                    Debug.Assert(id != null);
                    id.BillingDetail.BillingRef = _result.Billing.BillingId;
                    id.BillingDetail.BillingStatus = RfsBillingStatus.Approved;
                    rfsDataContext.AddStorageBillingDetail(id.BillingDetail);
                    rfsDataContext.UpdateStorageBillingInventoryTracking(id.InventoryDetail.DetailId, id.BillingDetail.NewDateBilledThrough);
                }

                var newEvent = new BopsRfsStorageBillingEvent(RfsStorageBillingEventType.StorageBillingSaved, _result.Billing.BillingId);
                rfsDataContext.AddStorageBillingEvent(newEvent);

                rfsDataContext.SaveChanges();

                SaveBillingButton.Enabled = false;
            }
            catch (Exception ex)
            {
                success = false;
                Log.Error("An error occurred while saving storage billing. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context
                EnableUi(true);
            }

            if (success)
            {
                SaveBillingButton.Enabled = false;
                var message = string.Format("Storage billing results saved as storage billing ID {0}.",
                                            _result.Billing.BillingId);
                MessageBox.Show(message, "Success");
                _Status.Items[0].Text = message;

                // On a successful save, close the dialog.

                DialogResult = DialogResult.OK;
                Close();
            }
            else
            {
                MessageHelper.ShowError("An error occurred while saving storage billing. Please contact IT support.");
            }
        }

        private int GetBillingResultErrors()
        {
            var errorCount = 0;
            Log.Info("Analyzing storage billing for errors prior to requested save.");

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            try
            {
                foreach (var result in _result.Items)
                {
                    var itemCompanyId = result.BillingDetail.CompanyRef;
                    var rfs = rfsDataContext.GetRfsById(result.Receiver.RfsRef.Value);

                    if (itemCompanyId != rfs.CompanyRef)
                    {
                        Log.ErrorFormat("Inventory item {0} billing has company ID {1}, but its receiver's RFS {2} has company ID {3}.",
                            result.InventoryDetail.DetailId, itemCompanyId, rfs.RfsId, rfs.CompanyRef);
                        errorCount++;
                    }

                    var billToClient = rfsDataContext.GetDestinationById(result.BillingDetail.BillToClientRef);

                    if (itemCompanyId != billToClient.CompanyRef)
                    {
                        Log.ErrorFormat("Inventory item {0} billing has company ID {1}, but its bill-to client {2} has company ID {3}.",
                            result.InventoryDetail.DetailId, itemCompanyId, billToClient.DestinationId, billToClient.CompanyRef);
                        errorCount++;
                    }
                }

            }
            catch (Exception ex)
            {
                Log.Error("An error occurred while checking storage billing for company errors. Details follow.", ex);
                errorCount++;
            }
            finally
            {
                // TODO: free the RFS data context
            }

            Log.Info(errorCount > 0 ? string.Format("Found a total of {0} errors.", errorCount) : "No errors found.");
            return errorCount;
        }

        private void ResultsListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (ResultsListview.Items.Count <= 0) return;

            ResultsListview.ListViewItemSorter = _resultsComparerFactory.CreateComparerForColumn(e.Column);
            ResultsListview.Sort();
        }

        private void ResultsListview_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            _needToUpdateStatusBarTotals = true;
        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (ResultsListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You must select items to copy.");
                return;
            }

            ListViewExportUtility.ExportToClipboard(ResultsListview, true, true);
        }

        private void disableItemStorageBillingToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (ResultsListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You must select items to disable their storage billing.");
                return;
            }

            if (!_isBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to disable storage billing for items.");
                return;
            }

            if (MessageHelper.ShowConfirm("Are you sure you want to disable storage billing for the selected items?") != DialogResult.Yes)
                return;

            var success = false;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                foreach (ListViewItem item in ResultsListview.SelectedItems)
                {
                    var id = item.Tag as RfsStorageBillingResult.ItemDetails;
                    Debug.Assert(id != null);

                    id.InventoryDetail.NoStorageBilling = true;

                    var newEvent = new BopsRfsStorageBillingEvent(RfsStorageBillingEventType.InventoryMarkedNsb, id.InventoryDetail.DetailId);
                    rfsDataContext.AddStorageBillingEvent(newEvent);
                }

                rfsDataContext.SaveChanges();
                success = true;
            }
            catch (Exception ex)
            {
                Log.Error("An exception occurred while disabling storage billing for selected items. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context
            }

            if (success)
            {
                ResultsListview.SuspendLayout();

                foreach (ListViewItem item in ResultsListview.Items)
                {
                    if (item.Selected)
                        ResultsListview.Items.Remove(item);
                }

                ResultsListview.ResumeLayout();
            }
            else
            {
                MessageHelper.ShowError("An exception occurred while disabling storage billing for selected items. Please contact IT support.");
            }
        }

        private void disableProfileStorageBillingToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (ResultsListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select precisely one item to disable storage billing for its profile.");
                return;
            }

            if (!_isBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to disable storage billing for a profile.");
                return;
            }

            var id = ResultsListview.SelectedItems[0].Tag as RfsStorageBillingResult.ItemDetails;
            Debug.Assert(id != null);
            var confirmMessage =
                string.Format("Are you sure you want to disable storage billing for product profile {0}?", id.Receiver.ProductProfileRef.Value);
            if (MessageHelper.ShowConfirm(confirmMessage) != DialogResult.Yes)
                return;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var success = false;

            try
            {
                var profile = rfsDataContext.GetProductProfileById(id.Receiver.ProductProfileRef.Value);
                profile.NoStorageBilling = true;

                var newEvent = new BopsRfsStorageBillingEvent(RfsStorageBillingEventType.ProfileMarkedNsb, id.Receiver.ProductProfileRef.Value);
                rfsDataContext.AddStorageBillingEvent(newEvent);
                rfsDataContext.SaveChanges();
                success = true;
            }
            catch (Exception ex)
            {
                Log.Error("An exception occurred while disabling storage billing for a product profile. Details follow.", ex);
            }
            finally
            {
                // TODO: free the RFS data context
            }

            if (success)
            {
                ResultsListview.SuspendLayout();

                foreach (ListViewItem item in ResultsListview.Items)
                {
                    var currentId = item.Tag as RfsStorageBillingResult.ItemDetails;
                    Debug.Assert(currentId != null);
                    if (currentId.Receiver.ProductProfileRef.Value == id.Receiver.ProductProfileRef.Value)
                        ResultsListview.Items.Remove(item);
                }

                ResultsListview.ResumeLayout();
            }
            else
            {
                MessageHelper.ShowError("An exception occurred while disabling storage billing for the selected item's profile. Please contact IT support.");
            }
        }

        private void StorageBillingForm_KeyDown(object sender, KeyEventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (e.KeyCode != Keys.Delete) return;

            if (ResultsListview.SelectedItems.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("You must select items to delete them from this storage billing.");
                return;
            }

            if (!_isBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must have Bops Administrators access to delete items from a storage billing.");
                return;
            }

            if (MessageHelper.ShowConfirm("Are you sure you want to delete the selected items from this storage billing?") != DialogResult.Yes)
                return;

            ResultsListview.SuspendLayout();
            foreach (ListViewItem item in ResultsListview.SelectedItems)
            {
                ResultsListview.Items.Remove(item);
            }
            ResultsListview.ResumeLayout();
        }

        private void _CopyButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (ResultsListview.Items.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("There are no results to copy to the clipboard.");
                return;
            }

            try
            {
                ListViewExportUtility.ExportToClipboard(ResultsListview, true, false);
                MessageBox.Show("Data copied to clipboard successfully.", "Success");
            }
            catch (Exception ex)
            {
                Log.Error("An error occurred copying the storage billing results to the clipboard. Details follow.", ex);
                MessageHelper.ShowError("An error occurred while copying the data to the clipboard. Please contact IT support.");
            }
        }

        private static string GetExportFileName()
        {
            var saveDialog = new SaveFileDialog();
            saveDialog.DefaultExt = "csv";
            saveDialog.Filter = "CSV files (*.csv)|*.csv|All files (*.*)|*.*";
            saveDialog.FileName = string.Format("RFS Storage Billing Details {0:yyyy-MM-dd HH-mm-ss}.csv", DateTime.Now);
            return saveDialog.ShowDialog() == DialogResult.OK ? saveDialog.FileName : null;
        }

        private void _ExportButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (ResultsListview.Items.Count < 1)
            {
                MessageHelper.ShowInvalidOperation("There are no results to export to a file.");
                return;
            }

            try
            {
                var exportFileName = GetExportFileName();
                if (exportFileName == null)
                    return;
                ListViewExportUtility.ExportDelimitedFile(ResultsListview, true, false, ",", exportFileName);
                MessageBox.Show("Data exported to file successfully.", "Success");
            }
            catch (Exception ex)
            {
                Log.Error("An error occurred saving the storage billing results to a file. Details follow.", ex);
                MessageHelper.ShowError("An error occurred while exporting the data to a file. Please contact IT support.");
            }
        }

        private void _ShowSummaryButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            if (_result == null)
            {
                MessageHelper.ShowInvalidOperation("There are no results to summarize.");
                return;
            }

            var newForm = new StorageBillingSummaryForm(_result);
            newForm.ShowDialog();
        }

        private void selectByProfileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            var comparer = new StringRepresentationComparer(StringRepresentationComparer.SortType.Integer,
                StringRepresentationComparer.SortDirection.Ascending);
            var newForm = new ListViewSelectByColumnForm(ResultsListview, 1, comparer);
            newForm.ShowDialog();
        }

        private void selectByReceiverToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled)
                return;

            var comparer = new StringRepresentationComparer(StringRepresentationComparer.SortType.Integer,
                StringRepresentationComparer.SortDirection.Ascending);
            var newForm = new ListViewSelectByColumnForm(ResultsListview, 4, comparer);
            newForm.ShowDialog();
        }

        #endregion
    }
}
