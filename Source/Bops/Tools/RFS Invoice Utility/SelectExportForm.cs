using System;
using System.Collections.Generic;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;

namespace RFS_Invoice_Utility
{
    public partial class SelectExportForm : Form
    {
        public enum ExportFormats
        {
            MAS90,
            Solomon
        }

        private int _ExportId;
        private ExportFormats _ExportFormat;
        private readonly ListViewComparerFactory _InvoiceExportsComparerFactory;

        public int ExportId
        {
            get { return _ExportId; }
        }

        public ExportFormats ExportFormat
        {
            get { return _ExportFormat; }
        }

        public SelectExportForm(IEnumerable<BopsRfsInvoiceExport> Exports)
        {
            InitializeComponent();

            _ExportId = -1;
            _ExportFormat = ExportFormats.MAS90;

            // Load the invoice exports listview with the following columns:
            //
            //  0   ID
            //  1   Date
            //  2   User ID
            //  3   Invoice Count
            //  4   Total Revenue

            InvoiceExportsListview.SuspendLayout();

            foreach (BopsRfsInvoiceExport Export in Exports)
            {
                ListViewItem NewItem = new ListViewItem(Export.ExportId.ToString());
                NewItem.SubItems.Add(Export.ExportDate.ToString("d"));
                NewItem.SubItems.Add(Export.UserId);
                NewItem.SubItems.Add(Export.InvoiceCount.ToString());
                NewItem.SubItems.Add(Export.TotalRevenue.ToString("c"));
                NewItem.Tag = Export;

                InvoiceExportsListview.Items.Add(NewItem);
            }

            foreach (ColumnHeader Hdr in InvoiceExportsListview.Columns)
                Hdr.Width = -2;
            InvoiceExportsListview.ResumeLayout();

            // Create the listview column-click comparer.

            _InvoiceExportsComparerFactory = new ListViewComparerFactory(5);
            _InvoiceExportsComparerFactory[0].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _InvoiceExportsComparerFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Date;
            _InvoiceExportsComparerFactory[3].SortType = ListViewComparerFactory.ColumnSortType.Integer;
            _InvoiceExportsComparerFactory[4].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            // Select the first item in the export format combobox.

            ExportFormatCombobox.SelectedIndex = 0;
        }

        private void OkButton_Click(object Sender, EventArgs E)
        {
            if (InvoiceExportsListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select an invoice export to proceed, or press the cancel button to abort.");
                return;
            }

            BopsRfsInvoiceExport Export = InvoiceExportsListview.SelectedItems[0].Tag as BopsRfsInvoiceExport;
            if (Export != null && Export.ExportId > 0)
            {
                _ExportId = Export.ExportId;
                if (!ExportFormatCombobox.Text.Contains("MAS90"))
                    _ExportFormat = ExportFormats.Solomon;

                DialogResult = DialogResult.OK;    
            }
            else
            {
                MessageHelper.ShowError("The selected export is invalid. Please contact IT support.");
            }
        }

        private void InvoiceExportsListview_ColumnClick(object Sender, ColumnClickEventArgs E)
        {
            if (InvoiceExportsListview.Items.Count <= 0) return;
            InvoiceExportsListview.ListViewItemSorter = _InvoiceExportsComparerFactory.CreateComparerForColumn(E.Column);
            InvoiceExportsListview.Sort();
        }
    }
}