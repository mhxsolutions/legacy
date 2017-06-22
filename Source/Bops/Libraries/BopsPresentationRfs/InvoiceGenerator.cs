using System;
using System.Collections.Generic;
using BopsDataAccess;
using PdfSharp.Drawing;
using PdfSharp.Drawing.Layout;
using PdfSharp.Pdf;

namespace BopsPresentationRfs
{
    public class InvoiceGenerator
    {
        #region Helper Classes 

        private class InvoiceLinesSorter : IComparer<BopsRfsInvoiceDetail>
        {
            public int Compare(BopsRfsInvoiceDetail x, BopsRfsInvoiceDetail y)
            {
                if (x.LineNumber < y.LineNumber)
                    return -1;
                else if (x.LineNumber > y.LineNumber)
                    return 1;
                else
                    return 0;
            }
        }

        #endregion

        private const double _PointsPerInch = 72.0;

        private double _VerticalSpace = _PointsPerInch / 4;
        private double _HorizontalSpace = _PointsPerInch / 4;
        private double _LeftMargin = _PointsPerInch * 0.75;
        private double _TopMargin = _PointsPerInch * 0.75;
        private double _RightMargin = _PointsPerInch * 0.75;
        private double _BottomMargin = _PointsPerInch * 0.75;
        private string _NormalFontName = "Calibri";

        public double VerticalSpace
        {
            get { return _VerticalSpace; }
            set { _VerticalSpace = value; }
        }

        public double HorizontalSpace
        {
            get { return _HorizontalSpace; }
            set { _HorizontalSpace = value; }
        }

        public double LeftMargin
        {
            get { return _LeftMargin; }
            set { _LeftMargin = value; }
        }

        public double TopMargin
        {
            get { return _TopMargin; }
            set { _TopMargin = value; }
        }

        public double RightMargin
        {
            get { return _RightMargin; }
            set { _RightMargin = value; }
        }

        public double BottomMargin
        {
            get { return _BottomMargin; }
            set { _BottomMargin = value; }
        }

        public string NormalFontName
        {
            get { return _NormalFontName; }
            set { _NormalFontName = value; }
        }

        static private XSize DrawStringAndReturnSize(XGraphics Xgr, string Text, XFont TextFont, double X, double Y)
        {
            XSize ReturnValue = new XSize(0, 0);

            if (Text != null && Text != string.Empty)
            {
                ReturnValue = Xgr.MeasureString(Text, TextFont);
                Xgr.DrawString(Text, TextFont, XBrushes.Black, X, Y);
            }

            return ReturnValue;
        }

        static private XSize DrawAddress(XGraphics Xgr, BopsDestination Dest, XFont TextFont, double X, double Y)
        {
            XSize ReturnValue = new XSize(0, 0);

            XSize TextSize = DrawStringAndReturnSize(Xgr, Dest.Name, TextFont, X, Y + ReturnValue.Height);
            ReturnValue.Width = Math.Max(ReturnValue.Width, TextSize.Width);
            ReturnValue.Height += TextSize.Height;
            TextSize = DrawStringAndReturnSize(Xgr, Dest.StreetAddress1, TextFont, X, Y + ReturnValue.Height);
            ReturnValue.Width = Math.Max(ReturnValue.Width, TextSize.Width);
            ReturnValue.Height += TextSize.Height;
            TextSize = DrawStringAndReturnSize(Xgr, Dest.StreetAddress2, TextFont, X, Y + ReturnValue.Height);
            ReturnValue.Width = Math.Max(ReturnValue.Width, TextSize.Width);
            ReturnValue.Height += TextSize.Height;
            string CityStateZip = string.Format("{0}, {1} {2}", Dest.City, Dest.State.ToUpper(), Dest.Zip);
            TextSize = DrawStringAndReturnSize(Xgr, CityStateZip, TextFont, X, Y + ReturnValue.Height);
            ReturnValue.Width = Math.Max(ReturnValue.Width, TextSize.Width);
            ReturnValue.Height += TextSize.Height;

            return ReturnValue;
        }

