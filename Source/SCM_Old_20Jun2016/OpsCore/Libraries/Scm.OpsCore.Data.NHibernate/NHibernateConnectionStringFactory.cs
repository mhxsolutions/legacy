namespace Scm.OpsCore.Data.NHibernate
{
    /// <summary>
    /// Helper class to create NHibernate connection strings from various parameters.
    /// </summary>
    /// <remarks>
    /// If a user ID and/or password are not supplied, Windows integrated security will be assumed.
    /// </remarks>
    internal class NHibernateConnectionStringFactory
    {
        /// <summary>
        /// Name of the server for connection.
        /// </summary>
        public string Server { get; set; }
        /// <summary>
        /// Name of the database for connection.
        /// </summary>
        public string Database { get; set; }
        /// <summary>
        /// User ID for connection.
        /// </summary>
        public string UserId { get; set; }
        /// <summary>
        /// User password for connection.
        /// </summary>
        public string UserPassword { get; set; }

        /// <summary>
        /// Creates a usable connection string from the current parameter values.
        /// </summary>
        /// <returns>An NHibernate connection string.</returns>
        public string CreateConnectionString()
        {
            // If user ID and/or password is/are not supplied, assume Windows integrated security.

            if (string.IsNullOrWhiteSpace(UserId) || string.IsNullOrWhiteSpace(UserPassword))
                return string.Format("Data Source={0};Initial Catalog={1};Integrated Security=True", Server, Database);

            // Otherwise, make a connection string for traditional authentication (mixed mode in SQL Server terms).

            return string.Format("Data Source={0};Initial Catalog={1};User ID={2}; Password={3}",
                Server, Database, UserId, UserPassword);
        }
    }
}
