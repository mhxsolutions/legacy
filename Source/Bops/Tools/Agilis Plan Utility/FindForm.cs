using System.Windows.Forms;

namespace Agilis_Plan_Utility
{
    public partial class FindForm : Form
    {
        private string _WorkOrderNumber;

        public string WorkOrderNumber
        {
            get { return _WorkOrderNumber; }
            set { _WorkOrderNumber = value; }
        }

        public FindForm()
        {
            InitializeComponent();
            DataBindings.Add("WorkOrderNumber", textBox1, "Text");
        }
    }
}