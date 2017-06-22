using Scm.OpsCore.Injection;

namespace Scm.OpsCore.Bootstrap
{
    /// <summary>
    /// Self-publishes interfaces for the bootstrap library.
    /// </summary>
    public class SelfPublisher : IInjectionPublisher
    {
        public void Publish(IInjectionBinder binder)
        {
            // Injection interface bindings.

            binder.Bind<IInjectionKernel, NinjectKernel>();
            binder.Bind<ILog, NinjectLog4Net>();
        }
    }
}
