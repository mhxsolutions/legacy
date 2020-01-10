using System;
using System.Collections.Generic;
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
        private static readonly ILog Log = LogManager.GetLogger(typeof(PdfMerger));

        private static string[] ScrubSourceFileNames(IEnumerable<string> inputStrings)
        {
            var fileList = new List<string>();

            foreach (var fileName in inputStrings)
            {
                var fileExtension = Path.GetExtension(fileName);
                if (string.Compare(".pdf", fileExtension, StringComparison.InvariantCultureIgnoreCase) == 0)
                    fileList.Add(fileName);
            }

            return fileList.Count > 0 ? fileList.ToArray() : null;
        }

        /// <summary>
        /// Merges the contents of the source files into a single destination file.
        /// </summary>
        /// <param name="destinationFile">Destination file name for the merge.</param>
        /// <param name="sourceFileNames">Array of source file names to merge, which must all be PDF files.</param>
        public static void MergeFiles(string destinationFile, string[] sourceFileNames)
        {
            if (string.IsNullOrEmpty(destinationFile))
                throw new ArgumentException("Must specify a destination ");

            var pdfFileNames = ScrubSourceFileNames(sourceFileNames);
            if (pdfFileNames == null || pdfFileNames.Length < 2)
                throw new ArgumentException("Must specify at least two source file names", "sourceFileNames");

            try
            {
                Document mergedDocument = null;
                PdfWriter documentWriter = null;
                PdfContentByte cb = null;

                foreach (var fileName in pdfFileNames)
                {
                    var reader = new PdfReader(fileName);

                    // If we're on the very first document, we set up the output file.

                    if (mergedDocument == null)
                    {
                        mergedDocument = new Document(reader.GetPageSizeWithRotation(1));
                        documentWriter = PdfWriter.GetInstance(mergedDocument, new FileStream(destinationFile, FileMode.Create));
                        mergedDocument.Open();
                        cb = documentWriter.DirectContent;
                    }

                    // NB: the reader's pages are one-indexed (not sure why).

                    for (var i = 1; i <= reader.NumberOfPages; i++)
                    {
                        mergedDocument.SetPageSize(reader.GetPageSizeWithRotation(i));
                        mergedDocument.NewPage();
                        var currentPage = documentWriter.GetImportedPage(reader, i);
                        var rotation = reader.GetPageRotation(i);

                        if (rotation == 90 || rotation == 270)
                            cb.AddTemplate(currentPage, 0, -1f, 1f, 0, 0, reader.GetPageSizeWithRotation(i).Height);
                        else
                            cb.AddTemplate(currentPage, 1f, 0, 0, 1f, 0, 0);
                    }
                }

                mergedDocument?.Close();
            }
            catch (Exception e)
            {
                Log.Error("Error merging PDF files. Details follow.", e);
            }
        }
    }
}
