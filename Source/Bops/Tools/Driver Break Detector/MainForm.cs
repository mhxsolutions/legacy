using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Windows.Forms;

namespace Driver_Break_Detector
{
    public partial class MainForm : Form, IStatusDisplay
    {
        #region Helper Classes

        #endregion

        readonly DriverDetails[] _Drivers = new DriverDetails[] 
        {
            new DriverDetails(2143815095, "Robbie", "Bell"),
            new DriverDetails(2143815145, "Steve", "Eckstein"),
            new DriverDetails(2143815093, "Brian", "Hess"),
            new DriverDetails(2143815197, "Kirk", "LaShelle"),
            new DriverDetails(2143815113, "Angel", "Moncada"),
            new DriverDetails(2143815081, "David", "Shelton"),
            new DriverDetails(2143815104, "Mike", "Tapia"),
            new DriverDetails(2143815043, "Richard", "Valadez"),
            //new DriverDetails(2143815203, "Eddie", "Vindiola"),   // REMOVED BECAUSE HE LEFT THE LAWSUIT
        };

        public string StatusBarText
        {
            set
            {
                _StatusStrip1.Items["toolStripStatusLabel1"].Text = string.IsNullOrEmpty(value) ? string.Empty : value;
                _StatusStrip1.Update();
            }
        }

        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object Sender, EventArgs E)
        {
            StatusBarText = null;

            //_BeginDatepicker.Value = new DateTime(2009, 1, 5);
            //_EndDatepicker.Value = _BeginDatepicker.Value.AddDays(1);

            _BeginDatepicker.Value = new DateTime(2007, 1, 17);     // The first date for which we have Agilis position data.
            _EndDatepicker.Value = DateTime.Now.Date.AddDays(1);

            //_BeginDatepicker.Value = new DateTime(2009, 1, 1);
            //_EndDatepicker.Value = _BeginDatepicker.Value.AddMonths(1);

            foreach (DriverDetails Driver in _Drivers)
            {
                _DriversCheckedlistbox.Items.Add(Driver, true);
            }

            _OutputModeCombobox.SelectedIndex = 0;

            //_OutputFileTextbox.Text = string.Format("Break Analysis {0:yyyy-MM-dd HH-mm-ss}.txt", DateTime.Now);

            _OutputFileTextbox.Text = @"output";
        }

        private void _AllButton_Click(object Sender, EventArgs E)
        {
            for (int Index = 0; Index < _DriversCheckedlistbox.Items.Count; Index++)
            {
                _DriversCheckedlistbox.SetItemChecked(Index, true);
            }
        }

        private void _NoneButton_Click(object Sender, EventArgs E)
        {
            for (int Index = 0; Index < _DriversCheckedlistbox.Items.Count; Index++)
            {
                _DriversCheckedlistbox.SetItemChecked(Index, false);
            }
        }

        private static string GetOutputFolderName()
        {
            FolderBrowserDialog BrowserDialog = new FolderBrowserDialog();
            BrowserDialog.Description = @"Select output folder:";

            //if (_OutputDocumentsFolder.Text.Length > 0 && Directory.Exists(_OutputDocumentsFolder.Text))
            //    BrowserDialog.SelectedPath = _OutputDocumentsFolder.Text;

            if (BrowserDialog.ShowDialog() == DialogResult.OK)
            {
                return BrowserDialog.SelectedPath;
                //Directory.SetCurrentDirectory(BrowserDialog.SelectedPath);
            }

            return null;
        }

/*
        private string GetSaveFileName()
        {
            SaveFileDialog SaveDialog = new SaveFileDialog();
            SaveDialog.DefaultExt = "csv";
            SaveDialog.Filter = "TXT files (*.txt)|*.txt|All files (*.*)|*.*";
            SaveDialog.FileName = string.Format("Break Analysis {0:yyyy-MM-dd HH-mm-ss}.txt", DateTime.Now);
            return SaveDialog.ShowDialog() == DialogResult.OK ? SaveDialog.FileName : null;
        }
*/

        private void _OutputFileButton_Click(object Sender, EventArgs E)
        {
            //string SaveFileName = GetSaveFileName();
            //if (SaveFileName != null)
            //    _OutputFileTextbox.Text = SaveFileName;

            string SaveFolder = GetOutputFolderName();
            if (SaveFolder != null)
                _OutputFileTextbox.Text = SaveFolder;
        }

