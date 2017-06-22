using System;
using System.Collections.Generic;
using BopsDataAccess;

namespace BopsBusinessLogicPlanning
{
    /// <summary>
    /// Provides a type to distinguish different demurrage operations.
    /// </summary>
    public enum DemurrageClockOperationType
    {
        /// <summary>
        /// Default value.
        /// </summary>
        None,
        /// <summary>
        /// The demurrage clock is starting.
        /// </summary>
        StartClock,
        /// <summary>
        /// The demurrage clock is stopping.
        /// </summary>
        StopClock
    }

    /// <summary>
    /// Defines the methods available to work with the container project system (CPS).
    /// </summary>
    public interface IContainerProjectPlanner
    {
        /// <summary>
        /// Creates a new CPS project.
        /// </summary>
        /// <remarks>
        /// The demurrage clock starts when a container is first put "in play" by picking it up from the default
        /// origin, and the demurrage for the container is evaluated based on the demurrage days in the project.
        /// The default origin/destination are used to determine whether container moves are pickups, returns, or
        /// custom moves.
        /// </remarks>
        /// <param name="BookingId">The ID of the booking for the project.</param>
        /// <param name="Berth">The berth at which the vessel will arrive.</param>
        /// <param name="ShippingLine">The shipping line providing/taking the containers.</param>
        /// <param name="BeginDate">The date the CPS project begins.</param>
        /// <param name="DemurrageDays">The number of days of demurrage for each container.</param>
        /// <param name="TotalContainers">The total number of containers in the project.</param>
        /// <param name="Description">A description of the project.</param>
        /// <param name="BillToClientRef">A reference to the bill-to client.</param>
        /// <param name="DefaultOriginRef">A reference to the default origin.</param>
        /// <param name="DefaultDestinationRef">A reference to the default destination.</param>
        /// <param name="Notes">Any notes for the project.</param>
        /// <returns>The resulting project object if successful or null otherwise.</returns>
        BopsCpsProject CreateProject(string BookingId, string Berth, string ShippingLine, DateTime BeginDate, int DemurrageDays,
            int TotalContainers, string Description, int BillToClientRef, int DefaultOriginRef, int DefaultDestinationRef, string Notes);

        /// <summary>
        /// Counts the active CPS projects.
        /// </summary>
        /// <returns>The number of active CPS projects if successful or -1 otherwise.</returns>
        int GetActiveProjectCount();

        /// <summary>
        /// Gets the CPS project data for the specific project ID.
        /// </summary>
        /// <param name="ProjectId">The ID of the project of interest.</param>
        /// <returns>The resulting project object if successful or null otherwise.</returns>
        BopsCpsProject GetProject(int ProjectId);

        /// <summary>
        /// Gets the pickup request data for the specified pickup request ID.
        /// </summary>
        /// <param name="PickupRequestId">The ID of the pickup request of interest.</param>
        /// <returns>The resulting pickup request object if successful or null otherwise.</returns>
        BopsPickupRequest GetPickupRequest(int PickupRequestId);

        /// <summary>
        /// Gets the movements for a specified container ID within the scope of a particular project.
        /// </summary>
        /// <param name="ProjectId">The ID of the project of interest.</param>
        /// <param name="ContainerId">The ID of the container of interest.</param>
        /// <returns>A IList interface through which the movements may be accessed if successful or null otherwise.</returns>
        IList<BopsCpsMovement> GetContainerMovements(int ProjectId, string ContainerId);

        /// <summary>
        /// Gets the demurrage record (and optionally the movement records for clock start/stop) for a specified
        /// container ID within the scope of a particular project.
        /// </summary>
        /// <param name="ProjectId">The ID of the project of interest.</param>
        /// <param name="ContainerId">The ID of the container of interest.</param>
        /// <param name="IncludeMovements">Flag indicating whether clock start/stop movement records 
        /// should be retrieived.</param>
        /// <returns>The resulting demurrage details object if succesful or null otherwise.</returns>
        DemurrageDetails GetDemurrageDetails(int ProjectId, string ContainerId, bool IncludeMovements);

        /// <summary>
        /// Creates a container movement record.
        /// </summary>
        /// <param name="ProjectId">The ID of the project for the movement.</param>
        /// <param name="PickupRequestId">The ID of the pickup request for the movement.</param>
        /// <param name="ContainerId">The ID of the container being moved.</param>
        /// <param name="OriginRef">The origin of the movement.</param>
        /// <param name="Departed">The time at which the container left the origin.</param>
        /// <param name="DestinationRef">The destination of the movement.</param>
        /// <param name="Arrived">The time at which the container arrived at the destination.</param>
        /// <param name="ClockOperation">The demurrage clock operation to be performed (if any).</param>
        /// <returns>True if the container movement record was created or false otherwise.</returns>
        bool CreateContainerMove(int ProjectId, int PickupRequestId, string ContainerId, int OriginRef,
                                 DateTime Departed, int DestinationRef, DateTime Arrived, DemurrageClockOperationType ClockOperation);

        /// <summary>
        /// Gets the full project details for the specified project ID.
        /// </summary>
        /// <param name="ProjectId">The ID of the project of interest.</param>
        /// <returns>The resulting project details object if successful or false otherwise.</returns>
        BopsCpsFullProjectDetails GetFullProjectDetails(int ProjectId);

        /// <summary>
        /// Closes the specified project.
        /// </summary>
        /// <param name="ProjectId">The ID of the project to be closed.</param>
        /// <returns>True if the project was closed or false otherwise.</returns>
        bool CloseProject(int ProjectId);

        /// <summary>
        /// Assigns the specified rail car to a particular project.
        /// </summary>
        /// <remarks>
        /// A railcar may be assigned to multiple projects, and the assignments are optional; they are used only
        /// as a means for providing useful information when unloading storage assets.
        /// </remarks>
        /// <param name="ProjectId">The ID of the project to which the railcar should be assigned.</param>
        /// <param name="Ukey">The ID of the railcar to be assigned.</param>
        /// <returns>True of the railcar was assigned or false otherwise.</returns>
        bool AssignRailcar(int ProjectId, string Ukey);

        /// <summary>
        /// Copies all assigned railcars from the source project to the destination project, deleting any existing
        /// destination project railcar assignments in the process.
        /// </summary>
        /// <param name="SourceProjectId">The ID of the project whose assignments should be copied.</param>
        /// <param name="DestinationProjectId">The ID of the project to which the assignments should be copied.</param>
        /// <returns>True if the assignments were copied or false otherwise.</returns>
        bool CopyRailcars(int SourceProjectId, int DestinationProjectId);
    }
}
