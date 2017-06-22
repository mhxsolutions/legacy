using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using log4net;
using NHibernate;
using NHibernate.Cfg;

namespace BopsDataConnector
{
    internal class BopsDataConnector : IBopsDataConnector
    {
        private const string _DefaultSqlServerName = @"SQL4";
        private static readonly ILog _Log = LogManager.GetLogger(typeof(BopsDataConnector));

        static readonly object _ThreadLock = new object();

        // TODO: Implement the IDispose interface so everything gets closed.

        private enum BopsDatabase
        {
            DwsNoRepData,
            DwsRepData
        }

        // Session factories, instantiated at need.

        private static readonly ISessionFactory[] _Factories = { null, null };
        private static readonly string[] _DatabaseNames = {"DWS No Rep Data", "DWS Rep Data"};
        private static readonly string[] _AssemblyNames = {"BopsDataAccess.dll", "AgilisCore.dll"};
        private static string _SqlServerName = _DefaultSqlServerName;

        private readonly ISession[] _Sessions = { null, null };

        public string SqlServerName
        {
            get { return _SqlServerName; }
        }

        // Mechnism for per-database SQL Server name overrides.

        static bool _DoNotPromptAgain;
        [Conditional("DEBUG")]
        private void ShowOverrideForm(string DatabaseName)
        {
            if (_DoNotPromptAgain) return;

            DebugOverrideForm NewForm = new DebugOverrideForm(DatabaseName, _SqlServerName);
            NewForm.ShowDialog();
            _SqlServerName = NewForm.SqlServerName;
            _DoNotPromptAgain = NewForm.UseForAllDatabases;
        }

        private static string CreateConnectionString(string ServerName, string DatabaseName)
        {
            return string.Format("Data Source={0};Initial Catalog={1};Integrated Security=True", ServerName, DatabaseName);
        }

        private static Dictionary<string, string> CreateConnectionProperties(string ConnectionString)
        {
            Dictionary<string, string> Properties = new Dictionary<string, string>();

            Properties.Add("connection.provider", "NHibernate.Connection.DriverConnectionProvider");
            Properties.Add("dialect", "NHibernate.Dialect.MsSql2008Dialect");
            Properties.Add("connection.driver_class", "NHibernate.Driver.SqlClientDriver");
            Properties.Add("connection.connection_string", ConnectionString);
            Properties.Add("cache.use_second_level_cache", "false");

            return Properties;
        }

        public BopsDataConnector()
        {
        }

        public BopsDataConnector(bool PromptForOverride)
        {
            _DoNotPromptAgain = !PromptForOverride;
        }

        public BopsDataConnector(string ServerName)
        {
            _SqlServerName = ServerName;
        }

        private void AddAssembly(NHibernate.Cfg.Configuration Config, string AssemblyName)
        {
            string PrivateBinPath = AppDomain.CurrentDomain.SetupInformation.PrivateBinPath;
            string AssemblyFileName = Path.Combine(PrivateBinPath, AssemblyName);

            if (File.Exists(AssemblyFileName))
                Config.AddAssembly(AssemblyFileName);
        }

        private void CheckFactory(BopsDatabase Database)
        {
            if (_Factories[(int) Database] != null) return;

            try
            {
                _Log.InfoFormat("Creating session factory for database {0}.", _DatabaseNames[(int)Database]);

                ShowOverrideForm(_DatabaseNames[(int)Database]);

                string ConnectionString = CreateConnectionString(_SqlServerName, _DatabaseNames[(int) Database]);
                Dictionary<string, string> ConnectionProperties = CreateConnectionProperties(ConnectionString);
                Configuration ConnectionConfiguration = new Configuration();
                ConnectionConfiguration.SetProperties(ConnectionProperties);

                foreach (Assembly Assembly in AppDomain.CurrentDomain.GetAssemblies())
                {
                    // NB:  The Assembly has a simple "Location" property that might look like it could be used, but
                    //      accessing that property will throw an exception for dynamic assemblies. Thankfully, even
                    //      dynamic assemblies have a "ManifestModule" property, which has a "Name".

                    foreach (string AllowedName in _AssemblyNames)
                    {
                        if (string.Compare(AllowedName, Assembly.ManifestModule.Name, true) == 0)
                            ConnectionConfiguration.AddAssembly(Assembly);
                    }
                }

                _Factories[(int)Database] = ConnectionConfiguration.BuildSessionFactory();
                Debug.Assert(_Factories[(int) Database] != null);
            }
            catch (Exception E)
            {
                _Log.Error("Exception in CheckFactory", E);
            }
        }

        private void CheckSession(BopsDatabase Database)
        {
            if (_Sessions[(int)Database] != null) return;
            _Log.InfoFormat("Creating session for database {0}.", _DatabaseNames[(int)Database]);
            _Sessions[(int) Database] = _Factories[(int) Database].OpenSession();
            Debug.Assert(_Sessions[(int)Database] != null);
        }

        public ISession DwsNoRepData
        {
            get
            {
                lock (_ThreadLock)
                {
                    CheckFactory(BopsDatabase.DwsNoRepData);
                    CheckSession(BopsDatabase.DwsNoRepData);
                    return _Sessions[(int)BopsDatabase.DwsNoRepData];
                }
            }
        }


        public ISession DwsRepData
        {
            get
            {
                lock (_ThreadLock)
                {
                    CheckFactory(BopsDatabase.DwsRepData);
                    CheckSession(BopsDatabase.DwsRepData);
                    return _Sessions[(int)BopsDatabase.DwsRepData];
                }
            }
        }

        public string DwsNoRepDataConnectionString
        {
            get { return CreateConnectionString(_SqlServerName, _DatabaseNames[(int) BopsDatabase.DwsNoRepData]); }
        }

        public string DwsRepDataConnectionString
        {
            get { return CreateConnectionString(_SqlServerName, _DatabaseNames[(int)BopsDatabase.DwsRepData]); }
        }

        public void CloseSessions()
        {
            for (int I = 0; I < _Sessions.Length; I++)
            {
                if (_Sessions[I] == null) continue;
                _Sessions[I].Close();
                _Sessions[I] = null;
            }
        }

        public void CloseFactories()
        {
            for (int I = 0; I < _Factories.Length; I++)
            {
                if (_Factories[I] == null) continue;
                _Factories[I].Close();
                _Factories[I] = null;
            }
        }

        public void CloseAll()
        {
            CloseSessions();
            CloseFactories();
        }
    }
}
