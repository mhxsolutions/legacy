namespace BopsBusinessLogicDestinations
{
    public class DestinationFactory
    {
        public static IDestinationSets GetDestinationSets()
        {
            return new DestinationSets();
        }
    }
}
