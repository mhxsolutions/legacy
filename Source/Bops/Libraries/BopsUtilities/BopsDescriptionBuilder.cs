using System;
using System.Text;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsUtilities
{
    public class BopsDescriptionBuilder
    {
        private readonly IRfsDataContext _rfsDataContext;

        public BopsDescriptionBuilder(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;
        }

        private BopsDestination GetParentDestination(int destinationId)
        {
            var returnValue = _rfsDataContext.GetDestinationById(destinationId);
            if (returnValue.ParentRef.HasValue && returnValue.ParentRef != 0 && returnValue.ParentRef != returnValue.DestinationId)
                returnValue = _rfsDataContext.GetDestinationById(returnValue.ParentRef.Value);
            return returnValue;
        }

        public string Describe(BopsLoad load)
        {
            if (load == null)
                throw new ArgumentException("Load cannot be null", "load");

            var sb = new StringBuilder("Load ");
            sb.Append(load.LoadReference);

            if (load.LoadDate.HasValue)
                sb.AppendFormat(", Load Date: {0}", load.LoadDate.Value.ToShortDateString());

            if (load.LogOutDate.HasValue)
                sb.AppendFormat(", Logout Date: {0}", load.LogOutDate.Value.ToShortDateString());

            if (load.GrossWeight.HasValue)
                sb.AppendFormat(", Gross Wt: {0}", load.GrossWeight.Value);

            if (load.ChargedWeight.HasValue)
                sb.AppendFormat(", Charged Wt: {0}", load.ChargedWeight);

            if (load.OriginRef.HasValue)
            {
                var origin = _rfsDataContext.GetDestinationById(load.OriginRef.Value);
                sb.AppendFormat(", Origin {0}: {1}", origin.DestinationId, origin);

                if (origin.ParentRef.HasValue && origin.ParentRef.Value != 0 && origin.ParentRef.Value != origin.DestinationId)
                {
                    var parent = GetParentDestination(load.OriginRef.Value);
                    sb.AppendFormat(" (Parent {0}: {1})", parent.DestinationId, parent);
                }
            }

            if (load.DeliveryLocationRef.HasValue)
            {
                var destination = GetParentDestination(load.DeliveryLocationRef.Value);

                sb.AppendFormat(", Destination {0}: {1}", destination.DestinationId, destination);

                if (destination.ParentRef.HasValue && destination.ParentRef.Value != 0 && destination.ParentRef.Value != destination.DestinationId)
                {
                    var parent = GetParentDestination(load.DeliveryLocationRef.Value);
                    sb.AppendFormat(" (Parent {0}: {1})", parent.DestinationId, parent);
                }
            }

            var billingStatus = _rfsDataContext.GetBillingStatusById((int)load.BillingStatus);
            sb.AppendFormat(", Billing Status: {0}", billingStatus.Status);

            return sb.ToString();
        }

        public string Describe(BopsReceivingRecord receiver)
        {
            var sb = new StringBuilder("Receiver ");
            sb.Append(receiver.ReceiverId);

            if (!string.IsNullOrEmpty(receiver.ReceiverType))
                sb.AppendFormat(", Type: {0}", receiver.ReceiverType);

            if (receiver.DateReceived.HasValue)
                sb.AppendFormat(", Date Received: {0}", receiver.DateReceived.Value.ToShortDateString());

            if (receiver.ShippingClientRef.HasValue)
            {
                var shipper = _rfsDataContext.GetDestinationById(receiver.ShippingClientRef.Value);
                sb.AppendFormat(", Shipper {0}: {1}", receiver.ShippingClientRef.Value, shipper);

                if (shipper.ParentRef.HasValue && shipper.ParentRef.Value != 0 && shipper.ParentRef.Value != shipper.DestinationId)
                {
                    var parent = GetParentDestination(receiver.ShippingClientRef.Value);
                    sb.AppendFormat(" (Parent {0}: {1})", parent.DestinationId, parent);
                }
            }

            if (receiver.ReceivingClientRef.HasValue)
            {
                var receivingClient = _rfsDataContext.GetDestinationById(receiver.ReceivingClientRef.Value);
                sb.AppendFormat(", Receiver {0}: {1}", receiver.ReceivingClientRef.Value, receivingClient);

                if (receivingClient.ParentRef.HasValue && 
                    receivingClient.ParentRef.Value != 0 && 
                    receivingClient.ParentRef.Value != receivingClient.DestinationId)
                {
                    var parent = GetParentDestination(receiver.ReceivingClientRef.Value);
                    sb.AppendFormat(" (Parent {0}: {1})", parent.DestinationId, parent);
                }
            }

            var billingStatus = _rfsDataContext.GetBillingStatusById((int)receiver.BillingStatus);
            sb.AppendFormat(", Billing Status: {0}", billingStatus.Status);

            return sb.ToString();
        }

        public string Describe(BopsShippingRecord Bol)
        {
            var sb = new StringBuilder("BOL ");
            sb.Append(Bol.LoadId);

            if (!string.IsNullOrEmpty(Bol.LoadType))
                sb.AppendFormat(", Type: {0}", Bol.LoadType);

            if (Bol.ShipmentDate.HasValue)
                sb.AppendFormat(", Date Shipped: {0}", Bol.ShipmentDate.Value.ToShortDateString());

            if (Bol.ShippingClientRef.HasValue)
            {
                var shipper = _rfsDataContext.GetDestinationById(Bol.ShippingClientRef.Value);
                sb.AppendFormat(", Shipper {0}: {1}", Bol.ShippingClientRef.Value, shipper);

                if (shipper.ParentRef.HasValue && 
                    shipper.ParentRef.Value != 0 && 
                    shipper.ParentRef.Value != shipper.DestinationId)
                {
                    var parent = GetParentDestination(Bol.ShippingClientRef.Value);
                    sb.AppendFormat(" (Parent {0}: {1})", parent.DestinationId, parent);
                }
            }

            if (Bol.DeliveryClientRef.HasValue)
            {
                var destination = _rfsDataContext.GetDestinationById(Bol.DeliveryClientRef.Value);
                sb.AppendFormat(", Destination {0}: {1}", Bol.DeliveryClientRef.Value, destination);

                if (destination.ParentRef.HasValue && 
                    destination.ParentRef.Value != 0 && 
                    destination.ParentRef.Value != destination.DestinationId)
                {
                    var parent = GetParentDestination(Bol.DeliveryClientRef.Value);
                    sb.AppendFormat(" (Parent {0}: {1})", parent.DestinationId, parent);
                }
            }

            var billingStatus = _rfsDataContext.GetBillingStatusById((int)Bol.BillingStatus);
            sb.AppendFormat(", Billing Status: {0}", billingStatus.Status);

            return sb.ToString();
        }

        public string DescribeCostMethod(BopsRfsRateDetails rateDetails)
        {
            const string unknown = "(unknown)";
            if (!rateDetails.CostMethodRef.HasValue)
                return unknown;
            var costMethod = _rfsDataContext.GetCostMethodById(rateDetails.CostMethodRef.Value);
            return costMethod != null ? costMethod.Name : unknown;
        }

        public string DescribeCost(BopsRfsRateDetails rateDetails)
        {
            // The following is from the RFS services editing page SQL. It's the template to use for 
            // describing the cost.

            /*
                CASE [RFS Services Requested].[Public Cost Method Ref] 
                    WHEN 1 THEN '$' + CAST([RFS Services Requested].[Public Cost] AS VARCHAR) 
                    WHEN 2 THEN '$' + CAST([RFS Services Requested].[Public Cost] AS VARCHAR) + ' / ' + [Unit] 
                    WHEN 3 THEN 'Matrix: ' + ISNULL([RFS Cost Matrices].[Name] , '(matrix not specified)') 
                END AS Cost                 
             */

            const string unknown = "(unknown)";
            if (!rateDetails.CostMethodRef.HasValue)
                return unknown;

            var returnValue = unknown;
            switch ((RfsCostMethods)rateDetails.CostMethodRef)
            {
                case RfsCostMethods.FlatFee:
                    if (rateDetails.Cost.HasValue)
                        returnValue = string.Format("{0:c}", rateDetails.Cost.Value);
                    break;
                case RfsCostMethods.PerUnit:
                    if (rateDetails.UnitRef.HasValue)
                    {
                        var unit = _rfsDataContext.GetUnitOfMeasureById(rateDetails.UnitRef.Value);
                        var unitString = (unit != null) ? unit.Name : unknown;
                        if (rateDetails.Cost.HasValue)
                            returnValue = string.Format("{0:c} / {1}", rateDetails.Cost.Value, unitString);
                    }
                    break;
                case RfsCostMethods.Matrix:
                    if (rateDetails.CostMatrixRef.HasValue)
                    {
                        var matrix = _rfsDataContext.GetCostMatrixById(rateDetails.CostMatrixRef.Value);
                        var matrixName = (matrix != null) ? matrix.Name : "(matrix not specified)";
                        returnValue = string.Format("Matrix: {0}", matrixName);
                    }
                    break;
            }

            return returnValue;
        }
    }
}
