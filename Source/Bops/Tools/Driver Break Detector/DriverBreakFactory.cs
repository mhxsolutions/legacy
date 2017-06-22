using System;
using System.Collections.Generic;
using System.Text;

namespace Driver_Break_Detector
{
    public enum OutputGeneratorType
    {
        HtmlFullDetail,
        CsvBreaksOnly
    }

    class DriverBreakFactory
    {
        public static IDriverBreakOutputGenerator CreateOutputGenerator(OutputGeneratorType GeneratorType, DateTime BeginTime, DateTime EndTime, Dictionary<int, DriverDetails> DriverMap, DriverPlanCache PlanCache, Dictionary<int, DriverLocationCache> LocationCacheMap, DriverBreakDetector BreakDetector)
        {
            switch (GeneratorType)
            {
                case OutputGeneratorType.HtmlFullDetail:
                    return new DriverBreakOutputHtmlFullDetailsGenerator(BeginTime, EndTime, DriverMap, PlanCache, LocationCacheMap, BreakDetector);
                case OutputGeneratorType.CsvBreaksOnly:
                    return new DriverBreakOutputCsvBreaksOnly(BeginTime, EndTime, DriverMap, PlanCache, LocationCacheMap, BreakDetector);

                default:
                    throw new ArgumentOutOfRangeException("GeneratorType");
            }
        }
    }
}
