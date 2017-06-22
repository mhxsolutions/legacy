using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cops.Web.Reports
{
    public class COPSReportUtils
    {
        /// <summary>
        /// Extracts the URL from a string containing HTML anchor tag markup.
        /// </summary>
        /// <param name="anchorTagMarkup">String to extract from.</param>
        /// <returns>The href attribute from the markup string.</returns>
        /// <remarks>Cops.Web.Reports.COPSReportUtils.HrefFromAnchorTag(string)</remarks>
        public static string HrefFromAnchorTag(string anchorTagMarkup)
        {
            string href = string.Empty;
            if (anchorTagMarkup == null) return string.Empty;

            // Get href attribute.
            System.Text.RegularExpressions.Match m = System.Text.RegularExpressions.Regex.Match(
                anchorTagMarkup, @"href=\""(.*?)\""", System.Text.RegularExpressions.RegexOptions.Singleline
              );
            if (m.Success)
            {
                href = m.Groups[1].Value;
            }
            return href;
        }

        /// <summary>
        /// Extracts the link text from a string containing HTML anchor tag markup.
        /// </summary>
        /// <param name="anchorTagMarkup">String to extract from.</param> 
        /// <returns>Link text</returns>
        /// <remarks>Cops.Web.Reports.COPSReportUtils.LinkTextFromAnchorTag(string)</remarks>
        public static string LinkTextFromAnchorTag(string anchorTagMarkup)
        {
            // Remove inner tags from text.
            if (anchorTagMarkup == null) return string.Empty;
            return System.Text.RegularExpressions.Regex.Replace(
                anchorTagMarkup, @"\s*<.*?>\s*", "", System.Text.RegularExpressions.RegexOptions.Singleline
             );
        }

        /// <summary>
        /// Tests a string to see if it contains HTML anchor tag markup.
        /// </summary>
        /// <param name="stringToCheck">String to test</param>
        /// <returns>true if string starts with "&lt;a" </returns>
        /// <remarks>Cops.Web.Reports.COPSReportUtils.IsAnchorTag(string)</remarks>
        public static Boolean IsAnchorTag(string stringToCheck)
        {
            if (stringToCheck == null) return false;

            // see if string starts with "<a"
            return stringToCheck.Replace(" ", "").ToLower().Substring(0, 2) == "<a";
        }

    }
}
