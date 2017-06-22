using System;
using System.Collections.Generic;
using System.Windows.Forms;
using BopsDataAccess;

namespace RFS_Invoice_Utility
{
    public partial class InvoiceDuplicatesForm : Form
    {
        private List<BopsRfsInvoiceDetail> _InvoiceDetails;

        public List<BopsRfsInvoiceDetail> InvoiceDetails
        {
            get { return _InvoiceDetails; }
            set { _InvoiceDetails = value; }
        }

        public InvoiceDuplicatesForm()
        {
            InitializeComponent();
        }

        private void PopulateDetailsListview()
        {
            // Columns
            //
            //  0   Invoice ID
            //  1   Line
            //  2   Date
            //  3   Amount
            //  4   Description

            InvoiceDetailsListview.SuspendLayout();
            foreach (BopsRfsInvoiceDetail detail in _InvoiceDetails)
            {
                ListViewItem NewItem = new ListViewItem(detail.InvoiceRef.ToString());
                NewItem.SubItems.Add(detail.LineNumber.ToString());
                NewItem.SubItems.Add(detail.ItemDate.ToString("d"));
                NewItem.SubItems.Add(string.Format("{0:c}", detail.ItemTotal));
                NewItem.SubItems.Add(detail.ItemDescription);
                InvoiceDetailsListview.Items.Add(NewItem);
            }
            foreach (ColumnHeader Hdr in InvoiceDetailsListview.Columns)
                Hdr.Width = -2;
            InvoiceDetailsListview.ResumeLayout();
        }

        private void InvoiceDuplicatesForm_Load(object sender, EventArgs e)
        {
            PopulateDetailsListview();
        }
    }
}
