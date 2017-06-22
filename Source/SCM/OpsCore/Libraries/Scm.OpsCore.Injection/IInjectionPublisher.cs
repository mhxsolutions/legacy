namespace Scm.OpsCore.Injection
{
    public interface IInjectionPublisher
    {
        /// <summary>
        /// Called by the injection abstractions to allow self-publishing.
        /// </summary>
        /// <param name="binder">The injection binder to use for self-publishing.</param>
        void Publish(IInjectionBinder binder);
    }
}
