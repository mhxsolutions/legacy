using System;
using System.Collections.Generic;
using NHibernate;
using NHibernate.Cfg;

namespace Scm.OpsCore.Data.NHibernate
{
    /// <summary>
    /// Helper class to simplify creation and caching of an NHibernate session factory interface.
    /// </summary>
    internal class NHibernateSessionFactory
    {
        /// <summary>
        /// List of assemblies that contain NHibernate types to be included.
        /// </summary>
        private static readonly string[] AssemblyNames = { "BopsDataAccess.dll", "AgilisCore.dll" };
        /// <summary>
        /// Manages the details of the connection string.
        /// </summary>
        private readonly NHibernateConnectionStringFactory _connection;
        /// <summary>
        /// The actual NHibernate session factory interface to use for opening sessions.
        /// </summary>
        private readonly ISessionFactory _factory;

        /// <summary>
        /// Initializes a session factory from various parameters.
        /// </summary>
        /// <param name="server">Name of the server for connection.</param>
        /// <param name="database">Name of the database for connection.</param>
        /// <param name="userId">User ID for connection.</param>
        /// <param name="userPassword">User password for connection.</param>
        public NHibernateSessionFactory(string server, string database, string userId, string userPassword)
        {
            _connection = new NHibernateConnectionStringFactory
            {
                Server = server,
                Database = database,
                UserId = userId,
                UserPassword = userPassword
            };

            _factory = CreateSessionFactory();
        }

        /// <summary>
        /// Specifies connection properties required for NHibernate.
        /// </summary>
        /// <returns>A dictionary of connection properties.</returns>
        private Dictionary<string, string> CreateConnectionProperties()
        {
            var connectionString = _connection.CreateConnectionString();

            var properties = new Dictionary<string, string>
            {
                {"connection.provider", "NHibernate.Connection.DriverConnectionProvider"},
                {"dialect", "NHibernate.Dialect.MsSql2008Dialect"},
                {"connection.driver_class", "NHibernate.Driver.SqlClientDriver"},
                {"connection.connection_string", connectionString},
                {"cache.use_second_level_cache", "false"}
            };

            return properties;
        }

        /// <summary>
        /// Creates an actual NHibernate session factory.
        /// </summary>
        /// <returns>An NHibernate session factory interface.</returns>
        private ISessionFactory CreateSessionFactory()
        {
            var props = CreateConnectionProperties();
            var connectionConfiguration = new Configuration();
            connectionConfiguration.SetProperties(props);

            foreach (var assembly in AppDomain.CurrentDomain.GetAssemblies())
            {
                // NB:  The Assembly has a simple "Location" property that might look like it could be used, but
                //      accessing that property will throw an exception for dynamic assemblies. Thankfully, even
                //      dynamic assemblies have a "ManifestModule" property, which has a "Name".

                foreach (var allowedName in AssemblyNames)
                {
                    if (String.Compare(allowedName, assembly.ManifestModule.Name, StringComparison.OrdinalIgnoreCase) == 0)
                        connectionConfiguration.AddAssembly(assembly);
                }
            }

            return connectionConfiguration.BuildSessionFactory();
        }

        /// <summary>
        /// Create a new NHibernate session from the previously initialized session factory.
        /// </summary>
        /// <returns>An NHibernate session interface.</returns>
        public ISession CreateSession()
        {
            return _factory.OpenSession();
        }
    }
}
