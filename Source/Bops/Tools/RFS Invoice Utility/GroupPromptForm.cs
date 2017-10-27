using System.Collections.Generic;
using System.Windows.Forms;

namespace RFS_Invoice_Utility
{
    public partial class GroupPromptForm : Form
    {
        private const int MaxGroupNameLength = 200;

        public string GroupName { get; set; }

        public GroupPromptForm(IEnumerable<string> existingGroupNames, string startingGroupName)
        {
            InitializeComponent();

            if (existingGroupNames != null)
                foreach (string s in existingGroupNames)
                    GroupNameCombobox.Items.Add(s);

            if (startingGroupName != null)
                GroupNameCombobox.Text = startingGroupName;

            DataBindings.Add("GroupName", GroupNameCombobox, "Text");
        }

        private void OkButton_Click(object sender, System.EventArgs e)
        {
            if (GroupName.Length > MaxGroupNameLength)
                MessageBox.Show("Name cannot be longer than 200 characters.", "Invalid Data", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
                DialogResult = DialogResult.OK;
        }

        // This handler is necessary because the combo box doesn't properly trigger the values
        // set for the form's accept/cancel button properties.

        private void GroupNameCombobox_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                OkButton_Click(sender, null);
            else if (e.KeyCode == Keys.Escape)
                DialogResult = DialogResult.Cancel;
        }
    }
}
