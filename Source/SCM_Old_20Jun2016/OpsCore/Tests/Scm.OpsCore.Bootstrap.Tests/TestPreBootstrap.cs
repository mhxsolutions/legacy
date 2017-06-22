using Ninject;
using NUnit.Framework;
using Scm.OpsCore.Injection;

namespace Scm.OpsCore.Bootstrap.Tests
{
    /// <summary>
    /// The point of these tests is to guarantee that a plain, uninitialized
    /// Ninject kernel cannot resolve any of the injection interfaces. This
    /// should help prevent unhappy monkeying with initialization order and/or
    /// unwanted coupling with future development.
    /// </summary>

    [TestFixture]
    public class TestPreBootstrap
    {
        /// <summary>
        /// Ensure that no kernel interface is available prior to bootstrap.
        /// </summary>
        [Test]
        [ExpectedException(typeof(ActivationException))]
        public void TestInjectionKernelResolveFailure()
        {
            var kernel = new StandardKernel();
            kernel.Get<IInjectionKernel>();
        }

        /// <summary>
        /// Ensure that no binder interface is available prior to bootstrap.
        /// </summary>
        [Test]
        [ExpectedException(typeof(ActivationException))]
        public void TestInjectionBinderResolveFailure()
        {
            var kernel = new StandardKernel();
            kernel.Get<IInjectionBinder>();
        }

        /// <summary>
        /// Ensure that no publisher interface is available prior to bootstrap.
        /// </summary>
        [Test]
        [ExpectedException(typeof(ActivationException))]
        public void TestInjectionPublisherResolveFailure()
        {
            var kernel = new StandardKernel();
            kernel.Get<IInjectionPublisher>();
        }

    }
}
