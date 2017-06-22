
using System;
using System.Collections.Generic;
using System.Xml;
using log4net;

namespace AgilisCore
{
    public enum AgilisExportMode
    {
        None,
        Add,
        Update
    }

    public class AgilisExporter
    {
        #region Fields

        private static readonly ILog Log = LogManager.GetLogger(typeof(AgilisExporter));

        #endregion

        #region Properties

        public string AgilisBaseRestUrl { get; set; }
        public string AgilisCompanyId { get; set; }
        public AgilisExportMode ExportMode { get; set;  }
        public bool ConvertTimesToUtc { get; set; }

        /// <summary>
        /// If this parameter is set to true, then the various outgoing calls that modify data
        /// in the Agilis system will be logged BUT NOT EXECUTED WITH AGILIS. This makes it 
        /// very useful for debugging.
        /// </summary>
        public bool SimulationOnly { get; set; }

        private AgilisOperationTypes OperationType
        {
            get { return ExportMode == AgilisExportMode.Add ? AgilisOperationTypes.ExportFull : AgilisOperationTypes.ExportUpdate; }
        }

        #endregion

        #region Construction
        public AgilisExporter(string agilisBaseRestUrl, string agilisCompanyId, AgilisExportMode exportMode, bool convertTimesToUtc, bool simulationOnly)
        {
            AgilisBaseRestUrl = agilisBaseRestUrl;
            AgilisCompanyId = agilisCompanyId;
            ExportMode = exportMode;
            ConvertTimesToUtc = convertTimesToUtc;
            SimulationOnly = simulationOnly;
        }
        #endregion

        private Dictionary<string, string> CreateAgilisParameters(AgilisWorkOrder workOrder)
        {
            var returnValue = new Dictionary<string, string>
                                  {
                                      {"driver_nbr", workOrder.DriverNumber.ToString()},
                                      {"wo_number", workOrder.WorkOrderNumber},
                                      {"wo_group_number", workOrder.WorkOrderGroup}
                                  };

            // The job code parameter is required only for a new job within the work order.
            if (ExportMode == AgilisExportMode.Add)
                returnValue.Add("wo_job_code", workOrder.Jobs[0].AgilisJobType);

            var slotStartDate = ConvertTimesToUtc ? AgilisUtilities.LocalTimeToAgilisTime(workOrder.SlotStartDate) : workOrder.SlotStartDate;
            returnValue.Add("slot_start_date", slotStartDate.ToString("s"));

            returnValue.Add("cust_first_name", workOrder.CustomerFirstName);
            returnValue.Add("cust_street_addr_1", workOrder.CustomerStreetAddress1);
            returnValue.Add("cust_street_addr_2", workOrder.CustomerStreetAddress2);
            returnValue.Add("cust_city", workOrder.CustomerCity);
            returnValue.Add("cust_state", workOrder.CustomerState);
            returnValue.Add("cust_zip", workOrder.CustomerZipCode);

            returnValue.Add("pickup_first_name", workOrder.PickupFirstName);
            returnValue.Add("pickup_street_addr_1", workOrder.PickupStreetAddress1);
            returnValue.Add("pickup_street_addr_2", workOrder.PickupStreetAddress2);
            returnValue.Add("pickup_city", workOrder.PickupCity);
            returnValue.Add("pickup_state", workOrder.PickupState);
            returnValue.Add("pickup_zip", workOrder.PickupZipCode);
            returnValue.Add("wo_notes", workOrder.Notes);

            returnValue.Add("misc1", workOrder.Sequence.ToString());
            returnValue.Add("misc2", workOrder.PlannerDetailId.ToString());
            returnValue.Add("misc3", workOrder.OriginId.ToString());
            returnValue.Add("misc4", workOrder.DestinationId.ToString());
            returnValue.Add("misc5", workOrder.DisplayWorkOrderNumber);
            returnValue.Add("misc6", workOrder.Trailer);

            // The alternate slot start date was added as a parameter by Diane Powers so that we
            // could start displaying the scheduled arrival time on the phones.

            var scheduledArrive = ConvertTimesToUtc ? AgilisUtilities.LocalTimeToAgilisTime(workOrder.ScheduledArrive) : workOrder.ScheduledArrive;
            returnValue.Add("alt_slot_start_date", scheduledArrive.ToString("s"));

            return returnValue;
        }