        static private void DrawWatermark(PdfPage TargetPage, XGraphics Xgr, XFont WatermarkFont, string WatermarkText)
        {
            // Variation 1: Draw watermark as text string
            //XGraphicsState PreWatermark = Xgr.Save();

            // Get the size (in point) of the text
            XSize size = Xgr.MeasureString(WatermarkText, WatermarkFont);

            // Define a rotation transformation at the center of the page
            Xgr.TranslateTransform(TargetPage.Width / 2, TargetPage.Height / 2);
            Xgr.RotateTransform(-Math.Atan(TargetPage.Height / TargetPage.Width) * 180 / Math.PI);
            Xgr.TranslateTransform(-TargetPage.Width / 2, -TargetPage.Height / 2);

            // Create a string format
            XStringFormat format = new XStringFormat();
            format.Alignment = XStringAlignment.Near;
            format.LineAlignment = XLineAlignment.Near;

            // Create a dimmed red brush
            XBrush brush = new XSolidBrush(XColor.FromArgb(128, 128, 128, 128));

            // Draw the string
            Xgr.DrawString(WatermarkText, WatermarkFont, brush,
              new XPoint((TargetPage.Width - size.Width) / 2, (TargetPage.Height - size.Height) / 2), format);

            //Xgr.Restore(PreWatermark);
        }

