using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;

namespace BopsUtilities
{
    public partial class ListViewSelectByColumnForm : Form
    {
        private readonly ListView _ListViewControl;
        private readonly int _ColumnIndex;
        private readonly StringRepresentationComparer _Comparer;

        public ListViewSelectByColumnForm(ListView ListViewControl, int ColumnIndex, StringRepresentationComparer Comparer)
        {
            _ListViewControl = ListViewControl;
            _ColumnIndex = ColumnIndex;
            _Comparer = Comparer;

            InitializeComponent();

            if (ListViewControl == null)
                throw new ArgumentNullException("ListViewControl");
            if (ColumnIndex < 0 || ListViewControl.Columns.Count <= ColumnIndex)
                throw new ArgumentOutOfRangeException("ColumnIndex", "The column index is out of range.");

            if (!string.IsNullOrEmpty(_ListViewControl.Columns[_ColumnIndex].Text))
                Text = string.Format("Select By {0}", _ListViewControl.Columns[_ColumnIndex].Text);
        }

        public override sealed string Text
        {
            get { return base.Text; }
            set { base.Text = value; }
        }

        private void Populate()
        {
            string ToSelect = null;
            if (_ListViewControl.SelectedItems.Count > 0)
                ToSelect = _ListViewControl.SelectedItems[0].SubItems[_ColumnIndex].Text;

            Dictionary<string, string> Items = new Dictionary<string, string>();

            for (int I = 0; I < _ListViewControl.Items.Count; I++)
            {
                ListViewItem.ListViewSubItem Subitem = _ListViewControl.Items[I].SubItems[_ColumnIndex];
                if (!Items.ContainsKey(Subitem.Text))
                    Items.Add(Subitem.Text, string.Empty);
            }

            foreach (string Key in Items.Keys)
            {
                _SelectCombobox.Items.Add(Key);
            }

            ArrayList SortList = ArrayList.Adapter(_SelectCombobox.Items);
            SortList.Sort(_Comparer);

            int IndexToSelect = _SelectCombobox.FindStringExact(ToSelect);
            if (IndexToSelect > -1)
                _SelectCombobox.SelectedIndex = IndexToSelect;
            
        }

        private void ListViewSelectByColumn_Load(object Sender, EventArgs E)
        {
            Populate();
        }

        private void _OkButton_Click(object Sender, EventArgs E)
        {
            _ListViewControl.SuspendLayout();

            if (_ReplaceSelectionRadiobutton.Checked)
                _ListViewControl.SelectedItems.Clear();

            for (int I = 0; I < _ListViewControl.Items.Count; I++)
            {
                ListViewItem CurrentItem = _ListViewControl.Items[I];
                ListViewItem.ListViewSubItem Subitem = CurrentItem.SubItems[_ColumnIndex];
                if (Subitem.Text == _SelectCombobox.Text)
                    CurrentItem.Selected = true;
            }

            _ListViewControl.ResumeLayout();
            DialogResult = DialogResult.OK;
        }
    }
}