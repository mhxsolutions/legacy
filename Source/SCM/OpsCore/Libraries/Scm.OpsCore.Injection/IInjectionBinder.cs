namespace Scm.OpsCore.Injection
{
    /// <summary>
    /// Abstracts the details of binding one type to another for the DI system.
    /// </summary>
    public interface IInjectionBinder
    {
        /// <summary>
        /// Binds one type to another.
        /// </summary>
        /// <example>
        /// This is intended to bind an abstract interface to its concrete type implementation.
        /// <code>
        /// binding.Bind&lt;IInterface, Implementation&gt;();
        /// </code>
        /// </example>
        /// <remarks>Throws an exception if the concrete type is not known.</remarks>
        /// <typeparam name="TFrom">The type to bind (usually an interface).</typeparam>
        /// <typeparam name="TTo">The type to bind it to (usually a concrete type).</typeparam>
        /// <returns>The original interface to provide a fluent API.</returns>
        IInjectionBinder Bind<TFrom, TTo>() where TTo : TFrom;

        /// <summary>
        /// Binds one type to another but with a variant name.
        /// </summary>
        /// <example>
        /// This is intended to bind an abstract interface to a named variant of a 
        /// concrete type implementation.
        /// <code>
        /// binding.Bind&lt;IInterface, Implementation&gt;("variant");
        /// </code>
        /// </example>
        /// <remarks>Throws an exception if the concrete type is not known.</remarks>
        /// <typeparam name="TFrom">The type to bind (usually an interface).</typeparam>
        /// <typeparam name="TTo">The type to bind it to (usually a concrete type).</typeparam>
        /// <returns>The original interface to provide a fluent API.</returns>
        IInjectionBinder Bind<TFrom, TTo>(string variant) where TTo : TFrom;
    }
}
