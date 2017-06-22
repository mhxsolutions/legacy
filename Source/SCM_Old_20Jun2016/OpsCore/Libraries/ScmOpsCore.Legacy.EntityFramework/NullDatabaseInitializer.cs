using System.Data.Entity;

namespace ScmOpsCore.Legacy.EntityFramework
{
    /// <summary>
    /// Database initializer strategy enumeration.
    /// </summary>
    public enum DatabaseInitializerStrategy
    {
        /// <summary>
        /// Production nevers drops the database, always preserving data.
        /// </summary>
        Production,
        /// <summary>
        /// Development drops and creates the database whenever the model changes.
        /// </summary>
        Development,
        /// <summary>
        /// Testing always drops and creates the database.
        /// </summary>
        Testing,
    }

    /// <summary>
    /// An Entity Framework database initializer that does nothing.
    /// </summary>
    /// <typeparam name="T">Type of the context for which the initializer will be used.</typeparam>
    public class NullDatabaseInitializer<T> : IDatabaseInitializer<T> where T : DbContext
    {
        /// <inheritdoc/>
        public void InitializeDatabase(T context)
        {
            // Do nothing, leave the database alone and don't complain about anything.
        }
    }
}
