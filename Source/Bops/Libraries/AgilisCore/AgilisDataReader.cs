
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using log4net;

namespace AgilisCore
{
    public class AgilisDataReader
    {
        #region Fields

        private const int DefaultMaxRetries = 5;
        private static readonly ILog Log = LogManager.GetLogger(typeof(AgilisDataReader));

        #endregion

        #region Properties

        public int MaxRetries { get; set; }
        public string AgilisRestUrl { get; set; }
        public string AgilisRestCompany { get; set; }
        public string AgilisUserId { get; set; }
        public string AgilisPassword { get; set; }
        public string WebProxyUrl { get; set; }
        public string WebProxyUserId { get; set; }
        public string WebProxyPassword { get; set; }
        public string WebProxyDomain { get; set; }

        /// <summary>
        /// If this property is set to true, then the reader will only log the calls about to be made and 
        /// will not communicate with Agilis.
        /// </summary>
        public bool SimulationOnly { get; set; }

        #endregion

        #region Construction
        
        public AgilisDataReader(string restUrl, string restCompany, string userId, string password, bool simulationOnly)
        {
            MaxRetries = DefaultMaxRetries;
            AgilisRestUrl = restUrl;
            AgilisRestCompany = restCompany;
            AgilisUserId = userId;
            AgilisPassword = password;
            SimulationOnly = simulationOnly;
        }

        #endregion

        #region Helper Methods

        private string MakeRestUrl(string restApiMethod, Dictionary<string, string> parameters)
        {
            var url = new StringBuilder();
            url.AppendFormat("{0}/{1}/{2}?user_name={3}&password={4}", AgilisRestUrl, AgilisRestCompany, restApiMethod,
                HttpUtility.UrlEncode(AgilisUserId), HttpUtility.UrlEncode(AgilisPassword));

            foreach (KeyValuePair<string, string> pair in parameters)
                url.AppendFormat("&{0}={1}", pair.Key, HttpUtility.UrlEncode(pair.Value));

            return url.ToString();
        }

        private static void StreamToStream(Stream inputStream, Stream outputStream)
        {
            const int bufferSize = 256;
            var streamBuffer = new Byte[bufferSize];
            var bytesReadCount = inputStream.Read(streamBuffer, 0, bufferSize);

            while (bytesReadCount > 0)
            {
                outputStream.Write(streamBuffer, 0, bytesReadCount);
                bytesReadCount = inputStream.Read(streamBuffer, 0, bufferSize);
            }
        }

        #endregion

        public void CallAgilisRestApiMethod(string restApiMethod, Dictionary<string, string> parameters, string outputFilename)
        {
            var requestUrl = MakeRestUrl(restApiMethod, parameters);
            if (SimulationOnly)
            {
                Log.InfoFormat("Simulating REST API call: {0}", requestUrl);
                return;
            }

            Log.InfoFormat("REST API call: {0}", requestUrl);
            var requestUri = new Uri(requestUrl);
            var webRequestObject = HttpWebRequest.Create(requestUri);

            //Added Timeout 120 seconds 130116
            webRequestObject.Timeout = 120000;//from default of 100 seconds
            // TODO: Add a retry mechanism in the case of a timeout.

            using (var webResponse = webRequestObject.GetResponse())
            {
                using (var responseStream = webResponse.GetResponseStream())
                {
                    Log.InfoFormat("REST API response saved to file: {0}", outputFilename);
                    var writeStream = new FileStream(outputFilename, FileMode.Create, FileAccess.Write);
                    StreamToStream(responseStream, writeStream);
                    responseStream.Close();
                    writeStream.Close();
                }

                webResponse.Close();
            }
        }

        public void CallAgilisRestApiMethod(string restApiMethod, Dictionary<string, string> parameters, out string outputString)
        {
            var requestUrl = MakeRestUrl(restApiMethod, parameters);
            if (SimulationOnly)
            {
                Log.InfoFormat("Simulating REST API call: {0}", requestUrl);
                outputString = null;
                return;
            }

            Log.InfoFormat("REST API call: {0}", requestUrl);
            var requestUri = new Uri(requestUrl);
            var webRequestObject = HttpWebRequest.Create(requestUri);

            using (var webResponse = webRequestObject.GetResponse())
            {
                using (var responseStream = webResponse.GetResponseStream())
                {
                    using (var responseReader = new StreamReader(responseStream))
                    {
                        outputString = responseReader.ReadToEnd();
                        responseReader.Close();
                    }
                    responseStream.Close();
                }
                webResponse.Close();
            }
        }
    }
}
