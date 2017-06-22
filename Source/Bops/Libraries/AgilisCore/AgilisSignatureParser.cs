using System;
using System.Collections.Generic;
using System.Globalization;
using System.Xml;
using log4net;

/*
 * For those who have noticed that this library has both an AgilisSignatureParser class
 * and an AgilisWorkOrderSignatureParser class, the reason for the duplication is
 * historical. The original means for requesting a signature from Agilis required that
 * the REST API be called once for every work order. The AgilisSignatureParser class
 * handled the response from that method.
 * 
 * Because the performance of such a web API was understandably poor, Agilis later
 * added a new API to allow signatures to be queried for multiple work orders at once
 * across time. The AgilisWorkOrderSignatureParser class handles the response from that
 * new, more efficient, "chunky" method.
 */

namespace AgilisCore
{
    class AgilisSignatureParser
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisSignatureParser));

        #region Helper Methods

        private string GetFirstChildValue(XmlNode Node)
        {
            if (Node.FirstChild == null)
                return null;
            else
                return Node.FirstChild.Value.Trim();
        }

        private AgilisSignature AgilisSignatureFromXmlNode(XmlNode Node)
        {
            AgilisSignature ReturnValue = new AgilisSignature();
            IFormatProvider Culture = new CultureInfo("En-US", true);

            foreach (XmlNode SubNode in Node.ChildNodes)
            {
                switch (SubNode.Name)
                {
                    case "timeStamp":
                        ReturnValue.Timestamp = DateTime.ParseExact(GetFirstChildValue(SubNode), "s", Culture);
                        ReturnValue.Timestamp = AgilisUtilities.AgilisTimeToLocalTime(ReturnValue.Timestamp);
                        break;
                    case "image":
                        ReturnValue.ImageData = GetFirstChildValue(SubNode);
                        break;
                    case "typeCode":
                        ReturnValue.Type = GetFirstChildValue(SubNode);
                        break;
                    default:
                        _Log.DebugFormat("Unknown field found while parsing signature: {0}", SubNode.Name);
                        break;
                }
            }

            return ReturnValue;
        }

        private void ParseSignatures(XmlDocument Document, IAgilisStatusInterface Status, List<AgilisSignature> ReturnValue)
        {
            int SignatureNumber = 0;

            try
            {
                foreach (XmlNode Node in Document["SignatureList"])
                {
                    if (Node.Name == "Signature")
                    {
                        AgilisSignature Signature = AgilisSignatureFromXmlNode(Node);
                        Signature.Number = ++SignatureNumber;
                        _Log.DebugFormat("Parsed signature at {0}.", Signature.Timestamp);

                        if (Status != null)
                            Status.ProgressUpdate(string.Format("Parsed signature at {0}.", Signature.Timestamp), "", 0, 0);

                        ReturnValue.Add(Signature);
                    }
                    else
                    {
                        _Log.DebugFormat("Unknown element found in signature list: {0}", Node.Name);
                    }
                }
            }
            catch (Exception e)
            {
                _Log.Error("Exception parsing signatures.", e);
            }
        }

        #endregion

        #region Public Interface

        public List<AgilisSignature> ParseSignatures(XmlDocument Document, IAgilisStatusInterface Status, AgilisIntegrationOperation Operation)
        {
            List<AgilisSignature> ReturnValue = new List<AgilisSignature>();

            if (Document != null && Document.HasChildNodes)
                ParseSignatures(Document, Status, ReturnValue);

            return ReturnValue;
        }

        public List<AgilisSignature> ParseSignatures(string FileName, IAgilisStatusInterface Status, AgilisIntegrationOperation Operation)
        {
            List<AgilisSignature> ReturnValue = new List<AgilisSignature>();
            XmlDocument Document = new XmlDocument();
            Document.Load(FileName);
            ParseSignatures(Document, Status, ReturnValue);
            return ReturnValue;
        }

        #endregion
    }
}
