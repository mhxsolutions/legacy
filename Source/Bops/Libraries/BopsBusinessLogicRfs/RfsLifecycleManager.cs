using System;
using System.Text;
using BopsDataAccess;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    public class RfsLifecycleManager : IRfsLifecycleManager
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(RfsLifecycleManager));

        public string ReassignLoadRfs(string loadReference, int newRfs)
        {
            var errors = new StringBuilder();

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var load = rfsDataContext.GetLoadByReference(loadReference);

                if (load == null)
                {
                    errors.Append("The load cannot be found in the database. ");
                }
                else
                {
                    if (load.BillingStatus >= RfsBillingStatus.Approved)
                    {
                        errors.Append("The load bill is approved (or further) in the invoice process. ");
                    }

                    var approvedOrFurther = 0;
                    var bills = rfsDataContext.GetServiceCalculationResultsByLoadReference(load.LoadReference);

                    foreach (var result in bills)
                    {
                        if (result.BillingStatus >= RfsBillingStatus.Approved)
                            approvedOrFurther++;
                    }

                    if (approvedOrFurther > 0)
                    {
                        errors.Append("One or more service calculation results is approved (or further) in the invoice process. ");
                    }

                    // If we make it this far without any errors, we may safely change the RFS. We already
                    // have the list of bills, so we simply delete them here to help with the cleanup.

                    if (errors.Length == 0)
                    {                     
                        foreach (var result in bills)
                            rfsDataContext.RemoveServiceCalculationResult(result);

                        load.RfsRef = newRfs;
                        // TODO: make sure this gets updated
                        rfsDataContext.SaveChanges();
                    }
                }
            }
            catch (Exception e)
            {
                Log.ErrorFormat("An exception occurred while reassigning load {0} to RFS {1}. Details follow.", loadReference, newRfs);
                Log.Error(e);
            }
            finally
            {
                // TODO: free the RFS data context
            }

            return (errors.Length > 0) ? errors.ToString() : null;
        }

        public string ReassignReceiverRfs(int receiverId, int newRfs)
        {
            var errors = new StringBuilder();

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var receiver = rfsDataContext.GetReceiverById(receiverId);

                if (receiver == null)
                {
                    errors.Append("The receiver cannot be found in the database. ");
                }
                else
                {
                    if (receiver.BillingStatus >= RfsBillingStatus.Approved)
                    {
                        errors.Append("The receiver bill is approved (or further) in the invoice process. ");
                    }

                    var approvedOrFurther = 0;
                    var bills = rfsDataContext.GetServiceCalculationResultsByReceiverId(receiver.ReceiverId);
                    
                    foreach (var result in bills)
                    {
                        if (result.BillingStatus >= RfsBillingStatus.Approved)
                            approvedOrFurther++;
                    }

                    if (approvedOrFurther > 0)
                    {
                        errors.Append("One or more service calculation results is approved (or further) in the invoice process. ");
                    }

                    // If we make it this far without any errors, we may safely change the RFS. We already
                    // have the list of bills, so we simply delete them here to help with the cleanup.

                    if (errors.Length == 0)
                    {
                        foreach (var result in bills)
                            rfsDataContext.RemoveServiceCalculationResult(result);

                        receiver.RfsRef = newRfs;
                        // TODO: make sure this gets updated
                        rfsDataContext.SaveChanges();
                    }
                }
            }
            catch (Exception e)
            {
                Log.ErrorFormat("An exception occurred while reassigning receiver {0} to RFS {1}. Details follow.", receiverId, newRfs);
                Log.Error(e);

            }
            finally
            {
                // TODO: free the RFS data context
            }

            return (errors.Length > 0) ? errors.ToString() : null;
        }

        public string ReassignShipperRfs(int shipperId, int newRfs)
        {
            var errors = new StringBuilder();

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var bol = rfsDataContext.GetShipperById(shipperId);

                if (bol == null)
                {
                    errors.Append("The BOL cannot be found in the database. ");
                }
                else
                {
                    if (bol.BillingStatus >= RfsBillingStatus.Approved)
                    {
                        errors.Append("The BOL bill is approved (or further) in the invoice process. ");
                    }

                    var approvedOrFurther = 0;
                    var bills = rfsDataContext.GetServiceCalculationResultsByShipperId(bol.LoadId);

                    foreach (var result in bills)
                    {
                        if (result.BillingStatus >= RfsBillingStatus.Approved)
                            approvedOrFurther++;
                    }

                    if (approvedOrFurther > 0)
                    {
                        errors.Append("One or more service calculation results is approved (or further) in the invoice process. ");
                    }

                    // If we make it this far without any errors, we may safely change the RFS. We already
                    // have the list of bills, so we simply delete them here to help with the cleanup.

                    if (errors.Length == 0)
                    {
                        foreach (var result in bills)
                            rfsDataContext.RemoveServiceCalculationResult(result);

                        bol.RfsRef = newRfs;
                        // TODO: make sure this gets updated
                        rfsDataContext.SaveChanges();
                    }
                }
            }
            catch (Exception e)
            {
                Log.ErrorFormat("An exception occurred while reassigning shipper {0} to RFS {1}. Details follow.", shipperId, newRfs);
                Log.Error(e);

            }
            finally
            {
                // TODO: free the RFS data context
            }

            return (errors.Length > 0) ? errors.ToString() : null;
        }
    }
}