        private void _DetectButton_Click(object Sender, EventArgs E)
        {
            if (_BeginDatepicker.Value >= _EndDatepicker.Value)
            {
                MessageBox.Show(@"End date must be greater than begin date.", @"Invalid Operation", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (_DriversCheckedlistbox.CheckedItems.Count < 1)
            {
                MessageBox.Show(@"You must include at least one driver.", @"Invalid Operation", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (string.IsNullOrEmpty(_OutputFileTextbox.Text))
            {
                MessageBox.Show(@"You must provide an output file name.", @"Invalid Operation", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            DetectBreaks();
        }

        private void DetectBreaks()
        {
            Dictionary<int, DriverDetails> DriverMap = new Dictionary<int, DriverDetails>();
            int[] DriverIds = new int[_DriversCheckedlistbox.CheckedItems.Count];
            for (int Index = 0; Index < _DriversCheckedlistbox.CheckedItems.Count; Index++)
            {
                DriverDetails CheckedItem = _DriversCheckedlistbox.CheckedItems[Index] as DriverDetails;
                Debug.Assert(CheckedItem != null);
                DriverIds[Index] = CheckedItem.Id;
                DriverMap.Add(CheckedItem.Id, CheckedItem);
            }

            StatusBarText = "Loading plans...";
            DriverPlanCache Plans = new DriverPlanCache(_BeginDatepicker.Value, _EndDatepicker.Value, DriverIds);

            List<TargetLocation> CustomLocations = null;

            if (_MatchLocationsCheckbox.Checked)
            {
                StatusBarText = "Loading custom locations...";
                CustomLocations = TargetLocation.LoadFromXml(_LocationFileTextbox.Text);
            }

            Dictionary<int, DriverLocationCache> Locations = new Dictionary<int,DriverLocationCache>();
            for (int Index = 0; Index < DriverIds.Length; Index++)
            {
                StatusBarText = string.Format("Loading locations for driver {0} ({1} of {2})...", DriverMap[DriverIds[Index]].FullName,
                    Index + 1, DriverIds.Length);
                DriverLocationCache NewLocationCache = new DriverLocationCache(_BeginDatepicker.Value, _EndDatepicker.Value, DriverIds[Index]);
                Locations.Add(DriverIds[Index], NewLocationCache);
            }

            StatusBarText = "Detecting breaks...";
            DriverBreakDetector Detector = new DriverBreakDetector(DriverMap, Plans, Locations, this);
            Detector.DetectBreaks(CustomLocations);

            StatusBarText = "Generating output...";
            string OutputMode = _OutputModeCombobox.SelectedItem.ToString();
            IDriverBreakOutputGenerator OutputGenerator;
            switch (OutputMode)
            {
                case "CSV":
                    OutputGenerator = DriverBreakFactory.CreateOutputGenerator(OutputGeneratorType.CsvBreaksOnly, _BeginDatepicker.Value, _EndDatepicker.Value, DriverMap, Plans, Locations, Detector);
                    break;
                case "HTML":
                    OutputGenerator = DriverBreakFactory.CreateOutputGenerator(OutputGeneratorType.HtmlFullDetail, _BeginDatepicker.Value, _EndDatepicker.Value, DriverMap, Plans, Locations, Detector);
                    break;

                default:
                    throw new InvalidOperationException("Bad output mode combobox selection");
            }

            OutputGenerator.GenerateOutput(_OutputFileTextbox.Text, this);
            StatusBarText = null;
        }

        public string PrimaryTaskDescription
        {
            set { StatusBarText = value; }
        }

        public string SecondaryTaskDescription
        {
            set { }
        }

        public void ShowProgressBar(int InitialValue, int TotalItems)
        {
        }

        public void UpdateProgressBar(int NewValue)
        {
        }

        public void HideProgressBar()
        {
        }

        public void UpdateTasksAndProgressBar(string PrimaryTask, string SecondaryTask, int NewValue)
        {
            StatusBarText = PrimaryTask;
        }

        private void _MatchLocationsCheckbox_CheckedChanged(object Sender, EventArgs E)
        {
            label5.Enabled = _MatchLocationsCheckbox.Checked;
            _LocationFileTextbox.Enabled = _MatchLocationsCheckbox.Checked;
            _LocationFileButton.Enabled = _MatchLocationsCheckbox.Checked;
        }

        private void _LocationFileButton_Click(object sender, EventArgs e)
        {
            OpenFileDialog LocationFileOpenDialog = new OpenFileDialog();
            LocationFileOpenDialog.Title = "Specify Locations File Name";
            LocationFileOpenDialog.Filter = "XML Files (*.xml)|*.xml|All files (*.*)|*.*";
            LocationFileOpenDialog.DefaultExt = "xml";
            LocationFileOpenDialog.FilterIndex = 1;
            //PickRawFileDialog.FileName = "";
            LocationFileOpenDialog.InitialDirectory = Directory.GetCurrentDirectory();

            if (LocationFileOpenDialog.ShowDialog() == DialogResult.OK)
                _LocationFileTextbox.Text = LocationFileOpenDialog.FileName;
        }
    }
}
