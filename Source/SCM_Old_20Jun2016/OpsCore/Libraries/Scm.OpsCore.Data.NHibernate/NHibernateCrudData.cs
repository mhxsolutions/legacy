using System.Collections.Generic;
using NHibernate;
using Scm.OpsCore.Data.General;

namespace Scm.OpsCore.Data.NHibernate
{
    /// <summary>
    /// Provides an NHibernate implementation of the generic crud data interface.
    /// </summary>
    /// <typeparam name="T">Data type for crud functions.</typeparam>
    public class NHibernateCrudData<T> : ICrudData<T> where T : class
    {
        /// <summary>
        /// NHibernate session interface for operations.
        /// </summary>
        private readonly ISession _session;

        /// <summary>
        /// Construction from an existing session.
        /// </summary>
        /// <param name="session">NHibernate session interface to use.</param>
        public NHibernateCrudData(ISession session)
        {
            _session = session;
        }

        /// <inheritdoc/>
        public IEnumerable<T> GetAll()
        {
            return _session.CreateCriteria(typeof(T)).List<T>();
        }
    }
}
