
namespace AgilisCore
{
    public interface IAgilisStatusInterface
    {
        void ProgressUpdate(string PrimaryText, string SecondaryText, int CurrentNumber, int TotalNumber);
    }
    
    public class AgilisStatusSink : IAgilisStatusInterface
    {
        public void ProgressUpdate(string PrimaryText, string SecondaryText, int CurrentNumber, int TotalNumber)
        {
            // Do nothing; that's why it's called a sink.
        }
    }
}
