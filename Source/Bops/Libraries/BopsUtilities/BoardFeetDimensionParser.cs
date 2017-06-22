using System.Text;
using System.Text.RegularExpressions;

namespace BopsUtilities
{
    /// <summary>
    /// This class parses board feet dimensions of the form "Thickness x Length x Width". Each of the three
    /// dimensions may be a decmial number, a fraction, or a whole number with a fraction. Inches or feet may
    /// optionally be specified using "in" or "ft" respectively. Inches are assumed if no units are 
    /// specified. All units returned by the class properties are in inches.
    /// </summary>
    public class BoardFeetDimensionParser
    {
        # region Fields and Properties

        private string _Error;
        private double _Thickness;
        private double _Length;
        private double _Width;

        public string Error
        {
            get { return _Error; }
            set { _Error = value; }
        }

        public double Thickness
        {
            get { return _Thickness; }
            set { _Thickness = value; }
        }

        public double Length
        {
            get { return _Length; }
            set { _Length = value; }
        }

        public double Width
        {
            get { return _Width; }
            set { _Width = value; }
        }

        public double SheetBoardFeet
        {
            get
            {
                return (_Thickness * _Length * _Width) / 144;
            }
        }

        #endregion

        public BoardFeetDimensionParser(string Dimensions)
        {
            // The algorithm is a straightforward bit of divide and conquer. We split the string into an
            // array of parts, delimited by the letter 'x'. If we find something other than three dimensions
            // we bail; otherwise, we call helper routines to parse each dimension individually and we
            // accumulate any errors in a string builder object. If the string builder isn't empty at the
            // end of the process then something has gone wrong, in which case we set the error field and
            // clear the dimension fields.

            string[] Parts = Dimensions.ToLower().Split('x');

            if (Parts.Length != 3)
            {
                _Error = string.Format("Thickness x Length x Width expected: {0}", Dimensions);
            }
            else
            {
                StringBuilder Sb = new StringBuilder();

                if (!ParseDimension(Parts[0].Trim(), out _Thickness))
                    Sb.AppendFormat("Could not parse thickness: {0}. ", Parts[0]);
                if (!ParseDimension(Parts[1].Trim(), out _Length))
                    Sb.AppendFormat("Could not parse length: {0}. ", Parts[1]);
                if (!ParseDimension(Parts[2].Trim(), out _Width))
                    Sb.AppendFormat("Could not parse width: {0}. ", Parts[2]);

                if (Sb.Length > 0)
                {
                    _Error = Sb.ToString();
                    _Thickness = _Length = _Width = 0.0;
                }
            }
        }

        private static double ParseFraction(string Text)
        {
            Regex Rx = new Regex("(?<Numerator>[0-9]+)/(?<Denominator>[0-9]+)");
            Match M = Rx.Match(Text);
            double Numerator, Denominator, ReturnValue = 0.0;

            if (M.Success && 
                double.TryParse(M.Groups["Numerator"].ToString(), out Numerator) &&
                double.TryParse(M.Groups["Denominator"].ToString(), out Denominator))
            {
                ReturnValue = Numerator / Denominator;
            }

            return ReturnValue;
        }

        private static double ParseWholeAndFraction(string Text)
        {
            double ReturnValue = 0.0;
            Regex Rx = new Regex("(?<Whole>[0-9]+)[ \t]+(?<Fraction>[0-9]+/[0-9]+)");
            Match M = Rx.Match(Text);
            
            if (M.Groups["Whole"].ToString() != string.Empty && M.Groups["Fraction"].ToString() != string.Empty)
            {
                double Fraction = ParseFraction(M.Groups["Fraction"].ToString());
                if (Fraction != 0.0)
                {
                    double Whole;
                    if (double.TryParse(M.Groups["Whole"].ToString().Trim(), out Whole))
                        ReturnValue = Whole + Fraction;
                }
            }

            return ReturnValue;
        }

        private static bool ParseDimension(string Part, out double ReturnValue)
        {
            // This main helper routine uses a particular regular expression to recognize its input as a
            // decimal number (which includes integers), fractions of the form "x/y", and fractions of the
            // form "x y/z". For decimals we rely on the .NET framework; for the others we rely on helper
            // methods for greater clarity. Assuming we succeeded in parsing, all that remains is to convert
            // inches to feet if required and return.

            ReturnValue = 0.0;
            Regex Rx1 = new Regex("((?<WholeAndFraction>[0-9]+[ \\t]+[0-9]+/[0-9]+)|(?<Fraction>[0-9]+/[0-9]+)|(?<Decimal>[0-9]+(\\.[0-9]+)?))(?<Unit>[ \t]*(ft|in))?$");
            Match M = Rx1.Match(Part);

            // If we can't find a number of any format, we've failed altogether.

            if (!M.Success) return false;
            bool Success = false;
            bool Feet = (M.Groups["Unit"].ToString().Trim() == "ft");

            if (M.Groups["Decimal"].ToString() != string.Empty)
            {
                Success = double.TryParse(Part.Trim("ftin".ToCharArray()), out ReturnValue);
            }
            else if (M.Groups["WholeAndFraction"].ToString() != string.Empty)
            {
                ReturnValue = ParseWholeAndFraction(M.Groups["WholeAndFraction"].ToString().Trim("ftin".ToCharArray()));
                Success = (ReturnValue != 0.0);
            }
            else if (M.Groups["Fraction"].ToString() != string.Empty)
            {
                ReturnValue = ParseFraction(M.Groups["Fraction"].ToString().Trim().Trim("ftin".ToCharArray()));
                Success = (ReturnValue != 0.0);
            }

            // Convert feet to inches if necessary.

            if (Success && Feet)
                ReturnValue *= 12.0;

            return Success;
        }

        /// <summary>
        /// To calculate thousand board feet, we multiply the supplied piece count by the individual
        /// sheet board feet (the product of the dimensions parsed divided by the number of square inches
        /// in a square foot) and divide by one-thousand.
        /// </summary>
        /// <param name="PieceCount"></param>
        /// <returns></returns>
        public double CalculateThousandBoardFeet(int PieceCount)
        {
            return (SheetBoardFeet * PieceCount) / 1000;
        }
    }
}
