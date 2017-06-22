using System;
using System.Diagnostics;
using System.Windows.Forms;

namespace BopsUtilities
{
    /// <summary>
    /// Selects rows in a ListView on the basis of text supplied by the user, optionally limiting
    /// the search to a single column.
    /// </summary>
    public partial class ListViewSelectTextByColumnForm : Form
    {
        private readonly ListView _ListViewControl;
        private string _SearchText;
        private int _MatchCount;

        /// <summary>
        /// The last text specified by the user, set when the OK button is pressed.
        /// </summary>
        public string SearchText
        {
            get { return _SearchText; }
        }

        /// <summary>
        /// 
        /// </summary>
        public int MatchCount
        {
            get { return _MatchCount; }
        }

        /// <summary>
        /// Default constructor for the form.
        /// </summary>
        /// <param name="ListViewControl">The ListView control to be searched.</param>
        public ListViewSelectTextByColumnForm(ListView ListViewControl) : this(ListViewControl, string.Empty)
        {
        }

        /// <summary>
        /// Constructs the form with an initial text string in the find field.
        /// </summary>
        /// <param name="ListViewControl">The ListView control to be searched.</param>
        /// <param name="SearchText">The initial text string to set into the find field.</param>
        public ListViewSelectTextByColumnForm(ListView ListViewControl, string SearchText)
        {
            if (ListViewControl == null)
                throw new ArgumentNullException("ListViewControl");

            _ListViewControl = ListViewControl;
            _MatchCount = 0;
            _SearchText = SearchText;

            InitializeComponent();

            Populate();
            _FindTextbox.Text = _SearchText;
        }

        private void Populate()
        {
            _ColumnCombobox.SuspendLayout();
            _ColumnCombobox.Items.Clear();
            _ColumnCombobox.Items.Add(new FormatEnabledKeyValuePair<int, string>(-1, "(all)", 
                FormatEnabledKeyValuePair<int, string>.FormatType.ValueOnly));
            _ColumnCombobox.SelectedIndex = 0;

            foreach (ColumnHeader Column in _ListViewControl.Columns)
            {
                _ColumnCombobox.Items.Add(new FormatEnabledKeyValuePair<int, string>(Column.Index, Column.Text, 
                    FormatEnabledKeyValuePair<int, string>.FormatType.ValueOnly));
            }

            _ColumnCombobox.ResumeLayout();
        }

        private void _OkButton_Click(object Sender, EventArgs E)
        {
            if (string.IsNullOrEmpty(_FindTextbox.Text))
            {
                MessageHelper.ShowInvalidOperation("You must provide text for which to search.");
                return;
            }

            if (_ColumnCombobox.SelectedItem == null)
            {
                MessageHelper.ShowInvalidOperation("You must select a column to search.");
                return;
            }

            _SearchText = _FindTextbox.Text;
            FormatEnabledKeyValuePair<int, string> SearchColumn = _ColumnCombobox.SelectedItem as FormatEnabledKeyValuePair<int, string>;
            Debug.Assert(SearchColumn != null);

            int BeginColumn, EndColumn;
            if (SearchColumn.Key == -1)
            {
                BeginColumn = 0;
                EndColumn = _ListViewControl.Columns.Count;
            }
            else
            {
                BeginColumn = SearchColumn.Key;
                EndColumn = BeginColumn + 1;
            }

            foreach (ListViewItem Item in _ListViewControl.Items)
            {
                bool Match = false;

                for (int Col = BeginColumn; (Col < EndColumn) && !Match; Col++)
                {
                    string SearchString = Item.SubItems[Col].Text;

                    int Index = SearchString.IndexOf(_SearchText, _MatchCaseCheckbox.Checked ? StringComparison.CurrentCulture : StringComparison.CurrentCultureIgnoreCase);
                    if (Index > -1)
                        Match = true;
                }

                if (Match)
                {
                    Item.Selected = true;
                    _MatchCount++;
                }
                else if (_ReplaceSelectionRadiobutton.Checked)
                {
                    Item.Selected = false;
                }
            }

            DialogResult = DialogResult.OK;
            Close();
        }
    }
}
