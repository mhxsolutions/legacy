using System;
using System.Collections.Generic;
using System.Linq;
using BopsDataAccess;
using NUnit.Framework;

namespace Scm.OpsCore.Data.NHibernate.Tests
{
    [TestFixture]
    public class TestNHibernateCrudData
    {
        /// <summary>
        /// Ensure that the get all method of the NHibernate crud implementation works.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetAll()
        {
            // TODO: Move this stuff into configuration or something.

            var factory = new NHibernateSessionFactory("SQL2016", "DWS No Rep Data", "UnitTestUser", "19ZkV1e6Fto8QX");
            var session = factory.CreateSession();
            var crud = new NHibernateCrudData<BopsRfsBillingStatus>(session);

            var all = crud.GetAll();
            var statuses = all as IList<BopsRfsBillingStatus> ?? all.ToList();
            foreach (var status in statuses)
            {
                Console.WriteLine("ID = {0}, Status = {1}", status.StatusId, status.Status);
            }

            Assert.IsNotNull(all);
            Assert.Greater(statuses.Count(), 0);
        }
    }
}
