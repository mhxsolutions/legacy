using System;
using System.Diagnostics;
using Ninject;
using Scm.OpsCore.Injection;

namespace Scm.OpsCore.Bootstrap
{
    /// <summary>
    /// Exposes public static bootstrap methods for startup.
    /// </summary>
    public class Bootstrap
    {
        private static bool _initialized = false;
        private static readonly NinjectKernel Wrapper = new NinjectKernel(null);

        /// <summary>
        /// Exposes the abstracted kernel.
        /// </summary>
        public static IInjectionKernel Kernel
        {
            get { return Wrapper; }
        }

        /// <summary>
        /// Core startup mechanics.
        /// </summary>
        /// <param name="ninjectKernel">The concrete Ninject kernel to use (if any).</param>
        private static void StartupCore(IKernel ninjectKernel)
        {
            // TODO: replace the boolean with proper multi-threaded safety when needed.

            if (_initialized) return;
            _initialized = true;

            // Initialize the Log4Net system from configuration.

            log4net.Config.XmlConfigurator.Configure();

            // Call into Ninject.Extensions.Logging.Log4Net to ensure it's loaded. This prevents 
            // consuming applications from needing to depend upon it to get its binaries.

            var log4NetLoggerFactory = new Ninject.Extensions.Logging.Log4net.Infrastructure.Log4NetLoggerFactory();
            Debug.Assert(log4NetLoggerFactory != null);

            // If we were given a concrete Ninject kernel to work with, use it.

            if (ninjectKernel != null)
                Wrapper.Kernel = ninjectKernel;
        }

        /// <summary>
        /// Default bootstrap startup method.
        /// </summary>
        /// <remarks>
        /// This method should be used whenever possible as it starts up the 
        /// bootstrapper from nothing.
        /// </remarks>
        public static void Startup()
        {
            StartupCore(null);
        }

        /// <summary>
        /// Alternate bootstrap startup method using an existing concrete kernel.
        /// </summary>
        /// <param name="kernelDynamicObject">An external kernel object expected to have a "Kernel" property.</param>
        /// <remarks>
        /// This startup method provides a way for external code to configure a concrete kernel
        /// for cases wherein initialization must come first (e.g., web applications). 
        /// The type of the "Kernel" property must match the underlying injection 
        /// framework wrapped by the bootstrapper. The use of the dynamic argument means 
        /// that any public class with a public property will serve; i.e., anything but
        /// anonymous objects (for sake of flexibility).
        /// </remarks>
        public static void Startup(dynamic kernelDynamicObject)
        {
            if (kernelDynamicObject == null)
                throw new ArgumentNullException("kernelDynamicObject");

            using (IKernel ninjectKernel = kernelDynamicObject.Kernel)
            {
                StartupCore(ninjectKernel);
            }
        }
    }
}
