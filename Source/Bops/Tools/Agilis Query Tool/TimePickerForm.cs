
using System;
using System.Windows.Forms;

namespace AgilisQueryTool
{
    public partial class TimePickerForm : Form
    {
        public DateTime TimePicked
        {
            get { return dateTimePicker1.Value; }
            set { dateTimePicker1.Value = value; }
        }
        
        public TimePickerForm()
        {
            InitializeComponent();
        }

        private void OK_Click(object sender, EventArgs e)
        {
            if (ConvertToGmt.Checked)
                dateTimePicker1.Value = dateTimePicker1.Value.ToUniversalTime();

            DialogResult = DialogResult.OK;
        }

        private void TimePickerForm_Load(object sender, EventArgs e)
        {
            dateTimePicker1.Value = DateTime.Now.Date;
        }
    }
}