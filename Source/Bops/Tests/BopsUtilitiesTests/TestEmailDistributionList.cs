using System;
using BopsUtilities;
using NUnit.Framework;

namespace BopsUtilitiesTests
{
    [TestFixture]
    public class TestEmailDistributionList
    {
        [Test]
        [ExpectedException(typeof(InvalidOperationException))]
        public void TestSendMessageSmtpServerRequirement()
        {
            var newList = new EmailDistributionList();
            newList.SendMessage("No Subject", "No Text");
        }

        [Test]
        [ExpectedException(typeof(InvalidOperationException))]
        public void TestSendMessageFromRequirement()
        {
            var newList = new EmailDistributionList {SmtpServer = "smtp.emailsrvr.com"};
            newList.SendMessage("No Subject", "No Text");
        }

        [Test]
        [ExpectedException(typeof(InvalidOperationException))]
        public void TestSendMessageToRequirement()
        {
            var newList = new EmailDistributionList
            {
                SmtpServer = "mail.willistons.com",
                From = "john.williston@budway.net"
            };
            newList.SendMessage("No Subject", "No Text");
        }

        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void TestSendMessageSubjectNotNullRequirement()
        {
            var newList = new EmailDistributionList
            {
                SmtpServer = "mail.willistons.com",
                From = "john.williston@budway.net",
                To = "john.williston@budway.net"
            };
            newList.SendMessage(null, "No Text");
        }

        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void TestSendMessageSubjectNotEmptyRequirement()
        {
            var newList = new EmailDistributionList
            {
                SmtpServer = "mail.willistons.com",
                From = "john.williston@budway.net",
                To = "john.williston@budway.net"
            };
            newList.SendMessage(string.Empty, "No Text");
        }
    }
}
