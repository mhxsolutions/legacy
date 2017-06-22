using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using BopsDataAccess;
using BopsDataConnector;
using NHibernate.Criterion;
using NHibernateUtilities;
using log4net;
using NHibernate;

namespace BopsBusinessLogicPlanning
{
    internal class DriverPlanner : IDriverPlanner
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(DriverPlanner));

        public BopsDriver GetDriver(int DriverId)
        {
            BopsDriver ReturnValue;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                ReturnValue = DataConnector.DwsNoRepData.Load<BopsDriver>(DriverId);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return ReturnValue;
        }

        private static DriverPlanningDetails GetDriverPlanningDetails(IBopsDataConnector DataConnector, int PlanId, QueryDriverPlanningDetails Query)
        {
            BopsDriverPlan Plan = DataConnector.DwsNoRepData.Load<BopsDriverPlan>(PlanId);
            BopsDriver Driver = DataConnector.DwsNoRepData.Load<BopsDriver>(Plan.DriverRef);
            IList<BopsDriverPlanDetail> Details = null;
            IDictionary<int, BopsDestination> Destinations = null;

            if ((Query & QueryDriverPlanningDetails.Details) != 0)
            {
                Details = DataConnector.DwsNoRepData.CreateCriteria(typeof(BopsDriverPlanDetail))
                    .Add(Expression.Eq("PlanRef", Plan.PlanId))
                    .AddOrder(Order.Asc("SequenceNumber"))
                    .List<BopsDriverPlanDetail>();
            }

            if ((Query & QueryDriverPlanningDetails.Destinations) != 0)
            {
                Debug.Assert(Details != null);
                Destinations = new Dictionary<int, BopsDestination>();

                foreach (BopsDriverPlanDetail Detail in Details)
                {
                    if (!Destinations.ContainsKey(Detail.OriginRef))
                        Destinations.Add(Detail.OriginRef, null);
                    if (!Destinations.ContainsKey(Detail.DestinationRef))
                        Destinations.Add(Detail.DestinationRef, null);
                }

                Destinations = ReadUtilities.LoadObjectDictionary<int, BopsDestination>(DataConnector.DwsRepData, "DestinationId", Destinations.Keys);
            }

            return new DriverPlanningDetails(Driver, Plan, Details, Destinations);
        }

        public DriverPlanningDetails GetDriverPlanningDetails(int PlanId, QueryDriverPlanningDetails Query)
        {
            DriverPlanningDetails ReturnValue;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                ReturnValue = GetDriverPlanningDetails(DataConnector, PlanId, Query);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return ReturnValue;
        }

        public BopsDriverPlan CreatePlan(int DriverId, DateTime PlanDate, DateTime StartTime)
        {
            if (PlanDate.Date != StartTime.Date) return null;

            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsDriver Driver = DataConnector.DwsNoRepData.Load<BopsDriver>(DriverId);
                if (Driver == null) return null;

                BopsDriverPlan NewPlan = new BopsDriverPlan();
                NewPlan.DriverRef = DriverId;
                NewPlan.PlanDate = PlanDate.Date;
                NewPlan.StartTime = StartTime;
                DataConnector.DwsNoRepData.Save(NewPlan);
                return NewPlan;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        private static int FindPlanDetail(IEnumerable<BopsDriverPlanDetail> Details, int DetailId)
        {
            if (DetailId > 0)
            {
                int Index = 0;
                foreach (BopsDriverPlanDetail Detail in Details)
                {
                    if (Detail.PlanDetailId == DetailId)
                        return Index;
                    Index++;
                }
            }

            return -1;
        }

        /// <summary>
        /// Looks up the transit time for the specified O/D pair given the supplied departure time.
        /// </summary>
        /// <param name="DataConnector">The connector to use for database access.</param>
        /// <param name="OriginRef">The ID of the origin.</param>
        /// <param name="DestinationRef">The ID of the destination.</param>
        /// <param name="TimeOfDeparture">The time of day at which the trip will begin.</param>
        /// <returns>The transit time in minutes or the default value if none could be found.</returns>
        private static int GetTransitTime(IBopsDataConnector DataConnector, int OriginRef, int DestinationRef, DateTime TimeOfDeparture)
        {
            const string QueryFormat = "SELECT MAX(T.Transit) FROM BopsTransitTime T WHERE T.FromRef = '{0}' AND T.ToRef = '{1}' AND T.Hour <= '{2}'";

            IList Times = DataConnector.DwsRepData.CreateQuery(string.Format(QueryFormat, OriginRef, DestinationRef, TimeOfDeparture.Hour)).List();
            if (Times.Count == 1 && Times[0] != null)
                return Convert.ToInt32(Times[0]);

            Times = DataConnector.DwsRepData.CreateQuery(string.Format(QueryFormat, DestinationRef, OriginRef, TimeOfDeparture.Hour)).List();
            if (Times.Count == 1 && Times[0] != null)
                return Convert.ToInt32(Times[0]);

            // TODO: This could be improved by prompting the user for a transit time (and storing it like DWS does) if none is available.

            return 60;
        }

        public BopsDriverPlanDetail CreatePlanDetail(int PlanId, int InsertBeforeDetailId, int OriginRef, int DestinationRef, string LoadRef, int ActionRef, string Notes)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();
            ITransaction Tx = null;

            try
            {
                BopsDestination Destination = DataConnector.DwsRepData.Get<BopsDestination>(DestinationRef);
                if (Destination == null) return null;

                DriverPlanningDetails Dpd = GetDriverPlanningDetails(DataConnector, PlanId, QueryDriverPlanningDetails.All);
                if (Dpd == null) return null;

                // Figure out before which item we'll insert. If we were given an ID then find it or fail if we can't.

                int BeforeDetailIndex = FindPlanDetail(Dpd.Details, InsertBeforeDetailId);
                if (InsertBeforeDetailId != 0 && BeforeDetailIndex == -1) return null;
                BopsDriverPlanDetail InsertBeforeDetail = BeforeDetailIndex > -1 ? Dpd.Details[BeforeDetailIndex] : null;

                // TODO: This could be improved by prompting the user for a detention time (and storing it like DWS does) if none is available.

                int NewSequence;

                // By this point we either have an item before which we're going to insert, or we're going at the end
                // of the list. 

                if (InsertBeforeDetail != null)
                {
                    NewSequence = InsertBeforeDetail.SequenceNumber;
                }
                else
                {
                    // At the end of the list we need to handle the empty plan case in a special fashion.

                    if (Dpd.Details.Count == 0)
                    {
                        NewSequence = 1;
                    }
                    else
                    {
                        NewSequence = Dpd.Details[Dpd.Details.Count - 1].SequenceNumber + 1;
                    }
                }

                BopsDriverPlanDetail NewDetail = new BopsDriverPlanDetail();
                NewDetail.PlanRef = PlanId;
                NewDetail.SequenceNumber = NewSequence;
                NewDetail.OriginRef = OriginRef;
                NewDetail.DestinationRef = DestinationRef;
                NewDetail.LoadRef = LoadRef;
                NewDetail.ActionRef = ActionRef;
                NewDetail.Notes = Notes;
                Dpd.Details.Insert(BeforeDetailIndex == -1 ? Dpd.Details.Count : BeforeDetailIndex, NewDetail);

                // Make sure to add the new origin/destination records to the map before updating plan times.

                Dpd.AddDestination(DataConnector, OriginRef);
                Dpd.AddDestination(DataConnector, DestinationRef);

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                UpdatePlanSequenceAndTimes(DataConnector, Dpd);
                DataConnector.DwsNoRepData.Save(NewDetail);
                Tx.Commit();

                return NewDetail;
            }
            catch (Exception E)
            {
                if (Tx != null) Tx.Rollback();
                _Log.Error("An exception occurred while trying to create a new plan detail.", E);
                return null;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        public bool CreatePostTrip(int PlanId, int FinalDestinationRef)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();
            ITransaction Tx = null;

            try
            {
                DriverPlanningDetails Dpd = GetDriverPlanningDetails(DataConnector, PlanId, QueryDriverPlanningDetails.All);
                if (Dpd == null) return false;
                BopsDestination Destination = DataConnector.DwsRepData.Get<BopsDestination>(FinalDestinationRef);
                if (Destination == null) return false;

                if (Dpd.Details.Count < 1) return false;

                BopsDriverPlanDetail PostTripDetail = new BopsDriverPlanDetail();
                PostTripDetail.PlanRef = PlanId;
                PostTripDetail.SequenceNumber = Dpd.Details[Dpd.Details.Count - 1].SequenceNumber + 1;
                PostTripDetail.OriginRef = Dpd.Details[Dpd.Details.Count - 1].DestinationRef;
                PostTripDetail.DestinationRef = FinalDestinationRef;
                PostTripDetail.ActionRef = (int)BopsDriverPlanDetailActionType.Move;
                Dpd.Details.Add(PostTripDetail);

                Dpd.AddDestination(Destination);

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                UpdatePlanSequenceAndTimes(DataConnector, Dpd);
                DataConnector.DwsNoRepData.Save(PostTripDetail);
                Tx.Commit();

                return true;
            }
            catch (Exception E)
            {
                if (Tx != null) Tx.Rollback();
                _Log.Error("An exception occurred while trying to create the post trip step.", E);
                return false;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        public bool CreateLoadPlanDetails(int PlanId, string LoadRef)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();
            ITransaction Tx = null;

            try
            {
                BopsLoad Load = DataConnector.DwsNoRepData.Get<BopsLoad>(LoadRef);
                BopsDestination Destination = DataConnector.DwsRepData.Get<BopsDestination>(Load.DeliveryLocationRef);
                if (Destination == null) return false;
                BopsDestination Origin = DataConnector.DwsRepData.Get<BopsDestination>(Load.OriginRef);
                if (Origin == null) return false;

                DriverPlanningDetails Dpd = GetDriverPlanningDetails(DataConnector, PlanId, QueryDriverPlanningDetails.All);
                if (Dpd == null) return false;

                // Block all editing operations if the plan is today's or earlier; we only allow web planning
                // on plans in the future.

                if (Dpd.Plan.PlanDate.Value.Date <= DateTime.Now)
                    return false;

                // If the load is not a partial, and if the origin is not equal to where the previous step finished,
                // then we need to add a MOV step to the plan to get the driver to the load origin.

                int NewSequenceNumber = Dpd.Details.Count == 0 ? 1 : Dpd.Details[Dpd.Details.Count - 1].SequenceNumber + 1;
                BopsDriverPlanDetail PreviousStep = (Dpd.Details.Count > 0) ? Dpd.Details[Dpd.Details.Count - 1] : null;
                BopsDriverPlanDetail MoveDetail = null;

                if (!Load.PartialLoad && PreviousStep != null && PreviousStep.DestinationRef != Load.OriginRef)
                {
                    MoveDetail = new BopsDriverPlanDetail();
                    MoveDetail.PlanRef = PlanId;
                    MoveDetail.SequenceNumber = NewSequenceNumber++;
                    MoveDetail.OriginRef = PreviousStep.DestinationRef;
                    MoveDetail.DestinationRef = Load.OriginRef.Value;
                    MoveDetail.ActionRef = (int)BopsDriverPlanDetailActionType.Move;
                    Dpd.Details.Add(MoveDetail);
                }

                BopsDriverPlanDetail NewDetail = new BopsDriverPlanDetail();
                NewDetail.PlanRef = PlanId;
                NewDetail.SequenceNumber = NewSequenceNumber;

                // If it's a partial load and we have a previous step, then we make sure to use that previous step's
                // destination as the new step's origin. This allows a client to submit loads with O/D pairs: T/D1,
                // T/D2, T/D3, etc. but actually get the plan built correctly for what the driver will actually do:
                // T/D1, D1/D2, D2/D3, etc.

                if (Load.PartialLoad && PreviousStep != null)
                    NewDetail.OriginRef = PreviousStep.DestinationRef;
                else
                    NewDetail.OriginRef = Origin.DestinationId;

                NewDetail.DestinationRef = Destination.DestinationId;
                NewDetail.LoadRef = LoadRef;
                NewDetail.ActionRef = (int)BopsDriverPlanDetailActionType.Deliver;
                Dpd.Details.Add(NewDetail);

                // Make sure to add the new origin/destination records to the map before updating plan times. 

                Dpd.AddDestination(Origin);
                Dpd.AddDestination(Destination);

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                UpdatePlanSequenceAndTimes(DataConnector, Dpd);
                if (MoveDetail != null)
                    DataConnector.DwsNoRepData.Save(MoveDetail);
                DataConnector.DwsNoRepData.Save(NewDetail);
                Tx.Commit();

                return true;
            }
            catch (Exception E)
            {
                if (Tx != null) Tx.Rollback();
                _Log.Error("An exception occurred while trying to create a new plan detail.", E);
                return false;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        public bool UpdatePlanDetail(int PlanId, int DetailId, int OriginRef, int DestinationRef, string LoadRef, int ActionRef, string Notes)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();
            ITransaction Tx = null;

            try
            {
                BopsDriverPlanDetail Detail = DataConnector.DwsNoRepData.Get<BopsDriverPlanDetail>(DetailId);
                if (Detail.PlanRef != PlanId) return false;

                Detail.OriginRef = OriginRef;
                Detail.DestinationRef = DestinationRef;
                Detail.LoadRef = LoadRef;
                Detail.ActionRef = ActionRef;
                Detail.Notes = Notes;

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Update(Detail);
                Tx.Commit();
                return true;
            }
            catch (Exception E)
            {
                if (Tx != null) Tx.Rollback();
                _Log.Error("An exception occurred while trying to create a new plan detail.", E);
                return false;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        private void UpdatePlanSequenceAndTimes(IBopsDataConnector DataConnector, DriverPlanningDetails Dpd)
        {
            Debug.Assert(Dpd.HasDetails && Dpd.HasDestinations);

            int LastSequence = 0;
            DateTime CurrentTime = Dpd.Plan.StartTime.Value;

            foreach (BopsDriverPlanDetail Detail in Dpd.Details)
            {
                // Makes sure that all the plan sequence numbers are increasing.

                if (Detail.SequenceNumber > LastSequence)
                    LastSequence = Detail.SequenceNumber;
                else
                    Detail.SequenceNumber = ++LastSequence;

                // Fetches the transit time based on the current time and calculates the dwell, arrive, and depart
                // on that basis along with the destination record.
                // TODO: This could be improved by prompting the user for a detention time (and storing it like DWS does) if none is available.

                BopsDestination Destination = Dpd.Destinations[Detail.DestinationRef];
                int Transit = GetTransitTime(DataConnector, Detail.OriginRef, Detail.DestinationRef, CurrentTime);
                int DwellTime = Destination.UnloadTime ?? 30;

                Detail.MinutesInTransit = Transit;
                Detail.MinutesInDetention = DwellTime;
                Detail.ScheduledArrival = CurrentTime.AddMinutes(Transit);
                Detail.ScheduledDeparture = Detail.ScheduledArrival.Value.AddMinutes(DwellTime);
                CurrentTime = Detail.ScheduledDeparture.Value;

                if (Detail.PlanDetailId > 0)
                    DataConnector.DwsNoRepData.Update(Detail);
            }
        }

        public bool DeletePlanDetail(int PlanId, int DetailId)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();
            ITransaction Tx = null;

            try
            {
                DriverPlanningDetails Dpd = GetDriverPlanningDetails(DataConnector, PlanId, QueryDriverPlanningDetails.All);
                if (Dpd == null) return false;

                int DoomedIndex = -1;
                for (int Index = 0; Index < Dpd.Details.Count && DoomedIndex == -1; Index++)
                {
                    if (Dpd.Details[Index].PlanDetailId == DetailId)
                        DoomedIndex = Index;
                }

                if (DoomedIndex == -1)
                    return false;

                BopsDriverPlanDetail DoomedDetail = Dpd.Details[DoomedIndex];
                Dpd.Details.RemoveAt(DoomedIndex);

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Delete(DoomedDetail);
                UpdatePlanSequenceAndTimes(DataConnector, Dpd);
                Tx.Commit();
                return true;
            }
            catch (Exception E)
            {
                if (Tx != null) Tx.Rollback();
                _Log.Error(string.Format("An exception occurred while trying to delete plan {0} detail {1}.", PlanId, DetailId));
                _Log.Error(E);
                return false;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }

        public bool DeletePlanLastDetail(int PlanId)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();
            ITransaction Tx = null;

            try
            {
                DriverPlanningDetails Dpd = GetDriverPlanningDetails(DataConnector, PlanId, QueryDriverPlanningDetails.Details);
                if (Dpd == null) return false;
                int DoomedIndex = Dpd.Details.Count - 1;
                if (DoomedIndex == -1)
                    return false;

                BopsDriverPlanDetail DoomedDetail = Dpd.Details[DoomedIndex];
                Dpd.Details.RemoveAt(DoomedIndex);

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Delete(DoomedDetail);
                Tx.Commit();
                return true;
            }
            catch (Exception E)
            {
                if (Tx != null) Tx.Rollback();
                _Log.Error(string.Format("An exception occurred while trying to delete last step for plan {0}.", PlanId));
                _Log.Error(E);
                return false;
            }
            finally
            {
                DataConnector.CloseSessions();
            }
        }
    }
}
