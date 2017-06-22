using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;
using BopsBusinessLogicRfs;
using BopsUtilities;

namespace RFS_Invoice_Utility
{
    public partial class InvoiceExportResultsForm : Form
    {
        private readonly ListViewComparerFactory _AccountBreakdownCompareFactory;

        public InvoiceExportResultsForm(InvoiceExportResults _Results, string _FileName, string _FileContents)
        {
            _AccountBreakdownCompareFactory = new ListViewComparerFactory(2);
            _AccountBreakdownCompareFactory[0].SortType = ListViewComparerFactory.ColumnSortType.String;
            _AccountBreakdownCompareFactory[1].SortType = ListViewComparerFactory.ColumnSortType.Currency;

            InitializeComponent();

            ExportIdTextbox.Text = _Results.ExportId.ToString();
            InvoiceCountTextbox.Text = _Results.InvoiceCount.ToString();
            TotalAmountTextbox.Text = _Results.TotalAmount.ToString("c");
            Dictionary<string, double>.Enumerator AccountEnumerator = _Results.GetAccountDetailsEnumerator();

            while (AccountEnumerator.MoveNext())
            {
                KeyValuePair<string, double> pair = AccountEnumerator.Current;
                ListViewItem NewItem = new ListViewItem(pair.Key);
                NewItem.SubItems.Add(pair.Value.ToString("c"));
                AccountBreakdownListview.Items.Add(NewItem);
            }

            foreach (ColumnHeader Hdr in AccountBreakdownListview.Columns)
                Hdr.Width = -2;
            AccountBreakdownListview.ResumeLayout();

            OpenFileLink.Tag = _FileName;
            FileContentsTextbox.Text = _FileContents;
            CsvFileNameTextbox.Text = _FileName;
        }

        private void CloseButton_Click(object sender, System.EventArgs e)
        {
            Close();
        }

        private void OpenFileLink_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            try
            {
                Process.Start(OpenFileLink.Tag as string);
            }
            catch (Exception)
            {
                MessageHelper.ShowError("Sorry, but you don't seem to have an application installed that handles CSV files.");
            }
        }

        private void AccountBreakdownListview_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (AccountBreakdownListview.Items.Count > 0)
            {
                AccountBreakdownListview.ListViewItemSorter = _AccountBreakdownCompareFactory.CreateComparerForColumn(e.Column);
                AccountBreakdownListview.Sort();
            }
        }
    }
}