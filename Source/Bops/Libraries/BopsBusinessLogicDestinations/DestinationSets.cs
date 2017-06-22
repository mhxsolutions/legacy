using System;
using System.Collections.Generic;
using BopsDataAccess;
using BopsDataConnector;
using NHibernate.Criterion;
using log4net;

namespace BopsBusinessLogicDestinations
{
    internal class DestinationSets : IDestinationSets
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(DestinationSets));

        public DestinationSetDetails GetSetDetails(int SetId)
        {
            IBopsDataConnector DataConnector = BopsDataConnectorFactory.GetDataConnector();

            try
            {
                BopsDestinationSet Set = DataConnector.DwsNoRepData.Get<BopsDestinationSet>(SetId);
                IList<BopsDestinationSetAssignment> Assignments =
                    DataConnector.DwsNoRepData.CreateCriteria(typeof (BopsDestinationSetAssignment))
                        .Add(Expression.Eq("SetRef", SetId))
                        .List<BopsDestinationSetAssignment>();

                return new DestinationSetDetails(Set, Assignments);
            }
            catch(Exception E)
            {
                _Log.Error(string.Format("Could not get set details for set {0}. Details follow.", SetId), E);
            }
            finally
            {
                DataConnector.CloseSessions();
            }

            return null;
        }
    }
}
