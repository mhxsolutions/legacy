using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace AgilisQueryTool
{
    public partial class AgilisQueryTool : Form
    {
        #region Structures
        
        enum PickerType
        {
            None,
            DateTime
        }
        
        struct ParamDetails
        {
            private string _DisplayName;
            private string _UrlName;
            private bool _Required;
            PickerType _PickerType;

            public ParamDetails(string DisplayName, string UrlName, bool Required, PickerType Picker)
            {
                _DisplayName = DisplayName;
                _UrlName = UrlName;
                _Required = Required;
                _PickerType = Picker;
            }

            public string DisplayName
            {
                get { return _DisplayName; }
            }

            public string UrlName
            {
                get { return _UrlName; }
            }
            
            public bool IsUsed
            {
                get { return _DisplayName != null && _DisplayName != ""; }
            }

            public bool IsRequired
            {
                get { return _Required; }
            }

            public PickerType Picker
            {
                get { return _PickerType; }
            }
        }

        struct MethodDetails
        {
            public const int MaxParams = 3;

            private string _MethodUrl;
            private ParamDetails[] _Params;

            public MethodDetails(string MethodUrl, ParamDetails[] Params)
            {
                _MethodUrl = MethodUrl;
                _Params = Params;
            }

            public string MethodUrl
            {
                get { return _MethodUrl; }
            }

            public ParamDetails[] Params
            {
                get { return _Params; }
            }
        }

        #endregion

        #region Constants
        
        private const string _BaseProdUrl = "http://ibis.agilissystems.com/ibis/rest/8231/";
        private const string _BaseDemoUrl = "http://demo.agilissystems.com/ibis/rest/1086/";
        Color _RequiredColor = Color.Yellow;
        Color _OptionalColor = Color.White;

        #endregion

        #region Fields

        private IDictionary<string, MethodDetails> _Methods = new Dictionary<string, MethodDetails>();
        private Control[] _ParamControls;
        private Control[] _ParamLabelControls;
        private Control[] _PickerControls;

        #endregion

        #region Constructors
        
        public AgilisQueryTool()
        {
            InitializeComponent();
            ConfigureMethods();

            _ParamControls = new Control[MethodDetails.MaxParams];
            _ParamLabelControls = new Control[MethodDetails.MaxParams];
            _PickerControls = new Control[MethodDetails.MaxParams];

            for (int i = 0; i < MethodDetails.MaxParams; i++)
            {
                _ParamControls[i] = Controls[string.Format("Param{0}", i + 1)];
                _ParamLabelControls[i] = Controls[string.Format("Param{0}Label", i + 1)];
                _PickerControls[i] = Controls[string.Format("Picker{0}", i + 1)];
            }
        }

        #endregion

        #region Helper Methods
        
        private void ConfigureMethods()
        {
            ParamDetails[] Params = new ParamDetails[MethodDetails.MaxParams];
            
            Params[0] = new ParamDetails("Start Time", "start_time", true, PickerType.DateTime);
            Params[1] = new ParamDetails("End Time", "end_time", true, PickerType.DateTime);
            Params[2] = new ParamDetails("Device Number", "device_nbr", false, PickerType.None);
            _Methods.Add("Get Device Events", new MethodDetails("devices/events", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails("Start Time", "start_time", true, PickerType.DateTime);
            Params[1] = new ParamDetails("End Time", "end_time", true, PickerType.DateTime);
            Params[2] = new ParamDetails("Driver Number", "driver_nbr", false, PickerType.None);
            _Methods.Add("Get Driver Events", new MethodDetails("drivers/events", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails("Start Time", "start_time", true, PickerType.DateTime);
            Params[1] = new ParamDetails("End Time", "end_time", true, PickerType.DateTime);
            Params[2] = new ParamDetails("Driver Number", "driver_nbr", false, PickerType.None);
            _Methods.Add("Get Driver Positions", new MethodDetails("drivers/positions", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails();
            Params[1] = new ParamDetails();
            Params[2] = new ParamDetails();
            _Methods.Add("Get Drivers", new MethodDetails("drivers/list", Params));
            _Methods.Add("Get Vehicles", new MethodDetails("vehicles/list", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails("Start Time", "start_time", true, PickerType.DateTime);
            Params[1] = new ParamDetails("End Time", "end_time", true, PickerType.DateTime);
            _Methods.Add("Get Work Orders", new MethodDetails("workOrders/list", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails("Start Time", "start_time", true, PickerType.DateTime);
            Params[1] = new ParamDetails("End Time", "end_time", true, PickerType.DateTime);
            _Methods.Add("Get Work Orders by Slot Start Date", new MethodDetails("workOrders/listBySlotStartDate", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails("Start Time", "start_time", true, PickerType.DateTime);
            Params[1] = new ParamDetails("End Time", "end_time", true, PickerType.DateTime);
            _Methods.Add("Get Work Orders by Edit Date", new MethodDetails("workOrders/listByEditDate", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails("Work Order", "wo_number", true, PickerType.None);
            Params[1] = new ParamDetails("Image Format", "image_format", true, PickerType.None);
            _Methods.Add("Get Work Order Signature", new MethodDetails("smartForms/listByWorkOrder", Params));

            Params = new ParamDetails[MethodDetails.MaxParams];
            Params[0] = new ParamDetails("Start Time", "start_time", true, PickerType.DateTime);
            Params[1] = new ParamDetails("End Time", "end_time", true, PickerType.DateTime);
            Params[2] = new ParamDetails("Image Format", "image_format", true, PickerType.None);
            _Methods.Add("Get Signatures By Date Range", new MethodDetails("smartForms/listByDateRange", Params));

            foreach (KeyValuePair<string, MethodDetails> pair in _Methods)
                MethodName.Items.Add(pair.Key);
        }

        private string MakeUrl(out string ErrorMessage)
        {
            ErrorMessage = "";
            
            if (MethodName.Text != null && _Methods.ContainsKey(MethodName.Text))
            {
                if (UserName.Text == "" || Password.Text == "")
                {
                    ErrorMessage = "Error: User name and password are required.";
                    return null;
                }

                MethodDetails Method = _Methods[MethodName.Text];
                StringBuilder sb = new StringBuilder(UseDemoSite.Checked ? _BaseDemoUrl : _BaseProdUrl);
                sb.Append(Method.MethodUrl);
                sb.AppendFormat("?user_name={0}&password={1}", UserName.Text, Password.Text);

                for (int i = 0; i < MethodDetails.MaxParams; i++)
                {
                    if (Method.Params[i].IsUsed)
                    {
                        if (Method.Params[i].IsRequired && _ParamControls[i].Text == "")
                        {
                            ErrorMessage = string.Format("Error: The {0} parameter is required.", Method.Params[i].DisplayName);
                            return null;
                        }
                        else if (Method.Params[i].IsRequired || _ParamControls[i].Text != "")
                            sb.AppendFormat("&{0}={1}", Method.Params[i].UrlName, _ParamControls[i].Text);
                    }
                }
                
                return sb.ToString();
            }
            else
            {
                ErrorMessage = "Error: Not a valid API method.";
            }
            
            return null;
        }

        private string PickTime()
        {
            TimePickerForm Tpf = new TimePickerForm();
            DialogResult ReturnValue = Tpf.ShowDialog();
            if (ReturnValue == DialogResult.OK)
                return Tpf.TimePicked.ToString("yyyy-MM-ddTHH:mm:ss");
            else
                return "";
        }

        #endregion

        #region Event Handlers

        private void AgilisApiTesterForm_Load(object sender, System.EventArgs e)
        {
            MethodName.SelectedIndex = 0;   // Select the first item in the list.
            UserName.BackColor = _RequiredColor;
            Password.BackColor = _RequiredColor;
        }

        private void CopyUrl_Click(object sender, System.EventArgs e)
        {
            string ErrorMessage;
            string Url = MakeUrl(out ErrorMessage);
            
            if (Url != null)
                Clipboard.SetDataObject(Url);
            else
                MessageBox.Show(ErrorMessage, "Error");
        }

        private void LaunchUrl_Click(object sender, System.EventArgs e)
        {
            string ErrorMessage;
            string Url = MakeUrl(out ErrorMessage);

            if (Url != null)
                Process.Start(Url);
            else
                MessageBox.Show(ErrorMessage, "Error");
        }

        private void MethodName_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            string MethodToFind = MethodName.SelectedItem.ToString();
            ParamDetails[] Params = new ParamDetails[MethodDetails.MaxParams];

            if (_Methods.ContainsKey(MethodToFind))
            {
                MethodDetails Method = _Methods[MethodToFind];
                Params = Method.Params;
            }
            
            for (int i = 0; i < MethodDetails.MaxParams; i++)
            {
                if (Params[i].IsUsed)
                {
                    _ParamLabelControls[i].Text = string.Format("{0}:", Params[i].DisplayName);
                    _ParamLabelControls[i].Visible = true;
                    _ParamControls[i].Visible = true;
                    _ParamControls[i].BackColor = Params[i].IsRequired ? _RequiredColor : _OptionalColor;
                    _PickerControls[i].Visible = (Params[i].Picker != PickerType.None);
                        
                }
                else
                {
                    _ParamLabelControls[i].Visible = false;
                    _ParamControls[i].Visible = false;
                    _PickerControls[i].Visible = false;
                }
            }
        }

        private void Picker1_Click(object sender, System.EventArgs e)
        {
            string NewDateTime = PickTime();
            if (NewDateTime != "")
                Param1.Text = NewDateTime;
        }

        private void Picker2_Click(object sender, System.EventArgs e)
        {
            string NewDateTime = PickTime();
            if (NewDateTime != "")
                Param2.Text = NewDateTime;
        }

        private void Picker3_Click(object sender, System.EventArgs e)
        {
            string NewDateTime = PickTime();
            if (NewDateTime != "")
                Param3.Text = NewDateTime;
        }

        #endregion
    }
}