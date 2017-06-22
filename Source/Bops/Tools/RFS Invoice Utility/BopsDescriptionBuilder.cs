using System;
using System.Collections.Generic;
using System.Text;
using BopsDataAccess;
using BopsDataConnector;
using NHibernate.Expression;

namespace RFS_Invoice_Utility
{
    class BopsDescriptionBuilder
    {
        private readonly IBopsDataConnector _Connector;

        public BopsDescriptionBuilder(IBopsDataConnector Connector)
        {
            _Connector = Connector;
        }

        private BopsDestination GetParentDestination(int DestinationId)
        {
            BopsDestination ReturnValue = _Connector.DwsRepData.Get<BopsDestination>(DestinationId);
            if (ReturnValue.ParentRef.HasValue && ReturnValue.ParentRef != 0 && ReturnValue.ParentRef != ReturnValue.DestinationId)
                ReturnValue = _Connector.DwsRepData.Get<BopsDestination>(ReturnValue.ParentRef);
            return ReturnValue;
        }

        public string Describe(BopsLoad Load)
        {
            if (Load == null)
                throw new ArgumentException("Load cannot be null", "Load");

            StringBuilder Sb = new StringBuilder("Load ");
            Sb.Append(Load.LoadReference);

            if (Load.LoadDate.HasValue)
                Sb.AppendFormat(", Load Date: {0}", Load.LoadDate.Value.ToShortDateString());

            if (Load.LogOutDate.HasValue)
                Sb.AppendFormat(", Logout Date: {0}", Load.LogOutDate.Value.ToShortDateString());

            if (Load.GrossWeight.HasValue)
                Sb.AppendFormat(", Gross Wt: {0}", Load.GrossWeight.Value);

            if (Load.ChargedWeight.HasValue)
                Sb.AppendFormat(", Charged Wt: {0}", Load.ChargedWeight);

            if (Load.OriginRef.HasValue)
            {
                BopsDestination Origin = _Connector.DwsRepData.Get<BopsDestination>(Load.OriginRef.Value);
                Sb.AppendFormat(", Origin {0}: {1}", Origin.DestinationId, Origin);

                if (Origin.ParentRef.HasValue && Origin.ParentRef.Value != 0 && Origin.ParentRef.Value != Origin.DestinationId)
                {
                    BopsDestination Parent = GetParentDestination(Load.OriginRef.Value);
                    Sb.AppendFormat(" (Parent {0}: {1})", Parent.DestinationId, Parent);
                }
            }

            if (Load.DeliveryLocationRef.HasValue)
            {
                BopsDestination Destination = GetParentDestination(Load.DeliveryLocationRef.Value);

                Sb.AppendFormat(", Destination {0}: {1}", Destination.DestinationId, Destination);

                if (Destination.ParentRef.HasValue && Destination.ParentRef.Value != 0 && Destination.ParentRef.Value != Destination.DestinationId)
                {
                    BopsDestination Parent = GetParentDestination(Load.DeliveryLocationRef.Value);
                    Sb.AppendFormat(" (Parent {0}: {1})", Parent.DestinationId, Parent);
                }
            }

            BopsRfsBillingStatus BillingStatus = _Connector.DwsNoRepData.Load<BopsRfsBillingStatus>((int)Load.BillingStatus);
            Sb.AppendFormat(", Billing Status: {0}", BillingStatus.Status);

            return Sb.ToString();
        }

        public string Describe(BopsReceivingRecord Receiver)
        {
            StringBuilder Sb = new StringBuilder("Receiver ");
            Sb.Append(Receiver.ReceiverId);

            if (!string.IsNullOrEmpty(Receiver.ReceiverType))
                Sb.AppendFormat(", Type: {0}", Receiver.ReceiverType);

            if (Receiver.DateReceived.HasValue)
                Sb.AppendFormat(", Date Received: {0}", Receiver.DateReceived.Value.ToShortDateString());

            if (Receiver.ShippingClientRef.HasValue)
            {
                BopsDestination Shipper = _Connector.DwsRepData.Get<BopsDestination>(Receiver.ShippingClientRef.Value);
                Sb.AppendFormat(", Shipper {0}: {1}", Receiver.ShippingClientRef.Value, Shipper);

                if (Shipper.ParentRef.HasValue && Shipper.ParentRef.Value != 0 && Shipper.ParentRef.Value != Shipper.DestinationId)
                {
                    BopsDestination Parent = GetParentDestination(Receiver.ShippingClientRef.Value);
                    Sb.AppendFormat(" (Parent {0}: {1})", Parent.DestinationId, Parent);
                }
            }

            if (Receiver.ReceivingClientRef.HasValue)
            {
                BopsDestination ReceivingClient = _Connector.DwsRepData.Get<BopsDestination>(Receiver.ReceivingClientRef.Value);
                Sb.AppendFormat(", Receiver {0}: {1}", Receiver.ReceivingClientRef.Value, ReceivingClient);

                if (ReceivingClient.ParentRef.HasValue && ReceivingClient.ParentRef.Value != 0 && ReceivingClient.ParentRef.Value != ReceivingClient.DestinationId)
                {
                    BopsDestination Parent = GetParentDestination(Receiver.ReceivingClientRef.Value);
                    Sb.AppendFormat(" (Parent {0}: {1})", Parent.DestinationId, Parent);
                }
            }

            BopsRfsBillingStatus BillingStatus = _Connector.DwsNoRepData.Load<BopsRfsBillingStatus>((int)Receiver.BillingStatus);
            Sb.AppendFormat(", Billing Status: {0}", BillingStatus.Status);

            return Sb.ToString();
        }

