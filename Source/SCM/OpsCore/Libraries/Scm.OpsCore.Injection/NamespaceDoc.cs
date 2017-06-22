namespace Scm.OpsCore.Injection
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
    /// This namespace exposes interfaces used for dependency injection (DI), which 
    /// decouples code interfaces from implementations. This is done through three
    /// fundamental mechanisms:
    /// </para>
    /// <list type="table">
    ///     <item>
    ///         <term>Kernel</term>
    ///         <description>
    ///             The kernel is what provides concrete types for interfaces.
    ///         </description>
    ///     </item>
    ///     <item>
    ///         <term>Binding</term>
    ///         <description>
    ///             Binding is what tells the kernel which concrete type to use 
    ///             for each interface.
    ///         </description>
    ///     </item>
    ///     <item>
    ///         <term>Publishing</term>
    ///         <description>
    ///             Publishing provides assemblies an opportunity to bind (or
    ///             self-publish) their internal types.
    ///         </description>
    ///     </item>
    /// </list>
    /// </summary>
    internal class NamespaceDoc
    {
    }
}
