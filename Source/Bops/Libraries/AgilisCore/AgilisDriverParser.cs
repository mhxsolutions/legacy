using System;
using System.Collections.Generic;
using System.Globalization;
using System.Xml;
using log4net;

namespace AgilisCore
{
    class AgilisDriverParser
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisDriverEventParser));

        private static DateTime _DefaultLastSyncedDate = new DateTime(2006, 1, 1);

        #region Helper Methods

        private static string GetFirstChildValue(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return null;
            else
                return Node.FirstChild.Value.Trim();
        }

        private static int GetFirstChildValueAsInteger(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return 0;
            else
                return Convert.ToInt32(Node.FirstChild.Value.Trim());
        }

        private static AgilisDriver AgilisDriverFromXmlNode(XmlNode Node)
        {
            AgilisDriver ReturnValue = new AgilisDriver();
            IFormatProvider Culture = new CultureInfo("En-US", true);

            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                try
                {
                    switch (SubNode.Name)
                    {
                        case "driverNumber":
                            ReturnValue.DriverId = GetFirstChildValueAsInteger(SubNode);
                            break;
                        case "vehicleNumber":
                            ReturnValue.VehicleNumber = GetFirstChildValueAsInteger(SubNode);
                            break;
                        case "phoneNumber":
                            ReturnValue.PhoneNumber = GetFirstChildValue(SubNode);
                            break;
                        case "lastSyncDate":
                            ReturnValue.LastSynced = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                            ReturnValue.LastSynced = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.LastSynced);
                            break;
                        case "firstName":
                            ReturnValue.FirstName = GetFirstChildValue(SubNode);
                            break;
                        case "lastName":
                            ReturnValue.LastName = GetFirstChildValue(SubNode);
                            break;
                        case "fleetId":
                            ReturnValue.FleetNumber = GetFirstChildValueAsInteger(SubNode);
                            break;
                        case "businessUnitNumber":
                            ReturnValue.BusinessUnitNumber = GetFirstChildValueAsInteger(SubNode);
                            break;
                        case "active":
                            ReturnValue.Active = bool.Parse(GetFirstChildValue(SubNode));
                            break;

                        default:
                            _Log.DebugFormat("Unknown field found while parsing driver: {0}", SubNode.Name);
                            break;
                    }
                }
                catch (Exception e)
                {
                    _Log.ErrorFormat("Exception parsing node {0}, first child value {1}.", SubNode.Name, SubNode.FirstChild.Value);
                    _Log.Error("Details follow.", e);
                }
            }

            return ReturnValue;
        }

        #endregion

        #region Public Interface

        public List<AgilisDriver> ParseDrivers(string FileName, IAgilisStatusInterface Status, AgilisIntegrationOperation Operation)
        {
            List<AgilisDriver> ReturnValue = new List<AgilisDriver>();

            AgilisDriver LastSuccessfulDriver = null;
            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);

            try
            {
                foreach (XmlNode Node in Document["DriverList"])
                {
                    if (Node.Name == "Driver")
                    {
                        AgilisDriver Driver = AgilisDriverFromXmlNode(Node);
                        _Log.DebugFormat("Parsed driver {0} ((1) (2)).", Driver.DriverId, Driver.FirstName, Driver.LastName);

                        /*
                     * If a driver has never previously synchronized his phone, which would be the case for
                     * a new driver record, then we use a dummy date that won't explode SQL Server.
                     */

                        if (Driver.LastSynced == DateTime.MinValue)
                        {
                            _Log.WarnFormat("Driver has null last sync date; setting to dummy value ({0}).", _DefaultLastSyncedDate);
                            Driver.LastSynced = _DefaultLastSyncedDate;
                            Operation.WarningCount++;
                        }

                        if (Status != null)
                            Status.ProgressUpdate(string.Format("Parsed driver {0} ({1} {2}).", Driver.DriverId, Driver.FirstName, Driver.LastName), "", 0, 0);

                        if (Driver.IsValid())
                        {
                            ReturnValue.Add(Driver);
                            LastSuccessfulDriver = Driver;
                        }
                        else
                        {
                            _Log.WarnFormat("Discarding invalid driver: {0} ({1} {2})", Driver.ToString(), Driver.FirstName, Driver.LastName);
                            Operation.WarningCount++;
                        }
                    }
                    else
                    {
                        _Log.DebugFormat("Unknown element found in driver list: {0}", Node.Name);
                    }
                }
            }
            catch (Exception e)
            {
                _Log.Error("An exception occurred parsing drivers, details follow.", e);

                if (LastSuccessfulDriver != null)
                    _Log.ErrorFormat("Last successful driver processed was {0}", LastSuccessfulDriver.DriverId);

            }
            return ReturnValue;
        }

        #endregion

    }
}
