using System;

namespace AgilisCore
{
    public class AgilisUtilities
    {
        static public DateTime AgilisTimeToLocalTime(DateTime t)
        {
            return t.ToLocalTime();
        }

        static public DateTime LocalTimeToAgilisTime(DateTime t)
        {
            return t.ToUniversalTime();
        }
    }
}
