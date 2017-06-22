using System;
using System.Collections.Generic;
using System.Globalization;
using System.Xml;
using log4net;

namespace AgilisCore
{
    class AgilisDriverPositionParser
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisWorkOrderParser));

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

        private float GetFirstChildValueAsFloat(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return 0;
            else
                return Convert.ToSingle(Node.FirstChild.Value.Trim());
        }
        
        private AgilisDriverPosition AgilisDriverPositionFromXmlNode(XmlNode Node)
        {
            AgilisDriverPosition ReturnValue = new AgilisDriverPosition();
            IFormatProvider Culture = new CultureInfo("En-US", true);

            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
                    case "driverNumber":
                        ReturnValue.DriverId = GetFirstChildValueAsInteger(SubNode);
                        break;
                    case "phoneNumber":
                        // Though we're aware of the phone number field, we don't use it.
                        break;
                    case "positionDate":
                        ReturnValue.Timestamp = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                        ReturnValue.Timestamp = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.Timestamp);
                        break;
                    case "latitude":
                        ReturnValue.Latitude = GetFirstChildValueAsFloat(SubNode);
                        break;
                    case "longitude":
                        ReturnValue.Longitude = GetFirstChildValueAsFloat(SubNode);
                        break;
                    case "accuracy":
                        ReturnValue.Accuracy = GetFirstChildValueAsFloat(SubNode);
                        break;
                        
                    default:
                        _Log.DebugFormat("Unknown field found while parsing driver position: {0}", SubNode.Name);
                        break;
                }
            }

            return ReturnValue;
        }

        #endregion

        #region Public Interface

        public List<AgilisDriverPosition> ParseDriverPositions(string FileName, IAgilisStatusInterface Status, AgilisIntegrationOperation Operation)
        {
            List<AgilisDriverPosition> ReturnValue = new List<AgilisDriverPosition>();

            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);

            foreach (XmlNode Node in Document["PositionList"])
            {
                if (Node.Name == "Position")
                {
                    AgilisDriverPosition DriverPosition = AgilisDriverPositionFromXmlNode(Node);
                    _Log.DebugFormat("Parsed driver position for driver {0} at {1}.", DriverPosition.DriverId, DriverPosition.Timestamp);
                    
                    if (Status != null)
                        Status.ProgressUpdate(string.Format("Parsed driver position for driver {0} at {1}.", DriverPosition.DriverId, DriverPosition.Timestamp), "", 0, 0);

                    if (DriverPosition.IsValid())
                        ReturnValue.Add(DriverPosition);
                    else
                    {
                        _Log.WarnFormat("Discarding invalid driver position: {0}", DriverPosition.ToString());
                        Operation.WarningCount++;
                    }
                }
                else
                {
                    _Log.DebugFormat("Unknown element found in driver position list: {0}", Node.Name);
                }
            }

            return ReturnValue;
        }

        #endregion
    }
}
