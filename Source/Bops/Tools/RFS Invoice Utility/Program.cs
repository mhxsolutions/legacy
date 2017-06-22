using System;
using System.Windows.Forms;

namespace RFS_Invoice_Utility
{
    static class Program
    {
        public static RfsInvoiceUtilityMainForm MainForm { get; set; }

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            MainForm = new RfsInvoiceUtilityMainForm();
            Application.Run(MainForm);
        }
    }
}