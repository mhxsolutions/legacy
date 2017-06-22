using System;

namespace BopsDataAccess
{
    public class BopsScan
    {
        public int ScanId { get; set; }
        public string LoadRef { get; set; }
        public int DocTypeRef { get; set; }
        /// <summary>
        /// The document file name.
        /// </summary>
        public string FileName { get; set; }
        /// <summary>
        /// The raw folder name, which includes Dan's original use of the pound sign to make for a
        /// convenient hyperlink in Access.
        /// </summary>
        public string Folder { get; set; }
        public string Comment { get; set; }
        public bool Signed { get; set; }
        public DateTime? DateScanned { get; set; }
        public DateTime? DateConfirmed { get; set; }
        public string ConfirmedBy { get; set; }
        public int RejectRef { get; set; }

        /// <summary>
        /// The correctly and fully qualified file name, which strips the Access hyperlink characters
        /// as needed.
        /// </summary>
        public string CombinedFileName
        {
            get
            {
                // If the folder is configured as a hyperlink for Access, then it will be of the
                // following form: [Text]#[Hyperlink]#. If there's no hyperlink, we simply return
                // the raw folder. If there, is then we lose all the [Text] and strip the trailing
                // pound sign (as needed).

                int PoundIndex = Folder.IndexOf('#');
                if (PoundIndex == -1)
                    return Folder;

                char[] TrimCharacters = new char[3] { ' ', '\t', '#' };
                string ReturnValue = Folder.Substring(PoundIndex + 1).TrimEnd(TrimCharacters);
                return ReturnValue;
            }
        }
    }
}
