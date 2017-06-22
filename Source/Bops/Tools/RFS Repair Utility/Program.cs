using System;
using System.Collections.Generic;
using System.IO;
using BopsDataAccess;
using NHibernate;
using NHibernate.Expression;
using NHibernateUtilities;

namespace RFS_Repair_Utility
{
    class Program
    {
        private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

        static void Main()
        {
            string ConfigurationFileName = Path.Combine(Directory.GetCurrentDirectory(), _DwsNoRepData);
            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepDataSession = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            Mgr.BeginTransaction(_DwsNoRepData);

            IList<BopsRfs> AllRfs = DwsNoRepDataSession.CreateCriteria(typeof (BopsRfs)).List<BopsRfs>();

            foreach (BopsRfs Rfs in AllRfs)
            {
                Console.WriteLine("Processing RFS {0}", Rfs.RfsId);

                IList<BopsRfsStakeholder> Stakeholders = DwsNoRepDataSession.CreateCriteria(typeof (BopsRfsStakeholder))
                    .Add(Expression.Eq("RfsRef", Rfs.RfsId))
                    .List<BopsRfsStakeholder>();

                BopsRfsStakeholder Shipper = null;

                foreach (BopsRfsStakeholder Stakeholder in Stakeholders)
                {
                    if (Stakeholder.RoleRef == BopsRfsStakeholder.RoleType.Shipper)
                    {
                        if (Shipper != null)
                        {
                            Console.WriteLine("  RFS {0} has more than one shipper, deleting stakeholder {1}", Rfs.RfsId, Stakeholder.StakeholderId);
                            DwsNoRepDataSession.Delete(Stakeholder);
                        }
                        else
                        {
                            Shipper = Stakeholder;
                        }
                    }
                }

                if (Shipper == null)
                {
                    Console.WriteLine("  RFS {0} has no shipper stakeholder, creating", Rfs.RfsId);

                    Shipper = new BopsRfsStakeholder();
                    Shipper.ClientRef = Rfs.ShipperRef;
                    Shipper.RfsRef = Rfs.RfsId;
                    Shipper.RoleRef = BopsRfsStakeholder.RoleType.Shipper;
                    DwsNoRepDataSession.Save(Shipper);
                }
                else if (Shipper.ClientRef != Rfs.ShipperRef)
                {
                    Console.WriteLine("  RFS {0} shipper stakeholder {1} has wrong client, updating from {2} to {3}", 
                        Rfs.RfsId, Shipper.StakeholderId, Shipper.ClientRef, Rfs.ShipperRef);

                    Shipper.ClientRef = Rfs.ShipperRef;
                    DwsNoRepDataSession.Update(Shipper);
                }

                // Finally, update all services to point at the shipper stakeholder.

                IList<BopsRfsServicesRequested> Services = DwsNoRepDataSession.CreateCriteria(typeof (BopsRfsServicesRequested))
                    .Add(Expression.Eq("RfsRef", Rfs.RfsId))
                    .List<BopsRfsServicesRequested>();

                foreach (BopsRfsServicesRequested Service in Services)
                {
                    if (Service.ShipperRef != Shipper.StakeholderId)
                    {
                        Console.WriteLine("  RFS {0} service {1} has invalid shipper, updating from {2} to {3}",
                            Rfs.RfsId, Service.ServiceRequestedId, Service.ShipperRef, Shipper.StakeholderId);

                        Service.ShipperRef = Shipper.StakeholderId;
                        DwsNoRepDataSession.Update(Service);
                    }
                }
            }

            Mgr.CloseAllSessions(true);

            Console.WriteLine("Press any key to exit");
            Console.ReadKey();
        }
    }
}
