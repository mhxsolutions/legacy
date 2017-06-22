using System;
using System.Collections.Generic;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;

namespace AgilisCore
{
    /// <summary>
    /// Defines custom handling for a particular driver's plan. Plan upload may be set to a particular
    /// hour of the day or as an offset from the driver's start time for a particular plan date.
    /// </summary>
    public class AgilisDriverPlanControl
    {
        /// <summary>
        /// Types of strategy available to plan control.
        /// </summary>
        public enum UploadStrategyType
        {
            /// <summary>
            /// Negative strategy: no special processing.
            /// </summary>
            None,

            /// <summary>
            /// Driver's plan will be uploaded at the specified hour of day, local time.
            /// </summary>
            AtHour,

            /// <summary>
            /// Driver's plan will be uploaded at the driver's start time minus the specified upload hour.
            /// </summary>
            AtHoursBeforeStartTime
        }

        private int _DriverRef;
        private UploadStrategyType _UploadStrategy;
        private int _UploadHour;

        // Fields not stored in the database, used only for in-memory processing.
        private DateTime? _StartTime;

        /// <summary>
        /// The ID of the driver for which the plan customization applies.
        /// </summary>
        public int DriverRef
        {
            get { return _DriverRef; }
            set { _DriverRef = value; }
        }

        /// <summary>
        /// The strategy to be used for the plan.
        /// </summary>
        public UploadStrategyType UploadStrategy
        {
            get { return _UploadStrategy; }
            set { _UploadStrategy = value; }
        }

        /// <summary>
        /// The hour of the day to be interpreted in light of the upload strategy.
        /// </summary>
        public int UploadHour
        {
            get { return _UploadHour; }
            set { _UploadHour = value; }
        }

        /// <summary>
        /// The start time for the driver on the particular date in question. Used only in memory; not persisted.
        /// </summary>
        public DateTime? StartTime
        {
            get { return _StartTime; }
            set { _StartTime = value; }
        }

        public AgilisDriverPlanControl()
        {
        }

        public AgilisDriverPlanControl(int _DriverRef, UploadStrategyType _UploadStrategy, int _UploadHour, DateTime? _StartTime)
        {
            this._DriverRef = _DriverRef;
            this._UploadStrategy = _UploadStrategy;
            this._UploadHour = _UploadHour;
            this._StartTime = _StartTime;
        }

        /// <summary>
        /// Gets all driver plan controls.
        /// </summary>
        /// <param name="Session">The NHibernate session to use for data retrieval.</param>
        /// <returns></returns>
        static public List<AgilisDriverPlanControl> GetDriverPlanControls(ISession Session)
        {
            IList<AgilisDriverPlanControl> Controls = Session.CreateCriteria(typeof(AgilisDriverPlanControl))
                .List<AgilisDriverPlanControl>();
            return new List<AgilisDriverPlanControl>(Controls);
        }

        /// <summary>
        /// Gets all driver plan controls for drivers with start times on the specified plan date.
        /// </summary>
        /// <param name="Session">The NHibernate session to use for data retrieval.</param>
        /// <param name="PlanDate">The plan date from which driver start times should be taken.</param>
        /// <returns></returns>
        static public List<AgilisDriverPlanControl> GetDriverPlanControls(ISession Session, DateTime PlanDate)
        {
            IList<BopsDriverPlan> Plans = Session.CreateCriteria(typeof(BopsDriverPlan))
                .Add(Expression.Eq("PlanDate", PlanDate))
                .List<BopsDriverPlan>();

            Dictionary<int, DateTime?> DriverStartTimes = new Dictionary<int, DateTime?>();
            foreach (BopsDriverPlan plan in Plans)
            {
                if (DriverStartTimes.ContainsKey(plan.DriverRef))
                    DriverStartTimes[plan.DriverRef] = plan.StartTime;
                else
                    DriverStartTimes.Add(plan.DriverRef, plan.StartTime);
            }

            IList<AgilisDriverPlanControl> controls = Session.CreateCriteria(typeof(AgilisDriverPlanControl))
                .List<AgilisDriverPlanControl>();
            List<AgilisDriverPlanControl> ReturnValue = new List<AgilisDriverPlanControl>(controls);
            foreach (AgilisDriverPlanControl c in ReturnValue)
            {
                c.StartTime = DriverStartTimes.ContainsKey(c.DriverRef) ? DriverStartTimes[c.DriverRef] : null;

                // DWS uses only the time portion of the underlying DATETIME field, so here we create an offset
                // based upon the hour, minute, and second, which is then added to the plan date to produce the
                // proper time for the current plan date.

                if (c.StartTime.HasValue)
                {
                    TimeSpan Offset = new TimeSpan(c.StartTime.Value.Hour, c.StartTime.Value.Minute, c.StartTime.Value.Second);
                    c.StartTime = PlanDate + Offset;
                }
            }

            return ReturnValue;
        }
    }
}
