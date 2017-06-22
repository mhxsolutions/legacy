using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Xml;
using log4net;

namespace AgilisCore
{
    public class AgilisWorkOrderParser
    {
        private const int _MiscField_Sequence = 1;
        private const int _MiscField_PlannerDetailId = 2;
        private const int _MiscField_OriginId = 3;
        private const int _MiscField_DestinationId = 4;
        private const int _MiscField_DisplayWorkOrder = 5;

        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisWorkOrderParser));

        #region Helper Methods
        
        private string GetFirstChildValue(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return null;
            else if (Node.FirstChild.Value == null)
                return null;
            else
                return Node.FirstChild.Value.Trim();
        }

        private static int GetFirstChildValueAsInteger(XmlNode Node)
        {
            int ReturnValue = 0;

            if (Node.FirstChild != null)
            {
                /*
                 * This is only necessary because the Agilis system has an irritating
                 * tendency to convert what should be handled as text fields into
                 * numbers in scientific notation. I suspect it happens only when
                 * uploading an Excel spreadsheet via their web site, but I can't be
                 * certain of that. What I do know is that I have to handle it.
                 */

                string StringToConvert = Node.FirstChild.Value.Trim();
                if (StringToConvert.Contains("E"))
                {
                    double Temporary = Convert.ToDouble(StringToConvert);
                    ReturnValue = Convert.ToInt32(Temporary);
                }
                else
                {
                    ReturnValue = Convert.ToInt32(StringToConvert);
                }
            }

            return ReturnValue;
        }

        private float GetFirstChildValueAsFloat(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return 0;
            else
                return Convert.ToSingle(Node.FirstChild.Value.Trim());
        }

        private AgilisWorkOrderJobStatusHistory AgilisWorkOrderJobHistoryFromXmlNode(XmlNode Node)
        {
            AgilisWorkOrderJobStatusHistory ReturnValue = new AgilisWorkOrderJobStatusHistory();
            IFormatProvider Culture = new CultureInfo("En-US", true);

            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
                    case "statusCode":
                        ReturnValue.AgilisJobStatus = GetFirstChildValue(SubNode);
                        break;
                    case "description":
                        ReturnValue.Description = GetFirstChildValue(SubNode);
                        break;
                    case "timestamp":
                        ReturnValue.Timestamp = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                        ReturnValue.Timestamp = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.Timestamp);
                        ReturnValue.CorrectTimestamp = ReturnValue.Timestamp;
                        break;
                    case "current":
                        ReturnValue.Current = Boolean.Parse(GetFirstChildValue(SubNode));
                        break;
                    case "Position":
                        foreach (XmlNode PosNode in SubNode.ChildNodes)
                        {
                            switch (PosNode.Name)
                            {
                                case "time":
                                    ReturnValue.PositionTimestamp = DateTime.ParseExact(GetFirstChildValue(PosNode), "s", Culture);
                                    ReturnValue.PositionTimestamp = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.PositionTimestamp);
                                    break;
                                case "latitude":
                                    ReturnValue.Latitude = GetFirstChildValueAsFloat(PosNode);
                                    break;
                                case "longitude":
                                    ReturnValue.Longitude = GetFirstChildValueAsFloat(PosNode);
                                    break;
                                case "accuracy":
                                    ReturnValue.Accuracy = GetFirstChildValueAsFloat(PosNode);
                                    break;

                                default:
                                    _Log.WarnFormat("Unknown field found while parsing work order job history position: {0}", PosNode.Name);
                                    break;
                            }
                        }
                        break;

                    case "id":
                    case "acknowledged":
                        // New fields Agilis has added but that we don't use. They are added here
                        // to avoid logging them as something potentially troublesome.
                        break;

                    default:
                        _Log.WarnFormat("Unknown field found while parsing work order job history: {0}", SubNode.Name);
                        break;
                }
            }

            // TODO: Remove this once Agilis has their daylight savings time ducks in a row!

