using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_LoadTrackingUnifiedLoadContentsControl : UserControl
{
    private const int _ColumnWidth = 200;

    private string _LoadReference;
    private string _DatabaseConnection;

    public string LoadReference
    {
        get { return _LoadReference; }
        set { _LoadReference = value; }
    }

    public string DatabaseConnection
    {
        get { return _DatabaseConnection; }
        set { _DatabaseConnection = value; }
    }

    private void ConfigureTable()
    {
        string[] Headers = new string[4] { "Type", "Count", "Description", "Weight" };

        TableRow r = new TableRow();

        foreach (string s in Headers)
        {
            TableCell c = new TableCell();
            LiteralControl l = new LiteralControl(s);
            c.Controls.Add(l);
            r.Cells.Add(c);
        }

        UnifiedContentsTable.Rows.Add(r);
    }

    private void AddNormalCell(TableRow Row, string Text, int Width)
    {
        TableCell c = new TableCell();
        c.VerticalAlign = VerticalAlign.Top;
        c.Width = Width;
        c.Controls.Add(new LiteralControl(Text));
        Row.Cells.Add(c);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ConfigureTable();

        using (SqlConnection Connection = new SqlConnection(_DatabaseConnection))
        {
            using (SqlCommand Command = new SqlCommand("BopsGetUnifiedLoadContents", Connection))
            {
                Connection.Open();

                Command.CommandType = CommandType.StoredProcedure;
                Command.Parameters.Add("@LoadReference", SqlDbType.VarChar).Value = LoadReference;

                using (SqlDataReader Reader = Command.ExecuteReader())
                {
                    while (Reader.Read())
                    {
                        string Type = Reader["Type"].ToString();
                        string Count = Reader["Count"].ToString();
                        string Description = Reader["Description"].ToString();
                        string Weight = Reader["Weight"].ToString();

                        TableRow r = new TableRow();
                        AddNormalCell(r, Type, 100);
                        AddNormalCell(r, Count, 100);
                        AddNormalCell(r, Description, 230);
                        AddNormalCell(r, Weight, 100);

                        UnifiedContentsTable.Rows.Add(r);
                    }

                    Reader.Close();
                }

                Connection.Close();
            }
        }
    }
}
