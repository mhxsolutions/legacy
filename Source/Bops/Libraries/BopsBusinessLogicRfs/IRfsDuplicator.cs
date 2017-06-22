namespace BopsBusinessLogicRfs
{
    public interface IRfsDuplicator
    {
        /// <summary>
        /// Duplicates the specified RFS, returning the ID of the new RFS if successful or
        /// zero in case of failure.
        /// </summary>
        /// <param name="rfsId">The ID of the RFS to be duplicated.</param>
        /// <returns>The ID number of the newly created, duplicate RFS if successful, zero otherwise.</returns>
        int DuplicateRfs(int rfsId);
    }
}
