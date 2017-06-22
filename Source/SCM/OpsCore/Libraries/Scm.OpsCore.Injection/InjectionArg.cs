namespace Scm.OpsCore.Injection
{
    /// <summary>
    /// Models a constructor argument for sake of the injection system.
    /// </summary>
    public class InjectionArg
    {
        /// <summary>
        /// The name of the constructor argument parameter.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; set; }
        /// <summary>
        /// The object for the constructor argument parameter.
        /// </summary>
        /// <value>The object.</value>
        public object Object { get; set; }
    }
}
