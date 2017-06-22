namespace BopsDataAccess
{
    public enum BisStorageAssetType
    {
        None,
        Railcar,
        Container,
        Silo
    }

    public class BopsBisStorageAsset
    {
        private int _StorageAssetId;
        private BisStorageAssetType _AssetType;
        private string _Name;
        private string _Description;
        private int _ProductRef;
        private double _CurrentQuantity;
        private string _OriginalAssetRef;
        private bool _Active;

        public int StorageAssetId
        {
            get { return _StorageAssetId; }
            set { _StorageAssetId = value; }
        }

        public BisStorageAssetType AssetType
        {
            get { return _AssetType; }
            set { _AssetType = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public int ProductRef
        {
            get { return _ProductRef; }
            set { _ProductRef = value; }
        }

        public double CurrentQuantity
        {
            get { return _CurrentQuantity; }
            set { _CurrentQuantity = value; }
        }

        public string OriginalAssetRef
        {
            get { return _OriginalAssetRef; }
            set { _OriginalAssetRef = value; }
        }

        public bool Active
        {
            get { return _Active; }
            set { _Active = value; }
        }
    }
}
