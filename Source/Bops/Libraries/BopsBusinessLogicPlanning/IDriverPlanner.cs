using System;
using BopsDataAccess;

namespace BopsBusinessLogicPlanning
{
    /// <summary>
    /// Specifies the details to be retrieved when querying driver planning information.
    /// </summary>
    [Flags]
    public enum QueryDriverPlanningDetails
    {
        /// <summary>
        /// Retrieves driver record and plan header record.
        /// </summary>
        DriverAndPlan = 0x1,
        /// <summary>
        /// Retrieves the plan detail records.
        /// </summary>
        Details = 0x2,
        /// <summary>
        /// Retrieves all destination records referenced by the plan detail records.
        /// </summary>
        Destinations = 0x6,

        /// <summary>
        /// Retrieves everything.
        /// </summary>
        All = DriverAndPlan | Details | Destinations
    }

    public interface IDriverPlanner
    {
        /// <summary>
        /// Gets the driver record for the specified driver ID.
        /// </summary>
        /// <param name="DriverId">The ID of the driver of interest.</param>
        /// <returns>The resulting driver object if successful or null otherwise.</returns>
        BopsDriver GetDriver(int DriverId);

        /// <summary>
        /// Gets the desired plan details for the specified plan ID.
        /// </summary>
        /// <remarks>
        /// The driver and plan are always queried. The details and destinations are queried only if the 
        /// corresponding flags are set, though the destinations will be empty if the details are not queried.
        /// In effect, the flags probably shouldn't be flags at all but rather a series of ascending levels
        /// of information to be queried. TODO: rework the query API to make more sense.
        /// </remarks>
        /// <param name="PlanId">The ID of the plan of interest.</param>
        /// <param name="Query">Flags that control the details to be retrieived.</param>
        /// <returns>The resulting plan details object if successful or null otherwise.</returns>
        DriverPlanningDetails GetDriverPlanningDetails(int PlanId, QueryDriverPlanningDetails Query);

        /// <summary>
        /// Creates a driver plan record.
        /// </summary>
        /// <param name="DriverId">The ID of the driver whose plan should be created.</param>
        /// <param name="PlanDate">The date of the plan to be created.</param>
        /// <param name="StartTime">The start time of the plan to be created.</param>
        /// <returns>The resulting plan object if successful or null otherwise.</returns>
        BopsDriverPlan CreatePlan(int DriverId, DateTime PlanDate, DateTime StartTime);
        
        /// <summary>
        /// Creates a plan detail record.
        /// </summary>
        /// <remarks>
        /// This method will cause all sequence numbers and times to be updated for the driver's entire
        /// plan, so any other detail records in memory should be flushed. This method should be considered
        /// deprecated, as it will likely be stripped in the future. <see cref="CreateLoadPlanDetails"/> is 
        /// the preferred method.
        /// </remarks>
        /// <param name="PlanId">The ID of the plan for which the detail record should be created.</param>
        /// <param name="InsertBeforeDetailId">The ID of the existing plan detail record before which the
        /// new detail record should be inserted or a zero if it should be added to the end of the plan.</param>
        /// <param name="OriginRef">A reference to the origin of the plan detail record.</param>
        /// <param name="DestinationRef">A reference to the destination of the plan detail record.</param>
        /// <param name="LoadRef">The load reference for the plan detail record.</param>
        /// <param name="ActionRef">A reference to the action for the plan detail record.</param>
        /// <param name="Notes">The notes for the plan detail record.</param>
        /// <returns>The resulting plan detail record if successful or null otherwise.</returns>
        BopsDriverPlanDetail CreatePlanDetail(int PlanId, int InsertBeforeDetailId, int OriginRef, int DestinationRef,
                                              string LoadRef, int ActionRef, string Notes);

        /// <summary>
        /// Creates a plan detail record for a "post trip", where the driver will end his plan day.
        /// </summary>
        /// <param name="PlanId">The ID of the plan for which the post-trip record should be created.</param>
        /// <param name="FinalDestinationRef">A reference to the destination of the post-trip record.</param>
        /// <returns>True if the post-trip record was created or false otherwise.</returns>
        bool CreatePostTrip(int PlanId, int FinalDestinationRef);

        /// <summary>
        /// Creates one or more plan detail records as needed to plan the specified load.
        /// </summary>
        /// <remarks>
        /// This method employs some business logic to make the planning process simpler. For example, it checks
        /// whether the load is a partial or not and inserts a move back to the terminal if needed. Refer to the
        /// code for other comments.
        /// </remarks>
        /// <param name="PlanId">The ID of the plan to which the load should be added.</param>
        /// <param name="LoadRef">A reference to the load being planned.</param>
        /// <returns>True if the load was planned or false otherwise.</returns>
        bool CreateLoadPlanDetails(int PlanId, string LoadRef);

        /// <summary>
        /// Updates a plan detail record.
        /// </summary>
        /// <remarks>
        /// This method does NOT update the plan detail record times, so use it with care.
        /// </remarks>
        /// <param name="PlanId">The ID of the plan that owns the detail record, which is not updated but used
        /// only to guarantee good data.</param>
        /// <param name="DetailId">The ID of the detail record to be updated.</param>
        /// <param name="OriginRef">The new origin for the detail record.</param>
        /// <param name="DestinationRef">The new destination for the detail record.</param>
        /// <param name="LoadRef">The new load reference for the detail record.</param>
        /// <param name="ActionRef">The new action reference for the detail record.</param>
        /// <param name="Notes">The new notes for the detail record.</param>
        /// <returns>True if the detail record was updated or false otherwise.</returns>
        bool UpdatePlanDetail(int PlanId, int DetailId, int OriginRef, int DestinationRef,
                                              string LoadRef, int ActionRef, string Notes);

        /// <summary>
        /// Deletes a plan detail record.
        /// </summary>
        /// This method will cause all sequence numbers and times to be updated for the driver's entire
        /// plan, so any other detail records in memory should be flushed.
        /// <param name="PlanId">The ID of the plan that owns the detail record, which is used only to guarantee
        /// good data.</param>
        /// <param name="DetailId">The ID of the detail record to be deleted.</param>
        /// <returns>True if the detail record was deleted or false otherwise.</returns>
        bool DeletePlanDetail(int PlanId, int DetailId);

        /// <summary>
        /// Deletes the last detail record for the specified plan.
        /// </summary>
        /// <param name="PlanId">The ID of the plan whose last detail record should be deleted.</param>
        /// <returns>True if the last detail record was deleted or false otherwise.</returns>
        bool DeletePlanLastDetail(int PlanId);
    }
}
