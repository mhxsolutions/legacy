using System.IO;
using System.Text;
using System.Windows.Forms;

namespace BopsUtilities
{
    public class ListViewExportUtility
    {
        private static string EscapeIfNeeded(string originalText, string textToEscape, string escapeSequence)
        {
            return originalText.Contains(textToEscape) ? string.Format("{0}{1}{0}", escapeSequence, originalText) : originalText;
        }

        public static void ExportToClipboard(ListView control, bool includeHeaders, bool selectedItemsOnly)
        {
            var sb = new StringBuilder();

            // Copy the headers.

            if (includeHeaders)
            {
                sb.Append(control.Columns[0].Text);
                for (var i = 1; i < control.Columns.Count; i++)
                    sb.AppendFormat("\t{0}", control.Columns[i].Text);
                sb.AppendLine();
            }

            // Now copy all the rows.

            foreach (ListViewItem item in control.Items)
            {
                if (selectedItemsOnly && !item.Selected)
                    continue;

                sb.Append(item.Text);
                for (var i = 1; i < item.SubItems.Count; i++)
                    sb.AppendFormat("\t{0}", item.SubItems[i].Text);
                sb.AppendLine();
            }

            Clipboard.SetText(sb.ToString());
        }

        public static void ExportDelimitedFile(ListView control, bool includeHeaders, bool selectedItemsOnly, string fieldDelimeter, string exportFileName)
        {
            var sb = new StringBuilder();

            // Copy the headers.

            if (includeHeaders)
            {
                sb.Append(EscapeIfNeeded(control.Columns[0].Text, fieldDelimeter, "\""));
                for (var i = 1; i < control.Columns.Count; i++)
                    sb.AppendFormat("{0}{1}", fieldDelimeter, EscapeIfNeeded(control.Columns[i].Text, fieldDelimeter, "\""));
                sb.AppendLine();
            }

            // Now copy all the rows.

            foreach (ListViewItem item in control.Items)
            {
                if (selectedItemsOnly && !item.Selected)
                    continue;

                sb.Append(EscapeIfNeeded(item.Text, fieldDelimeter, "\""));

                for (var i = 1; i < item.SubItems.Count; i++)
                {
                    sb.Append(fieldDelimeter);
                    sb.Append(EscapeIfNeeded(item.SubItems[i].Text, fieldDelimeter, "\""));
                }
                sb.AppendLine();
            }

            using (var sw = new StreamWriter(exportFileName, false))
                sw.Write(sb.ToString());
        }
    }
}
