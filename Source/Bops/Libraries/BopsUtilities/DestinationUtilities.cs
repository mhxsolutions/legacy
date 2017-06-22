using BopsDataAccess;
using NHibernate;

namespace BopsUtilities
{
    public class DestinationUtilities
    {
        public static BopsDestination LookupParentDestination(ISession DwsRepData, int ChildDestinationId)
        {
            BopsDestination Child = DwsRepData.Load<BopsDestination>(ChildDestinationId);
            if (Child.ParentRef.HasValue && Child.ParentRef.Value != Child.DestinationId)
                return DwsRepData.Load<BopsDestination>(ChildDestinationId);
            return Child;
        }
    }
}
