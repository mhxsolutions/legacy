using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_App.Controls
{
    public partial class LoadTrackingUnifiedHistoryControl : UserControl
    {
        private const int NumberAgilisEvent = -1;
        private const int NumberPod = -2;
        private const int ColumnOneWidth = 200;
        private const int ColumnTwoWidth = 330;

        public string LoadReference { get; set; }

        public string DatabaseConnection { get; set; }

        private void ConfigureTable()
        {
            var headers = new string[] { "Event", "Time" };

            var r = new TableRow();

            foreach (var s in headers)
            {
                var c = new TableCell();
                var l = new LiteralControl(s);
                c.Controls.Add(l);
                r.Cells.Add(c);
            }

            UnifiedHistoryTable.Rows.Add(r);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ConfigureTable();

            using (var connection = new SqlConnection(DatabaseConnection))
            {
                using (var command = new SqlCommand("BopsGetUnifiedLoadHistory", connection))
                {
                    connection.Open();

                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@LoadReference", SqlDbType.VarChar).Value = LoadReference;

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var description = reader["Description"].ToString();

                            DateTime? timestamp = null;
                            if (reader["Timestamp"].GetType()!= typeof(DBNull))
                                timestamp = Convert.ToDateTime(reader["Timestamp"]);

                            var number = Convert.ToInt32(reader["Number"]);
                            var folder = reader["Folder"].ToString();
                            var fileName = reader["FileName"].ToString();

                            var r = new TableRow();
                            var timeString = timestamp.HasValue ? timestamp.ToString() : "(unknown)";

                            switch (number)
                            {
                                case NumberAgilisEvent:
                                    AddNormalCell(r, description, ColumnOneWidth);
                                    AddNormalCell(r, timeString, ColumnTwoWidth);
                                    break;
                                case NumberPod:
                                    AddHyperlinkCell(r, description, MakePodNavigationUrl(folder), ColumnOneWidth);
                                    AddNormalCell(r, timeString, ColumnTwoWidth);
                                    break;
                                default:
                                    AddImageCell(r, description, MakeSignatureUrl(folder, fileName), ColumnOneWidth);
                                    //AddHyperlinkCell(r, Description, Path.Combine(Folder, FileName), _ColumnOneWidth);
                                    AddNormalCell(r, timeString, ColumnTwoWidth);
                                    break;
                            }
                        
                            UnifiedHistoryTable.Rows.Add(r);
                        }

                        reader.Close();
                    }

                    connection.Close();
                }
            }

        }

        private void AddImageCell(TableRow row, string text, string imageUrl, int width)
        {
            var c = new TableCell();
            var i = new Image { ImageUrl = imageUrl, AlternateText = text };

            c.VerticalAlign = VerticalAlign.Top;
            c.Width = width;
            c.Controls.Add(i);
            row.Cells.Add(c);
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

        private string MakePodNavigationUrl(string folder)
        {
            var poundIndex = folder.IndexOf('#');
            if (poundIndex != -1)
            {
                // First, strip off the Access junk.

                var internalFilename = folder.Substring(poundIndex + 1).TrimEnd('#');

                // Next, convert all the backslashes to forward slashes for proper web etiquette.

                var externalUrl = internalFilename.Replace('\\', '/');

                // Next, replace the internal path with the public path.

                var pathRx = new Regex(@"//FS1/scans/", RegexOptions.IgnoreCase);
                return pathRx.Replace(externalUrl, "http://budwaydirect.com/PODs/");
            }

            return string.Empty;
        }

        private string MakeSignatureUrl(string folder, string filename)
        {
            // Next, convert all the backslashes to forward slashes for proper web etiquette.

            var externalUrl = folder.Replace('\\', '/') + '/' + filename;

            // Next, replace the internal path with the public path.

            var pathRx = new Regex(@"//FS1/scans/Agilis Signatures/", RegexOptions.IgnoreCase);

            return pathRx.Replace(externalUrl, "http://budwaydirect.com/Signatures/");
        }

        private void AddHyperlinkCell(TableRow row, string text, string url, int width)
        {
            var link = new HyperLink { Target = "_blank", NavigateUrl = url, Text = text };

            var c = new TableCell { VerticalAlign = VerticalAlign.Top, Width = width };

            c.Controls.Add(link);
            row.Cells.Add(c);
        }

        private void AddNormalCell(TableRow row, string text, int width)
        {
            var c = new TableCell { VerticalAlign = VerticalAlign.Top, Width = width };

            c.Controls.Add(new LiteralControl(text));
            row.Cells.Add(c);
        }
    }
}
