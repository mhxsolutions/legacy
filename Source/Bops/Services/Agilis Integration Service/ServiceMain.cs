using System;
using System.Collections.Specialized;
using System.Configuration;
using System.ServiceProcess;
using System.Threading;
using AgilisIntegrationServiceCore;
using log4net;
using log4net.Config;

[assembly: XmlConfigurator(Watch = true)]

namespace Agilis_Integration_Service
{
    public partial class ServiceMain : ServiceBase
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(ServiceMain));

        private DateTime _LastSynchronized;
        private DateTime _LastFullImport;
        private DateTime _SynchronizeAnchorTime;
        private int _SynchronizationInterval;
        private int _ForceFullImportInterval;
        private Timer _SynchronizationTimer;
        private AisMain _Main;
        
        public ServiceMain()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            //Thread.Sleep(10000);    // Use only for debugging.

            _Main = new AisMain();

            int TimerInterval = Convert.ToInt32(ConfigurationManager.AppSettings["TimerInterval"]);
            _SynchronizationInterval = Convert.ToInt32(ConfigurationManager.AppSettings["SynchronizationInterval"]);
            _ForceFullImportInterval = Convert.ToInt32(ConfigurationManager.AppSettings["ForceFullImportInterval"]);

            /*
             * Set the last email notification time based on the current time minus the cooldown,
             * so that the cooldown period has effectively elapsed. Set the last synchronized time
             * to now so that the service won't run immediately on startup. And set the initial
             * synchronize anchor time to the beginning of the day to import everything.
             */

            _LastSynchronized = _LastFullImport = DateTime.Now;
            _SynchronizeAnchorTime = DateTime.Now.Date;

            _Log.InfoFormat("Agilis Integration Service (AIS) starting at {0}", DateTime.Now.ToString("G"));
            _Log.InfoFormat("Timer interval set to {0} ms.", TimerInterval);
            _Log.InfoFormat("Synchronization interval set to {0} ms.", _SynchronizationInterval);
            _Log.InfoFormat("Force full import interval set to {0} ms.", _ForceFullImportInterval);

            _Main.NotificationListManager.AddList("General", ConfigurationManager.GetSection("NotificationChannels/General") as NameValueCollection);
            _Main.NotificationListManager.AddList("Dispatch", ConfigurationManager.GetSection("NotificationChannels/Dispatch") as NameValueCollection);

            _SynchronizationTimer = new Timer(TimerCallback, null, 0, TimerInterval);
        }

        protected override void OnStop()
        {
            _SynchronizationTimer.Dispose();
            _Log.InfoFormat("Agilis Integration Service (AIS) stopping at {0}", DateTime.Now.ToString("G"));
        }

        private void TimerCallback(Object StateInformation)
        {
            lock (_SynchronizationTimer)
            {
                bool UpdateLastSynchronizedTime = false;

                try
                {
                    /*
                     * The temporal logic is designed to make sure we pick up all the status updates.
                     * The last synchronized time determines when the next synchronization will begin,
                     * which will be the time the last one ended plus the synchronization interval.
                     * This guarantees some down time for the system between runs.
                     * 
                     * The synchronization anchor time determines the start of the update period for
                     * the Agilis query. When the service first runs, it will be set to midnight of the
                     * current day. But as soon as we determine that it's time to synchronize, the
                     * next anchor period will be set to the current time minus the synchronization
                     * interval, the point being that we always overlap by one period for safety.
                     * 
                     * Finally, in what is probably an ode to paranoia, we set the anchor time to the
                     * beginning of the plan day at every full import interval. That way, even if
                     * something does manage to slip through the cracks, we should pick it up.
                     */

                    DateTime CurrentTime = DateTime.Now;
                    TimeSpan Interval = CurrentTime - _LastSynchronized;
                    if (Interval.TotalMilliseconds > _SynchronizationInterval)
                    {
                        UpdateLastSynchronizedTime = true;
                        _Log.Debug("Synchronization interval has passed; preparing to execute.");

                        DateTime NextAnchorTime = CurrentTime.AddMilliseconds(-_SynchronizationInterval);
                        DateTime PartialAnchorTime;

                        Interval = CurrentTime - _LastFullImport;
                        if (Interval.TotalMilliseconds > _ForceFullImportInterval)
                        {
                            PartialAnchorTime = CurrentTime.Date;
                            _LastFullImport = CurrentTime;
                            _Log.DebugFormat("Force full import interval has passed; using {0} as anchor time.", PartialAnchorTime.ToString("G"));
                        }
                        else
                        {
                            PartialAnchorTime = _SynchronizeAnchorTime;
                            _Log.DebugFormat("Will do partial import using {0} as anchor time.", PartialAnchorTime.ToString("G"));
                        }

                        _Main.PerformSynchronization(PartialAnchorTime, CurrentTime.Date);

                        _SynchronizeAnchorTime = NextAnchorTime;
                        _Log.DebugFormat("Next synchronization anchor time set to {0}.", _SynchronizeAnchorTime.ToString("G"));
                    }
                }
                catch (Exception e)
                {
                    _Log.Error("Exception in timer callback.", e);
                }
                finally
                {
                    /*
                     * If we should have synchronized, set the last synchronized time to provide 
                     * some down time for the machine until the next attempt. This is done in the 
                     * finally block to guarantee that it happens, even in case of exception.
                     */

                    if (UpdateLastSynchronizedTime)
                    {
                        _LastSynchronized = DateTime.Now;
                        _Log.DebugFormat("Last synchronized time set to {0}.", _LastSynchronized.ToString("G"));
                    }
                }
            }
        }
    }
}