using Ninject;
using Scm.OpsCore.Injection;

namespace Scm.OpsCore.Bootstrap
{
    /// <summary>
    /// A Ninject-specific implementation of a binder interface.
    /// </summary>
    internal class NinjectBinder : IInjectionBinder
    {
        private readonly IKernel _kernel;

        /// <summary>
        /// Construction from an existing Ninject kernel.
        /// </summary>
        /// <param name="kernel">The Ninject kernel to use for binding.</param>
        public NinjectBinder(IKernel kernel)
        {
            _kernel = kernel;
        }

        /// <inheritdoc/>
        public IInjectionBinder Bind<TFrom, TTo>() where TTo : TFrom
        {
            _kernel.Bind<TFrom>().To<TTo>();
            return this;
        }

        /// <inheritdoc/>
        public IInjectionBinder Bind<TFrom, TTo>(string name) where TTo : TFrom
        {
            _kernel.Bind<TFrom>().To<TTo>().Named(name);
            return this;
        }

    }
}