        private static Dictionary<string, string> CreateAgilisParameters(AgilisDriver driver)
        {
            var returnValue = new Dictionary<string, string>
                                  {
                                      {"driver_nbr", driver.DriverId.ToString()},
                                      {"drv_user_name", MakeDriverUserId(driver.FirstName, driver.LastName)},
                                      {"drv_password", "password"},
                                      {"device_number", driver.PhoneNumber},
                                      {"first_name", driver.FirstName},
                                      {"last_name", driver.LastName},
                                      {"active", driver.Active ? "true" : "false"},
                                      {"tz_pref", "PST"}
                                  };

            // Removed both of these parameters to avoid confusion over driver fleet IDs and business unit numbers.
            // Previously, AIS was using defaults of 155 and 101 respectively, but at some point 155 became a non-Budway
            // fleet ID and was causing problems. 
            //
            // JBW 10/30/2007 11:04

            //ReturnValue.Add("fleet_id", Driver.FleetNumber.ToString());
            //ReturnValue.Add("bus_unit_nbr", Driver.BusinessUnitNumber.ToString());

            return returnValue;
        }

        private static string MakeDriverUserId(string firstName, string lastName)
        {
            return firstName.ToLower() + lastName[0].ToString().ToLower();
        }

        private static bool ResponseStatusIsOk(string resultNodeName, string response)
        {
            try
            {
                var parser = new XmlDocument {InnerXml = response};

                foreach (XmlNode node in parser[resultNodeName])
                {
                    if (node.Name == "Status" && node.FirstChild != null && node.FirstChild.Value == "OK")
                        return true;
                }
            }
            catch (Exception e)
            {
                Log.Error("An error occurred while parsing the response, details follow.", e);
            }

            return false;
        }

        public AgilisIntegrationOperation ExportWorkOrders(List<AgilisWorkOrder> workOrders, string userId, string password, 
            IAgilisStatusInterface statusCallback)
        {
            var returnValue = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrders, OperationType);
            var status = (statusCallback ?? new AgilisStatusSink());

            if (workOrders.Count < 1)
            {
                status.ProgressUpdate("No work orders found to export.", "", 0, 0);
                returnValue.Successful = true;
            }
            else
            {
                var totalWorkOrders = workOrders.Count;
                var currentWorkOrder = 0;
                
                try
                {
                    // Setting the plan date in the return value ensures that the proper plan date is
                    // stored in the database tables.

                    returnValue.PlanDate = workOrders[0].SlotStartDate.ToLocalTime();
                    var agilisReader = new AgilisDataReader(AgilisBaseRestUrl, AgilisCompanyId, userId, password, SimulationOnly);
                
                    foreach (var workOrder in workOrders)
                    {
                        try
                        {
                            string response;
                            status.ProgressUpdate(String.Format("Processing work order {0}", workOrder.WorkOrderNumber), "", ++currentWorkOrder, totalWorkOrders);
                            var parameters = CreateAgilisParameters(workOrder);
                            agilisReader.CallAgilisRestApiMethod("workOrders/save", parameters, out response);
                    
                            if (SimulationOnly || ResponseStatusIsOk("SaveWorkOrderResult", response))
                            {
                                returnValue.RecordsSuccessful++;
                            }
                            else
                            {
                                Log.ErrorFormat("Unexpected response exporting work order {0}, details follow.", workOrder.WorkOrderNumber);
                                Log.Error(response);
                                returnValue.ErrorCount++;
                                returnValue.RecordsFailed++;
                            }
                        }
                        catch (Exception e)
                        {
                            Log.Error("An exception occurred while exporting work order. Details follow.", e);
                            returnValue.ErrorCount++;
                        }
                    }
                }
                catch (Exception e)
                {
                    Log.Error("A fatal exception occurred while exporting work orders, terminating operation. Details follow.", e);
                    returnValue.ErrorCount++;
                }

                if (returnValue.ErrorCount > 0)
                {
                    status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
                }
                else
                {
                    status.ProgressUpdate("Done", "", 0, 0);
                    returnValue.Successful = true;
                }
            }

