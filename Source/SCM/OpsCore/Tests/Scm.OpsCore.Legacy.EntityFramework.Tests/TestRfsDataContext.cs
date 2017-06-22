using System;
using NUnit.Framework;
using ScmOpsCore.Legacy.EntityFramework;

namespace Scm.OpsCore.Legacy.EntityFramework.Tests
{
    /// <summary>
    /// Tests the Entity Framework implementation of the RFS data context.
    /// </summary>
    [TestFixture]
    public class TestRfsDataContext
    {
        /// <summary>
        /// Ensures RFS billing statuses may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetBillingStatuses()
        {
            var context = new RfsDataContext();
            var statuses = context.GetBillingStatuses();
            Assert.IsNotNull(statuses);
            Assert.Greater(statuses.Count, 0);

            foreach (var status in statuses)
            {
                Console.WriteLine("ID = {0}, Status = {1}", status.StatusId, status.Status);
            }
        }
    }
}
