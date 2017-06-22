namespace BopsBusinessLogicRfs
{
    public interface IRfsLifecycleManager
    {
        string ReassignLoadRfs(string loadReference, int newRfs);
        string ReassignReceiverRfs(int receiverId, int newRfs);
        string ReassignShipperRfs(int shipperId, int newRfs);
    }
}
