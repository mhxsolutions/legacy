using System;

namespace BopsDataAccess
{
    public enum BisTransactionType
    {
        None,
        Deposit,
        Withdraw,
        Adjust,
        Transfer
    }

    public class BopsBisTransaction
    {
        private int _TransactionId;
        private BisTransactionType _TransactionType;
        private string _UserId;
        private DateTime _Timestamp;
        private int _ProductRef;
        private double _Quantity;
        private int _OriginStorageAssetRef;
        private BisStorageAssetType _DestinationStorageAssetType;
        private string _DestinationStorageAssetRef;

        public int TransactionId
        {
            get { return _TransactionId; }
            set { _TransactionId = value; }
        }

        public BisTransactionType TransactionType
        {
            get { return _TransactionType; }
            set { _TransactionType = value; }
        }

        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public DateTime Timestamp
        {
            get { return _Timestamp; }
            set { _Timestamp = value; }
        }

        public int ProductRef
        {
            get { return _ProductRef; }
            set { _ProductRef = value; }
        }

        public double Quantity
        {
            get { return _Quantity; }
            set { _Quantity = value; }
        }

        public int OriginStorageAssetRef
        {
            get { return _OriginStorageAssetRef; }
            set { _OriginStorageAssetRef = value; }
        }

        public BisStorageAssetType DestinationStorageAssetType
        {
            get { return _DestinationStorageAssetType; }
            set { _DestinationStorageAssetType = value; }
        }

        public string DestinationStorageAssetRef
        {
            get { return _DestinationStorageAssetRef; }
            set { _DestinationStorageAssetRef = value; }
        }
    }
}
