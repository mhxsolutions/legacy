using System;
using System.Collections.Generic;
using System.Diagnostics;
using BopsDataAccess;
using BopsDataConnector;
using NHibernate.Criterion;
using log4net;
using NHibernate;

namespace BopsBusinessLogicBis
{
    public class BisStorage : IBisStorage
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(BisStorage));
        
        public BopsBisStorageAsset CreateStorageAssetFromRailcar(string RailcarUkey)
        {
            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsAtsfRailcar Railcar = DataConnector.DwsRepData.Get<BopsAtsfRailcar>(RailcarUkey);

                BopsBisStorageAsset NewAsset = new BopsBisStorageAsset();
                NewAsset.AssetType = BisStorageAssetType.Railcar;
                NewAsset.Name = string.Format("{0}", Railcar.CarNumber);
                NewAsset.Description = string.Format("{0}", Railcar.Ukey);
                NewAsset.ProductRef = Railcar.ProductTypeRef.Value;
                NewAsset.CurrentQuantity = Railcar.BillWeight.Value;
                NewAsset.OriginalAssetRef = Railcar.Ukey;
                NewAsset.Active = true;

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Save(NewAsset);
                Tx.Commit();

                return NewAsset;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error(string.Format("An error occurred while creating a BIS storage asset from railcar '{0}'. Details follow.", RailcarUkey), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }

        public BopsBisStorageAsset CreateStorageAssetSilo(string Name, string Description, int ProductTypeRef)
        {
            if (string.IsNullOrEmpty(Name) || string.IsNullOrEmpty(Description))
                return null;

            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsAtsfProduct Product = DataConnector.DwsRepData.Load<BopsAtsfProduct>(ProductTypeRef);
                if (!Product.BisEnable)
                    return null;

                BopsBisStorageAsset NewAsset = new BopsBisStorageAsset();
                NewAsset.AssetType = BisStorageAssetType.Silo;
                NewAsset.Name = Name;
                NewAsset.Description = Description;
                NewAsset.ProductRef = ProductTypeRef;
                NewAsset.CurrentQuantity = 0;
                NewAsset.OriginalAssetRef = null;
                NewAsset.Active = true;

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Save(NewAsset);
                Tx.Commit();

                return NewAsset;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error(string.Format("An error occurred while creating a BIS storage silo '{0}'. Details follow.", Name), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }

        public bool DeactivateStorageAsset(int AssetId)
        {
            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsBisStorageAsset Asset = DataConnector.DwsNoRepData.Load<BopsBisStorageAsset>(AssetId);
                if (Asset.CurrentQuantity > 0)
                    return false;

                Asset.Active = false;
                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Update(Asset);
                Tx.Commit();

                return true;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error(string.Format("An error occurred while deactivating BIS storage asset '{0}'. Details follow.", AssetId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return false;
        }

        public bool LoadContainer(string UserId, int OriginStorageAssetRef, string ContainerId, double Quantity, BopsBisCpsContainerData FinalData)
        {
            BopsBisTransaction NewTx = new BopsBisTransaction();
            NewTx.TransactionType = BisTransactionType.Withdraw;
            NewTx.UserId = UserId;
            NewTx.Quantity = Quantity;
            NewTx.OriginStorageAssetRef = OriginStorageAssetRef;
            NewTx.DestinationStorageAssetType = BisStorageAssetType.Container;
            NewTx.DestinationStorageAssetRef = ContainerId;

            BopsBisTransaction Result = CreateTransaction(NewTx, FinalData);
            return Result != null;
        }

        public bool AdjustStorageAsset(string UserId, int StorageAssetRef, double Adjustment)
        {
            BopsBisTransaction NewTx = new BopsBisTransaction();
            NewTx.TransactionType = BisTransactionType.Adjust;
            NewTx.UserId = UserId;
            NewTx.Quantity = Adjustment;
            NewTx.OriginStorageAssetRef = StorageAssetRef;
            BopsBisTransaction Result = CreateTransaction(NewTx, null);
            return Result != null;
        }

        public bool Transfer(string UserId, int OriginStorageAssetId, int DestinationAssetId, double Quantity)
        {
            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsBisStorageAsset OriginAsset = DataConnector.DwsNoRepData.Load<BopsBisStorageAsset>(OriginStorageAssetId);
                BopsBisStorageAsset DestinationAsset = DataConnector.DwsNoRepData.Load<BopsBisStorageAsset>(DestinationAssetId);

                if (!OriginAsset.Active || 
                    !DestinationAsset.Active ||
                    OriginAsset.CurrentQuantity < Quantity ||
                    (OriginAsset.ProductRef != DestinationAsset.ProductRef && DestinationAsset.CurrentQuantity != 0))
                {
                    return false;
                }

                DateTime Timestamp = DateTime.Now;

                BopsBisTransaction TransferTx = new BopsBisTransaction();
                TransferTx.TransactionType = BisTransactionType.Transfer;
                TransferTx.UserId = UserId;
                TransferTx.Timestamp = Timestamp;
                TransferTx.ProductRef = OriginAsset.ProductRef;
                TransferTx.Quantity = Quantity;
                TransferTx.OriginStorageAssetRef = OriginStorageAssetId;
                TransferTx.DestinationStorageAssetType = DestinationAsset.AssetType;
                TransferTx.DestinationStorageAssetRef = DestinationAssetId.ToString();

                OriginAsset.CurrentQuantity -= Quantity;
                DestinationAsset.CurrentQuantity += Quantity;
                DestinationAsset.ProductRef = OriginAsset.ProductRef;

                Tx = DataConnector.DwsNoRepData.BeginTransaction();
                DataConnector.DwsNoRepData.Save(TransferTx);
                DataConnector.DwsNoRepData.Update(OriginAsset);
                DataConnector.DwsNoRepData.Update(DestinationAsset);
                Tx.Commit();

                return true;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error("An error occurred while creating BIS storage transaction. Details follow.", E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return false;
        }

        private BopsBisTransaction CreateTransaction(BopsBisTransaction NewTx, BopsBisCpsContainerData FinalContainerData)
        {
            // Basic validation checks to make sure we were given basic, good data.

            if (NewTx.TransactionId != 0 ||
                NewTx.TransactionType < BisTransactionType.Deposit || 
                NewTx.TransactionType > BisTransactionType.Adjust ||
                string.IsNullOrEmpty(NewTx.UserId))
            {
                return null;
            }

            // Make sure that the quantity sign is correct for a deposit/withdraw. Only an adjust can be negative.

            if ((NewTx.TransactionType == BisTransactionType.Deposit || NewTx.TransactionType == BisTransactionType.Withdraw) && (NewTx.Quantity <= 0))
                return null;

            // Make sure we have a destination ref for any transaction type other than an adjust.

            if (NewTx.TransactionType != BisTransactionType.Adjust && string.IsNullOrEmpty(NewTx.DestinationStorageAssetRef))
                return null;

            // Make sure we have a destination type for any transaction type other than an adjust.

            if (NewTx.TransactionType != BisTransactionType.Adjust && 
                (NewTx.DestinationStorageAssetType < BisStorageAssetType.Railcar || NewTx.DestinationStorageAssetType > BisStorageAssetType.Container))
                return null;

            ITransaction Tx = null;
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                // Using ISession.Load will ensure these exist or we'll throw an exception, but we validate anyway.

                BopsBisStorageAsset Asset = DataConnector.DwsNoRepData.Load<BopsBisStorageAsset>(NewTx.OriginStorageAssetRef);
                if (Asset == null || Asset.CurrentQuantity < NewTx.Quantity)
                    return null;

                // If we're dealing with a container, make sure we can get the unique container demurrage record
                // that needs to be marked as loaded.

                BopsCpsDemurrage Demurrage = null;
                if (NewTx.DestinationStorageAssetType == BisStorageAssetType.Container)
                {
                    IList<BopsCpsDemurrage> DemurrageList = DataConnector.DwsNoRepData.CreateCriteria(
                        typeof (BopsCpsDemurrage))
                        .Add(Expression.Eq("ContainerRef", NewTx.DestinationStorageAssetRef))
                        .Add(Expression.IsNull("ClockEnd"))
                        .Add(Expression.IsNull("ClockEndMovementRef"))
                        .Add(Expression.Eq("BisExclude", false))
                        .List<BopsCpsDemurrage>();

                    if (DemurrageList == null || DemurrageList.Count != 1)
                        return null;

                    Demurrage = DemurrageList[0];
                }

                // Set the variables that need to be updated.

                NewTx.ProductRef = Asset.ProductRef;
                NewTx.Timestamp = DateTime.Now;

                // Update the quantity in the asset for an update below. TODO: make this more concurrency safe if needed.

                switch (NewTx.TransactionType)
                {
                    case BisTransactionType.Deposit:
                        Asset.CurrentQuantity += NewTx.Quantity;
                        break;
                    case BisTransactionType.Withdraw:
                        Asset.CurrentQuantity -= NewTx.Quantity;
                        break;
                    case BisTransactionType.Adjust:
                        Asset.CurrentQuantity += NewTx.Quantity;
                        break;
                }

                if (NewTx.TransactionType == BisTransactionType.Adjust)
                {
                    NewTx.DestinationStorageAssetType = Asset.AssetType;
                    NewTx.DestinationStorageAssetRef = null;

                    // If we're told to adjust by zero, that means to zero out the container. In that case, override the
                    // quantity in the transaction record.

                    if (NewTx.Quantity == 0.0)
                    {
                        NewTx.Quantity = -Asset.CurrentQuantity;
                        Asset.CurrentQuantity = 0.0;
                    }
                }

                Tx = DataConnector.DwsNoRepData.BeginTransaction();

                DataConnector.DwsNoRepData.Update(Asset);
                DataConnector.DwsNoRepData.Save(NewTx);

                if (NewTx.DestinationStorageAssetType == BisStorageAssetType.Container)
                {
                    Debug.Assert(Demurrage != null);

                    if (FinalContainerData != null)
                    {
                        Demurrage.BisExclude = true;
                        DataConnector.DwsNoRepData.Update(Demurrage);

                        BopsBisCpsContainerData Cd = new BopsBisCpsContainerData(Demurrage.ProjectRef, Demurrage.ContainerRef, NewTx.TransactionId);
                        Cd.SealId = FinalContainerData.SealId;
                        Cd.TestId = FinalContainerData.TestId;
                        Cd.BillOfLading = FinalContainerData.BillOfLading;
                        DataConnector.DwsNoRepData.Save(Cd);
                    }

                    BopsBisCpsTransaction NewContainerTx = new BopsBisCpsTransaction(Demurrage.ProjectRef, Demurrage.ContainerRef, NewTx.TransactionId);
                    DataConnector.DwsNoRepData.Save(NewContainerTx);
                }

                Tx.Commit();

                return NewTx;
            }
            catch (Exception E)
            {
                if (Tx != null)
                    Tx.Rollback();
                _Log.Error("An error occurred while creating BIS storage transaction. Details follow.", E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }
    }
}
