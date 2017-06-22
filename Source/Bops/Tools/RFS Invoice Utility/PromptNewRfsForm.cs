using System;
using System.Windows.Forms;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class PromptNewRfsForm : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(PromptNewRfsForm));

        public int NewRfs { get; set; }

        public PromptNewRfsForm(string itemDescription)
        {
            NewRfs = -1;

            InitializeComponent();

            _DirectionsLabel.Text = string.Format("To change the RFS for {0}, choose the new RFS in the dropdown and click the OK button.", itemDescription);
        }

        private void PromptNewRfsForm_Load(object sender, System.EventArgs e)
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                // TODO: Update this to use user company detail if appropriate.

                var rfsList = rfsDataContext.GetRfs(0, 0, 0);
                foreach (var rfs in rfsList)
                {
                    _RfsCombobox.Items.Add(rfs.RfsId);
                }

                if (_RfsCombobox.Items.Count > 0)
                    _RfsCombobox.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                Log.Error("An error occurred loading RFS data.", ex);
            }
            finally
            {
                // TODO: free the RFS data context
            }
        }

        private void _OkButton_Click(object sender, EventArgs e)
        {
            if (_RfsCombobox.SelectedItem == null)
            {
                MessageHelper.ShowInvalidOperation("You must select an RFS.");
                return;
            }

            var newRfs = 0;
            var newRfsString = _RfsCombobox.SelectedItem.ToString();
            if (!int.TryParse(newRfsString, out newRfs)) return;
            NewRfs = newRfs;
            DialogResult = DialogResult.OK;
            Close();
        }
    }
}