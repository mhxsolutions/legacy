using System;
using System.Configuration;
using System.ServiceProcess;
using System.Threading;
using BopsBusinessLogicRfs;
using log4net;
using log4net.Config;
using Scm.OpsCore.Legacy.DataLayer;

[assembly: XmlConfigurator(Watch = true)]

namespace Bops_RFS_Operations
{
    public partial class ServiceMain : ServiceBase
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(ServiceMain));

        #region Fields

        private DateTime _lastCalculated;
        private DateTime _lastMajorCalculation;
        private int _minorCalculationInterval;
        private int _majorCalculationInterval;
        private Timer _synchronizationTimer;

        #endregion

        public ServiceMain()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            var timerInterval = Convert.ToInt32(ConfigurationManager.AppSettings["TimerInterval"]);
            _minorCalculationInterval = Convert.ToInt32(ConfigurationManager.AppSettings["MinorCalculationInterval"]);
            _majorCalculationInterval = Convert.ToInt32(ConfigurationManager.AppSettings["MajorCalculationInterval"]);
            _lastCalculated = _lastMajorCalculation = DateTime.Now;

            Log.InfoFormat("RFS Operations Service (ROS) starting at {0:G}", DateTime.Now);
            Log.InfoFormat("Timer interval set to {0} ms.", timerInterval);
            Log.InfoFormat("Minor calculation interval set to {0} ms.", _minorCalculationInterval);
            Log.InfoFormat("Major calculation import interval set to {0} ms.", _majorCalculationInterval);

            _synchronizationTimer = new Timer(TimerCallback, null, 0, timerInterval);
        }

        protected override void OnStop()
        {
            _synchronizationTimer.Dispose();
            Log.InfoFormat("RFS Operations Service (ROS) stopping at {0:G}", DateTime.Now);
        }

        private void TimerCallback(object stateInformation)
        {
            lock (_synchronizationTimer)
            {
                var updateLastCalculatedTime = false;

                try
                {
                    var currentTime = DateTime.Now;
                    var interval = currentTime - _lastCalculated;
                    if (interval.TotalMilliseconds > _minorCalculationInterval)
                    {
                        DateTime beginTime, endTime;

                        updateLastCalculatedTime = true;
                        Log.Debug("Calculation interval has passed; preparing to execute.");

                        interval = currentTime - _lastMajorCalculation;
                        if (interval.TotalMilliseconds > _majorCalculationInterval)
                        {
                            _lastMajorCalculation = currentTime;
                            beginTime = currentTime.Date.AddMonths(-1);
                            endTime = currentTime.AddDays(14);
                            Log.DebugFormat("Major calculation: {0} to {1}", beginTime, endTime);
                            PerformRfsOperations(beginTime, endTime);
                        }
                        else
                        {
                            beginTime = currentTime.Date.AddDays(-7);
                            endTime = currentTime.AddDays(7);
                            Log.DebugFormat("Minor calculation: {0} to {1}", beginTime, endTime);
                            PerformRfsOperations(beginTime, endTime);
                        }
                    }
                }
                catch (Exception e)
                {
                    Log.Error("Exception in timer callback.", e);
                }
                finally
                {
                    /*
                     * If we should have calculated, set the last calculated time to provide 
                     * some down time for the machine until the next attempt. This is done in the 
                     * finally block to guarantee that it happens, even in case of exception.
                     */

                    if (updateLastCalculatedTime)
                    {
                        _lastCalculated = DateTime.Now;
                        Log.DebugFormat("Last calculated time set to {0:G}.", _lastCalculated);
                    }
                }
            }
        }

        private void PerformRfsOperations(DateTime beginDate, DateTime endDate)
        {
            //Debug.Assert(false);

            var calculationBeginTime = DateTime.Now;
            Log.InfoFormat("ROS beginning: {0} to {1}.", beginDate, endDate);

            // Initialize the data context by retrieving the relevant interface through the kernel.

            RfsLoadRevenueCalculationResult loadResult = null;
            RfsWarehouseRevenueCalculationResult warehouseResult = null;
            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var revenueCalculator = RfsFactory.GetRfsRevenueCalculator(rfsDataContext, null);
                revenueCalculator.PrecacheRfsData();
                loadResult = revenueCalculator.CalculateLoadRevenue(beginDate, endDate);
                warehouseResult = revenueCalculator.CalculateWarehouseRevenue(beginDate, endDate);
                revenueCalculator.CleanInvalidRevenueResults();
            }
            finally
            {
                // TODO: free the RFS data context
            }

            var interval = DateTime.Now - calculationBeginTime;
            Log.InfoFormat("Load Results: {0}", loadResult);
            Log.InfoFormat("Warehouse Results: {0}", warehouseResult);
            Log.InfoFormat("ROS ending, total run time was {0}.", interval.ToString());
        }
    }
}
