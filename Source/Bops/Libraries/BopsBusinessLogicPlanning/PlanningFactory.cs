namespace BopsBusinessLogicPlanning
{
    /// <summary>
    /// Manufactures planning related interfaces.
    /// </summary>
    public class PlanningFactory
    {
        /// <summary>
        /// Manufactures a driver planner interface.
        /// </summary>
        /// <returns>A driver planner interface if successful or null otherwise.</returns>
        public static IDriverPlanner GetDriverPlanner()
        {
            return new DriverPlanner();
        }

        /// <summary>
        /// Manufactures a container project planner interface.
        /// </summary>
        /// <returns>A container planner interface if successful or null otherwise.</returns>
        public static IContainerProjectPlanner GetContainerProjectPlanner()
        {
            return new ContainerProjectPlanner();
        }
    }
}
