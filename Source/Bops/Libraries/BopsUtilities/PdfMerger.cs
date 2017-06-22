using System;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using log4net;

namespace BopsUtilities
{
    /// <summary>
    /// Provides functions for merging multiple PDF files into a single output file.
    /// </summary>
    public class PdfMerger
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(PdfMerger));

        /// <summary>
        /// Merges the contents of the source files into a single destination file.
        /// </summary>
        /// <param name="DestinationFile">Destination file name for the merge.</param>
        /// <param name="SourceFileNames">Array of source file names to merge, which must all be PDF files.</param>
        public static void MergeFiles(string DestinationFile, string[] SourceFileNames)
        {
            if (string.IsNullOrEmpty(DestinationFile))
                throw new ArgumentException("Must specify a destination ");
            if (SourceFileNames == null || SourceFileNames.Length < 2)
                throw new ArgumentException("Must specify at least two source file names", "SourceFileNames");

            try
            {
                Document MergedDocument = null;
                PdfWriter DocumentWriter = null;
                PdfContentByte cb = null;

                foreach (string SourceFileName in SourceFileNames)
                {
                    PdfReader Reader = new PdfReader(SourceFileName);

                    // If we're on the very first document, we set up the output file.

                    if (MergedDocument == null)
                    {
                        MergedDocument = new Document(Reader.GetPageSizeWithRotation(1));
                        DocumentWriter = PdfWriter.GetInstance(MergedDocument, new FileStream(DestinationFile, FileMode.Create));
                        MergedDocument.Open();
                        cb = DocumentWriter.DirectContent;
                    }

                    // NB: the reader's pages are one-indexed (not sure why).

                    for (int i = 1; i <= Reader.NumberOfPages; i++)
                    {
                        MergedDocument.SetPageSize(Reader.GetPageSizeWithRotation(i));
                        MergedDocument.NewPage();
                        PdfImportedPage CurrentPage = DocumentWriter.GetImportedPage(Reader, i);
                        int Rotation = Reader.GetPageRotation(i);

                        if (Rotation == 90 || Rotation == 270)
                            cb.AddTemplate(CurrentPage, 0, -1f, 1f, 0, 0, Reader.GetPageSizeWithRotation(i).Height);
                        else
                            cb.AddTemplate(CurrentPage, 1f, 0, 0, 1f, 0, 0);
                    }
                }

                if (MergedDocument != null)
                    MergedDocument.Close();
            }
            catch (Exception e)
            {
                _Log.Error("Error merging PDF files. Details follow.", e);
            }
        }
    }
}