        public string Describe(BopsShippingRecord Bol)
        {
            StringBuilder Sb = new StringBuilder("BOL ");
            Sb.Append(Bol.LoadId);

            if (!string.IsNullOrEmpty(Bol.LoadType))
                Sb.AppendFormat(", Type: {0}", Bol.LoadType);

            if (Bol.ShipmentDate.HasValue)
                Sb.AppendFormat(", Date Shipped: {0}", Bol.ShipmentDate.Value.ToShortDateString());

            if (Bol.ShippingClientRef.HasValue)
            {
                BopsDestination Shipper = _Connector.DwsRepData.Get<BopsDestination>(Bol.ShippingClientRef.Value);
                Sb.AppendFormat(", Shipper {0}: {1}", Bol.ShippingClientRef.Value, Shipper);

                if (Shipper.ParentRef.HasValue && Shipper.ParentRef.Value != 0 && Shipper.ParentRef.Value != Shipper.DestinationId)
                {
                    BopsDestination Parent = GetParentDestination(Bol.ShippingClientRef.Value);
                    Sb.AppendFormat(" (Parent {0}: {1})", Parent.DestinationId, Parent);
                }
            }

            if (Bol.DeliveryClientRef.HasValue)
            {
                BopsDestination Destination = _Connector.DwsRepData.Get<BopsDestination>(Bol.DeliveryClientRef.Value);
                Sb.AppendFormat(", Destination {0}: {1}", Bol.DeliveryClientRef.Value, Destination);

                if (Destination.ParentRef.HasValue && Destination.ParentRef.Value != 0 && Destination.ParentRef.Value != Destination.DestinationId)
                {
                    BopsDestination Parent = GetParentDestination(Bol.DeliveryClientRef.Value);
                    Sb.AppendFormat(" (Parent {0}: {1})", Parent.DestinationId, Parent);
                }
            }

            BopsRfsBillingStatus BillingStatus = _Connector.DwsNoRepData.Load<BopsRfsBillingStatus>((int)Bol.BillingStatus);
            Sb.AppendFormat(", Billing Status: {0}", BillingStatus.Status);

            return Sb.ToString();
        }

        public string DescribeCostMethod(BopsRfsRateDetails RateDetails)
        {
            // The following is from the RFS services editing page SQL. It's the template to use for 
            // describing the cost method.

            /*
                CASE [RFS Services Requested].[Public Cost Method Ref] 
                    WHEN 1 THEN '$' + CAST([RFS Services Requested].[Public Cost] AS VARCHAR) 
                    WHEN 2 THEN '$' + CAST([RFS Services Requested].[Public Cost] AS VARCHAR) + ' / ' + [Unit] 
                    WHEN 3 THEN 'Matrix: ' + ISNULL([RFS Cost Matrices].[Name] , '(matrix not specified)') 
                END AS Cost                 
             */

            string ReturnValue = "(unknown)";

            switch ((RfsCostMethods)RateDetails.CostMethodRef)
            {
                case RfsCostMethods.FlatFee:
                    ReturnValue = string.Format("{0:c}", RateDetails.Cost.Value);
                    break;
                case RfsCostMethods.PerUnit:
                    IList<BopsSysUnitOfMeasure> Units = _Connector.DwsNoRepData.CreateCriteria(typeof (BopsSysUnitOfMeasure))
                        .Add(Expression.Eq("UnitId", RateDetails.UnitRef))
                        .List<BopsSysUnitOfMeasure>();
                    string UnitString = (Units.Count == 1) ? Units[0].Name : "(unknown)";
                    ReturnValue = string.Format("{0:c} / {1}", RateDetails.Cost.Value, UnitString);
                    break;
                case RfsCostMethods.Matrix:
                    IList<BopsRfsCostMatrix> Matrices = _Connector.DwsNoRepData.CreateCriteria(typeof (BopsRfsCostMatrix))
                        .Add(Expression.Eq("MatrixId", RateDetails.CostMatrixRef))
                        .List<BopsRfsCostMatrix>();
                    string MatrixName = (Matrices.Count == 1) ? Matrices[0].Name : "(matrix not specified)";
                    ReturnValue = string.Format("Matrix: {0}", MatrixName);
                    break;
            }

            return ReturnValue;
        }
    }
}
