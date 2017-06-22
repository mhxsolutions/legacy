using System;
using System.Collections;
using System.Globalization;
using System.Windows.Forms;

namespace BopsUtilities
{
    #region Helper Classes 

    internal class ListViewItemComparer : IComparer
    {
        private readonly int _Column;
        private readonly ListViewComparerFactory.ColumnSortDirection _SortDirection;
        private readonly ListViewComparerFactory.ColumnSortType _SortType;

        public ListViewItemComparer(int Column)
            : this(Column, ListViewComparerFactory.ColumnSortDirection.Ascending, ListViewComparerFactory.ColumnSortType.String)
        {
        }

        public ListViewItemComparer(int Column, ListViewComparerFactory.ColumnSortDirection SortDirection)
            : this(Column, SortDirection, ListViewComparerFactory.ColumnSortType.String)
        {
        }

        public ListViewItemComparer(int Column, ListViewComparerFactory.ColumnSortType SortType)
            : this(Column, ListViewComparerFactory.ColumnSortDirection.Ascending, SortType)
        {
        }

        public ListViewItemComparer(int Column, ListViewComparerFactory.ColumnSortDirection SortDirection, ListViewComparerFactory.ColumnSortType SortType)
        {
            if (Column < 0)
                throw new ArgumentException("Column number must be greater than or equal to zero", "Column");
            if (SortDirection == ListViewComparerFactory.ColumnSortDirection.None)
                throw new ArgumentException("Sort direction must not be none", "SortDirection");

            _Column = Column;
            _SortDirection = SortDirection;
            _SortType = SortType;
        }

        public int Compare(object X, object Y)
        {
            int ReturnValue = 0;

            bool Parsed = false;
            string Left = ((ListViewItem)X).SubItems[_Column].Text;
            string Right = ((ListViewItem)Y).SubItems[_Column].Text;

            switch (_SortType)
            {
                case ListViewComparerFactory.ColumnSortType.Integer:
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
                case ListViewComparerFactory.ColumnSortType.Double:
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
                case ListViewComparerFactory.ColumnSortType.Currency:
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
                case ListViewComparerFactory.ColumnSortType.Date:
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

            if (_SortDirection == ListViewComparerFactory.ColumnSortDirection.Descending)
                ReturnValue = -ReturnValue;
                
            return ReturnValue;
        }
    }

    #endregion

    public class ListViewComparerFactory
    {
        public enum ColumnSortType
        {
            String,
            Integer,
            Double,
            Currency,   // Sorts the same as a double but copes with currency formatting.
            Date
        }

        public enum ColumnSortDirection
        {
            None,
            Ascending,
            Descending
        }

        public class ColumnDetails
        {
            private ColumnSortDirection _SortDirection;
            private ColumnSortType _SortType;

            public ColumnDetails()
                : this(ColumnSortDirection.None, ColumnSortType.String)
            {
            }

            public ColumnDetails(ColumnSortDirection SortDirection)
                : this(SortDirection, ColumnSortType.String)
            {
            }

            public ColumnDetails(ColumnSortType SortType)
                : this(ColumnSortDirection.None, SortType)
            {
            }

            public ColumnDetails(ColumnSortDirection SortDirection, ColumnSortType SortType)
            {
                _SortDirection = SortDirection;
                _SortType = SortType;
            }

            public ColumnSortDirection SortDirection
            {
                get { return _SortDirection; }
                set { _SortDirection = value; }
            }

            public ColumnSortType SortType
            {
                get { return _SortType; }
                set { _SortType = value; }
            }
        }

        private readonly ColumnDetails[] _Columns;

        private void ValidateColumnNumber(int ColumnNumber)
        {
            if (0 > ColumnNumber || ColumnNumber >= _Columns.Length)
                throw new ArgumentOutOfRangeException("ColumnNumber");
        }

        private void ResetColumnSortDirections()
        {
            for (int I = 0; I < _Columns.Length; I++)
                _Columns[I].SortDirection = ColumnSortDirection.None;
        }

        public ColumnDetails this[int ColumnNumber]
        {
            get
            {
                ValidateColumnNumber(ColumnNumber);
                return _Columns[ColumnNumber];
            }

            set
            {
                ValidateColumnNumber(ColumnNumber);
                _Columns[ColumnNumber] = value;
            }
        }

        public ListViewComparerFactory(int ColumnCount)
        {
            _Columns = new ColumnDetails[ColumnCount];
            for (int I = 0; I < _Columns.Length; I++)
                _Columns[I] = new ColumnDetails();
        }

        public IComparer CreateComparerForColumn(int ColumnNumber)
        {
            ValidateColumnNumber(ColumnNumber);

            // Initially, all the column sort directions will be set to none, indicating an unsorted state.
            // As such, a value of none or descending should result in ascending, whereas a value of ascending
            // should result in descending. Once the value has been determined, we plug it into the column data
            // for future reference and return the comparer therefrom. Whatever the case, we reset all the
            // column sort settings after determining the new sort direction.

            ColumnSortDirection NewDirection = (_Columns[ColumnNumber].SortDirection == ColumnSortDirection.Ascending) ? ColumnSortDirection.Descending : ColumnSortDirection.Ascending;

            ResetColumnSortDirections();
            _Columns[ColumnNumber].SortDirection = NewDirection;
            return new ListViewItemComparer(ColumnNumber, _Columns[ColumnNumber].SortDirection, _Columns[ColumnNumber].SortType);
        }
    }
}
