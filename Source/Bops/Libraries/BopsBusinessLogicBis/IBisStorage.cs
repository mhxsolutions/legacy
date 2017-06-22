using BopsDataAccess;

namespace BopsBusinessLogicBis
{
    public interface IBisStorage
    {
        BopsBisStorageAsset CreateStorageAssetFromRailcar(string RailcarUkey);
        BopsBisStorageAsset CreateStorageAssetSilo(string Name, string Description, int ProductTypeRef);
        bool DeactivateStorageAsset(int AssetId);
        bool LoadContainer(string UserId, int OriginStorageAssetRef, string ContainerId, double Quantity,
                           BopsBisCpsContainerData FinalData);
        bool AdjustStorageAsset(string UserId, int StorageAssetRef, double Adjustment);
        bool Transfer(string UserId, int OriginStorageAssetId, int DestinationAssetId, double Quantity);
    }
}
