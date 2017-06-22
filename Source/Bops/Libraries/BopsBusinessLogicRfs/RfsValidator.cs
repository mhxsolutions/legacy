using System.Collections.Generic;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    class RfsValidator : IRfsValidator
    {
        private readonly IRfsDataContext _rfsDataContext;

        public RfsValidator(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;
        }

        /// <summary>
        ///  Checks a single RFS for issues and returns a list of errors or null if there are none.
        /// </summary>
        /// <param name="rfsId">The RFS ID to be checked.</param>
        /// <returns></returns>
        public List<RfsValidationError> ValidateSingleRfs(int rfsId)
        {
            var returnValue = new List<RfsValidationError>();

            // Verify that the RFS itself exists.

            var targetRfs = _rfsDataContext.GetRfsById(rfsId);
            if (targetRfs == null)
            {
                returnValue.Add(new RfsValidationError(rfsId, RfsValidationError.ErrorType.RfsDoesNotExist, rfsId));
                return returnValue;
            }

            // Verify that the shipper exists.

            var shipperClient = _rfsDataContext.GetDestinationById(targetRfs.ShipperRef);
            if (shipperClient == null)
                returnValue.Add(new RfsValidationError(rfsId, RfsValidationError.ErrorType.ShipperClientDoesNotExist, targetRfs.ShipperRef));

            // Verify that all existing stakeholders point to valid clients.

            var targetStakeholders = _rfsDataContext.GetStakeholdersByRfsId(targetRfs.RfsId);

            var shipperStakeholders = 0;
            foreach (var stakeholder in targetStakeholders)
            {
                var client = _rfsDataContext.GetDestinationById(stakeholder.ClientRef);
                if (client == null)
                    returnValue.Add(new RfsValidationError(rfsId, RfsValidationError.ErrorType.StakeholderClientDoesNotExist, stakeholder.StakeholderId));

                if (stakeholder.RoleRef == BopsRfsStakeholderRoleType.Shipper)
                    shipperStakeholders++;
            }

            // Verify that the stakeholders list includes one and only one shipper.

            if (shipperStakeholders < 1)
                returnValue.Add(new RfsValidationError(rfsId, RfsValidationError.ErrorType.ShipperStakeholderDoesNotExist, 0));
            else if (shipperStakeholders > 1)
                returnValue.Add(new RfsValidationError(rfsId, RfsValidationError.ErrorType.ShipperStakeholderCountIsNotOne, 0));

            // Verify the list of existing services requested.

            var targetServices = _rfsDataContext.GetServicesRequestedByRfsId(targetRfs.RfsId);

            foreach (var service in targetServices)
            {
                // Verify that the referenced service offered exists.

                var serviceOffered = _rfsDataContext.GetServiceOfferedById(service.ServiceOfferedRef);
                if (serviceOffered == null)
                    returnValue.Add(new RfsValidationError(rfsId, RfsValidationError.ErrorType.ServiceOfferedDoesNotExist, service.ServiceRequestedId));

                // Verify the stakeholder references.

                var stakeholderError = ValidateReferencedStakeholder(rfsId, service.ServiceRequestedId, service.ShipperRef, BopsRfsStakeholderRoleType.Shipper);
                if (stakeholderError != null)
                    returnValue.Add(stakeholderError);

                stakeholderError = ValidateReferencedStakeholder(rfsId, service.ServiceRequestedId, service.ReceiverRef, BopsRfsStakeholderRoleType.Receiver);
                if (stakeholderError != null)
                    returnValue.Add(stakeholderError);

                stakeholderError = ValidateReferencedStakeholder(rfsId, service.ServiceRequestedId, service.OriginRef, BopsRfsStakeholderRoleType.Origin);
                if (stakeholderError != null)
                    returnValue.Add(stakeholderError);

                stakeholderError = ValidateReferencedStakeholder(rfsId, service.ServiceRequestedId, service.DestinationRef, BopsRfsStakeholderRoleType.Destination);
                if (stakeholderError != null)
                    returnValue.Add(stakeholderError);

                stakeholderError = ValidateReferencedStakeholder(rfsId, service.ServiceRequestedId, service.BillToRef, BopsRfsStakeholderRoleType.BillTo);
                if (stakeholderError != null)
                    returnValue.Add(stakeholderError);
            }

            return (returnValue.Count > 0) ? returnValue : null;
        }

        private RfsValidationError ValidateReferencedStakeholder(int rfsId, int serviceId, int? stakeholderId, 
            BopsRfsStakeholderRoleType roleToEnforce)
        {
            if (!stakeholderId.HasValue) return null;

            var stakeholder = _rfsDataContext.GetStakeholderById(stakeholderId.Value);
            if (stakeholder == null)
                return new RfsValidationError(rfsId, RfsValidationError.ErrorType.StakeholderDoesNotExist, serviceId);

            if (stakeholder.RfsRef != rfsId)
                return new RfsValidationError(rfsId, RfsValidationError.ErrorType.StakeholderRfsMismatch, stakeholderId.Value);

            if (stakeholder.RoleRef != roleToEnforce)
                return new RfsValidationError(rfsId, RfsValidationError.ErrorType.StakeholderRoleMismatch, stakeholderId.Value);

            return null;
        }
    }
}
