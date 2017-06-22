using System.Windows.Forms;

namespace BopsUtilities
{
    public partial class ProgressForm : Form
    {
        private bool _Abort;

        public bool Abort
        {
            get { return _Abort; }
        }

        public string TopLevelText
        {
            get { return TopLevelDescription.Text; }
            set { TopLevelDescription.Text = value; }
        }

        public string WorkText
        {
            get { return ItemDescription.Text; }
            set { ItemDescription.Text = value; }
        }

        public ProgressBar Progress
        {
            get { return WorkProgressbar; }
        }

        public ProgressForm()
        {
            InitializeComponent();
        }

        public void ClearAbort()
        {
            if (_Abort)
            {
                _Abort = false;
                AbortButton.Enabled = true;
            }
        }

        private void AbortButton_Click(object Sender, System.EventArgs E)
        {
            AbortButton.Enabled = false;
            _Abort = true;
        }
    }
}
