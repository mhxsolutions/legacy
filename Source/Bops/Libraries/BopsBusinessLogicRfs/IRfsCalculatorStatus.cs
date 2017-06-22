namespace BopsBusinessLogicRfs
{
    /// <summary>
    /// The interface defined by the RFS system for clients to receive progress notifications.
    /// </summary>
    public interface IRfsCalculatorStatus
    {
        /// <summary>
        /// Called at the beginning of a numerically quantifiable operation so that the client may show a progress
        /// bar to the user if desired.
        /// </summary>e
        /// <param name="minimumNumber">The minimum number involved in the operation.</param>
        /// <param name="maximumNumber">The maximum number involved in the operation.</param>
        void InitializeProgressMeter(int minimumNumber, int maximumNumber);

        /// <summary>
        /// Called at various points during operations describing the overall task, the current sub-task, and the
        /// current and total numbers for sake of updating any progress bar.
        /// </summary>
        /// <param name="primaryText">Describes the top-level task being conducted.</param>
        /// <param name="secondaryText">Describes the sub-task being conducted.</param>
        /// <param name="currentNumber">The current iteration number, which should always be within the range
        /// provided by the earlier call to <see cref="InitializeProgressMeter"/></param>
        /// <param name="totalNumber"></param>
        void ProgressUpdate(string primaryText, string secondaryText, int currentNumber, int totalNumber);

        /// <summary>
        /// Called to signal the end of a numerically quantifiable operation. The client should remove any
        /// status bar altogether.
        /// </summary>
        void UninitializeProgressMeter();
    }
}
