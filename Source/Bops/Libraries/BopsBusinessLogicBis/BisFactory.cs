namespace BopsBusinessLogicBis
{
    public class BisFactory
    {
        public static IBisStorage GetBisStorage()
        {
            return new BisStorage();
        }
    }
}
