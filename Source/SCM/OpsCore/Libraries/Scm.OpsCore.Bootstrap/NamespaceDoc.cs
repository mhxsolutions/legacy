namespace Scm.OpsCore.Bootstrap
{
    /*
     * NAME SPACE DOCUMENTATION FOR SANDCASTLE HELP FILE BUILDER
     * 
     * Microsoft's XML documentation is good but omits the ability to add a 
     * summary to a namespace. The Sandcastle Help File Builder (SHFB) lets
     * us work around this via a class named "NamespaceDoc".
     * 
     * See Also:
     * 
     * http://shfb.codeplex.com/
     * http://stackoverflow.com/questions/793210/xml-documentation-for-a-namespace
     */

    /// <summary>
    /// <para>
    /// This namespace contains classes concerned with initializing the dependency injection
    /// (DI) system and other necessary infrastructure. It's the primary mechanism that 
    /// encapsulates third-party interfaces and isolates them from the upper layers.
    /// </para>
    /// <para>
    /// DI services are provided by <a href="http://www.ninject.org/">Ninject</a>, hidden 
    /// insofar as it's possible behind our own interfaces for the upper layers. This should
    /// allow the DI system itself to be swapped out if needed.
    /// </para>
    /// <para>
    /// The bootstrap startup method must be called before any common infrastructure will be
    /// available in most project types. Web applications are somewhat special in that their 
    /// bootstrap execution takes place through other means. See the other bootstrap library
    /// variant(s) for more details.
    /// </para>
    /// </summary>
    internal class NamespaceDoc
    {
    }
}
