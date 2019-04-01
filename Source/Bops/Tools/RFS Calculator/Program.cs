using System;
using System.Windows.Forms;
using BopsBusinessLogicRfs;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Calculator
{
    static class Program
    {
        // This method largely lifted out of the RFS Operations Service file ServiceMain.cs.

        private static void PerformRfsOperations(DateTime beginDate, DateTime endDate)
        {
            var calculationBeginTime = DateTime.Now;
            Console.WriteLine("ROS beginning: {0} to {1}.", beginDate, endDate);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            RfsLoadRevenueCalculationResult loadResult = null;
            RfsWarehouseRevenueCalculationResult warehouseResult = null;
            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var revenueCalculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, null);
                revenueCalculator.PrecacheRfsData();
                //loadResult = revenueCalculator.CalculateLoadRevenue(beginDate, endDate);
                warehouseResult = revenueCalculator.CalculateWarehouseRevenue(beginDate, endDate);
                revenueCalculator.CleanInvalidRevenueResults();
            }
            finally
            {
                // TODO: free the RFS data context
            }

            var interval = DateTime.Now - calculationBeginTime;

            Console.WriteLine("Load Results: {0}", loadResult);
            Console.WriteLine("Warehouse Results: {0}", warehouseResult);
            Console.WriteLine("ROS ending, total run time was {0}.", interval.ToString());
        }

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            DateTime beginDate, endDate;

            var args = Environment.GetCommandLineArgs();
            if (args.Length == 3 && DateTime.TryParse(args[1], out beginDate) && DateTime.TryParse(args[2], out endDate) && 
                beginDate < endDate)
            {
                PerformRfsOperations(beginDate, endDate);
            }
            else
            {
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new MainForm());
            }
        }
    }
}