            returnValue.EndDate = DateTime.Now;
            return returnValue;
        }

        public AgilisIntegrationOperation ExportDrivers(List<AgilisDriver> drivers, string userId, string password, 
            IAgilisStatusInterface statusCallback)
        {
            var returnValue = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrders, OperationType);
            var status = (statusCallback ?? new AgilisStatusSink());

            if (drivers.Count < 1)
            {
                status.ProgressUpdate("No drivers found to export.", "", 0, 0);
                returnValue.Successful = true;
            }
            else
            {
                int totalWorkOrders = drivers.Count, current = 0;

                try
                {
                    var agilisReader = new AgilisDataReader(AgilisBaseRestUrl, AgilisCompanyId, userId, password, SimulationOnly);
    
                    foreach (var driver in drivers)
                    {
                        try
                        {
                            string response;
                            status.ProgressUpdate(String.Format("Processing driver {0}", driver.DriverId), "", ++current, totalWorkOrders);
                            var parameters = CreateAgilisParameters(driver);
                            agilisReader.CallAgilisRestApiMethod("drivers/save", parameters, out response);

                            if (SimulationOnly || ResponseStatusIsOk("SaveDriverResult", response))
                            {
                                returnValue.RecordsSuccessful++;
                            }
                            else
                            {
                                Log.WarnFormat("Unexpected response exporting driver {0}, details follow.", driver.DriverId);
                                Log.Warn(response);
                                returnValue.RecordsFailed++;
                                returnValue.ErrorCount++;
                            }
                        }
                        catch (Exception e)
                        {
                            Log.Error("An exception occurred while exporting driver. Details follow.", e);
                            returnValue.RecordsFailed++;
                            returnValue.ErrorCount++;
                        }
                    }
                }
                catch (Exception e)
                {
                    Log.Error("A fatal exception occurred while exporting drivers, terminating operation. Details follow.", e);
                    returnValue.ErrorCount++;
                }

                if (returnValue.ErrorCount > 0)
                {
                    status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
                }
                else
                {
                    status.ProgressUpdate("Done", "", 0, 0);
                    returnValue.Successful = true;
                }
            }

