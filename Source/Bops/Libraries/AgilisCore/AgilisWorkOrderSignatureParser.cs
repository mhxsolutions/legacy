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
    class AgilisWorkOrderSignatureParser
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisWorkOrderSignatureParser));

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
                    case "mimeType":
                        //Skip Column so it will not add to log
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
            try
            {
                #region 130116 Disabled old Signature Paser based on .../workOrders/signaturesByDateRange
                //foreach (XmlNode Node in Document["WorkOrderSignatureList"])
                //{
                //    if (Node.Name == "WorkOrder")
                //    {
                //        List<AgilisSignature> Signatures = new List<AgilisSignature>();
                //        string WorkOrderNumber = string.Empty;

                //        foreach (XmlNode child in Node.ChildNodes)
                //        {
                //            if (child.Name == "workOrderNumber")
                //            {
                //                WorkOrderNumber = GetFirstChildValue(child);
                //            }
                //            else if (child.Name == "SignatureList")
                //            {
                //                foreach (XmlNode signode in child.ChildNodes)
                //                {
                //                    if (signode.Name == "Signature")
                //                    {
                //                        int SignatureNumber = 0;
                //                        AgilisSignature Signature = AgilisSignatureFromXmlNode(signode);
                //                        Signature.Number = ++SignatureNumber;
                //                        _Log.DebugFormat("Parsed signature at {0}.", Signature.Timestamp);
                //                        Signatures.Add(Signature);

                //                        if (Status != null)
                //                            Status.ProgressUpdate(
                //                                string.Format("Parsed signature at {0}.", Signature.Timestamp), "", 0, 0);
                //                    }
                //                }
                //            }
                //        }

                //        if (Signatures.Count > 0)
                //        {
                //            foreach (AgilisSignature Signature in Signatures)
                //            {
                //                Signature.WorkOrderNumber = WorkOrderNumber;
                //            }

                //            ReturnValue.AddRange(Signatures);
                //        }
                //    }
                //    else
                //    {
                //        _Log.DebugFormat("Unknown element found in work order signature list: {0}", Node.Name);
                //    }
                //}
                #endregion
                #region 130116 New Signature Parser based on .../smartForms/listByDateRange
                foreach (XmlNode Node in Document["SmartFormInstanceList"])
                {
                    if (Node.Name == "SmartFormInstance")
                    {
                        List<AgilisSignature> Signatures = new List<AgilisSignature>();
                        string WorkOrderNumber = String.Empty;
                        string TypeCode = String.Empty;
                        DateTime TimeStampSignature = DateTime.Parse("1/1/1900");
                        IFormatProvider Culture = new CultureInfo("En-US", true);
                        foreach (XmlNode SmartFormInstanceChild in Node.ChildNodes)
                        {
                            if (SmartFormInstanceChild.Name == "workOrderNbr")
                            {
                                WorkOrderNumber = GetFirstChildValue(SmartFormInstanceChild);
                            }
                            else if (SmartFormInstanceChild.Name == "typeCode")
                            {
                                TypeCode = GetFirstChildValue(SmartFormInstanceChild);
                            }
                            else if (SmartFormInstanceChild.Name == "date")
                            {
                                TimeStampSignature = DateTime.ParseExact(GetFirstChildValue(SmartFormInstanceChild), "s", Culture);
                                TimeStampSignature = AgilisUtilities.AgilisTimeToLocalTime(TimeStampSignature);
                            }
                            else if (SmartFormInstanceChild.Name == "Form")
                            {
                                foreach (XmlNode FormChild in SmartFormInstanceChild.ChildNodes)
                                {
                                    if (FormChild.Name == "Section")
                                    {
                                        foreach (XmlNode SectionChild in FormChild.ChildNodes)
                                        {
                                            if (SectionChild.Name == "Field")
                                            {
                                                foreach (XmlNode FieldChild in SectionChild.ChildNodes)
                                                {
                                                    //Check if we are on the Signature Field (id 60530), IF NOT, Get Next Field
                                                    if (FieldChild.Name == "id" && (GetFirstChildValue(FieldChild) != "60530"))
                                                    {
                                                        //Exit foreach.  Get next FieldChild
                                                        break;
                                                    }
                                                    //Find the Signature Node
                                                    if (FieldChild.Name == "Signature")
                                                    {
                                                        int SignatureNumber = 0;
                                                        //Get the Image and Pass the typeCode
                                                        AgilisSignature Signature = AgilisSignatureFromXmlNode(FieldChild);
                                                        if (Signature.ImageData == null)
                                                        {
                                                            //Do not submit since no signature.  Original code always had records with Signature
                                                            break;
                                                        }
                                                        Signature.Number = ++SignatureNumber;
                                                        _Log.DebugFormat("Parsed signature at {0}.", TimeStampSignature);
                                                        Signatures.Add(Signature);

                                                        if (Status != null)
                                                            Status.ProgressUpdate(string.Format("Parsed signature at {0}.", TimeStampSignature), "", 0, 0);

                                                        if (Signatures.Count > 0)
                                                        {
                                                            foreach (AgilisSignature recSignature in Signatures)
                                                            {
                                                                recSignature.WorkOrderNumber = WorkOrderNumber;
                                                                recSignature.Type = TypeCode;
                                                                recSignature.Timestamp = TimeStampSignature;
                                                            }
                                                            ReturnValue.AddRange(Signatures);
                                                        }

                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        _Log.DebugFormat("Unknown element found in work order signature list: {0}", Node.Name);
                    }
                }
                #endregion
            }
            catch (Exception e)
            {
                _Log.Error("Exception parsing work order signatures.", e);
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
