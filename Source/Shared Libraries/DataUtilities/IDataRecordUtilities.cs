using System;
using System.Data;
using log4net;

namespace DataUtilities
{
    public class IDataRecordUtilities
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(IDataRecordUtilities));

        public static string GetReaderString(IDataRecord Reader, string FieldName)
        {
            try
            {
                return Reader[FieldName].ToString();
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return string.Empty;
        }

        public static int GetReaderInteger(IDataRecord Reader, string FieldName)
        {
            try
            {
                return Convert.ToInt32(Reader[FieldName]);
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return 0;
        }

        public static double GetReaderDouble(IDataRecord Reader, string FieldName)
        {
            try
            {
                return Convert.ToDouble(Reader[FieldName]);
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return 0;
        }

        public static DateTime GetReaderDateTime(IDataRecord Reader, string FieldName)
        {
            try
            {
                DateTime ReturnValue = Convert.ToDateTime(Reader[FieldName]);
                return ReturnValue;
            }
            catch (Exception e)
            {
                _Log.ErrorFormat("Could not retrieve field {0} from data reader.", FieldName);
                _Log.Error("Exception details follow.", e);
            }

            return DateTime.MinValue;
        }
    }
}
