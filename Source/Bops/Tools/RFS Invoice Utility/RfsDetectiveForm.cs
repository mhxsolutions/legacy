using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using BopsUiRfs;
using BopsUtilities;
using log4net;
using RFS_Invoice_Utility.Properties;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class RfsDetectiveForm : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(RfsDetectiveForm));

        private IDictionary<int, BopsRfsBillingStatus> _billingStatusMap;
        private IDictionary<int, BopsRfsInvoiceStatus> _invoiceStatusMap;
        private IDictionary<int, BopsRfsCalculationResultType> _calculationResultTypeMap;

        private ListViewComparerFactory _serviceResultsComparer;
        private ListViewComparerFactory _invoiceProgressComparer;

        private bool _uiEnabled;
        private string _lastType;
        private string _lastId;
        private int _lastRfsId;

        private readonly bool _allowRecalculate;

        public bool RfsReassigned { get; private set; }

        public RfsDetectiveForm(string documentType, string documentId, bool investigateOnLoad, bool allowRecalculate)
        {
            InitializeComponent();

            if (!string.IsNullOrEmpty(documentType))
            {
                var index = DocumentTypeCombobox.FindStringExact(documentType);
                if (index > -1)
                    DocumentTypeCombobox.SelectedIndex = index;
            }
            else
            {
                DocumentTypeCombobox.Text = @"Load";
            }

            if (!string.IsNullOrEmpty(documentId))
                DocumentIdTextbox.Text = documentId;

            _allowRecalculate = allowRecalculate;
            if (!allowRecalculate)
            {
                RecalculateButton.Enabled = false;
            }

            _uiEnabled = true;

            if (investigateOnLoad)
                InvestigateButton_Click(null, null);
        }

        private void EnableUi(bool enableUi)
        {
            CloseButton.Enabled = enableUi;
            InvestigateButton.Enabled = enableUi;
            DocumentTypeCombobox.Enabled = enableUi;
            if (_allowRecalculate)
            {
                RecalculateButton.Enabled = enableUi;
            }

            Cursor = enableUi ? Cursors.Default : Cursors.WaitCursor;
            _uiEnabled = enableUi;
        }

        private void InvestigateButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled) return;

            EnableUi(false);
            InvestigateBill();
            EnableUi(true);
        }

        private void InvestigateBill()
        {
            var enableRfsReassign = false;
            InitializeListviews();

            if (!string.IsNullOrEmpty(DocumentTypeCombobox.Text) && 
                !string.IsNullOrEmpty(DocumentIdTextbox.Text))
            {
                // Set the last type and last ID variables based on the last 
                // type of bill and ID investigated for future use.

                _lastType = DocumentTypeCombobox.Text.Trim();
                _lastId = DocumentIdTextbox.Text.Trim();

                // Initialize the data context by retrieving the relevant interface through the kernel.

                var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
                var descriptionBuilder = new BopsDescriptionBuilder(rfsDataContext);

                try
                {
                    BillingDocumentPicturebox.Image = Resources.Icon___Magnifying_Glass;

                    if (_billingStatusMap == null)
                        _billingStatusMap = rfsDataContext.GetBillingStatuses()
                            .ToDictionary(status => status.StatusId);
                    if (_invoiceStatusMap == null)
                        _invoiceStatusMap = rfsDataContext.GetInvoiceStatuses()
                            .ToDictionary(status => status.StatusId);
                    if (_calculationResultTypeMap == null)
                        _calculationResultTypeMap  = rfsDataContext.GetCalculationResultTypes()
                            .ToDictionary(status => status.ResultTypeId);

                    // Declare some lists for the calculation and service calculation results, 
                    // assigned below on the basis of the type of thing being investigated.

                    IList<BopsRfsCalculationResult> calculationResults = null;
                    IList<BopsRfsServiceCalculationResult> serviceCalculationResults = null;

                    switch (_lastType)
                    {
                        case "Load":
                            var load = rfsDataContext.GetLoadByReference(_lastId);
                            if (load != null)
                            {
                                if (load.RfsRef.HasValue)
                                    _lastRfsId = load.RfsRef.Value;
                                enableRfsReassign = (load.BillingStatus < RfsBillingStatus.Approved);

                                BillingDocumentPicturebox.Image = Resources.Icon___Check_Mark_2;
                                BillingDocumentTextbox.Text = descriptionBuilder.Describe(load);

                                calculationResults =
                                    rfsDataContext.GetCalculationResultsByLoadReference(load.LoadReference);
                                serviceCalculationResults =
                                    rfsDataContext.GetServiceCalculationResultsByLoadReference(load.LoadReference);
                            }
                            else
                            {
                                BillingDocumentPicturebox.Image = Resources.Icon___Cross_Mark_2;
                                BillingDocumentTextbox.Text = @"Load not found!";
                            }
                            break;
                        case "Receiver":
                            int receiverId;
                            if (int.TryParse(_lastId, out receiverId))
                            {
                                var receiver = rfsDataContext.GetReceiverById(receiverId);
                                if (receiver != null)
                                {
                                    if (receiver.RfsRef.HasValue)
                                        _lastRfsId = receiver.RfsRef.Value;
                                    enableRfsReassign = (receiver.BillingStatus < RfsBillingStatus.Approved);

                                    BillingDocumentPicturebox.Image = Resources.Icon___Check_Mark_2;
                                    BillingDocumentTextbox.Text = descriptionBuilder.Describe(receiver);

                                    calculationResults = rfsDataContext.GetCalculationResultsByReceiverId(receiverId);
                                    serviceCalculationResults =
                                        rfsDataContext.GetServiceCalculationResultsByReceiverId(receiverId);
                                }
                            }
                            else
                            {
                                BillingDocumentPicturebox.Image = Resources.Icon___Cross_Mark_2;
                                BillingDocumentTextbox.Text = @"Receiver not found!";
                            }
                            break;
                        case "BOL":
                            int bolId;
                            if (int.TryParse(_lastId, out bolId))
                            {
                                var bol = rfsDataContext.GetShipperById(bolId);
                                if (bol != null)
                                {
                                    if (bol.RfsRef.HasValue)
                                        _lastRfsId = bol.RfsRef.Value;
                                    enableRfsReassign = (bol.BillingStatus < RfsBillingStatus.Approved);

                                    BillingDocumentPicturebox.Image = Resources.Icon___Check_Mark_2;
                                    BillingDocumentTextbox.Text = descriptionBuilder.Describe(bol);

                                    calculationResults = rfsDataContext.GetCalculationResultsByShipperId(bolId);
                                    serviceCalculationResults =
                                        rfsDataContext.GetServiceCalculationResultsByShipperId(bolId);
                                }
                            }
                            else
                            {
                                BillingDocumentPicturebox.Image = Resources.Icon___Cross_Mark_2;
                                BillingDocumentTextbox.Text = @"BOL not found!";
                            }
                            break;

                        default:
                            BillingDocumentPicturebox.Image = Resources.Icon___Cross_Mark_2;
                            BillingDocumentTextbox.Text = @"Invalid document type.";
                            MessageHelper.ShowInvalidOperation("Invalid document type.");
                            break;
                    }

                    RfsPicturebox.Image = Resources.Icon___Magnifying_Glass;
                    var rfs = rfsDataContext.GetRfsById(_lastRfsId);

                    if (rfs != null)
                    {
                        RfsPicturebox.Image = Resources.Icon___Check_Mark_2;
                        RfsTextbox.Text = string.Format("Assigned valid RFS {0}", rfs.RfsId);
                    }
                    else
                    {
                        RfsPicturebox.Image = Resources.Icon___Cross_Mark_2;
                        RfsTextbox.Text = @"Invalid RFS!";
                    }

                    if (calculationResults != null)
                    {
                        CalculationResultPicturebox.Image = Resources.Icon___Magnifying_Glass;

                        if (calculationResults.Count == 1)
                        {
                            CalculationResultPicturebox.Image = Resources.Icon___Check_Mark_2;
                            var resultType = _calculationResultTypeMap[(int) calculationResults[0].ResultType];
                            CalculationResultTextbox.Text = string.Format("Result {0} calculated at {1}: {2}",
                                calculationResults[0].ResultId,
                                calculationResults[0].LastCalculation,
                                resultType.Description);
                        }
                        else
                        {
                            CalculationResultPicturebox.Image = Resources.Icon___Cross_Mark_2;
                            CalculationResultTextbox.Text = string.Format("{0} calculation results found!",
                                calculationResults.Count);
                        }
                    }
                    else
                    {
                        CalculationResultPicturebox.Image = Resources.Icon___Cross_Mark_2;
                        InvoiceProgressPicturebox.Image = Resources.Icon___Cross_Mark_2;
                        CalculationResultTextbox.Text = @"Could not look up calculation result!";
                        InvoiceProgressTextbox.Text = @"Could not look up invoice references!";
                    }

                    if (serviceCalculationResults != null)
                    {
                        ServiceCalculationResultPicturebox.Image = Resources.Icon___Magnifying_Glass;

                        if (serviceCalculationResults.Count > 0)
                        {
                            ServiceCalculationResultPicturebox.Image = Resources.Icon___Check_Mark_2;
                            ServiceCalculationResultTextbox.Text = string.Format(
                                "{0} service calculation results found", serviceCalculationResults.Count);

                            PopulateServiceCalculationResults(serviceCalculationResults);

                            InvoiceProgressPicturebox.Image = Resources.Icon___Magnifying_Glass;

                            var invoiceDetails = GetInvoiceDetails(serviceCalculationResults);
                            PopulateInvoiceDetails(serviceCalculationResults, invoiceDetails);
                        }
                        else
                        {
                            ServiceCalculationResultPicturebox.Image = Resources.Icon___Cross_Mark_2;
                            InvoiceProgressPicturebox.Image = Resources.Icon___Cross_Mark_2;
                            ServiceCalculationResultTextbox.Text = @"No service calculation results found!";
                            InvoiceProgressTextbox.Text = @"Could not look up invoice references!";
                        }
                    }
                    else
                    {
                        ServiceCalculationResultPicturebox.Image = Resources.Icon___Cross_Mark_2;
                        InvoiceProgressPicturebox.Image = Resources.Icon___Cross_Mark_2;
                        ServiceCalculationResultTextbox.Text = @"Could not look up service calculation results!";
                        InvoiceProgressTextbox.Text = @"Could not look up invoice references!";
                    }
                }
                finally
                {
                    // TODO: close out the RFS data context
                }
            }

            ReassignButton.Enabled = enableRfsReassign;
        }

        private void InitializeListviews()
        {
            ServiceCalculationResultsListview.Items.Clear();

            // Columns:
            //
            //  0   Result ID
            //  1   Service ID
            //  2   Status
            //  3   Date
            //  4   Revenue
            //  5   FSC
            //  6   Details

            _serviceResultsComparer = new ListViewComparerFactory(7);
            _serviceResultsComparer[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _serviceResultsComparer[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _serviceResultsComparer[3].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _serviceResultsComparer[4].SortType = ListViewComparerFactory.ColumnSortType.Currency;
            _serviceResultsComparer[5].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            InvoiceProgressListview.Items.Clear();

            // Columns:
            //
            //  0   Result ID
            //  1   Service ID
            //  2   Invoice
            //  3   Line
            //  4   Invoice Status

            _invoiceProgressComparer = new ListViewComparerFactory(5);
            _invoiceProgressComparer[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _invoiceProgressComparer[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _invoiceProgressComparer[2].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _invoiceProgressComparer[3].SortType = ListViewComparerFactory.ColumnSortType.Integer;
        }

        private void PopulateInvoiceDetails(IEnumerable<BopsRfsServiceCalculationResult> serviceResults, IDictionary<int, BopsRfsInvoiceDetail> invoiceDetails)
        {
            var allGood = true;
            InvoiceProgressListview.SuspendLayout();
            InvoiceProgressListview.Items.Clear();

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            foreach (var result in serviceResults)
            {
                var newItem = new ListViewItem(result.ResultId.ToString());
                newItem.SubItems.Add(result.ServiceId.ToString(CultureInfo.InvariantCulture));

                if (invoiceDetails.ContainsKey(result.ResultId))
                {
                    var detail = invoiceDetails[result.ResultId];
                    newItem.SubItems.Add(detail.InvoiceRef.ToString(CultureInfo.InvariantCulture));
                    newItem.SubItems.Add(detail.LineNumberDisplayed.ToString(CultureInfo.InvariantCulture));

                    var invoice = rfsDataContext.GetInvoiceById(detail.InvoiceRef);
                    if (invoice != null)
                    {
                        var status = _invoiceStatusMap[(int)invoice.InvoiceStatus];
                        newItem.SubItems.Add(status.Status);
                    }
                    else
                    {
                        newItem.SubItems.Add("Invoice not found!");
                        allGood = false;
                    }

                }
                else
                {
                    allGood = false;
                    newItem.SubItems.Add("(none)");
                    newItem.SubItems.Add("(none)");
                    newItem.SubItems.Add("(none)");
                }

                InvoiceProgressListview.Items.Add(newItem);
            }

            foreach (ColumnHeader hdr in InvoiceProgressListview.Columns)
                hdr.Width = -2;
            InvoiceProgressListview.ResumeLayout();

            if (allGood)
            {
                InvoiceProgressPicturebox.Image = Resources.Icon___Check_Mark_2;
                InvoiceProgressTextbox.Text = @"All bills are on a valid invoice.";
            }
            else
            {
                InvoiceProgressPicturebox.Image = Resources.Icon___Cross_Mark_2;
                InvoiceProgressTextbox.Text = @"At least one bill is not on a valid invoice.";
            }
        }

        private IDictionary<int, BopsRfsInvoiceDetail> GetInvoiceDetails(IList<BopsRfsServiceCalculationResult> serviceResults)
        {
            // TODO: We're going to need to build a big OR expression for Entity Framework, I think:
            // http://blogs.msdn.com/b/alexj/archive/2009/03/26/tip-8-writing-where-in-style-queries-using-linq-to-entities.aspx

            var returnValue = new Dictionary<int, BopsRfsInvoiceDetail>();
            if (serviceResults.Count <= 0) return returnValue;

            var resultIds = new int[serviceResults.Count];
            for (var i = 0; i < serviceResults.Count; i++)
            {
                resultIds[i] = serviceResults[i].ResultId;
            }

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var invoiceDetails = rfsDataContext.GetInvoiceDetailsFromServiceCalculationResults(resultIds);

            foreach (var detail in invoiceDetails)
            {
                returnValue.Add(detail.ServiceCalculationResultRef.Value, detail);
            }

            return returnValue;
        }

        private void PopulateServiceCalculationResults(IEnumerable<BopsRfsServiceCalculationResult> results)
        {
            ServiceCalculationResultsListview.SuspendLayout();
            ServiceCalculationResultsListview.Items.Clear();

            foreach (var result in results)
            {
                var newItem = new ListViewItem(result.ResultId.ToString(CultureInfo.InvariantCulture));
                newItem.SubItems.Add(result.ServiceId.ToString(CultureInfo.InvariantCulture));
                var billingStatus = _billingStatusMap[(int)result.BillingStatus];
                newItem.SubItems.Add(billingStatus.Status);
                newItem.SubItems.Add(result.BillingDate.HasValue ? result.BillingDate.Value.ToString("d") : "?");
                newItem.SubItems.Add(string.Format("{0:c}", result.PublicRate.RfsRevenue));
                newItem.SubItems.Add(string.Format("{0:c}", result.PublicRate.FscRevenue));
                newItem.SubItems.Add(result.PublicRate.CalculationDetails);

                ServiceCalculationResultsListview.Items.Add(newItem);
            }

            foreach (ColumnHeader hdr in ServiceCalculationResultsListview.Columns)
                hdr.Width = -2;
            ServiceCalculationResultsListview.ResumeLayout();
        }

        private void RfsDetectiveForm_KeyDown(object sender, KeyEventArgs e)
        {
            if (!_uiEnabled) return;
            if (!e.Control || (e.KeyCode != Keys.F)) return;
            DocumentIdTextbox.Focus();
            DocumentIdTextbox.SelectAll();
        }

        private void ServiceCalculationResultsListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (!_uiEnabled) return;
            if (ServiceCalculationResultsListview.Items.Count <= 0) return;
            ServiceCalculationResultsListview.ListViewItemSorter = _serviceResultsComparer.CreateComparerForColumn(e.Column);
            ServiceCalculationResultsListview.Sort();
        }

        private void InvoiceProgressListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (!_uiEnabled) return;
            if (InvoiceProgressListview.Items.Count <= 0) return;
            InvoiceProgressListview.ListViewItemSorter = _invoiceProgressComparer.CreateComparerForColumn(e.Column);
            InvoiceProgressListview.Sort();
        }

        private bool RecalculateWarehouse(IRfsDataContext rfsDataContext, int warehouseDocumentId, 
            WarehouseDocumentType documentType)
        {
            var returnValue = false;
            var inputs = new WarehouseCalculationInputs();
            var documents = new List<WarehouseCalculationInputs>();

            if (documentType == WarehouseDocumentType.Received)
            {
                var receiver = rfsDataContext.GetReceiverById(warehouseDocumentId);

                inputs.DocumentId = warehouseDocumentId;
                inputs.DocumentType = WarehouseDocumentType.Received;
                inputs.DocumentDate = receiver.DateReceived.Value;
                inputs.RfsRef = receiver.RfsRef.Value;
                inputs.ReceiverDocument = receiver;

                if (receiver.ProductProfileRef.HasValue)
                    inputs.ProductProfile = rfsDataContext.GetProductProfileById(receiver.ProductProfileRef.Value);

                documents.Add(inputs);
            }
            else if (documentType == WarehouseDocumentType.Shipped)
            {
                var shipper = rfsDataContext.GetShipperById(warehouseDocumentId);

                inputs.DocumentId = warehouseDocumentId;
                inputs.DocumentType = WarehouseDocumentType.Shipped;
                inputs.DocumentDate = shipper.ShipmentDate.Value;
                inputs.RfsRef = shipper.RfsRef.Value;
                inputs.ShipperDocument = shipper;

                // TODO: add the profile here if BOLs ever have a product profile.

                documents.Add(inputs);
            }

            // If we created a document above, then we attempt the calculation.

            if (documents.Count > 0)
            {
                var calculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, null);
                var result = new RfsWarehouseRevenueCalculationResult();
                calculator.CalculateWarehouseRevenue(documents, result);
                Log.Info(result);

                // This is a frequent source of exceptions, so I'm wrapping it in a try/catch.
                // I can't fix all the bad data, but I can at least prevent the detective form
                // from choking on it completely.

                try
                {
                    rfsDataContext.RemoveInvalidRevenueResults();
                }
                catch (Exception e)
                {
                    MessageHelper.ShowError("An error occurred when trying to clean invalid RFS results.");
                    Log.Error("An error occurred trying to clean invalid RFS results, details follow.", e);
                }

                returnValue = true;
            }

            return returnValue;
        }

        private void RecalculateButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled) return;

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            var success = false;

            try
            {
                EnableUi(false);

                switch (_lastType)
                {
                    case "Load":
                        var load = rfsDataContext.GetLoadByReference(_lastId);

                        if (load != null)
                        {
                            Log.InfoFormat("Recalculating load {0}", load.LoadReference);
                            var revenueCalculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, null);
                            var rfsLoadRevenueCalculationResult = new RfsLoadRevenueCalculationResult();
                            revenueCalculator.CalculateLoadRevenue(new List<BopsLoad> {load}, rfsLoadRevenueCalculationResult);
                            Log.Info(rfsLoadRevenueCalculationResult);
                            rfsDataContext.RemoveInvalidRevenueResults();
                            success = true;
                        }
                        break;

                    case "Receiver":
                        var receiverId = Convert.ToInt32(_lastId);
                        success = RecalculateWarehouse(rfsDataContext, receiverId, WarehouseDocumentType.Received);
                        break;

                    case "BOL":
                        var bolId = Convert.ToInt32(_lastId);
                        success = RecalculateWarehouse(rfsDataContext, bolId, WarehouseDocumentType.Shipped);
                        break;

                    default:
                        MessageHelper.ShowInvalidOperation("Invalid document type.");
                        break;
                }
            }
            finally
            {
                // TODO: free the RFS data context

                if (success)
                    InvestigateBill();

                EnableUi(true);
            }
        }

        private void RfsDetailsButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled) return;
            if (_lastRfsId <= 0) return;
            var newForm = new EditRfsForm(null, _lastRfsId, EditRfsForm.RfsEditPage.Main, false);
            newForm.ShowDialog();
        }

        private void ReassignButton_Click(object sender, EventArgs e)
        {
            if (!_uiEnabled) return;

            var promptForm = new PromptNewRfsForm(string.Format("{0} {1}", _lastType, _lastId));
            if (promptForm.ShowDialog() != DialogResult.OK)
                return;

            string errors = null;

            try
            {
                var rfsLifecycleManager = RfsFactory.GetRfsLifecycleManager();

                EnableUi(false);

                switch (_lastType)
                {
                    case "Load":
                        errors = rfsLifecycleManager.ReassignLoadRfs(_lastId, promptForm.NewRfs);
                        break;

                    case "Receiver":
                        var receiverId = Convert.ToInt32(_lastId);
                        errors = rfsLifecycleManager.ReassignReceiverRfs(receiverId, promptForm.NewRfs);
                        break;

                    case "BOL":
                        var bolId = Convert.ToInt32(_lastId);
                        errors = rfsLifecycleManager.ReassignShipperRfs(bolId, promptForm.NewRfs);
                        break;

                    default:
                        MessageHelper.ShowInvalidOperation("Invalid document type.");
                        break;
                }
            }
            finally
            {
                EnableUi(true);
            }

            if (errors != null)
            {
                MessageHelper.ShowError("The RFS could not be changed for the following reasons: " + errors);
            }
            else
            {
                MessageBox.Show(@"The RFS was changed.", @"Success");

                EnableUi(false);
                RfsReassigned = true;
                InvestigateBill();
                EnableUi(true);
            }
        }
    }
}
