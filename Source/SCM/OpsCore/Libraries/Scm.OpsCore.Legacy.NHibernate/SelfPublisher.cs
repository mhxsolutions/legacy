using Scm.OpsCore.Injection;
using Scm.OpsCore.Legacy.DataLayer;

namespace Scm.OpsCore.Legacy.NHibernate
{
    /// <summary>
    /// Self-publishes interfaces for the NHibernate implementation of the legacy data layer.
    /// </summary>
    public class SelfPublisher : IInjectionPublisher
    {
        /// <inheritdoc/>
        public void Publish(IInjectionBinder binder)
        {
            // Data layer bindings.

            binder.Bind<IRfsDataContext, RfsDataContext>();
            binder.Bind<ISolomonInvoiceTransfer, SolomonInvoiceTransfer>();
        }
    }
}