            returnValue.EndDate = DateTime.Now;
            return returnValue;
        }

        public AgilisIntegrationOperation CancelWorkOrders(List<AgilisWorkOrder> workOrders, string userId, string password, 
            IAgilisStatusInterface statusCallback)
        {
            var returnValue = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrders, AgilisOperationTypes.Cancel);
            var status = (statusCallback ?? new AgilisStatusSink());

            if (workOrders.Count == 0)
            {
                status.ProgressUpdate("No work orders found to cancel.", "", 0, 0);
                Log.Warn("Cancel work orders was called with an empty list.");
                returnValue.Successful = true;
            }
            else
            {
                int totalWorkOrders = workOrders.Count, current = 0;
                
                try
                {
                    var agilisReader = new AgilisDataReader(AgilisBaseRestUrl, AgilisCompanyId, userId, password, SimulationOnly);

                    foreach (var workOrder in workOrders)
                    {
                        try
                        {
                            string response;
                            status.ProgressUpdate(String.Format("Cancelling work order {0}", workOrder.WorkOrderNumber), "", ++current, totalWorkOrders);
                            var parameters = new Dictionary<string, string>();
                            parameters.Add("wo_number", workOrder.WorkOrderNumber);
                            agilisReader.CallAgilisRestApiMethod("workOrders/cancel", parameters, out response);

                            if (SimulationOnly || ResponseStatusIsOk("CancelWorkOrderResult", response))
                            {
                                Log.InfoFormat("Cancelled work order number {0}.", workOrder.WorkOrderNumber);
                                returnValue.RecordsSuccessful++;
                            }
                            else
                            {
                                Log.WarnFormat("Unexpected response cancelling work order {0}, details follow.", workOrder.WorkOrderNumber);
                                Log.Warn(response);
                                returnValue.ErrorCount++;
                            }
                        }
                        catch (Exception e)
                        {
                            Log.Error("An exception occurred while cancelling work order. Details follow.", e);
                            returnValue.ErrorCount++;
                        }
                    }
                }
                catch (Exception e)
                {
                    Log.Error("A fatal exception occurred while cancelling work orders. Details follow.", e);
                    returnValue.ErrorCount++;
                }

                if (returnValue.ErrorCount > 0)
                {
                    status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
                }
                else
                {
                    status.ProgressUpdate("Done", "", 0, 0);
                    returnValue.Successful = true;
                }
            }

            returnValue.EndDate = DateTime.Now;
            return returnValue;
        }

        public AgilisIntegrationOperation ReactivateWorkOrders(List<AgilisWorkOrder> workOrders, string userId, string password,
            IAgilisStatusInterface statusCallback)
        {
            var returnValue = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrders, AgilisOperationTypes.Reactivate);
            IAgilisStatusInterface status = (statusCallback ?? new AgilisStatusSink());

            if (workOrders.Count == 0)
            {
                status.ProgressUpdate("No work orders found to reactivate.", "", 0, 0);
                Log.Warn("Reactivate work orders was called with an empty list.");
                returnValue.Successful = true;
            }
            else
            {
                int totalWorkOrders = workOrders.Count, current = 0;

                try
                {
                    var agilisReader = new AgilisDataReader(AgilisBaseRestUrl, AgilisCompanyId, userId, password, SimulationOnly);

                    foreach (var workOrder in workOrders)
                    {
                        try
                        {
                            status.ProgressUpdate(String.Format("Reactivating work order {0}", workOrder.WorkOrderNumber), "", ++current, totalWorkOrders);

                            foreach (var job in workOrder.Jobs)
                            {
                                string response;
                                var parameters = new Dictionary<string, string>
                                                     {{"wo_number", workOrder.WorkOrderNumber}};
                                agilisReader.CallAgilisRestApiMethod("workOrders/uncancel", parameters, out response);

                                if (SimulationOnly || ResponseStatusIsOk("UncancelWorkOrderResult", response))
                                {
                                    Log.InfoFormat("Reactivated work order number {0}.", workOrder.WorkOrderNumber);
                                    returnValue.RecordsSuccessful++;
                                }
                                else
                                {
                                    Log.WarnFormat("Unexpected response reactivating work order {0}, job {1}, details follow.",
                                                    workOrder.WorkOrderNumber, job.AgilisJobId);
                                    Log.Warn(response);
                                    returnValue.ErrorCount++;
                                }
                            }
                        }
                        catch (Exception e)
                        {
                            Log.Error("An exception occurred while reactivating work order. Details follow.", e);
                            returnValue.ErrorCount++;
                        }
                    }
                }
                catch (Exception e)
                {
                    Log.Error("A fatal exception occurred while reactivating work orders. Details follow.", e);
                    returnValue.ErrorCount++;
                }

                if (returnValue.ErrorCount > 0)
                {
                    status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
                }
                else
                {
                    status.ProgressUpdate("Done", "", 0, 0);
                    returnValue.Successful = true;
                }
            }

            returnValue.EndDate = DateTime.Now;
            return returnValue;
        }

    }
}
