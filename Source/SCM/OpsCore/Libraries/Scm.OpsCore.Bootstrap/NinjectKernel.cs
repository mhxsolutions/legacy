using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using Ninject;
using Ninject.Parameters;
using Scm.OpsCore.Injection;

namespace Scm.OpsCore.Bootstrap
{
    /// <summary>
    /// A Ninject-specific concrete implementation of <see cref="IInjectionKernel"/>.
    /// </summary>
    internal class NinjectKernel : IInjectionKernel
    {
        private IKernel _kernel;

        /// <summary>
        /// Construction from an existing Ninject concrete kernel.
        /// </summary>
        /// <remarks>
        /// This constructor assumes the kernel has already been initialized.
        /// </remarks>
        /// <param name="kernel">The kernel from which to be constructed.</param>
        public NinjectKernel(IKernel kernel)
        {
            _kernel = kernel;
        }

        /// <summary>
        /// The underlying (i.e., unwrapped) DI kernel
        /// </summary>
        /// <remarks>
        /// The underlying kernel should NOT be used unless absolutely necessary
        /// as this will create undesirable coupling in the higher layers. It is
        /// necessary to expose it, however, for other variants of the bootstrap
        /// code to do their thing (most notably for web applications).
        /// </remarks>
        public IKernel Kernel
        {
            get
            {
                if (_kernel != null) return _kernel;
                _kernel = new StandardKernel();
                InitializeConcreteKernel();
                return _kernel;
            }

            set
            {
                _kernel = value;
                InitializeConcreteKernel();
            }
        }
        
        /// <summary>
        /// Gets the directory name of the folder from which the current 
        /// assembly is executed.
        /// </summary>
        /// <returns>The directory name if successful.</returns>
        private static string GetExecutingAssemblyFolder()
        {
            var thisCodeBase = Assembly.GetExecutingAssembly().CodeBase;
            var uri = new UriBuilder(thisCodeBase);
            var path = Uri.UnescapeDataString(uri.Path);
            return Path.GetDirectoryName(path);
        }

        /// <summary>
        /// Gets the SCM Operations Core assemblies.
        /// </summary>
        /// <returns>An enumerable of the assemblies if successful.</returns>
        private static IEnumerable<Assembly> GetScmOpsCoreAssemblies()
        {
            var folder = GetExecutingAssemblyFolder();
            var drAssemblies = new List<string>(Directory.GetFiles(folder, @"Scm.OpsCore.*.dll"));
            return drAssemblies.Select(Assembly.LoadFrom).ToList();
        }

        /// <summary>
        /// Detects and calls any self-publishing methods for the assemblies.
        /// </summary>
        /// <param name="assemblies">The enumerable of assemblies for self-publishing.</param>
        private void SelfPublishAssemblies(IEnumerable<Assembly> assemblies)
        {
            // To allow assemblies to self-publish with the concrete kernel, we 
            // need a Ninject-specific binder.

            var binder = new NinjectBinder(_kernel);

            // The following uses LINQ and .NET extension methods to locate assemblies that 
            // have public types with a DI publishing interface and call that with
            // the ninject binding interface created above.

            foreach (var publisher in 
                assemblies.Where(assembly => assembly.HasInjectionPublishers())
                    .Select(assembly => assembly.GetInjectionPublishers()).SelectMany(publishers => publishers))
            {
                publisher.Publish(binder);
            }
        }

        /// <summary>
        /// Gets the complete list of assemblies for self-publishing.
        /// </summary>
        /// <returns>An enumerable of assemblies if successful.</returns>
        private static IEnumerable<Assembly> GetAssembliesForSelfPublishing()
        {
            // At the moment I'm only going to allow OpsCore assemblies to avoid 
            // assembles that cause problems and match our naming standard. 

            // TODO: Change this method or add other methods to allow more precise and finely controlled initialization.

            return GetScmOpsCoreAssemblies();
        }

        /// <summary>
        /// Allocates and initializes the underlying concrete kernel.
        /// </summary>
        private void InitializeConcreteKernel()
        {
            var assemblies = GetAssembliesForSelfPublishing();
            _kernel.Load(assemblies);
            SelfPublishAssemblies(assemblies);
        }

        /// <inheritdoc/>
        public object Get(Type type)
        {
            var request = Kernel.CreateRequest(type, null, new Parameter[0], true, true);
            return Kernel.Resolve(request).SingleOrDefault();
        }

        /// <inheritdoc/>
        public T Get<T>(string name)
        {
            return Kernel.Get<T>(name);
        }

        /// <inheritdoc/>
        public T Get<T>(params InjectionArg[] parameters)
        {
            return Kernel.Get<T>(parameters.Select(arg => (new ConstructorArgument(arg.Name, arg.Object)) as IParameter).ToArray());
        }

        /// <inheritdoc/>
        public IEnumerable<object> GetAll(Type type)
        {
            var request = Kernel.CreateRequest(type, null, new Parameter[0], true, true);
            return _kernel.Resolve(request).ToList();
        }
    }
}
