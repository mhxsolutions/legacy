using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    public class RfsStorageBillingCalculator : IRfsStorageBillingCalculator
    {
        #region Helper Classes

        /// <summary>
        /// Puts BopsRfsStorageBillingDetail records in an order so that they may be rolled back. To be more precise, the 
        /// later billings have to be rolled back before the earlier billing, or else earlier inventory tracking dates could
        /// get overwritten with later inventory tracking dates.
        /// </summary>
        private class DetailRollbackComparer : IComparer<BopsRfsStorageBillingDetail>
        {
            private readonly Dictionary<int, BopsRfsStorageBilling> _billingMap;

            public DetailRollbackComparer(Dictionary<int, BopsRfsStorageBilling> billingMap)
            {
                _billingMap = billingMap;
            }

            public int Compare(BopsRfsStorageBillingDetail x, BopsRfsStorageBillingDetail y)
            {
                // Basic data setup. Get the detail records and their associated billings.

                Debug.Assert(_billingMap.ContainsKey(x.BillingRef) && _billingMap.ContainsKey(y.BillingRef));

                var leftBilling = _billingMap[x.BillingRef];
                var rightBilling = _billingMap[y.BillingRef];

                // Step 1: compare the billing dates billed through, sorting prior before after.

                if (leftBilling.DateBilledThrough > rightBilling.DateBilledThrough)
                    return -1;
                if (leftBilling.DateBilledThrough < rightBilling.DateBilledThrough)
                    return 1;

                // Step 2: if the billing dates are the same, then check the billing detail IDs.

                if (x.DetailId > y.DetailId)
                    return -1;
                if (x.DetailId < y.DetailId)
                    return 1;

                // If we've made it this far, then we're dealing with the same billing detail ID.

                return 0;
            }
        }

        private class CalcResult
        {
            public readonly BopsRfsStorageBillingDetail Detail;
            public readonly BopsRfsStorageBillingInventoryTracking Tracking;

            public CalcResult()
            {
                Detail = new BopsRfsStorageBillingDetail();
                Tracking = new BopsRfsStorageBillingInventoryTracking();
            }
        }

        private class BillingSegment
        {
            public int AssignmentId { get; set; }

            public int RateId { get; set; }

            public double Cycles { get; set; }

            public int BillingDays { get; set; }

            public int CycleDays { get; set; }

            public DateTime BeginDate { get; set; }

            public DateTime EndDate { get; set; }

            public double Quantity { get; set; }

            public double Rate { get; set; }

            public double Revenue { get; set; }

            public string QuantityString { get; set; }

            public string UnitString { get; set; }

            public string SingleResultString
            {
                get
                {
                    return string.Format(" for {0:n3} {1} at {2:c}/{3}.", Quantity, QuantityString, Rate, UnitString);
                }
            }
        }

        private class StorageBillingPlan
        {
            private readonly double _totalCycles;
            private readonly int _totalBillingDays;
            private readonly int _totalCycleDays;
            private readonly List<BillingSegment> _segments;

            public StorageBillingPlan(IEnumerable<BillingSegment> segments, double totalCycles, 
                int totalBillingDays, int totalCycleDays)
            {
                _segments = new List<BillingSegment>(segments);
                _totalCycles = totalCycles;
                _totalBillingDays = totalBillingDays;
                _totalCycleDays = totalCycleDays;
            }

            public double TotalCycles
            {
                get { return _totalCycles; }
            }

            public int TotalBillingDays
            {
                get { return _totalBillingDays; }
            }

            public int TotalCycleDays
            {
                get { return _totalCycleDays; }
            }

            public List<BillingSegment> Segments
            {
                get { return _segments; }
            }
        }

        private class RateAssignmentComparer : IComparer<BopsRfsStorageRateAssignment>
        {
            public int Compare(BopsRfsStorageRateAssignment x, BopsRfsStorageRateAssignment y)
            {
                // The first metric for comparing two assignments is the begin date.

                if (x.BeginDate < y.BeginDate) return -1;
                if (x.BeginDate > y.BeginDate) return 1;

                // We should never get this far. Two assignments on the same rate shouldn't have
                // same begin date, but if they do we'll look at end date.

                if (x.EndDate < y.EndDate) return -1;
                if (x.EndDate > y.EndDate) return 1;

                // Otherwise, I really don't know what to return.

                return 0;
            }
        }

        #endregion

        private static readonly ILog Log = LogManager.GetLogger(typeof(RfsStorageBillingCalculator));

        private Dictionary<int, BopsRfsStorageRate> _rateMap;
        private Dictionary<int, BopsInventoryDetail> _inventoryMap;
        private Dictionary<int, BopsReceivingRecord> _receiverMap;
        private Dictionary<int, BopsRfs> _rfsMap;
        private Dictionary<int, BopsProductProfile> _profileMap;
        private Dictionary<int, List<BopsRfsStorageRateAssignment>> _profileAssignmentsMap;
        private Dictionary<int, List<BopsRfsStorageRateEscalation>> _rateEscalationsMap;
        private Dictionary<int, BopsSysUnitOfMeasure> _unitMap;
        private Dictionary<int, BopsRfsStorageBillingInventoryTracking> _inventoryTrackingMap;
        private Dictionary<int, DateTime> _shipmentDateMap;

        public List<BopsRfsStorageRateAssignment> GetAssignments(int profileId)
        {
            return _profileAssignmentsMap.ContainsKey(profileId) ? 
                new List<BopsRfsStorageRateAssignment>(_profileAssignmentsMap[profileId]) : null;
        }

        public BopsRfsStorageRate GetRate(int rateId)
        {
            return _rateMap.ContainsKey(rateId) ? 
                _rateMap[rateId] : null;
        }

        public List<BopsRfsStorageRateEscalation> GetRateEscalations(int rateId)
        {
            return _rateEscalationsMap.ContainsKey(rateId) ? 
                new List<BopsRfsStorageRateEscalation>(_rateEscalationsMap[rateId]) : null;
        }

        #region Helper Methods


        #endregion

        private void LoadRfsData(IRfsDataContext rfsDataContext, IEnumerable<BopsRfsStorageBillingInput> inputData)
        {
            // Get the assignment, inventory, and receiver IDs from the input data.

            var assignmentMap = new Dictionary<int, int>();
            var inventoryDetailMap = new Dictionary<int, int>();
            var receiverMap = new Dictionary<int, int>();
            var rfsMap = new Dictionary<int, int>();
            _shipmentDateMap = new Dictionary<int, DateTime>();

            foreach (var data in inputData)
            {
                if (!assignmentMap.ContainsKey(data.AssignmentId))
                    assignmentMap.Add(data.AssignmentId, 0);
                if (!inventoryDetailMap.ContainsKey(data.InventoryId))
                    inventoryDetailMap.Add(data.InventoryId, 0);
                if (!receiverMap.ContainsKey(data.ReceiverId))
                    receiverMap.Add(data.ReceiverId, 0);
                if (!rfsMap.ContainsKey(data.RfsId))
                    rfsMap.Add(data.RfsId, 0);
                if (data.DateShipped.HasValue && !_shipmentDateMap.ContainsKey(data.InventoryId))
                    _shipmentDateMap.Add(data.InventoryId, data.DateShipped.Value);
            }

            var assignmentIds = CollectionUtilities.GetArrayFromKeys(assignmentMap);
            var inventoryIds = CollectionUtilities.GetArrayFromKeys(inventoryDetailMap);
            var receiverIds = CollectionUtilities.GetArrayFromKeys(receiverMap);
            var rfsIds = CollectionUtilities.GetArrayFromKeys(rfsMap);

            _inventoryMap = rfsDataContext.GetInventoryDetailsByIDs(inventoryIds).ToDictionary(d => d.DetailId, d => d);
            _receiverMap = rfsDataContext.GetReceiversByIDs(receiverIds).ToDictionary(r => r.ReceiverId, r => r);
            _rfsMap = rfsDataContext.GetRfsByIds(rfsIds).ToDictionary(r => r.RfsId, r => r);
            _inventoryTrackingMap = rfsDataContext.GetStorageBillingInventoryTrackingsByIds(inventoryIds).ToDictionary(t => t.InventoryRef, t => t);
            _unitMap = rfsDataContext.GetUnitsOfMeasure().ToDictionary(u => u.UnitId, u => u);

            // Load up all assignments for the product profiles referenced by the input data.

            var profileMap = new Dictionary<int, int>();
            foreach (var receiver in _receiverMap.Values)
            {
                if (!profileMap.ContainsKey(receiver.ProductProfileRef.Value))
                    profileMap.Add(receiver.ProductProfileRef.Value, 0);
            }

            var profileIds = CollectionUtilities.GetArrayFromKeys(profileMap);
            _profileMap = rfsDataContext.GetProductProfilesByIDs(profileIds).ToDictionary(p => p.ProfileId, p => p);
            var allProfileAssignments = rfsDataContext.GetStorageRateAssignmentsByProfileIds(profileIds);
            _profileAssignmentsMap = new Dictionary<int, List<BopsRfsStorageRateAssignment>>();
            foreach (var assignment in allProfileAssignments)
            {
                if (_profileAssignmentsMap.ContainsKey(assignment.ProfileRef))
                {
                    _profileAssignmentsMap[assignment.ProfileRef].Add(assignment);
                }
                else
                {
                    var newList = new List<BopsRfsStorageRateAssignment>();
                    newList.Add(assignment);
                    _profileAssignmentsMap.Add(assignment.ProfileRef, newList);
                }
            }

            // Sort the assignments by date.

            foreach (var pair in _profileAssignmentsMap)
                pair.Value.Sort(new RateAssignmentComparer());

            // Load the rate map.

            var rateIdMap = new Dictionary<int, int>();
            foreach (var pair in _profileAssignmentsMap)
            {
                foreach (var assignment in pair.Value)
                {
                    if (!rateIdMap.ContainsKey(assignment.StorageRateRef))
                        rateIdMap.Add(assignment.StorageRateRef, 0);
                }
            }

            var index = 0;
            var rateIds = new int[rateIdMap.Count];
            foreach (var pair in rateIdMap)
            {
                rateIds[index++] = pair.Key;
            }
            _rateMap = rfsDataContext.GetStorageRatesByRateIds(rateIds).ToDictionary(r => r.RateId, r => r);

            // Load the escalations (if any).

            _rateEscalationsMap = new Dictionary<int, List<BopsRfsStorageRateEscalation>>();
            var escalations = rfsDataContext.GetStorageRateEscalationsByRateIds(rateIds);

            // TODO: sort the escalations by date.

            foreach (var escalation in escalations)
            {
                if (_rateEscalationsMap.ContainsKey(escalation.StorageRateRef))
                    _rateEscalationsMap[escalation.StorageRateRef].Add(escalation);
                else
                {
                    var newList = new List<BopsRfsStorageRateEscalation> {escalation};
                    _rateEscalationsMap.Add(escalation.StorageRateRef, newList);
                }
            }
        }

        /// <summary>
        /// Converts the value in pounds to the weight unit specified by the unit reference. Only pounds, CWT,
        /// and tons are valid weight units.
        /// </summary>
        /// <param name="pounds">The value in pounds to be converted.</param>
        /// <param name="unitRef">The unit reference, which corresponds to values in [DWS No Rep Data].dbo.[sys Units of Measure].</param>
        /// <returns>The weight converted to the new unit if successful or -1 in case of failure.</returns>
        private static double ConvertPoundsToWeightUnit(double pounds, int unitRef)
        {
            double returnValue = -1;
            var costMethodUnit = (RfsCostMethodUnits)unitRef;

            switch (costMethodUnit)
            {
                case RfsCostMethodUnits.Pound:
                    returnValue = pounds;
                    break;
                case RfsCostMethodUnits.CWT:
                    returnValue = pounds / 100;
                    break;
                case RfsCostMethodUnits.Ton:
                    returnValue = pounds / 2000;
                    break;
            }

            return returnValue;
        }

        // The preliminary data now available, the following switch statement handles the specifics of the
        // storage billing rate type; i.e., this is where it all comes together to produce an actual per
        // weight, per count, per thoussand board feet, etc. quantity and revenue numbers.

        private double UpdateStoragePlanWithRevenue(BopsInventoryDetail inventoryDetail, StorageBillingPlan plan)
        {
            double totalRevenue = 0;

            foreach (var segment in plan.Segments)
            {
                var rate = _rateMap[segment.RateId];

                switch (rate.BillingType)
                {
                    case RfsStorageBillingType.PerWeightUnit:
                        var convertedWeight = ConvertPoundsToWeightUnit(inventoryDetail.Weight.Value, rate.UnitRef);
                        segment.Quantity = convertedWeight;
                        segment.Rate = rate.UnitCostPerCycle;
                        segment.Revenue = segment.Cycles * rate.UnitCostPerCycle * convertedWeight;
                        segment.QuantityString = string.Format("{0:n0} lbs.", inventoryDetail.Weight.Value);
                        segment.UnitString = _unitMap.ContainsKey(rate.UnitRef) ? _unitMap[rate.UnitRef].Name : "?";
                        break;
                    case RfsStorageBillingType.PerCount:
                        segment.Quantity = inventoryDetail.CountInPackage.Value;
                        segment.Rate = rate.UnitCostPerCycle;
                        segment.Revenue = segment.Cycles * rate.UnitCostPerCycle * inventoryDetail.CountInPackage.Value;
                        segment.QuantityString = string.Format("{0:n0} pieces", inventoryDetail.CountInPackage.Value);
                        segment.UnitString = "piece";
                        break;
                    case RfsStorageBillingType.PerUnit:
                        //Instead of using CountInPackage, a Unit is equivalent to 1 [Inventory Detail]
                        segment.Quantity = 1;
                        segment.Rate = rate.UnitCostPerCycle;
                        segment.Revenue = segment.Cycles * rate.UnitCostPerCycle;
                        segment.QuantityString = string.Format("{0:n0} units", 1);
                        segment.UnitString = "unit";
                        break;
                    // This case is a special hack added to support what had previously been done manually via a
                    // tedious spreadsheet.

                    case RfsStorageBillingType.PerThousandBoardFeet:
                        var parser = new BoardFeetDimensionParser(inventoryDetail.ProductGroup1);
                        if (string.IsNullOrEmpty(parser.Error))
                        {
                            Debug.Assert(inventoryDetail.CountInPackage.HasValue);
                            segment.Quantity = parser.CalculateThousandBoardFeet(inventoryDetail.CountInPackage.Value);
                            segment.Rate = rate.UnitCostPerCycle;
                            segment.Revenue = segment.Cycles * rate.UnitCostPerCycle * segment.Quantity;
                            segment.QuantityString = string.Format("{0:n3} MBF", segment.Quantity);
                            segment.UnitString = "MBF";
                        }
                        else
                        {
                            Log.ErrorFormat("Could not parse dimensions ({0}) for inventory item {1}, which is set to calculate by thousand board feet. Errors: {2}",
                                inventoryDetail.ProductGroup1, inventoryDetail.DetailId, parser.Error);
                        }
                        break;

                    default:
                        throw new ArgumentException("Bad storage billing type");
                }

                totalRevenue += segment.Revenue;
            }

            return totalRevenue;
        }

        /// <summary>
        /// Calculates the storage billing details for a single inventory item.
        /// </summary>
        /// <param name="billingDate">The date through which the current billing is being generated.</param>
        /// <param name="dateBilledThrough">The date through which the item has previously been billed.</param>
        /// <param name="storageFreeDays">The number of free days of storage the item is to be granted.</param>
        /// <param name="inventoryDetail">The detail record for the inventory item to be billed.</param>
        /// <param name="receiver">The receiver under which the item was entered into inventory.</param>
        /// <param name="rate">The storage billing rate to be used for the calculation.</param>
        /// <returns>A calculation result object containing the data relevant to billing and inventory tracking.</returns>
        private CalcResult CalculateStorageBillingDetail(DateTime billingDate, DateTime dateBilledThrough, int storageFreeDays,
            BopsInventoryDetail inventoryDetail, BopsReceivingRecord receiver, BopsRfsStorageRate rate)
        {
            // In the event that we're doing a billing that's in the past (e.g., the first billing Dan is
            // doing in multiple phases to clean up old records), we should skip any item who's already
            // billed past the billing date.

            if (dateBilledThrough > billingDate)
                return null;

            // Start a string builder object for use throughout the method in concatenating billing details.
            // Initialize it from the outset with the item's unique ID (if any).

            var publicBuilder = new StringBuilder();
            var privateBuilder = new StringBuilder();
            if (!string.IsNullOrEmpty(inventoryDetail.ItemId))
                publicBuilder.AppendFormat("Item {0}", inventoryDetail.ItemId);
            else if (!string.IsNullOrEmpty(inventoryDetail.ProductGroup1))
                publicBuilder.AppendFormat("Item {0}", inventoryDetail.ProductGroup1);
            else
                publicBuilder.AppendFormat("No ID");

            // If it has shipped from our warehouse, and it did so prior to the billing date, then then we need 
            // to bill through that date instead, so we set up a target date variable for use below.

            var targetDate = billingDate;
            if (_shipmentDateMap.ContainsKey(inventoryDetail.DetailId) && _shipmentDateMap[inventoryDetail.DetailId] < billingDate)
                targetDate = _shipmentDateMap[inventoryDetail.DetailId];

            // Here follows the time calculation. We figure out how much time the item has been in our inventory
            // altogether from date received to target date. Then we figure out how much time we've already billed,
            // from the date received to the date last billed through (which is the date received for items that 
            // have never been billed). From those time spans we can calculate the dates, then figure out how many
            // free days to apply to current billing (if any), and arrive at a total number of days we need to bill.

            var timeSinceReceived = targetDate - receiver.DateReceived.Value;
            var timeAlreadyBilled = dateBilledThrough - receiver.DateReceived.Value;
            var totalDays = timeSinceReceived.Days;
            var daysAlreadyBilled = timeAlreadyBilled.Days;
            var freeDays = (storageFreeDays > daysAlreadyBilled) ? (storageFreeDays - daysAlreadyBilled) : 0;
            Debug.Assert(freeDays >= 0);
            var billingDays = Math.Max(totalDays - daysAlreadyBilled - freeDays, 0);

            // In the event that we calculate no days for billing, then we effectively skip this item. This can
            // happen, for example, when items ship before their free days are up.

            if (billingDays < 1)
                return null;
            
            Debug.Assert(receiver.ProductProfileRef.HasValue);
            var assignments = _profileAssignmentsMap[receiver.ProductProfileRef.Value];
            Debug.Assert(assignments != null);
            var plan = PlanBillingSegments(dateBilledThrough.AddDays(freeDays), targetDate, assignments);
            Debug.Assert(plan.Segments.Count > 0);
            var totalRevenue = UpdateStoragePlanWithRevenue(inventoryDetail, plan);
            var profile = _profileMap[receiver.ProductProfileRef.Value];

            publicBuilder.AppendFormat(", {0}, received {1}, {2} free days, {3} total days, last billed through {4}, {5} days billed:", 
                profile.ProductClassDescription, receiver.DateReceived.Value.ToShortDateString(), storageFreeDays, totalDays, 
                dateBilledThrough.ToShortDateString(), plan.TotalBillingDays);

            var returnValue = new CalcResult();
            returnValue.Detail.InventoryRef = inventoryDetail.DetailId;
            returnValue.Detail.PriorDateBilledThrough = dateBilledThrough;
            returnValue.Detail.BillToClientRef = rate.BillToClientRef;
            returnValue.Detail.ProfileRef = receiver.ProductProfileRef.Value;
            returnValue.Detail.Quantity = plan.Segments[0].Quantity;
            returnValue.Detail.CyclesBilled = plan.TotalCycles;
            returnValue.Detail.Revenue = totalRevenue;

            publicBuilder.AppendFormat(" {0} for", plan.Segments[0].QuantityString);

            if (plan.Segments.Count == 1)
            {
                returnValue.Detail.AverageCostPerCycle = plan.Segments[0].Rate;
                publicBuilder.AppendFormat(" {0:n0} cycle(s) at {1:c}/{2}.", plan.Segments[0].Cycles, plan.Segments[0].Rate, plan.Segments[0].UnitString);
                privateBuilder.AppendFormat("Assign {0}, Rate {1}", plan.Segments[0].AssignmentId, plan.Segments[0].RateId);
            }
            else
            {
                var first = true;
                returnValue.Detail.AverageCostPerCycle = 0;

                foreach (var segment in plan.Segments)
                {
                    var fraction = (double)segment.BillingDays / plan.TotalBillingDays;
                    returnValue.Detail.AverageCostPerCycle += fraction * segment.Rate;

                    if (first)
                    {
                        first = false;
                    }
                    else
                    {
                        publicBuilder.Append(",");
                        privateBuilder.Append("; ");
                    }

                    publicBuilder.AppendFormat(" {0:n2} cycle(s) at {1:c}/{2}", segment.Cycles, segment.Rate, segment.UnitString);
                    privateBuilder.AppendFormat("Assign {0}, Rate {1}", segment.AssignmentId, segment.RateId);
                }

                publicBuilder.Append(".");
            }

            returnValue.Tracking.InventoryRef = inventoryDetail.DetailId;
            returnValue.Tracking.DateBilledThrough = dateBilledThrough.AddDays(plan.TotalCycleDays + freeDays);
            returnValue.Detail.NewDateBilledThrough = returnValue.Tracking.DateBilledThrough;
            returnValue.Detail.PublicDetails = publicBuilder.ToString();
            returnValue.Detail.PrivateDetails = privateBuilder.ToString();

            return returnValue;
        }

        // Given that we have some number of days to be billed, we must now construct a plan. Dan's preference
        // (as expressed by phone on 03/19/2010), is that we bill for a fractional cycle when we're about to 
        // hit a rate change. So if a rate change comes 28 days into a 30 day cycle, we'll bill that cycle for
        // 28 days. Then the new cycle will begin on the next day at the new rate (and new cycle length).

        private StorageBillingPlan PlanBillingSegments(DateTime dateBilledThrough, DateTime targetDate, IEnumerable<BopsRfsStorageRateAssignment> assignments)
        {
            var done = false;
            var segments = new List<BillingSegment>();
            double totalCycles = 0;
            var totalBillingDays = 0;
            var totalCycleDays = 0;
            var startDate = dateBilledThrough;
            
            do
            {
                var plan = new RfsStorageRateSegmentPlanner(startDate, targetDate, assignments);
                var newSegment = new BillingSegment();
                newSegment.AssignmentId = plan.Segments[0].Assignment.AssignmentId;
                newSegment.BeginDate = plan.Segments[0].BeginDate;
                newSegment.EndDate = plan.Segments[0].EndDate;
                newSegment.RateId = plan.Segments[0].Assignment.StorageRateRef;
                newSegment.BillingDays = (newSegment.EndDate - newSegment.BeginDate).Days;

                var rate = _rateMap[newSegment.RateId];
                var preciseCycles = newSegment.BillingDays / (double)rate.DaysInCycle;

                // In the event that we have a single segment, it means we're not crossing a rate boundary.
                // As such, we round up the precise cycle count to arrive at a number of cycles to bill
                // and then calculate the corresponding number of cycle days.
                //
                // Otherwise, we must have crossed a boundary, in which case we set the cycle days to the
                // number of billing days. When all is said and done, the total cycle days will be used
                // to calculate a new dated billed through.

                if (plan.Segments.Count == 1)
                {
                    newSegment.Cycles = Math.Ceiling(preciseCycles);
                    newSegment.CycleDays = (int)newSegment.Cycles * rate.DaysInCycle;
                    done = true;
                }
                else
                {
                    newSegment.Cycles = preciseCycles;
                    newSegment.CycleDays = newSegment.BillingDays;
                }

                startDate = newSegment.EndDate;
                totalCycles += newSegment.Cycles;
                totalBillingDays += newSegment.BillingDays;
                totalCycleDays += newSegment.CycleDays;

                segments.Add(newSegment);

            } while (!done);

            return new StorageBillingPlan(segments, totalCycles, totalBillingDays, totalCycleDays);
        }

        public RfsStorageBillingResult CalculateStorageBilling(DateTime billThroughDate)
        {
            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();

            try
            {
                var targetDate = billThroughDate.Date.AddDays(1);
                var inputData = rfsDataContext.GetStorageBillingInputData();
                var returnValue = new RfsStorageBillingResult
                {
                    Billing = {DateBilledThrough = billThroughDate.Date, DateGenerated = DateTime.Now}
                };
                LoadRfsData(rfsDataContext, inputData);

                foreach (var pair in _inventoryMap)
                {
                    Log.DebugFormat("Inventory ID: {0}", pair.Value.DetailId);

                    var receiver = _receiverMap[pair.Value.ReceiverRef.Value];

                    // While up at Budway on 02/01/2010 Dan and I discovered a case wherein one of the inventory
                    // items to be billed referenced a receiver with a zero RFS, which was a special case we 
                    // assigned back when building the system. We log a warning here and skip it.

                    if (receiver.RfsRef.Value == 0)
                    {
                        Log.WarnFormat("Receiver {0} has RFS 0, so item {1} cannot be handled.", receiver.RfsRef.Value,
                            pair.Value.DetailId);
                        continue;
                    }

                    var rfs = _rfsMap[receiver.RfsRef.Value];
                    var assignments = _profileAssignmentsMap[receiver.ProductProfileRef.Value];
                    var rate = _rateMap[assignments[0].StorageRateRef];

                    var dateBilledThrough = _inventoryTrackingMap.ContainsKey(pair.Value.DetailId) ? 
                        _inventoryTrackingMap[pair.Value.DetailId].DateBilledThrough : receiver.DateReceived.Value;

                    var result = CalculateStorageBillingDetail(targetDate, dateBilledThrough, rfs.StorageFreeDays, pair.Value, receiver, rate);
                    if (result == null)
                        continue;

                    result.Detail.CompanyRef = rfs.CompanyRef;
                    returnValue.Billing.TotalItemsProcessed++;
                    returnValue.Billing.TotalRevenue += result.Detail.Revenue;

                    var item = new RfsStorageBillingResult.ItemDetails
                    {
                        StorageFreeDays = rfs.StorageFreeDays,
                        InventoryDetail = pair.Value,
                        Receiver = receiver,
                        Rate = rate,
                        BillingDetail = result.Detail,
                        InventoryTracking = result.Tracking
                    };

                    returnValue.Items.Add(item);
                }

                return returnValue;
            }
            catch (Exception e)
            {
                Log.Error("An exception occurred while calculating storage billing. Details follow.", e);
            }
            finally
            {
                // TODO: free the RFS data context
            }

            return null;
        }

        public BopsRfsStorageBilling GetLastStorageBilling(IRfsDataContext rfsDataContext)
        {
            return rfsDataContext.GetLastStorageBilling();
        }

        public bool RollBackLastStorageBilling(IRfsDataContext rfsDataContext)
        {
            var lastStorageBilling = rfsDataContext.GetLastStorageBilling();

            if (lastStorageBilling == null)
            {
                Log.Info("No last storage billing to roll back.");
                return false;
            }

            var details = rfsDataContext.GetStorageBillingDetailsByBillingId(lastStorageBilling.BillingId);

            if (details == null || details.Count < 1)
            {
                Log.ErrorFormat("Storage billing {0} has no details.", lastStorageBilling.BillingId);
                return false;
            }

            var index = 0;
            var inventoryIds = new int[details.Count];
            foreach (var detail in details)
                inventoryIds[index++] = detail.InventoryRef;
            var inventoryTracking = rfsDataContext.GetStorageBillingInventoryTrackingsByIds(inventoryIds)
                .ToDictionary(t => t.InventoryRef, t => t);

            if (inventoryTracking.Count != inventoryIds.Length)
            {
                Log.ErrorFormat("Cannot roll back storage billing; expected {0} inventory items but found only {1}", 
                    inventoryIds.Length, inventoryTracking.Count);
                return false;
            }

            try
            {
                foreach (var billingDetail in details)
                {
                    var tracking = inventoryTracking[billingDetail.InventoryRef];
                    Log.InfoFormat("Resetting inventory ID {0} last billed date from {1} to {2}",
                        billingDetail.InventoryRef, tracking.DateBilledThrough, billingDetail.PriorDateBilledThrough);
                    tracking.DateBilledThrough = billingDetail.PriorDateBilledThrough;
                    Log.InfoFormat("Deleting storage billing detail for inventory ID {0}", billingDetail.InventoryRef);
                    rfsDataContext.RemoveStorageBillingDetail(billingDetail);
                }

                Log.InfoFormat("Deleting RFS storage billing {0}", lastStorageBilling);
                var doomedId = lastStorageBilling.BillingId;
                rfsDataContext.RemoveStorageBilling(lastStorageBilling);

                var newEvent = new BopsRfsStorageBillingEvent(RfsStorageBillingEventType.StorageBillingRolledBack, doomedId);
                rfsDataContext.AddStorageBillingEvent(newEvent);
                rfsDataContext.SaveChanges();
            }
            catch (Exception E)
            {
                Log.Error("An exception ocurred while rolling back the last storage billing.", E);
            }

            return true;
        }

        public bool RollbackStorageBillingDetails(IRfsDataContext rfsDataContext, IEnumerable<BopsRfsStorageBillingDetail> details)
        {
            // Fail if no details were provided.

            if (details == null)
            {
                Log.Error("No storage billing details supplied.");
                return false;
            }

            // Load up the referenced storage billing header records and inventory items, failing if we can't get all of them.

            var inventoryIds = new Dictionary<int, int>();
            var billingIds = new Dictionary<int, int>();
            foreach (var detail in details)
            {
                if (!inventoryIds.ContainsKey(detail.InventoryRef))
                    inventoryIds.Add(detail.InventoryRef, 0);
                if (!billingIds.ContainsKey(detail.BillingRef))
                    billingIds.Add(detail.BillingRef, 0);
            }

            var billingMap = rfsDataContext.GetStorageBillingsByIDs(billingIds.Keys.ToArray())
                .ToDictionary(b => b.BillingId, b => b);
            if (billingMap.Count != billingIds.Count)
            {
                Log.ErrorFormat("Cannot roll back storage billing details; expected {0} billings but found only {1}", 
                    billingIds.Count, billingMap.Count);
                return false;
            }

            var inventoryTrackingMap =
                rfsDataContext.GetStorageBillingInventoryTrackingsByIds(inventoryIds.Keys.ToArray());
            if (inventoryTrackingMap.Count != inventoryIds.Count)
            {
                Log.ErrorFormat("Cannot roll back storage billing details; expected {0} inventory items but found only {1}",
                    inventoryIds.Count, inventoryTrackingMap.Count);
                return false;
            }

            // Get our own private copy of the details and sort them as needed for rollback. If they're not sorted properly,
            // then it would be possible to screw up the last billed through dates by rolling back a later date before
            // an earlier date.

            var sortedDetails = new List<BopsRfsStorageBillingDetail>(details);
            sortedDetails.Sort(new DetailRollbackComparer(billingMap));

            try
            {
                foreach (var billingDetail in sortedDetails)
                {
                    var doomedId = billingDetail.DetailId;
                    var tracking = inventoryTrackingMap[billingDetail.InventoryRef];
                    Log.InfoFormat("Resetting inventory ID {0} last billed date from {1} to {2}",
                        billingDetail.InventoryRef, tracking.DateBilledThrough, billingDetail.PriorDateBilledThrough);
                    tracking.DateBilledThrough = billingDetail.PriorDateBilledThrough;
                    Log.InfoFormat("Deleting storage billing detail for inventory ID {0}", billingDetail.InventoryRef);
                    rfsDataContext.RemoveStorageBillingDetail(billingDetail);

                    var newEvent = new BopsRfsStorageBillingEvent(
                        RfsStorageBillingEventType.StorageBillingDetailRolledBack, doomedId);
                    rfsDataContext.AddStorageBillingEvent(newEvent);
                }

                rfsDataContext.SaveChanges();
            }
            catch (Exception e)
            {
                Log.Error("An exception ocurred while rolling back the last storage billing.", e);
            }

            return true;
        }
    }
}
