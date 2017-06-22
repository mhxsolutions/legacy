using System;
using BopsAuthentication;
using NUnit.Framework;
using System.DirectoryServices;

namespace BopsAuthenticationTests
{
    [TestFixture]
    public class TestBopsAuthentication
    {
        [Test]
        public void TestConstruction()
        {
            // On a machine joined to a domain, we should be able to get the domain name. On a machine not joined
            // to a domain, an exception will be thrown.

            string expectedDomainName;

            try
            {
                var de = new DirectoryEntry();
                if (de.Name != null && de.Name.Substring(0, 3) == "DC=")
                    expectedDomainName = de.Name.Substring(3);
                else
                    expectedDomainName = string.Empty;
            }
            catch (System.Runtime.InteropServices.COMException)
            {
                expectedDomainName = string.Empty;
            }
            catch (Exception)
            {
                expectedDomainName = string.Empty;
                Assert.Fail("Unexpected exception");
            }

            var ad = new ActiveDirectoryUtility();
            var actualDomainName = ad.DomainName;
            Assert.AreEqual(expectedDomainName, actualDomainName);
        }
    }
}
