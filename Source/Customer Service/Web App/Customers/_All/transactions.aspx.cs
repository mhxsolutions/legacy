using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

public partial class Customers__All_transactions : System.Web.UI.Page
{
    // NB: The following two constants must be maintained in sync with the gridview declaration or the page will break.

    private const int _CountTotalColumnIndex = 7;   // Hard-coded zero-based column index of the count totals column in the gridview.
    private const int _FeetTotalColumnIndex = 10;   // Hard-coded zero-based column index of the feet totals column in the gridview.

    private Dictionary<string, int> _CountTotals;
    private Dictionary<string, int> _FeetTotals;

    protected void Page_Load(object Sender, EventArgs E)
    {
        _CountTotals = new Dictionary<string, int>();
        _FeetTotals = new Dictionary<string, int>();
    }

    // Gets an overall delta for a pair of in/out columns in the gridview, returning zero if no data is available.

    private static int GetDelta(DataRowView Row, string InColumn, string OutColumn)
    {
        int Delta = 0;

        if (Row[InColumn] != null && Row[InColumn] != DBNull.Value)
            Delta += Convert.ToInt32(Row[InColumn]);
        if (Row[OutColumn] != null && Row[OutColumn] != DBNull.Value)
            Delta -= Convert.ToInt32(Row[OutColumn]);

        return Delta;
    }

    // Gets the text of a particular column in the data row, returning null if no data is available.

    private static string GetColumnString(DataRowView Row, string Column)
    {
        return (Row[Column] != null && Row[Column] != DBNull.Value) ? Row[Column].ToString() : null;
    }

    // Updates the row totals text and the corresponding totals dictionary.

    private static void UpdateRowAndTotals(string Key, int Delta, Dictionary<string, int> Totals, GridViewRowEventArgs EventArgs, int ColumnIndex)
    {
        // There are two cases to deal with. In the event that the delta is zero, that means that no in/out data was available
        // or couldn't be retrieved for some reason. In that case, we try to get the current total from the dictionary (if any)
        // and update the column text with it if found.

        if (Delta == 0)
        {
            if (!Totals.ContainsKey(Key)) return;
            EventArgs.Row.Cells[ColumnIndex].Text = Totals[Key].ToString();
        }

        // If a non-zero delta is supplied, then we get/create the corresponding entry in the data dictionary and update it 
        // and the column text accordingly.

        else
        {
            int NewValue;

            if (Totals.ContainsKey(Key))
            {
                NewValue = Totals[Key] + Delta;
                Totals[Key] = NewValue;
            }
            else
            {
                NewValue = Delta;
                Totals.Add(Key, NewValue);
            }

            EventArgs.Row.Cells[ColumnIndex].Text = NewValue.ToString();
        }
    }

    protected void GridView1_RowDataBound(object Sender, GridViewRowEventArgs E)
    {
        // If we're not dealing with data rows, get out of here.

        if (E.Row.RowType != DataControlRowType.DataRow)
            return;

        // Otherwise the algorithm is pretty simple:
        //
        //  1. Get the count and feet deltas from the relevant columns.
        //  2. Formulate a lookup key based on the PG1/PG2/PG3 tuple.
        //  3. Update the row and totals using the gathered information.

        DataRowView Row = E.Row.DataItem as DataRowView;
        int CountDelta = GetDelta(Row, "Item_Ct_In", "Item_Ct_Out");
        int FeetDelta = GetDelta(Row, "Linear Ft In", "Linear Ft Out");
        string Key = string.Format("{0}|{1}|{2}", GetColumnString(Row, "Group_1"), GetColumnString(Row, "Group_2"), GetColumnString(Row, "Group_3")).ToLower();
        UpdateRowAndTotals(Key, CountDelta, _CountTotals, E, _CountTotalColumnIndex);
        UpdateRowAndTotals(Key, FeetDelta, _FeetTotals, E, _FeetTotalColumnIndex);
    }
}
