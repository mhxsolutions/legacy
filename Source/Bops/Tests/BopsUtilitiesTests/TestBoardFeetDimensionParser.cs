using System;
using BopsUtilities;
using NUnit.Framework;

namespace BopsUtilitiesTests
{
    [TestFixture]
    public class TestBoardFeetDimensionParser
    {
        [Test]
        [ExpectedException(typeof(NullReferenceException))]
        public void TestNullString()
        {
            var parser = new BoardFeetDimensionParser(null);
            Assert.Fail("We should never get here", parser);
        }

        [Test]
        public void TestEmptyString()
        {
            var parser = new BoardFeetDimensionParser(string.Empty);
            Assert.That(parser.Error != null);
            Console.WriteLine(parser.Error);
        }

        [Test]
        public void TestWrongNumberOfDimensions()
        {
            var parser1 = new BoardFeetDimensionParser("A");
            Assert.That(parser1.Error != null);
            Console.WriteLine(parser1.Error);

            var parser2 = new BoardFeetDimensionParser("A x B");
            Assert.That(parser2.Error != null);
            Console.WriteLine(parser2.Error);

            var parser3 = new BoardFeetDimensionParser("A x B x C x D");
            Assert.That(parser3.Error != null);
            Console.WriteLine(parser3.Error);
        }

        [Test]
        public void TestBadThickness()
        {
            var parser1 = new BoardFeetDimensionParser("A x 2 x 3");
            Assert.That(parser1.Error != null);
            Console.WriteLine(parser1.Error);

            var parser2 = new BoardFeetDimensionParser("22.5/3.7 x 2 x 3");
            Assert.That(parser2.Error != null);
            Console.WriteLine(parser2.Error);

            var parser3 = new BoardFeetDimensionParser("1s3 x 2 x 3");
            Assert.That(parser3.Error != null);
            Console.WriteLine(parser3.Error);

            var parser4 = new BoardFeetDimensionParser("1 ftft x 2 x 3");
            Assert.That(parser4.Error != null);
            Console.WriteLine(parser4.Error);
        }

        [Test]
        public void TestBadLength()
        {
            var parser1 = new BoardFeetDimensionParser("1 x A x 3");
            Assert.That(parser1.Error != null);
            Console.WriteLine(parser1.Error);

            var parser2 = new BoardFeetDimensionParser("1 x 22.5/3.7 x 3");
            Assert.That(parser2.Error != null);
            Console.WriteLine(parser2.Error);

            var parser3 = new BoardFeetDimensionParser("1 x 1s3 x 3");
            Assert.That(parser3.Error != null);
            Console.WriteLine(parser3.Error);

            var parser4 = new BoardFeetDimensionParser("1 x 2 ftft x 3"); 
            Assert.That(parser4.Error != null);
            Console.WriteLine(parser4.Error);
        }

        [Test]
        public void TestBadWidth()
        {
            var parser1 = new BoardFeetDimensionParser("1 x 2 x A");
            Assert.That(parser1.Error != null);
            Console.WriteLine(parser1.Error);

            var parser2 = new BoardFeetDimensionParser("1 x 2 x 22.5/3.7");
            Assert.That(parser2.Error != null);
            Console.WriteLine(parser2.Error);

            var parser3 = new BoardFeetDimensionParser("1 x 2 x 1s3");
            Assert.That(parser3.Error != null);
            Console.WriteLine(parser3.Error);

            var parser4 = new BoardFeetDimensionParser("1 x 2 x 3 ftft");
            Assert.That(parser4.Error != null);
            Console.WriteLine(parser4.Error);
        }

        [Test]
        public void TestAllIntegers()
        {
            var parser = new BoardFeetDimensionParser("1 x 2 x 3");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1, parser.Thickness);
            Assert.AreEqual(2, parser.Length);
            Assert.AreEqual(3, parser.Width);
        }

