using System;
using System.Collections.Generic;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class EditServiceGlCodesForm : Form
    {
        private class ServiceProxy
        {
            public int Id { get; set; }

            public string Name { get; set; }

            public string Mas90 { get; set; }

            public string SolomonAccount { get; set; }

            public string SolomonSubAccount { get; set; }

            internal BopsRfsServicesOffered ServiceOffered { get; private set; }

            internal bool IsChanged
            {
                get
                {
                    return Mas90 != ServiceOffered.GeneralLedgerCode ||
                           SolomonAccount != ServiceOffered.SolomonAccountNumber ||
                           SolomonSubAccount != ServiceOffered.SolomonCostCenterType;
                }
            }

            public ServiceProxy(BopsRfsServicesOffered service)
            {
                Id = service.Id;
                Name = service.Name;
                Mas90 = service.GeneralLedgerCode;
                SolomonAccount = service.SolomonAccountNumber;
                SolomonSubAccount = service.SolomonCostCenterType;
                ServiceOffered = service;
            }
        }

        private static readonly ILog Log = LogManager.GetLogger(typeof(EditServiceGlCodesForm));

        private readonly IRfsDataContext _rfsDataContext;
        private readonly IList<ServiceProxy> _proxyList;

        public EditServiceGlCodesForm()
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            _rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            InitializeComponent();

            // By binding the spread control directly to our proxy IList, we get a spread that contains
            // one column for each public property of the underlying objects. 

            // TODO: Update this to use user company detail if appropriate.

            var services = _rfsDataContext.GetServicesOffered(0);
            _proxyList = new List<ServiceProxy>();
            foreach (var service in services)
                _proxyList.Add(new ServiceProxy(service));

            _ServicesSpread_Sheet1.DataSource = _proxyList;

            ConfigureServicesSpreadControl();
        }

        private void ConfigureServicesSpreadControl()
        {
            // Hide the row header (i.e., the line numbers)

            _ServicesSpread_Sheet1.RowHeader.Visible = false;

            // Hide the scroll bars unless they're needed.

            _ServicesSpread.HorizontalScrollBarPolicy = FarPoint.Win.Spread.ScrollBarPolicy.AsNeeded;
            _ServicesSpread.VerticalScrollBarPolicy = FarPoint.Win.Spread.ScrollBarPolicy.AsNeeded;

            // Horizontally center align the first (ID) column.

            _ServicesSpread_Sheet1.ColumnHeader.Columns[0].HorizontalAlignment = FarPoint.Win.Spread.CellHorizontalAlignment.Center;
            _ServicesSpread_Sheet1.Columns[0].HorizontalAlignment = FarPoint.Win.Spread.CellHorizontalAlignment.Center;

            // Configure the column header labels.

            _ServicesSpread_Sheet1.ColumnHeader.Columns[0].Label = "ID";
            _ServicesSpread_Sheet1.ColumnHeader.Columns[1].Label = "Name";
            _ServicesSpread_Sheet1.ColumnHeader.Columns[2].Label = "MAS90";
            _ServicesSpread_Sheet1.ColumnHeader.Columns[3].Label = "SL Account";
            _ServicesSpread_Sheet1.ColumnHeader.Columns[4].Label = "SL Sub Account";

            // Configure the column header widths.

            _ServicesSpread_Sheet1.ColumnHeader.Columns[0].Width = 50;
            _ServicesSpread_Sheet1.ColumnHeader.Columns[1].Width = 225;
            _ServicesSpread_Sheet1.ColumnHeader.Columns[2].Width = 100;
            _ServicesSpread_Sheet1.ColumnHeader.Columns[3].Width = 100;
            _ServicesSpread_Sheet1.ColumnHeader.Columns[4].Width = 100;

            // Lock the first two columns to prevent changes.

            _ServicesSpread_Sheet1.Columns[0].Locked = true;
            _ServicesSpread_Sheet1.Columns[1].Locked = true;
        }

        private void OkButton_Click(object sender, EventArgs e)
        {
            try
            {
                var updates = 0;

                foreach (var proxy in _proxyList)
                {
                    if (!proxy.IsChanged) continue;

                    proxy.ServiceOffered.GeneralLedgerCode = proxy.Mas90;
                    proxy.ServiceOffered.SolomonAccountNumber = proxy.SolomonAccount;
                    proxy.ServiceOffered.SolomonCostCenterType = proxy.SolomonSubAccount;
                    updates++;
                }

                if (updates > 0)
                    _rfsDataContext.SaveChanges();
            }
            catch (Exception ex)
            {
                Log.Error("An exception occurred while updating the general ledger codes. Details follow.", ex);
                MessageHelper.ShowError("An exception occurred while updating service general ledger codes. Contact IT support.");
            }

            DialogResult = DialogResult.OK;
        }

        protected override void OnClosed(EventArgs e)
        {
            // TODO: Close the RFS data context
            base.OnClosed(e);
        }
    }
}