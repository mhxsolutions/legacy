
using System.Collections;
using System.ComponentModel;
using System.Configuration.Install;
using System.Text.RegularExpressions;
using System.Xml;

namespace Web_Setup_Utils
{
    [RunInstaller(true)]
    public partial class Configurators : Installer
    {
        public Configurators()
        {
            InitializeComponent();
        }

        private string ReplaceServerNameInConnectionString(string ConnectionString, string NewServerName)
        {
            string NewServerSubstring = string.Format("Data Source={0}", NewServerName);
            Regex RxServer = new Regex("Data Source=([^;]+)");
            string NewValue = RxServer.Replace(ConnectionString, NewServerSubstring);
            return NewValue;
        }

        private void UpdateConfigFile(string FileName, string Db1)
        {
            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);

            foreach (XmlNode Node in Document["configuration"]["appSettings"])
            {
                if (Node.Name == "add")
                {
                    if (Node.Attributes["key"].Value == "Db1Connection")
                        Node.Attributes["value"].Value = ReplaceServerNameInConnectionString(Node.Attributes["value"].Value, Db1);
                }
            }

            foreach (XmlNode Node in Document["configuration"]["nhibernate"])
            {
                if (Node.Name == "add")
                {
                    if (Node.Attributes["key"].Value == "hibernate.connection.connection_string")
                        Node.Attributes["value"].Value = ReplaceServerNameInConnectionString(Node.Attributes["value"].Value, Db1);
                }
            }

            Document.Save(FileName);
        }

        public override void Install(IDictionary stateSaver)
        {
            base.Install(stateSaver);

            string Home = Context.Parameters["HOME"];
            string Db1 = Context.Parameters["DB1"];
            UpdateConfigFile(Home + "Web.config", Db1);
        }
    }
}