using System.Collections.Specialized;
using BopsUtilities;
using NUnit.Framework;

namespace BopsUtilitiesTests
{
    [TestFixture]
    public class TestEmailDistributionListManager
    {
        [Test]
        public void TestFailureGetList()
        {
            var manager = new EmailDistributionListManager();
            var badList = manager.GetList("Bad list name");
            Assert.IsNull(badList);
        }

        [Test]
        public void TestFailureBadListName()
        {
            var manager = new EmailDistributionListManager();
            var result = manager.SendMessage("Bad list name", "Bad subject", "Bad body");
            Assert.AreEqual(EmailDistributionListManager.SendResult.ListNotFound, result);
        }

        [Test]
        public void TestAddingList()
        {
            var nvc = new NameValueCollection
            {
                {"SmtpServer", "smtp.office365.com"},
                {"From", "john.williston@budway.net"},
                {"To", "john.williston@budway.net"},
                {"Cooldown", "5000"}
            };
            var manager = new EmailDistributionListManager();
            manager.AddList("Testing", nvc);
            var testList = manager.GetList("Testing");
            Assert.IsNotNull(testList);
        }

        [Test]
        public void TestCooldown()
        {
            var nvc = new NameValueCollection
            {
                {"SmtpServer", "smtp.office365.com"},
                {"From", "john.williston@budway.net"},
                {"To", "john.williston@budway.net"},
                {"Cooldown", "5000"}
            };
            var manager = new EmailDistributionListManager();
            manager.AddList("Testing", nvc);
            var testList = manager.GetList("Testing");
            Assert.IsNotNull(testList);
            testList.ForceCooldown();
            var result = manager.SendMessage("Testing", "Cooldown subject", "Cooldown body");
            Assert.AreEqual(EmailDistributionListManager.SendResult.ListInCooldown, result);
        }

        [Test]
        public void TestSending()
        {
            var nvc = new NameValueCollection
            {
                {"SmtpServer", "smtp.office365.com"},
                {"SmtpUserId", "bops.admin@budway.net"},
                {"SmtpUserPassword", "RoyalFlu15"},
                {"From", "bops.admin@budway.net"},
                {"To", "john.williston@budway.net"},
                {"Cooldown", "5000"},
                {"EnableSsl", "true"}
            };
            var manager = new EmailDistributionListManager();
            manager.AddList("Testing", nvc);
            var result = manager.SendMessage("Testing", "Test message subject", "Test message body");
            Assert.AreEqual(EmailDistributionListManager.SendResult.MessageSent, result);
        }
    }
}
