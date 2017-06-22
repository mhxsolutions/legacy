using System.Collections;
using System.ComponentModel;
using System.Configuration.Install;
using System.IO;
using System.Text.RegularExpressions;
using System.Xml;

namespace Services_Setup_Utils
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

        private void UpdateRfsConfig(string FileName, string DataFilesFolder)
        {
            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);

            foreach (XmlNode Node in Document["configuration"]["log4net"])
            {
                if (Node.Name == "appender")
                {
                    if (Node.Attributes["type"].Value.CompareTo("log4net.Appender.RollingFileAppender") == 0)
                    {
                        for (int i = 0; i < Node.ChildNodes.Count; i++)
                        {
                            if (Node.ChildNodes[i].Name == "file")
                                Node.ChildNodes[i].Attributes["value"].Value =
                                    Path.Combine(DataFilesFolder, Node.ChildNodes[i].Attributes["value"].Value);
                        }
                    }
                }
            }

            Document.Save(FileName);
        }

        private void UpdateConfigFile(string FileName, string Db1, string SignaturesFolder, string DataFilesFolder)
        {
            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);

            foreach (XmlNode Node in Document["configuration"]["appSettings"])
            {
                if (Node.Name == "add")
                {
                    if (Node.Attributes["key"].Value == "Db1Connection")
                        Node.Attributes["value"].Value = ReplaceServerNameInConnectionString(Node.Attributes["value"].Value, Db1);
                    else if (Node.Attributes["key"].Value == "AgilisDataFolder")
                        Node.Attributes["value"].Value = DataFilesFolder;
                    else if (Node.Attributes["key"].Value == "AgilisSignaturesFolder")
                        Node.Attributes["value"].Value = SignaturesFolder;
                }
            }

            // Removed when the NHibernate configuration stuff was moved to separate files.

            //foreach (XmlNode Node in Document["configuration"]["nhibernate"])
            //{
            //    if (Node.Name == "add")
            //    {
            //        if (Node.Attributes["key"].Value == "hibernate.connection.connection_string")
            //            Node.Attributes["value"].Value = ReplaceServerNameInConnectionString(Node.Attributes["value"].Value, Db1);
            //    }
            //}

            foreach (XmlNode Node in Document["configuration"]["log4net"])
            {
                if (Node.Name == "appender")
                {
                    if (Node.Attributes["type"].Value.CompareTo("log4net.Appender.RollingFileAppender") == 0)
                    {
                        for (int i = 0; i < Node.ChildNodes.Count; i++)
                        {
                            if (Node.ChildNodes[i].Name == "file")
                                Node.ChildNodes[i].Attributes["value"].Value = Path.Combine(DataFilesFolder, Node.ChildNodes[i].Attributes["value"].Value);
                        }
                    }
                }
            }

            Document.Save(FileName);
        }

        public override void Install(IDictionary stateSaver)
        {
            base.Install(stateSaver);

            string Home = Context.Parameters["HOME"];
            string Db1 = Context.Parameters["DB1"];
            string SignaturesFolder = Context.Parameters["SIGNATURES"];
            string DataFilesFolder = Context.Parameters["DATAFILES"];

            /*
            string Dummy = Context.Parameters["DUMMY"];

            StreamWriter w = new StreamWriter("C:\\tmp.txt", false);
            w.WriteLine(Home ?? "null HOME");
            w.WriteLine(Db1 ?? "null Db1");
            w.WriteLine(SignaturesFolder ?? "null SignaturesFolder");
            w.WriteLine(DataFilesFolder ?? "null DataFilesFolder");
            w.WriteLine(Dummy ?? "null Dummy");
            w.Close();
            */
 
            UpdateConfigFile(Path.Combine(Home, "Agilis Integration Service.exe.config"), Db1, SignaturesFolder, Path.Combine(DataFilesFolder, "Agilis"));
            UpdateRfsConfig(Path.Combine(Home, "Bops RFS Operations.exe.config"), Path.Combine(DataFilesFolder, "RFS Operations"));
        }
    }
}