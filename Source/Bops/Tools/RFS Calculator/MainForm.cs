using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Windows.Forms;
using System.Xml;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using log4net.Config;
using NHibernate;
using Scm.OpsCore.Legacy.DataLayer;

[assembly: XmlConfigurator(Watch = true)]

namespace RFS_Calculator
{
    public partial class MainForm : Form, IRfsCalculatorStatus
    {
        #region Helper Classes

        class ListViewItemTagData
        {
            private readonly BopsLoad _Load;
            private readonly BopsReceivingRecord _Receiver;
            private readonly BopsShippingRecord _Shipper;
            private readonly double _Revenue;

            public BopsLoad Load
            {
                get { return _Load; }
            }

            public BopsReceivingRecord Receiver
            {
                get { return _Receiver; }
            }

            public BopsShippingRecord Shipper
            {
                get { return _Shipper; }
            }

            public double Revenue
            {
                get { return _Revenue; }
            }

            public ListViewItemTagData(BopsLoad Load, double Revenue)
            {
                _Load = Load;
                _Revenue = Revenue;
            }

            public ListViewItemTagData(BopsReceivingRecord Receiver, double Revenue)
            {
                _Receiver = Receiver;
                _Revenue = Revenue;
            }

            public ListViewItemTagData(BopsShippingRecord Shipper, double Revenue)
            {
                _Shipper = Shipper;
                _Revenue = Revenue;
            }
        }

        #endregion

        private static readonly ILog _Log = LogManager.GetLogger(typeof(MainForm));
        private ListViewComparerFactory _LoadsCompareFactory;
        private ListViewComparerFactory _WarehouseCompareFactory;

        #region Properties

        private ToolStripStatusLabel StatusText
        {
            get
            {
                return (ToolStripStatusLabel)statusStrip1.Items[0];
            }
        }

        private ToolStripProgressBar StatusProgress
        {
            get
            {
                return (ToolStripProgressBar)statusStrip1.Items[1];
            }
        }

        #endregion

        public MainForm()
        {
            InitializeComponent();
        }

        #region Helper Methods

        private static string GetDwsNoRepDataFileName()
        {
            string ApplicationPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetModules()[0].FullyQualifiedName);
            string DwsNoRepFile = Path.Combine(ApplicationPath, "NHibernateDwsNoRepData.xml.config");
            return DwsNoRepFile;
        }

