using System.Windows.Forms;

namespace BopsDataConnector
{
    public partial class DebugOverrideForm : Form
    {
        private string _SqlServerName;
        private bool _UseForAllDatabases;

        public string SqlServerName
        {
            get { return _SqlServerName; }
            set { _SqlServerName = value; }
        }

        public bool UseForAllDatabases
        {
            get { return _UseForAllDatabases; }
            set { _UseForAllDatabases = value; }
        }

        public DebugOverrideForm(string _DatabaseName, string _SqlServerName)
        {
            _UseForAllDatabases = true; // Assume that the user's override will apply to all databases.
            this._SqlServerName = _SqlServerName;
            InitializeComponent();

            DatabaseNameTextbox.Text = _DatabaseName;
            SqlServerNameTextbox.DataBindings.Add("Text", this, "SqlServerName");
            UseForAllDatabasesCheckbox.DataBindings.Add("Checked", this, "UseForAllDatabases");
        }

        private void OkButton_Click(object sender, System.EventArgs e)
        {
            Close();
        }
    }
}