        public PdfDocument CreateInvoicePdf(BopsRfsInvoice Invoice, BopsDestination BillToClient, BopsDestination ShipperClient,
            IEnumerable<BopsRfsInvoiceDetail> InvoiceLines)
        {
            // PDF Sharp page coordinates are specified in points.

            double X = _LeftMargin, Y = _TopMargin;
            PdfDocument Pdf = new PdfDocument();
            PdfPage Page = new PdfPage();
            Pdf.Pages.Add(Page);
            XRect PageRect = new XRect(_LeftMargin, _TopMargin, Page.Width - (_LeftMargin + _RightMargin), Page.Height - (_TopMargin + _BottomMargin));
            XGraphics Xgr = XGraphics.FromPdfPage(Pdf.Pages[0]);

            // Draw the page framing rectangle and the Budway logo.
            // NB:  I can't just draw the rectangle over the logo; the transparent brush doesn't seem to be working.
            //      That's why I'm redrawing lines over the logo below.

            double LogoHeight = 90; // Stupid, magic number to let the temporary art work.
            XImage Logo = XImage.FromFile(@"PDF Assets\Invoice Budway Logo.png");
            //Xgr.DrawImage(Logo, PageRect.Left + 1, PageRect.Top + 1, PageRect.Width - 2, LogoHeight);
            Xgr.DrawRectangle(XPens.Black, XBrushes.Transparent, PageRect);
            Xgr.DrawImage(Logo, PageRect.Left, PageRect.Top, PageRect.Width, LogoHeight);
            Xgr.DrawLine(XPens.Black, PageRect.Left, PageRect.Top, PageRect.Right, PageRect.Top);
            Xgr.DrawLine(XPens.Black, PageRect.Left, PageRect.Top, PageRect.Left, PageRect.Bottom);
            Xgr.DrawLine(XPens.Black, PageRect.Right, PageRect.Top, PageRect.Right, PageRect.Bottom);
            Y += LogoHeight + _VerticalSpace;

            // Draw the page footer showing the payment terms, total, etc.

            const string TermsString = "Terms: Net 7 Days";
            const string RemitToLine = "Remit to Budway Enterprises, Inc., 13600 Napa Street, Fontana, CA 92335.";
            string[] LegalStuff = new string[]
            {
                "Failure to pay charges may result in a lien on future shipments, including the cost of storage and appropriate security for ",
                "subsequent shipments held pursuant to section 3051.5 of the California Civil Code. Failure to pay freight charges and other ",
                "charges within the specified terms may revoke your credit privilege and all discounts (if any) shown on the freight bill."
            };
            string TotalString = string.Format("Total Due: {0:c}", Invoice.InvoiceTotal);

            XFont RemitFont = new XFont(_NormalFontName, 14, XFontStyle.Bold);
            XFont LegalFont = new XFont(_NormalFontName, 10, XFontStyle.Italic);
            XSize LegalStuffSize = new XSize(0, 0);
            foreach (string s in LegalStuff)
            {
                XSize LegalSize = Xgr.MeasureString(s, LegalFont);
                LegalStuffSize.Width = Math.Max(LegalStuffSize.Width, LegalSize.Width);
                LegalStuffSize.Height += LegalSize.Height;
            }

            double LegalY = PageRect.Bottom - LegalStuffSize.Height - 1;
            double RemitBottom = LegalY - 1;
            foreach (string s in LegalStuff)
            {
                XSize TextSize = Xgr.MeasureString(s, LegalFont);
                XRect TextRect = new XRect(PageRect.Left, LegalY, PageRect.Width, TextSize.Height);
                Xgr.DrawString(s, LegalFont, XBrushes.Black, TextRect, XStringFormats.Center);
                LegalY += TextSize.Height;
            }

            XSize RemitSize = Xgr.MeasureString(RemitToLine, RemitFont, XStringFormats.Center);
            double RemitTop = RemitBottom - RemitSize.Height;
            XRect RemitRect = new XRect(PageRect.Left, RemitTop, PageRect.Width, RemitBottom - RemitTop);
            Xgr.DrawString(RemitToLine, RemitFont, XBrushes.Black, RemitRect, XStringFormats.Center);

            XFont TermsAndTotalFont = new XFont(_NormalFontName, 12, XFontStyle.Bold);
            XSize TermsSize = Xgr.MeasureString(TermsString, TermsAndTotalFont);
            double TermsAndTotalBottom = RemitTop - 1;
            XRect TermsAndTotalRect = new XRect(PageRect.Left, TermsAndTotalBottom - TermsSize.Height, PageRect.Width, TermsSize.Height);
            Xgr.DrawRectangle(XPens.Black, XBrushes.Black, TermsAndTotalRect);
            Xgr.DrawString(TermsString, TermsAndTotalFont, XBrushes.White, TermsAndTotalRect.Left + _HorizontalSpace, TermsAndTotalRect.Top, XStringFormats.TopLeft);
            XSize TotalSize = Xgr.MeasureString(TotalString, TermsAndTotalFont);
            Xgr.DrawString(TotalString, TermsAndTotalFont, XBrushes.White, TermsAndTotalRect.Right - (TotalSize.Width + _HorizontalSpace), TermsAndTotalRect.Top, XStringFormats.TopLeft);

            // Draw the addresses box: the bill-to on the left and the shipper on the right.

            double AddressBoxesTop = Y;
            Xgr.DrawLine(XPens.Black, PageRect.Left, Y, PageRect.Right, Y);
            Y += _VerticalSpace;
            double HCenter = Page.Width / 2;
            XFont TitleFont = new XFont(_NormalFontName, 12, XFontStyle.Bold | XFontStyle.Underline);
            Xgr.DrawString("Bill To", TitleFont, XBrushes.Black, X + _HorizontalSpace, Y);
            Xgr.DrawString("Shipper", TitleFont, XBrushes.Black, HCenter + _HorizontalSpace, Y);
            XSize TitleSize = Xgr.MeasureString("Bill To", TitleFont);
            Y += TitleSize.Height;
            XFont NormalFont = new XFont(_NormalFontName, 10, XFontStyle.Regular);
            XSize BillToAddressSize = DrawAddress(Xgr, BillToClient, NormalFont, X + _HorizontalSpace * 2, Y);
            XSize ShipperAddressSize = DrawAddress(Xgr, ShipperClient, NormalFont, HCenter + _HorizontalSpace * 2, Y);
            Y += Math.Max(BillToAddressSize.Height, ShipperAddressSize.Height);
            Xgr.DrawLine(XPens.Black, PageRect.Left, Y, PageRect.Right, Y);
            Xgr.DrawLine(XPens.Black, HCenter, AddressBoxesTop, HCenter, Y);

            // Draw the invoice detail header, a black rectangle with inverse text.

            const string InvoiceDetailString = "Invoice Detail";
            XFont InvoiceFont = new XFont(_NormalFontName, 12, XFontStyle.Bold);
            XSize InvoiceDetailHeaderSize = Xgr.MeasureString(InvoiceDetailString, InvoiceFont);
            Xgr.DrawRectangle(XPens.Black, XBrushes.Black, PageRect.Left, Y, PageRect.Width, InvoiceDetailHeaderSize.Height);
            Xgr.DrawString(InvoiceDetailString, InvoiceFont, XBrushes.White, PageRect.Left + _HorizontalSpace, Y, XStringFormats.TopLeft);
            Y += InvoiceDetailHeaderSize.Height + _VerticalSpace / 2;

            // Draw the actual invoice details.

            XFont InvoiceDetailFont = new XFont(_NormalFontName, 12, XFontStyle.Regular);
            XSize LineSize = Xgr.MeasureString("8888", InvoiceDetailFont);
            XSize AmountSize = Xgr.MeasureString("$ 888,888.88", InvoiceDetailFont);
            double LineX = PageRect.Left + _HorizontalSpace;
            double DescriptionX = LineX + LineSize.Width + _HorizontalSpace;
            double AmountX = PageRect.Right - _VerticalSpace - AmountSize.Width;
            List<BopsRfsInvoiceDetail> SortedLines = new List<BopsRfsInvoiceDetail>(InvoiceLines);
            SortedLines.Sort(new InvoiceLinesSorter());

            XFont InvoiceDetailHeaderFont = new XFont(_NormalFontName, 12, XFontStyle.Underline);
            XSize InvoiceDetailLinesHeaderSize = Xgr.MeasureString("Line", InvoiceDetailHeaderFont);
            Xgr.DrawString("Line", InvoiceDetailHeaderFont, XBrushes.Black, LineX, Y, XStringFormats.TopLeft);
            Xgr.DrawString("Description", InvoiceDetailHeaderFont, XBrushes.Black, DescriptionX, Y, XStringFormats.TopLeft);
            Xgr.DrawString("Amount", InvoiceDetailHeaderFont, XBrushes.Black, AmountX, Y, XStringFormats.TopLeft);
            Y += InvoiceDetailLinesHeaderSize.Height;

            foreach (BopsRfsInvoiceDetail line in SortedLines)
            {
                Xgr.DrawString(line.LineNumber.ToString(), InvoiceDetailFont, XBrushes.Black, LineX, Y, XStringFormats.TopLeft);
                Xgr.DrawString(string.Format("{0:c}", line.ItemTotal), InvoiceDetailFont, XBrushes.Black, AmountX, Y, XStringFormats.TopLeft);
                XSize DescriptionSize = Xgr.MeasureString(line.ItemDescription, InvoiceDetailFont);
                double NumberOfLines = Math.Ceiling(DescriptionSize.Width / (AmountX - DescriptionX));
                XRect DescriptionRect = new XRect(DescriptionX, Y, AmountX - DescriptionX, LineSize.Height * NumberOfLines);
                XTextFormatter DescriptionFormatter = new XTextFormatter(Xgr);
                DescriptionFormatter.DrawString(line.ItemDescription, InvoiceDetailFont, XBrushes.Black, DescriptionRect, XStringFormats.TopLeft);
                Y += DescriptionRect.Height;
            }

            if (Invoice.InvoiceStatus < RfsInvoiceStatus.Closed)
            {
                XFont WatermarkFont = new XFont(_NormalFontName, 108);
                DrawWatermark(Pdf.Pages[0], Xgr, WatermarkFont, "DRAFT COPY");
            }

            return Pdf;
        }
    }
}
