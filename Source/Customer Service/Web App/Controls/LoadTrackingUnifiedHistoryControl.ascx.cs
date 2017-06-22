using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_LoadTrackingUnifiedHistoryControl : UserControl
{
    private const int _NumberAgilisEvent = -1;
    private const int _NumberPod = -2;
    private const int _ColumnOneWidth = 200;
    private const int _ColumnTwoWidth = 330;

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
        string[] Headers = new string[2]{ "Event", "Time" };

        TableRow r = new TableRow();

        foreach (string s in Headers)
        {
            TableCell c = new TableCell();
            LiteralControl l = new LiteralControl(s);
            c.Controls.Add(l);
            r.Cells.Add(c);
        }

        UnifiedHistoryTable.Rows.Add(r);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ConfigureTable();

        using (SqlConnection Connection = new SqlConnection(_DatabaseConnection))
        {
            using (SqlCommand Command = new SqlCommand("BopsGetUnifiedLoadHistory", Connection))
            {
                Connection.Open();

                Command.CommandType = CommandType.StoredProcedure;
                Command.Parameters.Add("@LoadReference", SqlDbType.VarChar).Value = LoadReference;

                using (SqlDataReader Reader = Command.ExecuteReader())
                {
                    while (Reader.Read())
                    {
                        string Description = Reader["Description"].ToString();

                        DateTime? Timestamp = null;
                        if (Reader["Timestamp"].GetType()!= typeof(DBNull))
                            Timestamp = Convert.ToDateTime(Reader["Timestamp"]);

                        int Number = Convert.ToInt32(Reader["Number"]);
                        string Folder = Reader["Folder"].ToString();
                        string FileName = Reader["FileName"].ToString();

                        TableRow r = new TableRow();
                        string TimeString = Timestamp.HasValue ? Timestamp.ToString() : "(unknown)";

                        switch (Number)
                        {
                            case _NumberAgilisEvent:
                                AddNormalCell(r, Description, _ColumnOneWidth);
                                AddNormalCell(r, TimeString, _ColumnTwoWidth);
                                break;
                            case _NumberPod:
                                AddHyperlinkCell(r, Description, MakePodNavigationUrl(Folder), _ColumnOneWidth);
                                AddNormalCell(r, TimeString, _ColumnTwoWidth);
                                break;
                            default:
                                AddImageCell(r, Description, MakeSignatureUrl(Folder, FileName), _ColumnOneWidth);
                                //AddHyperlinkCell(r, Description, Path.Combine(Folder, FileName), _ColumnOneWidth);
                                AddNormalCell(r, TimeString, _ColumnTwoWidth);
                                break;
                        }
                        
                        UnifiedHistoryTable.Rows.Add(r);
                    }

                    Reader.Close();
                }

                Connection.Close();
            }
        }

    }

    private void AddImageCell(TableRow Row, string Text, string ImageUrl, int Width)
    {
        TableCell c = new TableCell();
        Image i = new Image();
        i.ImageUrl = ImageUrl;
        i.AlternateText = Text;
        c.VerticalAlign = VerticalAlign.Top;
        c.Width = Width;
        c.Controls.Add(i);
        Row.Cells.Add(c);
    }

    /*
     * Because the data in the scans table was originally intended for Microsoft Access, the
     * folders are in the format: [LoadRef]#[Path]#. This formatting causes Access to display
     * the [LoadRef] value as a hyperlink with a navigation URL target of [Path]. The job of
     * this routine is to strip off that stuff and return a properly formatted URL.
     * 
     * Internally, the PODs are at UNC name: \\FS1\scans\Indexed PODs\. Publically, they
     * are available at http://budwaydirect.com/PODs/Indexed PODs/. So the trick is to convert
     * the internal format into the external format.
     */

    private string MakePodNavigationUrl(string Folder)
    {
        int PoundIndex = Folder.IndexOf('#');
        if (PoundIndex != -1)
        {
            // First, strip off the Access junk.
            string InternalFilename = Folder.Substring(PoundIndex + 1).TrimEnd('#');

            // Next, convert all the backslashes to forward slashes for proper web etiquette.
            string ExternalUrl = InternalFilename.Replace('\\', '/');

            // Next, replace the internal path with the public path.
            Regex PathRx = new Regex(@"//FS1/scans/", RegexOptions.IgnoreCase);
            return PathRx.Replace(ExternalUrl, "http://budwaydirect.com/PODs/");
        }

        return string.Empty;
    }

    private string MakeSignatureUrl(string Folder, string Filename)
    {
        // Next, convert all the backslashes to forward slashes for proper web etiquette.
        string ExternalUrl = Folder.Replace('\\', '/') + '/' + Filename;

        // Next, replace the internal path with the public path.
        Regex PathRx = new Regex(@"//FS1/scans/Agilis Signatures/", RegexOptions.IgnoreCase);
        return PathRx.Replace(ExternalUrl, "http://budwaydirect.com/Signatures/");
    }

    private void AddHyperlinkCell(TableRow Row, string Text, string Url, int Width)
    {
        HyperLink Link = new HyperLink();
        Link.Target = "_blank";
        Link.NavigateUrl = Url;
        Link.Text = Text;

        TableCell c = new TableCell();
        c.VerticalAlign = VerticalAlign.Top;
        c.Width = Width;
        c.Controls.Add(Link);
        Row.Cells.Add(c);
    }

    private void AddNormalCell(TableRow Row, string Text, int Width)
    {
        TableCell c = new TableCell();
        c.VerticalAlign = VerticalAlign.Top;
        c.Width = Width;
        c.Controls.Add(new LiteralControl(Text));
        Row.Cells.Add(c);
    }
}
