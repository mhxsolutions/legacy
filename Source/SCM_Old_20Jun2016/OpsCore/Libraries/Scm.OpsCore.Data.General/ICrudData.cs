using System.Collections.Generic;

namespace Scm.OpsCore.Data.General
{
    /// <summary>
    /// Interface for crud functionality for arbitrary data types.
    /// </summary>
    /// <typeparam name="T">Data type for crud functions.</typeparam>
    /// <remarks>
    /// Standard database "crud" functions inlcude create, read, update, and delete.
    /// </remarks>
    public interface ICrudData<T> where T : class
    {
        /// <summary>
        /// Gets all objects of the specified type.
        /// </summary>
        /// <returns>An enumerable of objects of the specified type if successful, null otherwise.</returns>
        /// <remarks>
        /// Use this with caution as it will literally fetch all rows from a given database table.
        /// </remarks>
        IEnumerable<T> GetAll();
    }
}
