using System;
using System.Collections.Generic;
using System.Globalization;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsUiRfs
{
    public sealed partial class EditRfsForm : Form
    {
        public enum RfsEditPage
        {
            Main,
            Stakeholders,
            Services
        }

        private readonly bool _AllowEdit;   // Isn't presently used but should be in the future.
        private readonly int _rfsNumber;
        private readonly IRfsDataContext _rfsDataContext;
        private readonly bool _ownTheRfsDataContext;

        private IList<BopsRfsStatus> _rfsStatuses;
        private IList<BopsDriver> _rfsSalesPersons;
        private IList<BopsDestination> _rfsDestinations;
        private IList<BopsAtsfProduct> _rfsCommodities;
        private IList<BopsRfsWorkType> _rfsWorkTypes;
        private IList<BopsRfsStakeholder> _rfsStakeholders;
        private IList<BopsRfsServicesRequested> _rfsServicesRequested;

        private IDictionary<int, BopsRfsStakeholderRole> _rfsStakeholderRolesMap;
        private IDictionary<int, BopsDestination> _rfsDestinationsMap;
        private IDictionary<int, BopsRfsServicesOffered> _rfsServicesOfferedMap;
        private IDictionary<int, BopsRfsStakeholder> _rfsStakeholdersMap;

        private ListViewComparerFactory _stakeholdersCompareFactory;
        private ListViewComparerFactory _servicesCompareFactory;

        private BopsRfs _rfsRecord;

        public EditRfsForm(IRfsDataContext rfsDataContext, int rfsNumber, RfsEditPage initialPage, bool allowEdit)
        {
            if (rfsDataContext == null)
            {
                _ownTheRfsDataContext = true;
                _rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            }
            else
            {
                _rfsDataContext = rfsDataContext;
            }

            _rfsNumber = rfsNumber;
            _AllowEdit = allowEdit;

            InitializeComponent();

            Cursor = Cursors.WaitCursor;

            CacheData();
            PopulateMainTab();
            PopulateStakeholdersTab();
            PopulateServicesTab();

            MainTabcontrol.SelectedIndex = (int) initialPage;

            // Configure the form on the basis of whether we're editing or merely viewing.

            Text = string.Format("{0} RFS {1}", _AllowEdit ? "Editing" : "Viewing", _rfsNumber);
            if (!_AllowEdit)
            {
                CloseButton.Location = OkButton.Location;
                CloseButton.Text = "Close";
                OkButton.Visible = false;
                //EnableMainControls(false);
            }

            Cursor = Cursors.Default;
        }

        private void PopulateMainTab()
        {
            PopulateMainComboboxes();

            MainBeginDatepicker.Value = _rfsRecord.BeginDate;
            SetDatePicker(MainEndDatepicker, _rfsRecord.EndDate);
            MainVesselTextbox.Text = _rfsRecord.Vessel;
            SetDatePicker(MainFfdDatepicker, _rfsRecord.FirstFreeDate);
            SetDatePicker(MainLfdDatepicker, _rfsRecord.LastFreeDate);
            MainDescriptionTextbox.Text = _rfsRecord.WorkDescription;
        }

        private void PopulateStakeholdersTab()
        {
            // Columns:
            //
            //  0   ID
            //  1   Role
            //  2   Client
            //  3   Instructions

            _stakeholdersCompareFactory = new ListViewComparerFactory(4);
            _stakeholdersCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;

            StakeholdersListview.SuspendLayout();
            StakeholdersListview.Items.Clear();

            foreach (var stakeholder in _rfsStakeholders)
            {
                var newItem = new ListViewItem(stakeholder.StakeholderId.ToString(CultureInfo.InvariantCulture));
                newItem.SubItems.Add(_rfsStakeholderRolesMap[(int) stakeholder.RoleRef].Name);
                var client = _rfsDestinationsMap[stakeholder.ClientRef];
                newItem.SubItems.Add(client.ToString());
                newItem.SubItems.Add(string.IsNullOrEmpty(stakeholder.Instructions) ? "(none)" : stakeholder.Instructions);

                StakeholdersListview.Items.Add(newItem);
            }

            foreach (ColumnHeader hdr in StakeholdersListview.Columns)
                hdr.Width = -2;
            StakeholdersListview.ResumeLayout();
        }

        private void PopulateServicesTab()
        {
            // Columns:
            //  0   ID
            //  1   Group
            //  2   Category
            //  3   Name
            //  4   Origin
            //  5   Destination
            //  6   Cost Method
            //  7   Cost
            //  8   Throughput
            //  9   Revenue
            //  10  Minutes

            _servicesCompareFactory = new ListViewComparerFactory(11);
            _servicesCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _servicesCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _servicesCompareFactory[8].SortType = ListViewComparerFactory.ColumnSortType.Currency;
            _servicesCompareFactory[9].SortType = ListViewComparerFactory.ColumnSortType.Currency;
            _servicesCompareFactory[10].SortType = ListViewComparerFactory.ColumnSortType.Integer;

            ServicesListview.SuspendLayout();
            ServicesListview.Items.Clear();

            var describer = new BopsDescriptionBuilder(_rfsDataContext);

            foreach (var service in _rfsServicesRequested)
            {
                var newItem = new ListViewItem(service.ServiceRequestedId.ToString(CultureInfo.InvariantCulture));
                newItem.SubItems.Add(service.ServiceGroup.ToString(CultureInfo.InvariantCulture));
                var serviceOffered = _rfsServicesOfferedMap[service.ServiceOfferedRef];
                newItem.SubItems.Add(serviceOffered.CategoryRef.ToString());
                newItem.SubItems.Add(serviceOffered.Name);

                if (service.OriginRef.HasValue && 
                    _rfsStakeholdersMap.ContainsKey(service.OriginRef.Value) &&
                    _rfsDestinationsMap.ContainsKey(_rfsStakeholdersMap[service.OriginRef.Value].ClientRef))
                {
                    var origin = _rfsDestinationsMap[_rfsStakeholdersMap[service.OriginRef.Value].ClientRef];
                    newItem.SubItems.Add(origin.ToString());
                }
                else
                {
                    newItem.SubItems.Add("(none)");
                }

                if (service.IndeterminateDestination)
                {
                    newItem.SubItems.Add("(indeterminate)");
                }
                else if (service.DestinationRef.HasValue && 
                    _rfsStakeholdersMap.ContainsKey(service.DestinationRef.Value) &&
                    _rfsDestinationsMap.ContainsKey(_rfsStakeholdersMap[service.DestinationRef.Value].ClientRef))
                {
                    var destination = _rfsDestinationsMap[_rfsStakeholdersMap[service.DestinationRef.Value].ClientRef];
                    newItem.SubItems.Add(destination.ToString());
                }
                else
                {
                    newItem.SubItems.Add("(none)");
                }

                var costMethod = describer.DescribeCostMethod(service.PublicRate);
                newItem.SubItems.Add(costMethod);

                var costDescription = describer.DescribeCost(service.PublicRate);
                newItem.SubItems.Add(costDescription);

                if (service.PublicRate.EstimatedThroughput.HasValue)
                    newItem.SubItems.Add(string.Format("{0:c}", service.PublicRate.EstimatedThroughput.Value));
                else
                    newItem.SubItems.Add("?");

                if (service.PublicRate.EstimatedRevenue.HasValue)
                    newItem.SubItems.Add(string.Format("{0:c}", service.PublicRate.EstimatedRevenue.Value));
                else
                    newItem.SubItems.Add("?");

                if (service.PublicRate.EstimatedMinutes.HasValue)
                    newItem.SubItems.Add(service.PublicRate.EstimatedMinutes.Value.ToString());
                else
                    newItem.SubItems.Add("?");

                ServicesListview.Items.Add(newItem);
            }

            foreach (ColumnHeader hdr in ServicesListview.Columns)
                hdr.Width = -2;
            ServicesListview.ResumeLayout();
        }

        private void EnableMainControls(bool enable)
        {
            MainStatusCombobox.Enabled = enable;
            //MainStatusCombobox.BackColor = Color.Red; //SystemColors.Window;
            MainSalespersonCombobox.Enabled = enable;
            MainShipperCombobox.Enabled = enable;
            MainCommodityCombobox.Enabled = enable;
            MainWorkTypeCombobox.Enabled = enable;
            MainBeginDatepicker.Enabled = enable;
            MainEndDatepicker.Enabled = enable;
            MainVesselTextbox.Enabled = enable;
            MainFfdDatepicker.Enabled = enable;
            MainLfdDatepicker.Enabled = enable;
            MainDescriptionTextbox.Enabled = enable;
        }

        private static void SetDatePicker(DateTimePicker ctl, DateTime? nullableValue)
        {
            ctl.Checked = nullableValue.HasValue;
            if (nullableValue.HasValue)
                ctl.Value = nullableValue.Value;
        }

        private void PopulateMainComboboxes()
        {
            foreach (var status in _rfsStatuses)
            {
                MainStatusCombobox.Items.Add(status);
                if (status.StatusId == _rfsRecord.StatusRef)
                    MainStatusCombobox.SelectedItem = status;
            }

            foreach (var salesPerson in _rfsSalesPersons)
            {
                MainSalespersonCombobox.Items.Add(salesPerson);
                if (salesPerson.DriverId == _rfsRecord.SalespersonRef)
                    MainSalespersonCombobox.SelectedItem = salesPerson;
            }

            foreach (BopsDestination destination in _rfsDestinations)
            {
                if (!destination.ParentRef.HasValue || 
                    destination.ParentRef.Value == 0 ||
                    destination.ParentRef.Value == destination.DestinationId)
                {
                    MainShipperCombobox.Items.Add(destination);
                    if (destination.DestinationId == _rfsRecord.ShipperRef)
                        MainShipperCombobox.SelectedItem = destination;
                }
            }

            foreach (var commodity in _rfsCommodities)
            {
                MainCommodityCombobox.Items.Add(commodity);
                if (commodity.AtsfProductId == _rfsRecord.CommodityRef)
                    MainCommodityCombobox.SelectedItem = commodity;
            }

            foreach (var workType in _rfsWorkTypes)
            {
                MainWorkTypeCombobox.Items.Add(workType);
                if (workType.WorkTypeId == _rfsRecord.WorkTypeRef)
                    MainWorkTypeCombobox.SelectedItem = workType;
            }
        }

        private void CacheData()
        {
            // TODO: Update this to use user company detail if appropriate.

            _rfsStatuses = _rfsDataContext.GetStatuses();
            _rfsSalesPersons = _rfsDataContext.GetEmployeesByRoleType(EmployeeRoleTypes.Sales);
            _rfsDestinations = _rfsDataContext.GetDestinations(0, 0, 0);
            _rfsCommodities = _rfsDataContext.GetProducts();
            _rfsWorkTypes = _rfsDataContext.GetWorkTypes();
            _rfsRecord = _rfsDataContext.GetRfsById(_rfsNumber);
            _rfsStakeholders = _rfsDataContext.GetStakeholdersByRfsId(_rfsNumber);

            var roles = _rfsDataContext.GetStakeholderRoles();

            _rfsDestinationsMap = new Dictionary<int, BopsDestination>();
            foreach (var destination in _rfsDestinations)
            {
                _rfsDestinationsMap.Add(destination.DestinationId, destination);
            }

            _rfsStakeholdersMap = new Dictionary<int, BopsRfsStakeholder>();
            foreach (var stakeholder in _rfsStakeholders)
            {
                _rfsStakeholdersMap.Add(stakeholder.StakeholderId, stakeholder);
            }

            _rfsStakeholderRolesMap = new Dictionary<int, BopsRfsStakeholderRole>();
            foreach (var role in roles)
            {
                _rfsStakeholderRolesMap.Add(role.Id, role);
            }

            _rfsServicesRequested = _rfsDataContext.GetServicesRequestedByRfsId(_rfsNumber);

            _rfsServicesOfferedMap = new Dictionary<int, BopsRfsServicesOffered>();

            // TODO: Update this to use user company detail if appropriate.

            var servicesOffered = _rfsDataContext.GetServicesOffered(0);
            foreach (var service in servicesOffered)
            {
                _rfsServicesOfferedMap.Add(service.Id, service);
            }
        }

        public override sealed string Text
        {
            get { return base.Text; }
            set { base.Text = value; }
        }

        private void EditRfsForm_FormClosed(object Sender, FormClosedEventArgs E)
        {
            // TODO: Figure out what to do to close the data context.
            //if (_ownTheRfsDataContext)
            //    _rfsDataContext.CloseSessions();
        }

        private void OkButton_Click(object Sender, EventArgs E)
        {
            // TODO: write the code to update the RFS when edit mode is supported.
            Close();
        }

        private void StakeholdersListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (StakeholdersListview.Items.Count <= 0) return;
            StakeholdersListview.ListViewItemSorter = _stakeholdersCompareFactory.CreateComparerForColumn(E.Column);
            StakeholdersListview.Sort();
        }

        private void ServicesListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (ServicesListview.Items.Count <= 0) return;
            ServicesListview.ListViewItemSorter = _servicesCompareFactory.CreateComparerForColumn(E.Column);
            ServicesListview.Sort();
        }
    }
}