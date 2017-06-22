using NHibernate;

namespace BopsDataConnector
{
    /// <summary>
    /// The IBopsDataConnector interface greatly simplifies the process of acquiring multiple
    /// NHibernate sessions from a single set of session factories. 
    /// </summary>
    public interface IBopsDataConnector
    {
        ISession DwsNoRepData { get; }
        ISession DwsRepData { get; }

        string DwsNoRepDataConnectionString { get; }
        string DwsRepDataConnectionString { get; }

        void CloseSessions();
        void CloseFactories();
        void CloseAll();
    }
}
