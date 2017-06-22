using System;
using log4net;

namespace BopsDataConnector
{
    public class BopsDataConnectorFactory
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(BopsDataConnectorFactory));

        public static IBopsDataConnector GetDataConnector()
        {
            IBopsDataConnector ReturnValue = null;

            try
            {
                ReturnValue = new BopsDataConnector();
            }
            catch(Exception Exception)
            {
                _Log.Error("Exception while creating data connector. Details follow.", Exception);
            }

            return ReturnValue;
        }

        public static IBopsDataConnector GetDataConnector(bool PromptForOverride)
        {
            IBopsDataConnector ReturnValue = null;

            try
            {
                ReturnValue = new BopsDataConnector(PromptForOverride);
            }
            catch (Exception Exception)
            {
                _Log.Error("Exception while creating data connector. Details follow.", Exception);
            }

            return ReturnValue;
        }
    }
}
