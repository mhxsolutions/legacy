using System;
using System.Collections.Generic;

namespace Scm.OpsCore.Injection
{
    /// <summary>
    /// The methods common to any DI system suitable for our use.
    /// </summary>
    public interface IInjectionKernel
    {
        /// <summary>
        /// Gets an instance of the concrete type.
        /// </summary>
        /// <remarks>
        /// Throws an exception if the concrete type is not known.
        /// </remarks>
        /// <param name="type">The type to get.</param>
        /// <returns>An instance of the concrete type if successful.</returns>
        object Get(Type type);

        /// <summary>
        /// Gets an instance of the concrete type with a variant name.
        /// </summary>
        /// <remarks>
        /// Throws an exception if the concrete type is not known.
        /// </remarks>
        /// <typeparam name="T">The type to get.</typeparam>
        /// <param name="variant">The variant of the type.</param>
        /// <returns>An instance of the concrete type if successful.</returns>
        T Get<T>(string variant);

        /// <summary>
        /// Gets an instance of the concrete type with parameters for its constructor.
        /// </summary>
        /// <typeparam name="T">The type to be get.</typeparam>
        /// <param name="parameters">Constructor parameters.</param>
        /// <returns>An instance of the concrete type if successful.</returns>
        T Get<T>(params InjectionArg[] parameters);

        /// <summary>
        /// Gets all instances of the concrete type.
        /// </summary>
        /// <remarks>
        /// Throws an exception if the concrete type is not known.
        /// </remarks>
        /// <param name="type">The type to get.</param>
        /// <returns>All instances of the concrete type if successful.</returns>
        IEnumerable<object> GetAll(Type type);
    }
}
