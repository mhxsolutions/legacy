using System;
using System.Linq;
using System.Windows.Forms;

namespace RFS_Calculator
{
    public partial class PromptRfsNumberForm : Form
    {
        public int? RfsNumber { get; set; }
        public int[] ValidRfsNumbers { get; set; }

        public PromptRfsNumberForm()
        {
            InitializeComponent();
        }

        private void PromptRfsNumberForm_Load(object sender, EventArgs e)
        {
            foreach (var number in ValidRfsNumbers)
            {
                RfsCombobox.Items.Add(number);
            }
        }

        private void OkButton_Click(object sender, EventArgs e)
        {
            int rfsValue;

            if (int.TryParse(RfsCombobox.Text, out rfsValue))
            {
                if (rfsValue < 0)
                {
                    MessageBox.Show("RFS number must be greater than zero.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                var isValidRfs = ValidRfsNumbers.Any(number => number == rfsValue);

                if (!isValidRfs)
                {
                    MessageBox.Show("Not a valid RFS number.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                RfsNumber = rfsValue;
                DialogResult = DialogResult.OK;
            }
            else
            {
                RfsNumber = null;
            }
        }
    }
}