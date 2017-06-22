using System;
using System.Collections.Generic;
using AgilisCore;
using BopsDataAccess;
using NHibernate.Criterion;
using log4net;
using NHibernate;

namespace BopsBusinessLogicAgilis
{
    public class WorkOrderImportEventHandler : IAgilisWorkOrderImportNotifier
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(WorkOrderImportEventHandler));

        private readonly ISession _DwsNoRepDataSession;
        private readonly ISession _EqManagerSession;
        private readonly Dictionary<int, int> _Tractors;
        private readonly Dictionary<int, int> _Trailers;
        private readonly Dictionary<int, string> _Drivers;
        private readonly List<string> _Messages;

        public List<string> Messages
        {
            get { return _Messages; }
        }

        public WorkOrderImportEventHandler(ISession DwsNoRepData, ISession EqManager)
        {
            _Messages = new List<string>();

            _DwsNoRepDataSession = DwsNoRepData;
            _EqManagerSession = EqManager;

            _Tractors = new Dictionary<int, int>();
            IList<BopsEquipment> AllTractors = _EqManagerSession.CreateCriteria(typeof(BopsEquipment))
                .Add(Expression.Eq("EquipmentType", (int)BopsEquipmentTypes.Tractor))
                .List<BopsEquipment>();
            foreach (BopsEquipment tractor in AllTractors)
                _Tractors.Add(tractor.EquipmentIdentifier, tractor.EquipmentId);

            _Trailers = new Dictionary<int, int>();
            IList<BopsEquipment> AllTrailers = _EqManagerSession.CreateCriteria(typeof(BopsEquipment))
                .Add(Expression.Eq("EquipmentType", (int)BopsEquipmentTypes.Trailer))
                .List<BopsEquipment>();
            foreach (BopsEquipment trailer in AllTrailers)
                _Trailers.Add(trailer.EquipmentIdentifier, trailer.EquipmentId);

            _Drivers = new Dictionary<int, string>();
            IList<BopsDriver> AllDrivers = _DwsNoRepDataSession.CreateCriteria(typeof(BopsDriver))
                .Add(Expression.Eq("Agilis", true))
                .List<BopsDriver>();
            foreach (BopsDriver driver in AllDrivers)
                _Drivers.Add(driver.DriverId, string.Format("{0} {1}", driver.FirstName, driver.LastName));
        }

        public bool BeforeImport(AgilisWorkOrder WorkOrder)
        {
            // TODO: perhaps add some code to trap and filter invalid work order numbers?

            return true;
        }

        public void AfterImport(AgilisWorkOrder WorkOrder, ImportMode Mode)
        {
            if (WorkOrder.Tractor != null && WorkOrder.Tractor != string.Empty &&
                WorkOrder.Trailer != null && WorkOrder.Trailer != string.Empty)
            {
                bool ValidTractor = _Tractors.ContainsKey(Convert.ToInt32(WorkOrder.Tractor));
                bool ValidTrailer = _Trailers.ContainsKey(Convert.ToInt32(WorkOrder.Trailer));

                if (!ValidTractor || !ValidTrailer)
                {
                    string DriverName = "(name unknown)";
                    if (_Drivers.ContainsKey(WorkOrder.DriverNumber))
                        DriverName = _Drivers[WorkOrder.DriverNumber];
                    string ErrorMessage = string.Format("Driver {0} ({1}) has entered an invalid tractor ({2}) or trailer ({3}) for work order number {4}, load {5}.",
                        WorkOrder.DriverNumber, DriverName, WorkOrder.Tractor, WorkOrder.Trailer, WorkOrder.WorkOrderNumber, WorkOrder.LoadRef);
                    _Log.Warn(ErrorMessage);
                    _Messages.Add(ErrorMessage);
                }

                if (ValidTrailer)
                {
                    BopsDriverPlanDetail PlannerDetail = _DwsNoRepDataSession.Get<BopsDriverPlanDetail>(WorkOrder.PlannerDetailId);
                    if (PlannerDetail != null && PlannerDetail.LoadRef != null)
                    {
                        BopsLoad Load = _DwsNoRepDataSession.Get<BopsLoad>(PlannerDetail.LoadRef);
                        if (Load != null && WorkOrder.Trailer != Load.Trailer)
                        {
                            _Log.DebugFormat("Updating tblPoscoLoads load {0} with trailer {1}.", WorkOrder.LoadRef, WorkOrder.Trailer);
                            Load.Trailer = WorkOrder.Trailer;
                            _DwsNoRepDataSession.Update(Load);
                        }
                    }
                }

                if (ValidTractor && ValidTrailer)
                {
                    BopsDriver Driver = _DwsNoRepDataSession.Get<BopsDriver>(WorkOrder.DriverNumber);
                    if (Driver != null && (Driver.Tractor.ToString() != WorkOrder.Tractor || Driver.Trailer.ToString() != WorkOrder.Trailer))
                    {
                        _Log.DebugFormat("Updating tblDriverList driver ID {0} with tractor/trailer {1}/{2}.",
                                         Driver.DriverId, WorkOrder.Tractor, WorkOrder.Trailer);

                        if (WorkOrder.Tractor == null || WorkOrder.Tractor == string.Empty)
                            Driver.Tractor = null;
                        else
                            Driver.Tractor = Convert.ToInt32(WorkOrder.Tractor);

                        if (WorkOrder.Trailer == null || WorkOrder.Trailer == string.Empty)
                            Driver.Trailer = null;
                        else
                            Driver.Trailer = Convert.ToInt32(WorkOrder.Trailer);

                        _DwsNoRepDataSession.Update(Driver);
                    }
                }
            }
        }
    }
}
