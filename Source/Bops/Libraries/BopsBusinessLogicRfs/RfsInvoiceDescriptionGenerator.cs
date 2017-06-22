using System.Collections.Generic;
using System.Linq;
using System.Text;
using BopsDataAccess;
using BopsUtilities;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    public class RfsInvoiceDescriptionGenerator
    {
        private IDictionary<int, BopsRfsServicesRequested> _servicesRequestedMap;
        private IDictionary<int, BopsRfsServicesOffered> _servicesOfferedMap;
        private IDictionary<string, BopsLoad> _loadsMap;
        private IDictionary<int, BopsDestination> _destinationsMap;
        private IDictionary<int, BopsRfs> _rfsMap;

        public BopsRfsServicesOffered LookupServiceOffered(int serviceOfferedId)
        {
            return _servicesOfferedMap.ContainsKey(serviceOfferedId) ? _servicesOfferedMap[serviceOfferedId] : null;
        }

        public BopsRfsServicesRequested LookupServiceRequested(int serviceRequestedId)
        {
            return _servicesRequestedMap.ContainsKey(serviceRequestedId) ? _servicesRequestedMap[serviceRequestedId] : null;
        }

        public BopsDestination LookupDestination(int destinationId)
        {
            return _destinationsMap.ContainsKey(destinationId) ? _destinationsMap[destinationId] : null;
        }

        public BopsRfs LookupRfs(int rfsId)
        {
            return _rfsMap.ContainsKey(rfsId) ? _rfsMap[rfsId] : null;
        }

        private void CacheServiceData(IRfsDataContext rfsDataContext, ICollection<string> loads)
        {
            // TODO: Update this to use user company detail if appropriate.

            _destinationsMap = rfsDataContext.GetDestinations(0, 0, 0)
                .ToDictionary(d => d.DestinationId, d => d);
            _servicesOfferedMap = rfsDataContext.GetServicesOffered(0)
                .ToDictionary(s => s.Id, s => s);
            _servicesRequestedMap = rfsDataContext.GetServicesRequested(0, 0, 0)
                .ToDictionary(s => s.ServiceRequestedId, s => s);
            _rfsMap = rfsDataContext.GetRfs(0, 0, 0).ToDictionary(r => r.RfsId, r => r);

            _loadsMap = rfsDataContext.GetLoadsByReferences(loads.ToArray()).ToDictionary(l => l.LoadReference, l => l);
        }

        public RfsInvoiceDescriptionGenerator(IRfsDataContext rfsDataContext, ICollection<string> loads)
        {
            CacheServiceData(rfsDataContext, loads);
        }

        public RfsInvoiceDescriptionGenerator(IDictionary<int, BopsRfsServicesRequested> servicesRequestedMap, 
            IDictionary<int, BopsRfsServicesOffered> servicesOfferedMap,
            IDictionary<string, BopsLoad> loadsMap, 
            IDictionary<int, BopsDestination> destinationsMap)
        {
            _servicesRequestedMap = servicesRequestedMap;
            _servicesOfferedMap = servicesOfferedMap;
            _loadsMap = loadsMap;
            _destinationsMap = destinationsMap;
            _rfsMap = null;
        }

        /// <summary>
        /// Helper method that takes a string, which may or may not contain client references, and appends it 
        /// with formatting to the given string builder.
        /// </summary>
        /// <param name="inputData">The input string which may or may not contain client references.</param>
        /// <param name="sb">The string builder to which data should be appended.</param>
        private static void AppendClientInfoString(string inputData, StringBuilder sb)
        {
            // If we weren't given anything for input data, do nothing.

            if (inputData == null)
                return;

            // If all we were given is a string of blanks, do nothing.

            var trimmedString = inputData.Trim();
            if (string.IsNullOrEmpty(trimmedString))
                return;

            // Otherwise, append the string. Then append a period, if it doesn't already end in one, and add a space
            // at the end. Neatness counts.

            sb.Append(trimmedString);
            if (trimmedString.Substring(trimmedString.Length - 1, 1) != ".")
                sb.Append(".");
            sb.Append(" ");
        }

        public string GenerateDescription(BopsRfsBillDetail bd)
        {
            var sb = new StringBuilder();
            var serviceRequested = _servicesRequestedMap[bd.ServiceResult.ServiceId];
            var serviceOffered = _servicesOfferedMap[serviceRequested.ServiceOfferedRef];

            if (bd.ServiceResult.IsReceiver)
            {
                AppendClientInfoString(bd.Receiver.ClientInvoiceData, sb);

                sb.AppendFormat("Receiver {0}, {1}, Service {2}", bd.ServiceResult.DocumentId, serviceOffered.Name, bd.ServiceResult.ServiceId);
                if (!string.IsNullOrEmpty(bd.ServiceResult.PublicRate.CalculationDetails))
                    sb.AppendFormat(", {0}", bd.ServiceResult.PublicRate.CalculationDetails);
            }
            else if (bd.ServiceResult.IsBillOfLading)
            {
                AppendClientInfoString(bd.Shipper.ClientInvoiceData, sb);

                sb.AppendFormat("BOL {0}, {1}, Service {2}", bd.ServiceResult.DocumentId, serviceOffered.Name, bd.ServiceResult.ServiceId);
                if (bd.Shipper != null && bd.Shipper.PostedCount.HasValue)
                    sb.AppendFormat(", {0} unit(s)", bd.Shipper.PostedCount.Value);
                if (!string.IsNullOrEmpty(bd.ServiceResult.PublicRate.CalculationDetails))
                    sb.AppendFormat(", {0}", bd.ServiceResult.PublicRate.CalculationDetails);
            }
            else
            {
                AppendClientInfoString(bd.Load.ClientInvoiceData, sb);

                sb.AppendFormat("Load {0}, {1}, Service {2}", bd.ServiceResult.LoadRef, serviceOffered.Name, bd.ServiceResult.ServiceId);
                if (!string.IsNullOrEmpty(bd.ServiceResult.PublicRate.CalculationDetails))
                    sb.AppendFormat(", {0}", bd.ServiceResult.PublicRate.CalculationDetails);

                if (_loadsMap.ContainsKey(bd.ServiceResult.LoadRef))
                {
                    var loadDetails = _loadsMap[bd.ServiceResult.LoadRef];

                    if (loadDetails.OriginRef.HasValue && _destinationsMap.ContainsKey(loadDetails.OriginRef.Value) &&
                        loadDetails.DeliveryLocationRef.HasValue && _destinationsMap.ContainsKey(loadDetails.DeliveryLocationRef.Value))
                    {
                        var originDetails = _destinationsMap[loadDetails.OriginRef.Value];
                        var destinationDetails = _destinationsMap[loadDetails.DeliveryLocationRef.Value];
                        sb.AppendFormat(", {0} to {1}", originDetails, destinationDetails);
                    }
                }
            }

            sb.Append(".");
            return sb.ToString();
        }
    }
}
