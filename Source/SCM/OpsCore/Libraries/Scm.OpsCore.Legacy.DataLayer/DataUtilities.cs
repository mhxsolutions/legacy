using System;
using System.Data;
using Scm.OpsCore.Bootstrap;

namespace Scm.OpsCore.Legacy.DataLayer
{
    public class DataUtilities
    {
        // TODO: Figure how to inject this into getting the logger: LogManager.GetLogger(typeof(DataUtilities));

        private static readonly ILog Log = Bootstrap.Bootstrap.Kernel.Get<ILog>();

        #region Data Reader Methods

        /// <summary>
        /// Gets a string value from a data reader.
        /// </summary>
        /// <param name="reader">The data reader.</param>
        /// <param name="fieldName">The field to be retrieved.</param>
        /// <returns>The string value if successful, an empty string otherwise.</returns>
        public static string GetReaderString(IDataRecord reader, string fieldName)
        {
            try
            {
                return reader[fieldName].ToString();
            }
            catch (Exception e)
            {
                Log.Error("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return string.Empty;
        }

        /// <summary>
        /// Gets a integer value from a data reader.
        /// </summary>
        /// <param name="reader">The data reader.</param>
        /// <param name="fieldName">The field to be retrieved.</param>
        /// <returns>The integer value if successful, zero otherwise.</returns>
        public static int GetReaderInteger(IDataRecord reader, string fieldName)
        {
            try
            {
                return Convert.ToInt32(reader[fieldName]);
            }
            catch (Exception e)
            {
                Log.Error("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return 0;
        }

        /// <summary>
        /// Gets a double value from a data reader.
        /// </summary>
        /// <param name="reader">The data reader.</param>
        /// <param name="fieldName">The field to be retrieved.</param>
        /// <returns>The double value if successful, zero otherwise.</returns>
        public static double GetReaderDouble(IDataRecord reader, string fieldName)
        {
            try
            {
                return Convert.ToDouble(reader[fieldName]);
            }
            catch (Exception e)
            {
                Log.Error("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return 0;
        }

        /// <summary>
        /// Gets a date time value from a data reader.
        /// </summary>
        /// <param name="reader">The data reader.</param>
        /// <param name="fieldName">The field to be retrieved.</param>
        /// <returns>The date time value if successful, DateTime.Min otherwise.</returns>
        public static DateTime GetReaderDateTime(IDataRecord reader, string fieldName)
        {
            try
            {
                var returnValue = Convert.ToDateTime(reader[fieldName]);
                return returnValue;
            }
            catch (Exception e)
            {
                Log.Error("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return DateTime.MinValue;
        }

        /// <summary>
        /// Gets a nullable date time value from a data reader.
        /// </summary>
        /// <param name="reader">The data reader.</param>
        /// <param name="fieldName">The field to be retrieved.</param>
        /// <returns>The nullable date time value if successful, null otherwise.</returns>
        public static DateTime? GetReaderNullableDateTime(IDataRecord reader, string fieldName)
        {
            try
            {
                if (reader[fieldName] == DBNull.Value)
                    return null;

                DateTime? returnValue = Convert.ToDateTime(reader[fieldName]);
                return returnValue;
            }
            catch (Exception e)
            {
                Log.Error("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return null;
        }

        #endregion
    }
}
