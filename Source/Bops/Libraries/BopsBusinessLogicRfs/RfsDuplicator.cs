using System;
using System.Collections.Generic;
using BopsDataAccess;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    class RfsDuplicator : IRfsDuplicator
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(RfsDuplicator));

        private readonly IRfsDataContext _rfsDataContext;

        public RfsDuplicator(IRfsDataContext rfsDataContext)
        {
            _rfsDataContext = rfsDataContext;
        }

        /// <summary>
        /// Duplicates the specified RFS, returning the ID of the new RFS if successful or
        /// zero in case of failure.
        /// </summary>
        /// <param name="rfsId">The ID of the RFS to be duplicated.</param>
        /// <returns>The ID number of the newly created, duplicate RFS if successful, zero otherwise.</returns>
        public int DuplicateRfs(int rfsId)
        {
            var returnValue = 0;
            var sourceRfs = _rfsDataContext.GetRfsById(rfsId);

            if (sourceRfs != null)
            {
                var sourceStakeholders = _rfsDataContext.GetStakeholdersByRfsId(sourceRfs.RfsId);
                var sourceServices = _rfsDataContext.GetServicesRequestedByRfsId(sourceRfs.RfsId);

                try
                {
                    var newRfs = new BopsRfs(sourceRfs) {RfsId = 0};
                    _rfsDataContext.AddRfs(newRfs);
                    _rfsDataContext.SaveChanges();  // TODO: not necessary if the RFS references the stuff

                    var stakeholderMap = new Dictionary<int, int>();

                    foreach (var stakeholder in sourceStakeholders)
                    {
                        var newStakeholder = new BopsRfsStakeholder(stakeholder)
                        {
                            StakeholderId = 0,
                            RfsRef = newRfs.RfsId
                        };
                        _rfsDataContext.AddStakeholder(newStakeholder);
                        _rfsDataContext.SaveChanges();  // TODO: not necessary if the RFS references the stuff
                        stakeholderMap.Add(stakeholder.StakeholderId, newStakeholder.StakeholderId);
                    }

                    var errorCount = 0;

                    foreach (var service in sourceServices)
                    {
                        var newService = new BopsRfsServicesRequested(service)
                        {
                            ServiceRequestedId = 0,
                            RfsRef = newRfs.RfsId
                        };

                        if (service.ShipperRef.HasValue)
                        {
                            if (stakeholderMap.ContainsKey(service.ShipperRef.Value))
                            {
                                newService.ShipperRef = stakeholderMap[service.ShipperRef.Value];
                            }
                            else
                            {
                                newService.ShipperRef = null;    
                                Log.WarnFormat("Service {0} has invalid shipper stakeholder {1}", service.ServiceRequestedId, service.ShipperRef);
                                errorCount++;
                            }
                        }

                        if (service.ReceiverRef.HasValue)
                        {
                            if (stakeholderMap.ContainsKey(service.ReceiverRef.Value))
                            {
                                newService.ReceiverRef = stakeholderMap[service.ReceiverRef.Value];
                            }
                            else
                            {
                                newService.ReceiverRef = null;
                                Log.WarnFormat("Service {0} has invalid receiver stakeholder {1}", service.ServiceRequestedId, service.ReceiverRef);
                                errorCount++;
                            }
                        }

                        if (service.OriginRef.HasValue)
                        {
                            if (stakeholderMap.ContainsKey(service.OriginRef.Value))
                            {
                                newService.OriginRef = stakeholderMap[service.OriginRef.Value];
                            }
                            else
                            {
                                newService.OriginRef = null;
                                Log.WarnFormat("Service {0} has invalid origin stakeholder {1}", service.ServiceRequestedId, service.OriginRef);
                                errorCount++;
                            }
                        }

                        if (service.DestinationRef.HasValue)
                        {
                            if (stakeholderMap.ContainsKey(service.DestinationRef.Value))
                            {
                                newService.DestinationRef = stakeholderMap[service.DestinationRef.Value];
                            }
                            else
                            {
                                newService.DestinationRef = null;
                                Log.WarnFormat("Service {0} has invalid destination stakeholder {1}", service.ServiceRequestedId, service.DestinationRef);
                                errorCount++;
                            }
                        }

                        if (service.BillToRef.HasValue)
                        {
                            if (stakeholderMap.ContainsKey(service.BillToRef.Value))
                            {
                                newService.BillToRef = stakeholderMap[service.BillToRef.Value];
                            }
                            else
                            {
                                newService.BillToRef = null;
                                Log.WarnFormat("Service {0} has invalid bill-to stakeholder {1}", service.ServiceRequestedId, service.BillToRef);
                                errorCount++;
                            }
                        }

                        _rfsDataContext.AddServiceRequested(newService);
                        _rfsDataContext.SaveChanges();  // TODO: not necessary if the RFS references the stuff
                    }

                    if (errorCount == 0)
                    {
                        returnValue = newRfs.RfsId;
                    }
                    else
                    {
                        // TODO: Do we need to do anything to rollback?
                    }
                }
                catch (Exception e)
                {
                    Log.ErrorFormat("An exception occurred while duplicating RFS ID {0}. Details follows.", rfsId);
                    Log.Error(e);
                }
            }

            return returnValue;
        }
    }
}
