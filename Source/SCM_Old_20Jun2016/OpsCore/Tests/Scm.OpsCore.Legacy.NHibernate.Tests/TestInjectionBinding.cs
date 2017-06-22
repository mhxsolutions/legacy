using Ninject;
using NUnit.Framework;
using Scm.OpsCore.Legacy.DataLayer;

namespace Scm.OpsCore.Legacy.NHibernate.Tests
{
    [TestFixture]
    public class TestInjectionBinding
    {
        /// <summary>
        /// Ensure that no RFS data context interface is available prior to bootstrap.
        /// </summary>
        [Test]
        [ExpectedException(typeof(ActivationException))]
        public void TestRfsContextResolveFailure()
        {
            var kernel = new StandardKernel();
            kernel.Get<IRfsDataContext>();
        }

        /// <summary>
        /// Ensure that RFS data context interface is available after bootstrap.
        /// </summary>
        [Test]
        public void TestRfsContextResolveSuccess()
        {
            Bootstrap.Bootstrap.Startup();
            var rfsDataContext = Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            Assert.IsNotNull(rfsDataContext);
        }
    }
}
