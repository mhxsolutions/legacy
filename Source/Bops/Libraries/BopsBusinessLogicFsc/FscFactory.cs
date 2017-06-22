using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFsc
{
    public class FscFactory
    {
        static public IFscCalculator GetFscCalculator(IRfsDataContext rfsDataContext)
        {
            //return new FscSimplePercentCalculator();

            var returnValue = new FscCalculator(rfsDataContext);
            return returnValue;
        }
    }
}
