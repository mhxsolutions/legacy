using System.Collections.Generic;
using System.Windows.Forms;

namespace RFS_Invoice_Utility
{
    public partial class GroupPromptForm : Form
    {
        private string _GroupName;

        public string GroupName
        {
            get { return _GroupName; }
            set { _GroupName = value; }
        }

        public GroupPromptForm(IEnumerable<string> ExistingGroupNames, string StartingGroupName)
        {
            InitializeComponent();

            if (ExistingGroupNames != null)
                foreach (string s in ExistingGroupNames)
                    GroupNameCombobox.Items.Add(s);

            if (StartingGroupName != null)
                GroupNameCombobox.Text = StartingGroupName;

            DataBindings.Add("GroupName", GroupNameCombobox, "Text");
        }

        private void OkButton_Click(object sender, System.EventArgs e)
        {
            DialogResult = System.Windows.Forms.DialogResult.OK;
        }

        // This handler is necessary because the combo box doesn't properly trigger the values
        // set for the form's accept/cancel button properties.

        private void GroupNameCombobox_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                OkButton_Click(sender, null);
            else if (e.KeyCode == Keys.Escape)
                DialogResult = System.Windows.Forms.DialogResult.Cancel;
        }
    }
}
