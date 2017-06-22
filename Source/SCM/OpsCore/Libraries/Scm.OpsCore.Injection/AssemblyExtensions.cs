using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace Scm.OpsCore.Injection
{
    public static class AssemblyExtensions
    {        
        /// <summary>
        /// Does the assembly have has classes that publish via injection?
        /// </summary>
        /// <param name="assembly">The assembly to be checked.</param>
        /// <returns>True if assembly has classes that publish via injection, false otherwise.</returns>
        public static bool HasInjectionPublishers(this Assembly assembly)
        {
            return assembly.GetExportedTypes().Any(TypeIsPublishable);
        }

        /// <summary>
        /// Gets the injection publishing interfaces for the assembly.
        /// </summary>
        /// <param name="assembly">The assembly whose injection publishing interfaces are desired.</param>
        /// <returns>An enumerable set of injection publishing interfaces if successful.</returns>
        public static IEnumerable<IInjectionPublisher> GetInjectionPublishers(this Assembly assembly)
        {
            return assembly.GetExportedTypes()
                    .Where(TypeIsPublishable)
                    .Select(type => Activator.CreateInstance(type) as IInjectionPublisher);
        }

        /// <summary>
        /// Is the type publishable?
        /// </summary>
        /// <param name="type">The type in question.</param>
        /// <returns>True if the type is publishable, false otherwise.</returns>
        private static bool TypeIsPublishable(Type type)
        {
            // The requirements are:
            //
            //   1. The type must support the IInjectionPublisher interface.
            //   2. It must be instantiable (i.e., not abstract or an interface).
            //   3. It must have at least a null constructor.

            return typeof(IInjectionPublisher).IsAssignableFrom(type)
                   && !type.IsAbstract
                   && !type.IsInterface
                   && type.GetConstructor(Type.EmptyTypes) != null;
        }
    }
}
