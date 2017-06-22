using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;

namespace RFS_Invoice_Utility
{
    public partial class ChooseLoginForm : Form
    {
        public List<CompanyDetails> LoginOptions { get; set; }
        public CompanyDetails FinalChoice { get; set; }

        public ChooseLoginForm()
        {
            InitializeComponent();
        }

        private void ChooseLoginForm_Load(object sender, EventArgs e)
        {
            Debug.Assert(LoginOptions.Count > 1);

            foreach (var option in LoginOptions)
            {
                var index = loginListbox.Items.Add(option);
                if (FinalChoice != null && FinalChoice.Company.CompanyId == option.Company.CompanyId)
                    loginListbox.SelectedIndex = index;
            }

            // Make sure something is selected, the first item if nothing else.

            if (loginListbox.SelectedIndex == -1)
                loginListbox.SelectedIndex = 0;
        }

        private void okButton_Click(object sender, EventArgs e)
        {
            FinalChoice = loginListbox.SelectedItem as CompanyDetails;
            Debug.Assert(FinalChoice != null);
            DialogResult = DialogResult.OK;
        }

        private void loginListbox_DoubleClick(object sender, EventArgs e)
        {
            okButton_Click(sender, e);
        }
    }
}