        private static string GetDwsRepDataFileName()
        {
            string ApplicationPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetModules()[0].FullyQualifiedName);
            string DwsRepFile = Path.Combine(ApplicationPath, "NHibernateDwsRepData.xml.config");
            return DwsRepFile;
        }

        public string SafeXmlNodeElementAttributeValue(XmlNode Node, string AttributeName, string NotFoundValue)
        {
            Debug.Assert(Node.NodeType == XmlNodeType.Element);
            XmlElement E = (XmlElement) Node;
            return E.HasAttribute(AttributeName) ? E.GetAttribute(AttributeName) : NotFoundValue;
        }

        private void PopulateListUsingNhibernate()
        {
            // Columns:
            //  0   Driver
            //  1   Load
            //  2   Load Date
            //  3   BOL
            //  4   PUR
            //  5   Origin
            //  6   Destination
            //  7   RFS
            //  8   Revenue

            _LoadsCompareFactory = new ListViewComparerFactory(9);
            _LoadsCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _LoadsCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _LoadsCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _LoadsCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _LoadsCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _LoadsCompareFactory[6].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _LoadsCompareFactory[7].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _LoadsCompareFactory[8].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var loads = rfsDataContext.GetLoadsByLoadDateRange(BeginDate.Value, EndDate.Value);

                // NB: When loading lots of items, it's faster to add them by range.

                var index = 0;
                var newItems = new ListViewItem[loads.Count];

                foreach (var load in loads)
                {
                    var newItem = new ListViewItem(load.DriverRef.ToString());
                    newItem.SubItems.Add(load.LoadReference);
                    newItem.SubItems.Add(load.LoadDate.Value.ToString("d"));
                    newItem.SubItems.Add(load.BillOfLadingRef.ToString());
                    newItem.SubItems.Add(load.PickUpRequestRef.ToString());
                    newItem.SubItems.Add(load.OriginRef.ToString());
                    newItem.SubItems.Add(load.LoadDestination.ToString());
                    newItem.SubItems.Add(load.RfsRef.ToString());

                    double loadRevenue = 0.0;
                    var revenue = rfsDataContext.GetLoadRevenueByReference(load.LoadReference);

                    if (revenue != null && revenue.ManualRevenue.HasValue)
                        loadRevenue = revenue.ManualRevenue.Value;
                    newItem.SubItems.Add(string.Format("{0:c}", loadRevenue));

                    ListViewItemTagData TagData = new ListViewItemTagData(load, loadRevenue);
                    newItem.Tag = TagData;

                    newItems[index++] = newItem;
                    StatusText.Text = load.LoadReference;
                    statusStrip1.Update();
                }

                LoadsListview.Items.AddRange(newItems);
            }
            finally
            {
                // TODO: free the RFS data context
            }
        }

        private void PopulateWarehouseListUsingNhibernate()
        {
            // Columns:
            //  0   Document ID
            //  1   Type
            //  2   Date
            //  3   Shipper
            //  4   Receiver
            //  5   RFS
            //  6   Revenue

            _WarehouseCompareFactory = new ListViewComparerFactory(7);
            _WarehouseCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _WarehouseCompareFactory[2].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _WarehouseCompareFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _WarehouseCompareFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _WarehouseCompareFactory[5].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _WarehouseCompareFactory[6].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var receivers = rfsDataContext.GetReceiversByDateReceivedRange(BeginDate.Value, EndDate.Value);

                var index = 0;
                var newReceivers = new ListViewItem[receivers.Count];

                foreach (var receiver in receivers)
                {
                    var newReceiver = new ListViewItem(receiver.ReceiverId.ToString());
                    newReceiver.SubItems.Add("Receiver");
                    newReceiver.SubItems.Add(receiver.DateReceived.Value.ToString("d"));
                    newReceiver.SubItems.Add(receiver.ShippingClientRef.ToString());
                    newReceiver.SubItems.Add(receiver.ReceivingClientRef.ToString());
                    newReceiver.SubItems.Add(receiver.RfsRef.ToString());

                    var revenue = rfsDataContext.GetWarehouseRevenueByDocumentTypeAndId(WarehouseDocumentType.Received, receiver.ReceiverId);

                    double WarehouseRevenue = 0.0;
                    if (revenue != null)
                        WarehouseRevenue = revenue.Revenue;

                    newReceiver.SubItems.Add(string.Format("{0:c}", WarehouseRevenue));
                    var tagData = new ListViewItemTagData(receiver, WarehouseRevenue);
                    newReceiver.Tag = tagData;

                    newReceivers[index++] = newReceiver;
                    StatusText.Text = receiver.ReceiverId.ToString();
                    statusStrip1.Update();
                }

                WarehouseListview.Items.AddRange(newReceivers);

                var shippers = rfsDataContext.GetShippersByShipmentDateRange(BeginDate.Value, EndDate.Value);

                index = 0;
                var newShippers = new ListViewItem[shippers.Count];

                foreach (var shipper in shippers)
                {
                    var newShipper = new ListViewItem(shipper.LoadId.ToString());
                    newShipper.SubItems.Add("Shipper");
                    newShipper.SubItems.Add(shipper.ShipmentDate.Value.ToString("d"));
                    newShipper.SubItems.Add(shipper.ShippingClientRef.ToString());
                    newShipper.SubItems.Add(shipper.ShippingClientRef.ToString());
                    newShipper.SubItems.Add(shipper.RfsRef.ToString());

                    var revenue = rfsDataContext.GetWarehouseRevenueByDocumentTypeAndId(WarehouseDocumentType.Shipped, shipper.LoadId);

                    double WarehouseRevenue = 0.0;
                    if (revenue != null)
                        WarehouseRevenue = revenue.Revenue;

                    newShipper.SubItems.Add(string.Format("{0:c}", WarehouseRevenue));
                    var tagData = new ListViewItemTagData(shipper, WarehouseRevenue);
                    newShipper.Tag = tagData;

                    newShippers[index++] = newShipper;
                    StatusText.Text = shipper.LoadId.ToString();
                    statusStrip1.Update();
                }

                WarehouseListview.Items.AddRange(newShippers);

            }
            finally
            {
                // TODO: free the RFS data context
            }
        }

        private void EnableInterface(bool enable)
        {
            BeginDate.Enabled = enable;
            EndDate.Enabled = enable;
            FindCalculableLoads.Enabled = enable;
            CalculateSelectedLoads.Enabled = enable;
            SelectZeroRevenueLoads.Enabled = enable;
            CalculateAllLoads.Enabled = enable;
            LoadsListview.Enabled = enable;
            SetEndDateToBeginDateButton.Enabled = enable;
            SetBeginDateToEndDateButton.Enabled = enable;
            FindCalculableWarehouseButton.Enabled = enable;
            CalculateSelectedWarehouseButton.Enabled = enable;
            SelectZeroRevenueWarehouseButton.Enabled = enable;
            CalculateAllWarehouseButton.Enabled = enable;
            
            Cursor = enable ? Cursors.Default : Cursors.WaitCursor;
        }

        #endregion

        private void CalculateSelectedLoads_Click(object Sender, EventArgs E)
        {
            if (LoadsListview.SelectedItems.Count > 0)
            {
                EnableInterface(false);

                var loads = new List<BopsLoad>();
                foreach (ListViewItem item in LoadsListview.SelectedItems)
                {
                    var tagData = item.Tag as ListViewItemTagData;
                    Debug.Assert(tagData != null);
                    loads.Add(tagData.Load);
                }

                // Initialize the data context by retrieving the relevant interface through the kernel.

                var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

                try
                {
                    var revenueCalculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, null);
                    var rfsLoadRevenueCalculationResult = new RfsLoadRevenueCalculationResult();
                    revenueCalculator.CalculateLoadRevenue(loads, rfsLoadRevenueCalculationResult);
                    _Log.Info(rfsLoadRevenueCalculationResult);
                    revenueCalculator.CleanInvalidRevenueResults();
                }
                finally
                {
                    // TODO: free the RFS data context
                }

                StatusProgress.Visible = false;
                statusStrip1.Update();
                EnableInterface(true);
            }
        }

        protected override void OnLoad(EventArgs E)
        {
            // Starting dates essentially match the "major calculation interval" for the RFS Operations Service.

            BeginDate.Value = DateTime.Now.Date.AddMonths(-1);
            EndDate.Value = DateTime.Now.Date.AddDays(15);

            base.OnLoad(E);
        }

        protected override void OnClosed(EventArgs E)
        {
            base.OnClosed(E);
        }

        private void FindCalculableLoads_Click(object Sender, EventArgs E)
        {
            var begin = DateTime.Now;

            LoadsListview.ListViewItemSorter = null;
            LoadsListview.Items.Clear();
            LoadsListview.SuspendLayout();

            PopulateListUsingNhibernate();
            foreach (ColumnHeader hdr in LoadsListview.Columns)
                hdr.Width = -2;
            LoadsListview.ResumeLayout();

            var duration = DateTime.Now - begin;
            StatusText.Text = string.Format("{0} loads, run time of {1}", LoadsListview.Items.Count, duration);
            statusStrip1.Update();
        }

        private void SelectZeroRevenueLoads_Click(object Sender, EventArgs E)
        {
            LoadsListview.SelectedIndices.Clear();

            for (var i = 0; i < LoadsListview.Items.Count; i++)
            {
                var tagData = LoadsListview.Items[i].Tag as ListViewItemTagData;
                Debug.Assert(tagData != null);

                if (tagData.Revenue == 0.0)
                    LoadsListview.SelectedIndices.Add(i);
            }

            LoadsListview.Focus();
            LoadsListview.RedrawItems(0, LoadsListview.Items.Count - 1, false);
        }

        private void CalculateAllLoads_Click(object Sender, EventArgs E)
        {
            EnableInterface(false);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var revenueCalculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, null);
                revenueCalculator.PrecacheRfsData();
                var rfsLoadRevenueCalculationResult = revenueCalculator.CalculateLoadRevenue(BeginDate.Value, EndDate.Value);
                _Log.Info(rfsLoadRevenueCalculationResult);
                revenueCalculator.CleanInvalidRevenueResults();
            }
            finally
            {
                // TODO: free the RFS data context
            }

            StatusProgress.Visible = false;
            statusStrip1.Update();
            EnableInterface(true);
        }

        public void InitializeProgressMeter(int MinimumNumber, int MaximumNumber)
        {
            StatusProgress.Minimum = MinimumNumber;
            StatusProgress.Maximum = MaximumNumber;
            StatusProgress.Visible = true;
        }

        public void ProgressUpdate(string PrimaryText, string SecondaryText, int CurrentNumber, int TotalNumber)
        {
            StatusText.Text = PrimaryText;
            StatusProgress.Value = CurrentNumber;
            statusStrip1.Update();
            Application.DoEvents();
        }

        public void UninitializeProgressMeter()
        {
            StatusProgress.Visible = false;
        }

        private void SetEndDateToBeginDateButton_Click(object Sender, EventArgs E)
        {
            EndDate.Value = BeginDate.Value;
        }

        private void SetBeginDateToEndDateButton_Click(object Sender, EventArgs E)
        {
            BeginDate.Value = EndDate.Value;
        }

        private void FindCalculableWarehouseButton_Click(object Sender, EventArgs E)
        {
            var begin = DateTime.Now;

            WarehouseListview.ListViewItemSorter = null;
            WarehouseListview.Items.Clear();
            WarehouseListview.SuspendLayout();

            PopulateWarehouseListUsingNhibernate();
            foreach (ColumnHeader hdr in WarehouseListview.Columns)
                hdr.Width = -2;
            WarehouseListview.ResumeLayout();

            var duration = DateTime.Now - begin;
            StatusText.Text = string.Format("{0} documents, run time of {1}", WarehouseListview.Items.Count, duration);
            statusStrip1.Update();
        }

        private void SelectZeroRevenueWarehouseButton_Click(object Sender, EventArgs E)
        {
            WarehouseListview.SelectedIndices.Clear();

            for (int I = 0; I < WarehouseListview.Items.Count; I++)
            {
                var tagData = WarehouseListview.Items[I].Tag as ListViewItemTagData;
                Debug.Assert(tagData != null);

                if (tagData.Revenue == 0.0)
                    WarehouseListview.SelectedIndices.Add(I);
            }

            WarehouseListview.Focus();
            WarehouseListview.RedrawItems(0, WarehouseListview.Items.Count - 1, false);
        }

        private void CalculateSelectedWarehouseButton_Click(object Sender, EventArgs E)
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                if (WarehouseListview.SelectedItems.Count > 0)
                {
                    EnableInterface(false);

                    var documents = new List<WarehouseCalculationInputs>();

                    foreach (ListViewItem item in WarehouseListview.SelectedItems)
                    {
                        var tagData = item.Tag as ListViewItemTagData;
                        Debug.Assert(tagData != null);

                        if (tagData.Receiver != null)
                        {
                            var receiver = new WarehouseCalculationInputs
                            {
                                DocumentId = tagData.Receiver.ReceiverId,
                                DocumentType = WarehouseDocumentType.Received
                            };

                            if (tagData.Receiver.DateReceived.HasValue)
                                receiver.DocumentDate = tagData.Receiver.DateReceived.Value;
                            if (tagData.Receiver.RfsRef.HasValue)
                                receiver.RfsRef = tagData.Receiver.RfsRef.Value;
                            receiver.ReceiverDocument = tagData.Receiver;
                            if (tagData.Receiver.ProductProfileRef.HasValue)
                                receiver.ProductProfile = rfsDataContext.GetProductProfileById(tagData.Receiver.ProductProfileRef.Value);
                            documents.Add(receiver);
                        }
                        else if (tagData.Shipper != null)
                        {
                            var shipper = new WarehouseCalculationInputs
                            {
                                DocumentId = tagData.Shipper.LoadId,
                                DocumentType = WarehouseDocumentType.Shipped
                            };

                            if (tagData.Shipper.ShipmentDate.HasValue)
                                shipper.DocumentDate = tagData.Shipper.ShipmentDate.Value;
                            if (tagData.Shipper.RfsRef.HasValue)
                                shipper.RfsRef = tagData.Shipper.RfsRef.Value;
                            shipper.ShipperDocument = tagData.Shipper;

                            // NB: Shippers don't have a product profile; if they have one someday this is where it should be set.

                            documents.Add(shipper);
                        }
                    }


                    var calculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, this);
                    var result = new RfsWarehouseRevenueCalculationResult();
                    calculator.CalculateWarehouseRevenue(documents, result);
                    _Log.Info(result);
                    calculator.CleanInvalidRevenueResults();

                    StatusProgress.Visible = false;
                    statusStrip1.Update();
                    EnableInterface(true);
                }

            }
            finally
            {
                // TODO: free the RFS data context
            }
        }

        private void CalculateAllWarehouseButton_Click(object Sender, EventArgs E)
        {
            EnableInterface(false);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var revenueCalculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, this);
                revenueCalculator.PrecacheRfsData();
                var revenueCalculationResult = revenueCalculator.CalculateWarehouseRevenue(BeginDate.Value, EndDate.Value);
                _Log.Info(revenueCalculationResult);
                revenueCalculator.CleanInvalidRevenueResults();
            }
            finally
            {
                // TODO: free the RFS data context
            }

            StatusProgress.Visible = false;
            statusStrip1.Update();
            EnableInterface(true);
        }

        private void AssignRfsToolStripMenuItem_Click(object Sender, EventArgs E)
        {
            MessageBox.Show("The code for this feature needs porting.", "Sorry", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);

            /*

            // Do nothing if we've nothing selected.

            if (LoadsListview.SelectedItems.Count <= 0) return;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                // Otherwise, get the new RFS number and make sure the user really wants to proceed.

                var allRfs = rfsDataContext.GetRfs(0, 0, 0);
                var validRfsNumbers = allRfs.Select(r => r.RfsId).ToArray();
                var rfsForm = new PromptRfsNumberForm {ValidRfsNumbers = validRfsNumbers};
                var result = rfsForm.ShowDialog();
                if (result != DialogResult.OK) return;

                bool Rollback = false;

                EnableInterface(false);
                _DwsNoRepSession.Clear();
                ITransaction Tx = _DwsNoRepSession.BeginTransaction();

                try
                {
                    foreach (ListViewItem Item in LoadsListview.SelectedItems)
                    {
                        ListViewItemTagData TagData = Item.Tag as ListViewItemTagData;
                        Debug.Assert(TagData != null);

                        TagData.Load.RfsRef = rfsForm.RfsNumber;
                        _DwsNoRepSession.Update(TagData.Load);
                    }
                }
                catch (Exception E1)
                {
                    _Log.Error("An exception occurred while assigning RFS numbers", E1);
                    Rollback = true;
                }
                finally
                {
                    if (Rollback)
                        Tx.Rollback();
                    else 
                        Tx.Commit();
                }

                StatusProgress.Visible = false;
                statusStrip1.Update();
                EnableInterface(true);
            }
            finally
            {
                // TODO: free the RFS data context
            }
            */
        }

        private void LoadsContextMenuStrip_Opening(object Sender, CancelEventArgs E)
        {
            AssignRfsToolStripMenuItem.Enabled = LoadsListview.SelectedItems.Count > 0;
        }

        private void LoadsListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            LoadsListview.ListViewItemSorter = _LoadsCompareFactory.CreateComparerForColumn(E.Column);
            LoadsListview.Sort();
        }

        private void WarehouseListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            WarehouseListview.ListViewItemSorter = _WarehouseCompareFactory.CreateComparerForColumn(E.Column);
            WarehouseListview.Sort();
        }
    }
}