using System;
using System.Collections.Generic;
using System.Xml;
using log4net;

namespace AgilisCore
{
    public class AgilisQuery
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisQuery));

        private string _AgilisRestUrl;
        private string _AgilisRestCompany;

        public AgilisQuery(string _AgilisRestUrl, string _AgilisRestCompany)
        {
            this._AgilisRestUrl = _AgilisRestUrl;
            this._AgilisRestCompany = _AgilisRestCompany;
        }

        public string AgilisRestUrl
        {
            get { return _AgilisRestUrl; }
            set { _AgilisRestUrl = value; }
        }

        public string AgilisRestCompany
        {
            get { return _AgilisRestCompany; }
            set { _AgilisRestCompany = value; }
        }

        public List<AgilisWorkOrder> GetWorkOrders(string UserId, string Password, DateTime StartTime, DateTime EndTime, 
            string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            const string RestApiMethod = "workOrders/list";
            IAgilisStatusInterface Status = (StatusCallback == null ? new AgilisStatusSink() : StatusCallback);
            string StartTimeParam = AgilisUtilities.LocalTimeToAgilisTime(StartTime).ToString("s");
            string EndTimeParam = AgilisUtilities.LocalTimeToAgilisTime(EndTime).ToString("s");
            Dictionary<string, string> Parameters = new Dictionary<string, string>();
            Parameters.Add("start_time", StartTimeParam);
            Parameters.Add("end_time", EndTimeParam);

            Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
            AgilisDataReader WorkOrderReader = new AgilisDataReader(AgilisRestUrl, AgilisRestCompany, UserId, Password, false);
            WorkOrderReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, RawDataFileName);

            Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
            AgilisIntegrationOperation ParseOperation = new AgilisIntegrationOperation();
            AgilisWorkOrderParser WorkOrderParser = new AgilisWorkOrderParser();
            List<AgilisWorkOrder> WorkOrders = WorkOrderParser.ParseWorkOrders(RawDataFileName, null, Status, ParseOperation);

            return WorkOrders;
        }

        public List<AgilisWorkOrder> GetWorkOrdersByPlanDate(string UserId, string Password, DateTime PlanDate, 
            string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            const string RestApiMethod = "workOrders/listBySlotStartDate";
            IAgilisStatusInterface Status = (StatusCallback == null ? new AgilisStatusSink() : StatusCallback);

            DateTime StartTime = PlanDate.Date;
            DateTime EndTime = PlanDate.Date.AddSeconds(1);

            string StartTimeParam = AgilisUtilities.LocalTimeToAgilisTime(StartTime).ToString("s");
            string EndTimeParam = AgilisUtilities.LocalTimeToAgilisTime(EndTime).ToString("s");
            Dictionary<string, string> Parameters = new Dictionary<string, string>();
            Parameters.Add("start_time", StartTimeParam);
            Parameters.Add("end_time", EndTimeParam);

            Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
            AgilisDataReader WorkOrderReader = new AgilisDataReader(AgilisRestUrl, AgilisRestCompany, UserId, Password, false);
            WorkOrderReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, RawDataFileName);

            Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
            AgilisIntegrationOperation ParseOperation = new AgilisIntegrationOperation();
            AgilisWorkOrderParser WorkOrderParser = new AgilisWorkOrderParser();
            List<AgilisWorkOrder> WorkOrders = WorkOrderParser.ParseWorkOrders(RawDataFileName, null, Status, ParseOperation);

            return WorkOrders;
        }

        public List<AgilisWorkOrder> GetWorkOrdersFromFile(string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            IAgilisStatusInterface Status = (StatusCallback == null ? new AgilisStatusSink() : StatusCallback);
            Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
            AgilisIntegrationOperation ParseOperation = new AgilisIntegrationOperation();
            AgilisWorkOrderParser WorkOrderParser = new AgilisWorkOrderParser();
            List<AgilisWorkOrder> WorkOrders = WorkOrderParser.ParseWorkOrders(RawDataFileName, null, Status, ParseOperation);
            return WorkOrders;
        }

        public List<AgilisDriver> GetDrivers(string UserId, string Password, string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            const string RestApiMethod = "drivers/list";
            IAgilisStatusInterface Status = (StatusCallback == null ? new AgilisStatusSink() : StatusCallback);
            Dictionary<string, string> Parameters = new Dictionary<string, string>();

            Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
            AgilisDataReader WorkOrderReader = new AgilisDataReader(AgilisRestUrl, AgilisRestCompany, UserId, Password, false);
            WorkOrderReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, RawDataFileName);

            Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
            AgilisIntegrationOperation ParseOperation = new AgilisIntegrationOperation();
            AgilisDriverParser AgilisParser = new AgilisDriverParser();
            List<AgilisDriver> Drivers = AgilisParser.ParseDrivers(RawDataFileName, Status, ParseOperation);

            return Drivers;
        }

        public List<AgilisSignature> GetWorkOrderSignatures(string UserId, string Password, string WorkOrderNumber, IAgilisStatusInterface StatusCallback)
        {
            const string RestApiMethod = "smartForms/listByWorkOrder";
            IAgilisStatusInterface Status = (StatusCallback == null ? new AgilisStatusSink() : StatusCallback);
            Dictionary<string, string> Parameters = new Dictionary<string, string>();
            Parameters.Add("wo_number", WorkOrderNumber);
            Parameters.Add("image_format", "png");  // TODO: put this in the app.config or somewhere else more mutable

            string Response;
            Status.ProgressUpdate(string.Format("Querying signature for work order {0} from Agilis system...", WorkOrderNumber), "", 0, 0);
            AgilisDataReader AgilisReader = new AgilisDataReader(_AgilisRestUrl, _AgilisRestCompany, UserId, Password, false);
            AgilisReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, out Response);
            List<AgilisSignature> ReturnValue = new List<AgilisSignature>();

            try
            {
                XmlDocument Document = new XmlDocument();
                Document.InnerXml = Response;
                //Old Parser based on old REST URI
                //AgilisSignatureParser Parser = new AgilisSignatureParser();
                //ReturnValue.AddRange(Parser.ParseSignatures(Document, Status, null));
                //130129
                AgilisWorkOrderSignatureParser AgilisParser = new AgilisWorkOrderSignatureParser();
                ReturnValue.AddRange(AgilisParser.ParseSignatures(Document, Status, null));
            }
            catch (Exception e)
            {
                _Log.Error("An exception occurred while processing a signature; details follow.", e);
            }

            return ReturnValue;
        }
        
    }
}
