using System;
using System.Collections.Generic;
using System.Globalization;
using System.Xml;
using log4net;

namespace AgilisCore
{
    public class AgilisDriverEventParser
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisDriverEventParser));

        #region Helper Methods

        private string GetFirstChildValue(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return null;
            else
                return Node.FirstChild.Value.Trim();
        }

        private int GetFirstChildValueAsInteger(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return 0;
            else
                return Convert.ToInt32(Node.FirstChild.Value.Trim());
        }

        private AgilisDriverEvent AgilisDriverEventFromXmlNode(XmlNode Node)
        {
            AgilisDriverEvent ReturnValue = new AgilisDriverEvent();
            IFormatProvider Culture = new CultureInfo("En-US", true);

            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
                    case "driverNumber":
                        ReturnValue.DriverId = GetFirstChildValueAsInteger(SubNode);
                        break;
                    case "eventCode":
                        ReturnValue.DriverEventCode = GetFirstChildValue(SubNode);
                        break;
                    case "eventDate":
                        ReturnValue.Timestamp = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                        ReturnValue.Timestamp = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.Timestamp);
                        break;

                    default:
                        _Log.DebugFormat("Unknown field found while parsing driver event: {0}", SubNode.Name);
                        break;
                }
            }

            return ReturnValue;
        }

        #endregion

        #region Public Interface

        public List<AgilisDriverEvent> ParseDriverEvents(string FileName, IAgilisStatusInterface Status, AgilisIntegrationOperation Operation)
        {
            List<AgilisDriverEvent> ReturnValue = new List<AgilisDriverEvent>();

            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);

            foreach (XmlNode Node in Document["DriverEventList"])
            {
                if (Node.Name == "DriverEvent")
                {
                    AgilisDriverEvent DriverEvent = AgilisDriverEventFromXmlNode(Node);
                    _Log.DebugFormat("Parsed driver event for driver {0} at {1}.", DriverEvent.DriverId, DriverEvent.Timestamp);

                    if (Status != null)
                        Status.ProgressUpdate(string.Format("Parsed driver position for driver {0} at {1}.", DriverEvent.DriverId, DriverEvent.Timestamp), "", 0, 0);

                    if (DriverEvent.IsValid())
                        ReturnValue.Add(DriverEvent);
                    else
                    {
                        _Log.WarnFormat("Discarding invalid driver event: {0}", DriverEvent.ToString());
                        Operation.WarningCount++;
                    }
                }
                else
                {
                    _Log.DebugFormat("Unknown element found in driver event list: {0}", Node.Name);
                }
            }

            return ReturnValue;
        }

        #endregion
    }
}
