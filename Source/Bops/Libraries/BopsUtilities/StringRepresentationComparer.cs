using System;
using System.Collections;
using System.Globalization;

namespace BopsUtilities
{
    public class StringRepresentationComparer : IComparer
    {
        public enum SortType
        {
            String,
            Integer,
            Double,
            Currency,   // Sorts the same as a double but copes with currency formatting.
            Date
        }

        public enum SortDirection
        {
            None,
            Ascending,
            Descending
        }

        private SortType _CompareSortType;
        private SortDirection _CompareSortDirection;

        public SortType CompareSortType
        {
            get { return _CompareSortType; }
            set { _CompareSortType = value; }
        }

        public SortDirection CompareSortDirection
        {
            get { return _CompareSortDirection; }
            set { _CompareSortDirection = value; }
        }

        public StringRepresentationComparer(SortType CompareSortType, SortDirection CompareSortDirection)
        {
            _CompareSortType = CompareSortType;
            _CompareSortDirection = CompareSortDirection;
        }

        public int Compare(object X, object Y)
        {
            int ReturnValue = 0;

            bool Parsed = false;
            string Left = X as string;
            string Right = Y as string;

            switch (_CompareSortType)
            {
                case SortType.Integer:
                    int LeftInt, RightInt;
                    if (int.TryParse(Left, out LeftInt) && int.TryParse(Right, out RightInt))
                    {
                        if (LeftInt < RightInt)
                            ReturnValue = -1;
                        else if (LeftInt > RightInt)
                            ReturnValue = 1;
                        else
                            ReturnValue = 0;
                        Parsed = true;
                    }
                    break;
                case SortType.Double:
                    double LeftDouble, RightDouble;
                    if (double.TryParse(Left, out LeftDouble) && double.TryParse(Right, out RightDouble))
                    {
                        if (LeftDouble < RightDouble)
                            ReturnValue = -1;
                        else if (LeftDouble > RightDouble)
                            ReturnValue = 1;
                        else
                            ReturnValue = 0;
                        Parsed = true;
                    }
                    break;
                case SortType.Currency:
                    double LeftCurrency, RightCurrency;
                    IFormatProvider Culture = new CultureInfo("En-US", true);
                    if (double.TryParse(Left, NumberStyles.Currency, Culture, out LeftCurrency) && double.TryParse(Right, NumberStyles.Currency, Culture, out RightCurrency))
                    {
                        if (LeftCurrency < RightCurrency)
                            ReturnValue = -1;
                        else if (LeftCurrency > RightCurrency)
                            ReturnValue = 1;
                        else
                            ReturnValue = 0;
                        Parsed = true;
                    }
                    break;
                case SortType.Date:
                    DateTime LeftDate, RightDate;
                    if (DateTime.TryParse(Left, out LeftDate) && DateTime.TryParse(Right, out RightDate))
                    {
                        if (LeftDate < RightDate)
                            ReturnValue = -1;
                        else if (LeftDate > RightDate)
                            ReturnValue = 1;
                        else
                            ReturnValue = 0;
                        Parsed = true;
                    }
                    break;
            }

            // If the values weren't parsed above, then we punt to a basic string compare.

            if (!Parsed)
                ReturnValue = string.Compare(Left, Right);

            // Finally, invert the return value's sign if we're supposed to sort descending.

            if (_CompareSortDirection == SortDirection.Descending)
                ReturnValue = -ReturnValue;

            return ReturnValue;

        }
    }
}
