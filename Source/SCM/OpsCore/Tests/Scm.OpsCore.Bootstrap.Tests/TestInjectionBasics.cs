using System.Linq;
using Ninject;
using NUnit.Framework;
using Scm.OpsCore.Injection;

namespace Scm.OpsCore.Bootstrap.Tests
{
    /// <summary>
    /// Tests the most basic DI operations.
    /// </summary>
    [TestFixture]
    public class TestInjectionBasics
    {
        #region Helper Classes

        private class ConstructorInjectionHelper
        {
            public IInjectionKernel Kernel { get; private set; }

            public ConstructorInjectionHelper(IInjectionKernel kernel)
            {
                Kernel = kernel;
            }
        }

        private class PropertyInjectionHelper
        {
            [Inject]
            public IInjectionKernel Kernel { get; set; }
        }

        #endregion

        private IInjectionKernel _kernel;

        /// <summary>
        /// NUnit setup method run individually to get a fresh kernel for each test.
        /// </summary>
        [SetUp]
        public void SetUp()
        {
            Bootstrap.Startup();
            _kernel = Bootstrap.Kernel.Get<IInjectionKernel>();
        }

        /// <summary>
        /// Tests the injection kernel resolve.
        /// </summary>
        [Test]
        public void TestInjectionKernelResolve()
        {
            Assert.NotNull(_kernel);
        }

        /// <summary>
        /// Tests the constructor injection.
        /// </summary>
        [Test]
        public void TestConstructorInjection()
        {
            var helper = _kernel.Get<ConstructorInjectionHelper>();
            Assert.NotNull(helper.Kernel);
        }

        /// <summary>
        /// Tests the property injection.
        /// </summary>
        [Test]
        public void TestPropertyInjection()
        {
            var helper = _kernel.Get<PropertyInjectionHelper>();
            Assert.NotNull(helper.Kernel);
        }

        /// <summary>
        /// Tests the method to get all resolutions for a given type.
        /// </summary>
        [Test]
        public void TestGetAllConcrete()
        {
            var all = _kernel.GetAll(typeof (IInjectionKernel));
            Assert.Greater(all.Count(), 0);
        }

        /// <summary>
        /// Tests the log interface is available.
        /// </summary>
        [Test]
        public void TestLogResolve()
        {
            var log = _kernel.Get<ILog>();
            Assert.NotNull(log);
        }
    }
}