/*
            if (ReturnValue.AgilisJobStatus == "STA" ||
                ReturnValue.AgilisJobStatus == "ARV" ||
                ReturnValue.AgilisJobStatus == "CMP")
            {
                ReturnValue.Timestamp = ReturnValue.Timestamp.AddHours(-1);
            }
*/

            return ReturnValue;
        }
        
        private void ParseAdditionalInfoNode(XmlNode Node, AgilisWorkOrderJob TargetJob)
        {
            string Key = null, Value = null;

            foreach (XmlNode node in Node.ChildNodes)
            {
                if (node.Name == "fieldName")
                    Key = GetFirstChildValue(node);
                else if (node.Name == "value")
                    Value = GetFirstChildValue(node);
                else
                    _Log.WarnFormat("Unknown additional info field found while parsing work order job: {0}", node.Name);
            }

            if (Key != null && Key != string.Empty && Value != null && Value != string.Empty)
                TargetJob.AdditionalInfo.Add(Key, Value);
        }

        private AgilisWorkOrderJob AgilisWorkOrderJobFromXmlNode(XmlNode Node)
        {
            AgilisWorkOrderJob ReturnValue = new AgilisWorkOrderJob();

            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
                    case "jobId":
                        ReturnValue.AgilisJobId = Convert.ToInt32(GetFirstChildValue(SubNode));
                        break;
                    case "type":
                        ReturnValue.AgilisJobType = GetFirstChildValue(SubNode);
                        break;
                    case "description":
                        ReturnValue.Description = GetFirstChildValue(SubNode);
                        break;
                    case "JobStatus":
                        ReturnValue.History.Add(AgilisWorkOrderJobHistoryFromXmlNode(SubNode));
                        break;
                    case "AdditionalInfo":
                        ParseAdditionalInfoNode(SubNode, ReturnValue);
                        break;

                    case "SmartFormInstanceIdList":
                        // New field added by Agilis, about which we care not.
                        break;

                    default:
                        _Log.WarnFormat("Unknown field found while parsing work order job: {0}", SubNode.Name);
                        break;
                }
            }

            return ReturnValue;
        }

        private void ParseCustomerAddress(XmlNode Node, AgilisWorkOrder Order)
        {
            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
					case "firstName":
                        Order.CustomerFirstName = GetFirstChildValue(SubNode);
						break;
					case "lastName":
                        Order.CustomerLastName = GetFirstChildValue(SubNode);
						break;
					case "streetAddr1":
                        Order.CustomerStreetAddress1 = GetFirstChildValue(SubNode);
						break;
					case "streetAddr2":
                        Order.CustomerStreetAddress2 = GetFirstChildValue(SubNode);
						break;
					case "city":
                        Order.CustomerCity = GetFirstChildValue(SubNode);
						break;
					case "state":
                        Order.CustomerState = GetFirstChildValue(SubNode);
						break;
					case "zipCode":
                        Order.CustomerZipCode = GetFirstChildValue(SubNode);
						break;
					case "country":
                        Order.CustomerCountry = GetFirstChildValue(SubNode);
						break;
					case "phoneNumber":
                        Order.CustomerPhoneNumber = GetFirstChildValue(SubNode);
						break;
					case "phoneNumberExt":
                        Order.CustomerPhoneNumberExtension = GetFirstChildValue(SubNode);
						break;

                    case "areaCode":
                    case "emailAddress":
                    case "postalCode":
                        // New fields Agilis has added but that we don't use. They are added here
                        // to avoid logging them as something potentially troublesome.
                        break;

                    default:
                        _Log.WarnFormat("Unknown field found while parsing customer address: {0}", SubNode.Name);
                        break;
                }
            }
        }

        private void ParseContactAddress(XmlNode Node, AgilisWorkOrder Order)
        {
            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
                    case "firstName":
                        Order.ContactFirstName = GetFirstChildValue(SubNode);
                        break;
                    case "lastName":
                        Order.ContactLastName = GetFirstChildValue(SubNode);
                        break;
                    case "streetAddr1":
                        Order.ContactStreetAddress1 = GetFirstChildValue(SubNode);
                        break;
                    case "streetAddr2":
                        Order.ContactStreetAddress2 = GetFirstChildValue(SubNode);
                        break;
                    case "city":
                        Order.ContactCity = GetFirstChildValue(SubNode);
                        break;
                    case "state":
                        Order.ContactState = GetFirstChildValue(SubNode);
                        break;
                    case "zipCode":
                        Order.ContactZipCode = GetFirstChildValue(SubNode);
                        break;
                    case "country":
                        Order.ContactCountry = GetFirstChildValue(SubNode);
                        break;
                    case "phoneNumber":
                        Order.ContactPhoneNumber = GetFirstChildValue(SubNode);
                        break;
                    case "phoneNumberExt":
                        Order.ContactPhoneNumberExtension = GetFirstChildValue(SubNode);
                        break;

                    case "areaCode":
                    case "emailAddress":
                    case "postalCode":
                        // New fields Agilis has added but that we don't use. They are added here
                        // to avoid logging them as something potentially troublesome.
                        break;

                    default:
                        _Log.WarnFormat("Unknown field found while parsing contact address: {0}", SubNode.Name);
                        break;
                }
            }
        }

        private void ParsePickupAddress(XmlNode Node, AgilisWorkOrder Order)
        {
            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
                    case "firstName":
                        Order.PickupFirstName = GetFirstChildValue(SubNode);
                        break;
                    case "lastName":
                        Order.PickupLastName = GetFirstChildValue(SubNode);
                        break;
                    case "streetAddr1":
                        Order.PickupStreetAddress1 = GetFirstChildValue(SubNode);
                        break;
                    case "streetAddr2":
                        Order.PickupStreetAddress2 = GetFirstChildValue(SubNode);
                        break;
                    case "city":
                        Order.PickupCity = GetFirstChildValue(SubNode);
                        break;
                    case "state":
                        Order.PickupState = GetFirstChildValue(SubNode);
                        break;
                    case "zipCode":
                        Order.PickupZipCode = GetFirstChildValue(SubNode);
                        break;
                    case "country":
                        Order.PickupCountry = GetFirstChildValue(SubNode);
                        break;
                    case "phoneNumber":
                        Order.PickupPhoneNumber = GetFirstChildValue(SubNode);
                        break;
                    case "phoneNumberExt":
                        Order.PickupPhoneNumberExtension = GetFirstChildValue(SubNode);
                        break;

                    case "areaCode":
                    case "emailAddress":
                    case "postalCode":
                        // New fields Agilis has added but that we don't use. They are added here
                        // to avoid logging them as something potentially troublesome.
                        break;

                    default:
                        _Log.WarnFormat("Unknown field found while parsing pickup address: {0}", SubNode.Name);
                        break;
                }
            }
        }

        /*
         * Because drivers were entering a bunch of garbage into the tractor/trailer fields, I've limited
         * the data we'll take to numbers only and no more than six characters. Everything else gets
         * stripped and ignored.
         */

        private static string SanitizeTractorTrailer(string S)
        {
            if (string.IsNullOrEmpty(S)) return null;

            const int MaxLength = 6;
            Regex Rx = new Regex("[^0-9]");
            string Output = Rx.Replace(S, string.Empty);
            if (Output.Length > MaxLength)
                Output = Output.Remove(MaxLength);
            return Output;
        }

        private AgilisWorkOrder AgilisWorkOrderFromXmlNode(XmlNode Node)
        {
            AgilisWorkOrder ReturnValue = new AgilisWorkOrder();
            IFormatProvider Culture = new CultureInfo("En-US", true);

            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                try
                {
                    switch (SubNode.Name)
                    {
                        case "workOrderNumber":
                            ReturnValue.WorkOrderNumber = GetFirstChildValue(SubNode);
                            break;
                        case "editDate":
                            ReturnValue.LastEdited = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                            ReturnValue.LastEdited = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.LastEdited);
                            break;
                        case "workOrderStatus":
                            ReturnValue.CurrentStatus = GetFirstChildValue(SubNode);
                            break;
                        case "statusUpdated":
                            ReturnValue.StatusLastUpdated = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                            ReturnValue.StatusLastUpdated = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.StatusLastUpdated);
                            break;
                        case "slotStartDate":
                            ReturnValue.SlotStartDate = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                            ReturnValue.SlotStartDate = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.SlotStartDate);
                            break;
                        case "slotEndDate":
                            // TODO: do something with this if we ever care about slotEndDate.
                            break;
                        case "driverNumber":
                            ReturnValue.DriverNumber = Convert.ToInt32(GetFirstChildValue(SubNode));
                            break;
                        case "Job":
                            AgilisWorkOrderJob NewJob = AgilisWorkOrderJobFromXmlNode(SubNode);
                            ReturnValue.Jobs.Add(NewJob);
                            foreach (KeyValuePair<string, string> pair in NewJob.AdditionalInfo)
                            {
                                switch (pair.Key)
                                {
                                    case "Tractor":
                                        ReturnValue.Tractor = SanitizeTractorTrailer(pair.Value);
                                        break;
                                    case "Trailer":
                                        ReturnValue.Trailer = SanitizeTractorTrailer(pair.Value);
                                        break;
                                }
                            }
                            break;
                        case "Customer":
                            ParseCustomerAddress(SubNode, ReturnValue);
                            break;
                        case "Contact":
                            ParseContactAddress(SubNode, ReturnValue);
                            break;
                        case "Pickup":
                            ParsePickupAddress(SubNode, ReturnValue);
                            break;
                        case "notes":
                            ReturnValue.Notes = GetFirstChildValue(SubNode);
                            break;

                        case "Caller":
                        case "SmartFormInstanceIdList":
                            // New field added by Agilis, about which we care not.
                            break;

                        default:
                            Regex Miscellaneous = new Regex("misc(?<Number>[0-9]+)");
                            Match MatchResult = Miscellaneous.Match(SubNode.Name);
                            if (MatchResult.Success)
                            {
                                int FieldNumber = Convert.ToInt32(MatchResult.Groups["Number"].Value);

                                switch (FieldNumber)
                                {
                                    case _MiscField_Sequence:
                                        ReturnValue.Sequence = GetFirstChildValueAsInteger(SubNode);
                                        break;
                                    case _MiscField_PlannerDetailId:
                                        ReturnValue.PlannerDetailId = GetFirstChildValueAsInteger(SubNode);
                                        break;
                                    case _MiscField_OriginId:
                                        ReturnValue.OriginId = GetFirstChildValueAsInteger(SubNode);
                                        break;
                                    case _MiscField_DestinationId:
                                        ReturnValue.DestinationId = GetFirstChildValueAsInteger(SubNode);
                                        break;
                                    case _MiscField_DisplayWorkOrder:
                                        string DisplayWorkOrder = GetFirstChildValue(SubNode);
                                        ReturnValue.LoadRef = ParseLoadRefFromWorkOrderNumber(DisplayWorkOrder);
                                        break;

                                    default:
                                        // Ignore all the other, miscellaneous fields.
                                        break;
                                }
                            }
                            else
                            {
                                _Log.WarnFormat("Unknown field found while parsing work order: {0}", SubNode.Name);
                            }
                            break;
                    }
                }
                catch (Exception)
                {
                    _Log.ErrorFormat("Exception parsing node {0}, first child value {1}.", SubNode.Name, SubNode.FirstChild.Value);
                    throw;
                }
            }

            return ReturnValue;
        }

        // Work order numbers are in the following format: [SEQ][JOB] [LOAD]
        
        private string ParseLoadRefFromWorkOrderNumber(string WorkOrderNumber)
        {   
            Regex WorkOrderNumberRegex = new Regex("(?<Seq>[0-9]+)(?<Job>[A-Z]+) (?<Load>[A-Za-z0-9]+)");
            Match MatchResult = WorkOrderNumberRegex.Match(WorkOrderNumber);
            
            if (MatchResult.Success)
                return MatchResult.Groups["Load"].ToString();
            else 
                return null;
        }

        private bool FilterXmlNodeChildren(List<AgilisOperationFilter> Filters, XmlNode ParentNode)
        {
            if (Filters != null && Filters.Count > 0)
            {
                foreach (XmlNode Node in ParentNode.ChildNodes)
                {
                    string Value = GetFirstChildValue(Node);
                    if (Value == null)
                        Value = "";

                    foreach (AgilisOperationFilter Filter in Filters)
                    {
                        if (Filter.MatchFilter(Node.Name, Value))
                        {
                            _Log.InfoFormat("Import filter triggered: {0}", Filter);
                            return true;
                        }
                    }
                }
            }

            return false;
        }
        #endregion

        #region Public Interface
        
        public List<AgilisWorkOrder> ParseWorkOrders(string FileName, List<AgilisOperationFilter> Filters, 
            IAgilisStatusInterface Status, AgilisIntegrationOperation Operation)
        {
            Dictionary<string, int> WorkOrderCounts = new Dictionary<string, int>();
            List<AgilisWorkOrder> ReturnValue = new List<AgilisWorkOrder>();

            AgilisWorkOrder LastSuccessfulWorkOrder = null;
            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);

            foreach (XmlNode Node in Document["WorkOrderList"])
            {
                try
                {
                    if (Node.Name == "WorkOrder")
                    {
                        if (FilterXmlNodeChildren(Filters, Node))
                            continue;

                        AgilisWorkOrder Order = AgilisWorkOrderFromXmlNode(Node);
                        _Log.DebugFormat("Parsed work order number {0}.", Order.WorkOrderNumber);

                        if (WorkOrderCounts.ContainsKey(Order.WorkOrderNumber))
                        {
                            int Occurance = WorkOrderCounts[Order.WorkOrderNumber] + 1;
                            _Log.WarnFormat("Work order number {0} already processed, handling occurrence {1}.",
                                            Order.WorkOrderNumber, Occurance);
                            Operation.WarningCount++;
                            WorkOrderCounts[Order.WorkOrderNumber] = Occurance;
                        }
                        else
                        {
                            WorkOrderCounts.Add(Order.WorkOrderNumber, 1);
                        }

                        if (Status != null)
                            Status.ProgressUpdate(string.Format("Parsed work order number {0}", Order.WorkOrderNumber), "", 0, 0);

                        ReturnValue.Add(Order);
                        LastSuccessfulWorkOrder = Order;
                    }
                    else
                    {
                        _Log.DebugFormat("Unknown element found in work order list: {0}", Node.Name);
                    }
                }
                catch (Exception e)
                {
                    _Log.Error("Exception parsing work orders.", e);

                    if (LastSuccessfulWorkOrder != null)
                        _Log.ErrorFormat("Last successful work order processed was {0}", LastSuccessfulWorkOrder.WorkOrderNumber);
                }
            }

            return ReturnValue;
        }

        #endregion
    }
}
