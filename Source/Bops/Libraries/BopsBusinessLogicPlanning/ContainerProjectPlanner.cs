using System;
using System.Collections.Generic;
using System.Security;
using BopsDataAccess;
using BopsDataConnector;
using NHibernate.Criterion;
using log4net;
using NHibernate;

namespace BopsBusinessLogicPlanning
{
    internal class ContainerProjectPlanner : IContainerProjectPlanner
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(ContainerProjectPlanner));

        public BopsCpsProject CreateProject(string BookingId, string Berth, string ShippingLine, DateTime BeginDate, int DemurrageDays, 
            int TotalContainers, string Description, int BillToClientRef, int DefaultOriginRef, int DefaultDestinationRef, string Notes)
        {
            if (string.IsNullOrEmpty(BookingId) || 
                string.IsNullOrEmpty(Berth) || 
                string.IsNullOrEmpty(ShippingLine) || 
                BeginDate < new DateTime(2010, 09, 26) ||
                DemurrageDays < 0 ||
                TotalContainers < 1 ||
                string.IsNullOrEmpty(Description) ||
                BillToClientRef == 0 ||
                DefaultOriginRef == 0 ||
                DefaultDestinationRef == 0)
            {
                return null;
            }

            System.Security.Principal.WindowsIdentity CurrentIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (CurrentIdentity == null)
                throw new SecurityException("Could not obtain Windows identity.");

            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsCpsProject NewProject = new BopsCpsProject();

                NewProject.CreateTimestamp = DateTime.Now;
                NewProject.CreateUser = CurrentIdentity.Name;
                NewProject.BillToClientRef = BillToClientRef;
                NewProject.BookingId = BookingId;
                NewProject.Description = Description;
                NewProject.Berth = Berth;
                NewProject.ShippingLine = ShippingLine;
                NewProject.DefaultOriginRef = DefaultOriginRef;
                NewProject.DefaultDestinationRef = DefaultDestinationRef;
                NewProject.BeginDate = BeginDate;
                NewProject.DemurrageDays = DemurrageDays;
                NewProject.TotalContainers = TotalContainers;
                NewProject.Notes = Notes;
                NewProject.Complete = false;

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Save(NewProject);
                Tx.Commit();

                return NewProject;
            }
            catch (Exception E)
            {
                _Log.Error("An error occurred while creating a new container project. Details follow.", E);
                if (Tx != null)
                    Tx.Rollback();
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }

        public int GetActiveProjectCount()
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                int Count = Convert.ToInt32(DataConnector.DwsNoRepData.CreateCriteria(typeof (BopsCpsProject))
                                                .Add(Expression.Eq("Complete", false))
                                                .SetProjection(Projections.Count("ProjectId")).UniqueResult());

                return Count;
            }
            catch (Exception E)
            {
                _Log.Error("An error occurred while querying active project count. Details follow.", E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return -1;
        }

        public BopsCpsProject GetProject(int ProjectId)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                return DataConnector.DwsNoRepData.Load<BopsCpsProject>(ProjectId);
            }
            catch (Exception E)
            {
                _Log.Error(string.Format("An error occurred while retrieving project {0}. Details follow.", ProjectId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }

        #region IContainerProjectPlanner Members


        public BopsPickupRequest GetPickupRequest(int PickupRequestId)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                return DataConnector.DwsNoRepData.Get<BopsPickupRequest>(PickupRequestId);
            }
            catch (Exception E)
            {
                _Log.Error(string.Format("An error occurred while retrieving pickup request {0}. Details follow.", PickupRequestId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }

        public IList<BopsCpsMovement> GetContainerMovements(int ProjectId, string ContainerId)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                IList<BopsCpsMovement> Movements = DataConnector.DwsNoRepData.CreateCriteria(typeof (BopsCpsMovement))
                    .Add(Expression.Eq("ProjectRef", ProjectId))
                    .Add(Expression.Eq("ContainerRef", ContainerId))
                    .List<BopsCpsMovement>();
                return Movements;
            }
            catch (Exception E)
            {
                _Log.Error(string.Format("An error occurred while retrieving movements for project {0}, container {1}. Details follow.",
                    ProjectId, ContainerId), E);
                return null;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        public DemurrageDetails GetDemurrageDetails(int ProjectId, string ContainerId, bool IncludeMovements)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                
                BopsCpsDemurrage Demurrage = DataConnector.DwsNoRepData.Get<BopsCpsDemurrage>(new BopsCpsDemurrage(ProjectId, ContainerId));
                if (Demurrage == null)
                    return null;

                if (!IncludeMovements)
                    return new DemurrageDetails(Demurrage);

                BopsCpsMovement ClockBeginMovement = DataConnector.DwsNoRepData.Load<BopsCpsMovement>(Demurrage.ClockBeginMovementRef);
                BopsCpsMovement ClockEndMovement = Demurrage.ClockEndMovementRef.HasValue ? DataConnector.DwsNoRepData.Load<BopsCpsMovement>(Demurrage.ClockEndMovementRef) : null;
                return new DemurrageDetails(Demurrage, ClockBeginMovement, ClockEndMovement);
            }
            catch (Exception E)
            {
                _Log.Error(string.Format("An error occurred while retrieving demurrage for project {0}, container {1}. Details follow.",
                    ProjectId, ContainerId), E);
                return null;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        public bool CreateContainerMove(int ProjectId, int PickupRequestId, string ContainerId, int OriginRef, DateTime Departed,
            int DestinationRef, DateTime Arrived, DemurrageClockOperationType ClockOperation)
        {
            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                Tx = DataConnector.DwsNoRepData.BeginTransaction();

                // Create or update the container record.

                BopsCpsContainer Container = DataConnector.DwsNoRepData.Get<BopsCpsContainer>(ContainerId);
                if (Container != null)
                {
                    Container.LastKnownLocationRef = DestinationRef;
                    Container.LastKnownLocationTimestamp = Arrived;
                    DataConnector.DwsNoRepData.Update(Container);
                }
                else
                {
                    Container = new BopsCpsContainer(ContainerId, DestinationRef, Arrived);
                    DataConnector.DwsNoRepData.Save(Container);
                }

                // Create the movement record.

                BopsCpsMovement NewMovement = new BopsCpsMovement();
                NewMovement.ProjectRef = ProjectId;
                NewMovement.ContainerRef = ContainerId;
                NewMovement.OriginRef = OriginRef;
                NewMovement.OriginTimestamp = Departed;
                NewMovement.DestinationRef = DestinationRef;
                NewMovement.DestinationTimestamp = Arrived;
                NewMovement.PickupRequestRef = PickupRequestId;
                DataConnector.DwsNoRepData.Save(NewMovement);

                // Update the demurrage clock if needed.

                switch (ClockOperation)
                {
                    case DemurrageClockOperationType.StartClock:
                        BopsCpsDemurrage NullDemurrage = DataConnector.DwsNoRepData.Get<BopsCpsDemurrage>(new BopsCpsDemurrage(ProjectId, ContainerId));
                        if (NullDemurrage != null) throw new InvalidOperationException(string.Format("Demurrage clock already started for project {0} container {1}", ProjectId, ContainerId));
                        BopsCpsDemurrage NewDemurrage = new BopsCpsDemurrage();
                        NewDemurrage.ProjectRef = ProjectId;
                        NewDemurrage.ContainerRef = ContainerId;
                        NewDemurrage.ClockBegin = Departed;
                        NewDemurrage.ClockBeginMovementRef = NewMovement.MovementId;
                        DataConnector.DwsNoRepData.Save(NewDemurrage);
                        break;
                    case DemurrageClockOperationType.StopClock:
                        BopsCpsDemurrage Demurrage = DataConnector.DwsNoRepData.Load<BopsCpsDemurrage>(new BopsCpsDemurrage(ProjectId, ContainerId));
                        Demurrage.ClockEnd = Arrived;
                        Demurrage.ClockEndMovementRef = NewMovement.MovementId;
                        DataConnector.DwsNoRepData.Update(Demurrage);
                        break;
                    default:
                        _Log.InfoFormat("Project {0}, new movement {1} does not affect demurrage clock.", ProjectId, NewMovement.MovementId);
                        break;
                }

                Tx.Commit();
                return true;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error(string.Format("An error occurred while creating container move for project {0}, PUR {1}, container {2}. Details follow.", ProjectId, PickupRequestId, ContainerId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return false;
        }

        public BopsCpsFullProjectDetails GetFullProjectDetails(int ProjectId)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsCpsProject Project = DataConnector.DwsNoRepData.Load<BopsCpsProject>(ProjectId);
                IList<BopsCpsMovement> Moves = DataConnector.DwsNoRepData.CreateCriteria(typeof (BopsCpsMovement))
                    .Add(Expression.Eq("ProjectRef", ProjectId)).List<BopsCpsMovement>();
                IList<BopsCpsDemurrage> Demurrage = DataConnector.DwsNoRepData.CreateCriteria(typeof (BopsCpsDemurrage))
                    .Add(Expression.Eq("ProjectRef", ProjectId)).List<BopsCpsDemurrage>();

                return new BopsCpsFullProjectDetails(Project, Moves, Demurrage);
            }
            catch (Exception E)
            {
                _Log.Error(string.Format("An error occurred while retrieving project {0}. Details follow.", ProjectId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }

        public bool CloseProject(int ProjectId)
        {
            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsCpsProject Project = DataConnector.DwsNoRepData.Load<BopsCpsProject>(ProjectId);
                IList<BopsCpsMovement> Moves = DataConnector.DwsNoRepData.CreateCriteria(typeof(BopsCpsMovement))
                    .Add(Expression.Eq("ProjectRef", ProjectId)).List<BopsCpsMovement>();
                IList<BopsCpsDemurrage> DemurrageRecords = DataConnector.DwsNoRepData.CreateCriteria(typeof(BopsCpsDemurrage))
                    .Add(Expression.Eq("ProjectRef", ProjectId)).List<BopsCpsDemurrage>();

                BopsCpsFullProjectDetails Details = new BopsCpsFullProjectDetails(Project, Moves, DemurrageRecords);

                int OpenDemurrage = 0;
                foreach (BopsCpsDemurrage Demurrage in DemurrageRecords)
                {
                    if (!Demurrage.ClockEnd.HasValue || !Demurrage.ClockEndMovementRef.HasValue)
                        OpenDemurrage++;
                }


                if (Details.Pickups != Details.Returns || OpenDemurrage > 0)
                    return false;

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                Project.Complete = true;
                DataConnector.DwsNoRepData.Update(Project);
                Tx.Commit();
                return true;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error(string.Format("An error occurred while closing project {0}. Details follow.", ProjectId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return false;
        }

        public bool AssignRailcar(int ProjectId, string Ukey)
        {
            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsCpsProject Project = DataConnector.DwsNoRepData.Load<BopsCpsProject>(ProjectId);
                BopsAtsfRailcar Railcar = DataConnector.DwsRepData.Load<BopsAtsfRailcar>(Ukey);

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                BopsCpsProjectRailcar NewAssignment = new BopsCpsProjectRailcar(Project.ProjectId, Railcar.Ukey);
                DataConnector.DwsNoRepData.Save(NewAssignment);
                Tx.Commit();
                return true;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error(string.Format("An error occurred while assigning railcar '{0}' to CPS project {1}. Details follow.", Ukey, ProjectId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return false;
        }

        public bool CopyRailcars(int SourceProjectId, int DestinationProjectId)
        {
            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsCpsProject SourceProject = DataConnector.DwsNoRepData.Load<BopsCpsProject>(SourceProjectId);
                BopsCpsProject DestinationProject = DataConnector.DwsNoRepData.Load<BopsCpsProject>(DestinationProjectId);

                IList<BopsCpsProjectRailcar> SourceCars =
                    DataConnector.DwsNoRepData.CreateCriteria(typeof (BopsCpsProjectRailcar))
                        .Add(Expression.Eq("ProjectRef", SourceProject.ProjectId))
                        .List<BopsCpsProjectRailcar>();

                string DeleteCommand = string.Format("FROM BopsCpsProjectRailcar R WHERE R.ProjectRef = '{0}'", DestinationProjectId);

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Delete(DeleteCommand);

                foreach (BopsCpsProjectRailcar Car in SourceCars)
                {
                    BopsCpsProjectRailcar NewAssignment = new BopsCpsProjectRailcar(DestinationProject.ProjectId, Car.RailcarRef);
                    DataConnector.DwsNoRepData.Save(NewAssignment);
                }
                
                Tx.Commit();
                return true;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error(string.Format("An error occurred while assigning railcars from CPS project {0} to CPS project {1}. Details follow.", SourceProjectId, DestinationProjectId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return false;
        }

        #endregion
    }
}