        [Test]
        public void TestAllFloats()
        {
            var parser = new BoardFeetDimensionParser("1.23 x 4.5 x 6.78");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1.23, parser.Thickness);
            Assert.AreEqual(4.5, parser.Length);
            Assert.AreEqual(6.78, parser.Width);
        }

        [Test]
        public void TestAllFractions()
        {
            var parser = new BoardFeetDimensionParser("1/2 x 10/5 x 4/16");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(0.5, parser.Thickness);
            Assert.AreEqual(2.0, parser.Length);
            Assert.AreEqual(0.25, parser.Width);
        }

        [Test]
        public void TestAllWholesAndFractions()
        {
            var parser = new BoardFeetDimensionParser("1 3/8 x 2 250/25 x 99 3/32");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1.375, parser.Thickness);
            Assert.AreEqual(12.0, parser.Length);
            Assert.AreEqual(99.09375, parser.Width);
        }

        [Test]
        public void TestThicknessInFeet()
        {
            var parser = new BoardFeetDimensionParser("1 ft x 2 x 3");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(12.0, parser.Thickness);
            Assert.AreEqual(2.0, parser.Length);
            Assert.AreEqual(3.0, parser.Width);
        }

        [Test]
        public void TestLengthInFeet()
        {
            var parser = new BoardFeetDimensionParser("1 x 2 ft x 3");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1.0, parser.Thickness);
            Assert.AreEqual(24.0, parser.Length);
            Assert.AreEqual(3.0, parser.Width);
        }

        [Test]
        public void TestWidthInFeet()
        {
            var parser = new BoardFeetDimensionParser("1 x 2 x 3 ft");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1.0, parser.Thickness);
            Assert.AreEqual(2.0, parser.Length);
            Assert.AreEqual(36.0, parser.Width);
        }

        [Test]
        public void TestThicknessInInches()
        {
            var parser = new BoardFeetDimensionParser("1 in x 2 x 3");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1.0, parser.Thickness);
            Assert.AreEqual(2.0, parser.Length);
            Assert.AreEqual(3.0, parser.Width);
        }

        [Test]
        public void TestLengthInInches()
        {
            var parser = new BoardFeetDimensionParser("1 x 2 in x 3");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1.0, parser.Thickness);
            Assert.AreEqual(2.0, parser.Length);
            Assert.AreEqual(3.0, parser.Width);
        }

        [Test]
        public void TestWidthInInches()
        {
            var parser = new BoardFeetDimensionParser("1 x 2 x 3 in");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(1.0, parser.Thickness);
            Assert.AreEqual(2.0, parser.Length);
            Assert.AreEqual(3.0, parser.Width);
        }

        [Test]
        public void TestSheetBoardFeetCalculation()
        {
            // NB: The values used in this test come from an Excel spreadsheet from Jim C. in an email dated 02/02/2010.

            var parser = new BoardFeetDimensionParser("7/8 x 48 x 96");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(0.875, parser.Thickness);
            Assert.AreEqual(48, parser.Length);
            Assert.AreEqual(96, parser.Width);
            var sheetBoardFeet = parser.SheetBoardFeet;
            Assert.AreEqual(28, sheetBoardFeet);
        }

        [Test]
        public void TestThousandBoardFeetCalculation()
        {
            // NB: The values used in this test come from an Excel spreadsheet from Jim C. in an email dated 02/02/2010.

            var parser = new BoardFeetDimensionParser("7/8 x 48 x 96");
            Assert.That(string.IsNullOrEmpty(parser.Error));
            Assert.AreEqual(0.875, parser.Thickness);
            Assert.AreEqual(48, parser.Length);
            Assert.AreEqual(96, parser.Width);
            var sheetBoardFeet = parser.SheetBoardFeet;
            Assert.AreEqual(28, sheetBoardFeet);
            var thousandBoardFeet = parser.CalculateThousandBoardFeet(35);
            Assert.AreEqual(0.980, thousandBoardFeet);
        }
    }
}
