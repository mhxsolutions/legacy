using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Controls
{
    public partial class LoadTrackingUnifiedLoadContentsControl : UserControl
    {
        private const int ColumnWidth = 200;

        public string LoadReference { get; set; }

        public string DatabaseConnection { get; set; }

        private void ConfigureTable()
        {
            var headers = new string[] { "Type", "Count", "Description", "Weight" };

            var r = new TableRow();

            foreach (var s in headers)
            {
                var c = new TableCell();
                var l = new LiteralControl(s);
                c.Controls.Add(l);
                r.Cells.Add(c);
            }

            UnifiedContentsTable.Rows.Add(r);
        }

        private void AddNormalCell(TableRow row, string text, int width)
        {
            var c = new TableCell { VerticalAlign = VerticalAlign.Top, Width = width };

            c.Controls.Add(new LiteralControl(text));
            row.Cells.Add(c);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ConfigureTable();

            using (var connection = new SqlConnection(DatabaseConnection))
            {
                using (var command = new SqlCommand("BopsGetUnifiedLoadContents", connection))
                {
                    connection.Open();

                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@LoadReference", SqlDbType.VarChar).Value = LoadReference;

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var type = reader["Type"].ToString();
                            var count = reader["Count"].ToString();
                            var description = reader["Description"].ToString();
                            var weight = reader["Weight"].ToString();

                            var r = new TableRow();
                            AddNormalCell(r, type, 100);
                            AddNormalCell(r, count, 100);
                            AddNormalCell(r, description, 230);
                            AddNormalCell(r, weight, 100);

                            UnifiedContentsTable.Rows.Add(r);
                        }

                        reader.Close();
                    }

                    connection.Close();
                }
            }
        }
    }
}
