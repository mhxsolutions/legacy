using System;
using System.Linq;
using BopsDataAccess;
using NUnit.Framework;

namespace Scm.OpsCore.Legacy.DataLayer.Tests
{
    public class TestRfsDataContext : ITestRfsDataContext
    {
        public void TestGetStatuses(IRfsDataContext context)
        {
            var statuses = context.GetStatuses();
            Assert.IsNotNull(statuses);
            Assert.Greater(statuses.Count, 0);

            foreach (var status in statuses)
            {
                Console.WriteLine("ID = {0}, Status = {1}", status.StatusId, status.Status);
            }
        }

        public void TestGetBillingStatuses(IRfsDataContext context)
        {
            var statuses = context.GetBillingStatuses();
            Assert.IsNotNull(statuses);
            Assert.Greater(statuses.Count, 0);

            foreach (var status in statuses)
            {
                Console.WriteLine("ID = {0}, Status = {1}", status.StatusId, status.Status);
            }
        }

        public void TestGetBillingStatusById(IRfsDataContext context)
        {
            const int statusId = 1;
            Console.WriteLine("Getting status for ID = {0}", statusId);

            var status = context.GetBillingStatusById(statusId);
            Assert.IsNotNull(status);

            Console.WriteLine("Status = {0}", status.Status);
        }

        public void TestGetInvoiceStatuses(IRfsDataContext context)
        {
            var statuses = context.GetInvoiceStatuses();
            Assert.IsNotNull(statuses);
            Assert.Greater(statuses.Count, 0);

            foreach (var status in statuses)
            {
                Console.WriteLine("ID = {0}, Status = {1}", status.StatusId, status.Status);
            }
        }

        public void TestGetCalculationResultTypes(IRfsDataContext context)
        {
            var resultTypes = context.GetCalculationResultTypes();
            Assert.IsNotNull(resultTypes);
            Assert.Greater(resultTypes.Count, 0);

            foreach (var t in resultTypes)
            {
                Console.WriteLine("ID = {0}, Description = {1}", t.ResultTypeId, t.Description);
            }
        }

        public void TestGetLoadByReference(IRfsDataContext context)
        {
            const string loadRef = "S9N0215";
            Console.WriteLine("Getting load for ref = {0}", loadRef);

            var load = context.GetLoadByReference(loadRef);
            Assert.IsNotNull(load);

            Console.WriteLine("Load Key = {0}, BOL = {1}, Log Out Date = {2}",
                load.LoadKey, load.BillOfLading, load.LogOutDate);
        }

        public void TestGetLoadsByReferences(IRfsDataContext context)
        {
            var loadRefs = new[] { "S8H3115", "P1108611", "P1108608", "P1108607", "P1108605", "P1108603" };

            Console.WriteLine("Getting loads for the following refs:");
            foreach (var loadRef in loadRefs)
            {
                Console.WriteLine("\t{0}", loadRef);
            }
            Console.WriteLine();

            var loads = context.GetLoadsByReferences(loadRefs);

            Assert.IsNotNull(loads);
            Assert.Greater(loads.Count, 0);

            foreach (var load in loads)
            {
                Console.WriteLine("Load Ref = {0}, Load Key = {1}, BOL = {2}, Log Out Date = {3}, Load Date = {4}",
                    load.LoadReference, load.LoadKey, load.BillOfLading, load.LogOutDate, load.LoadDate);
            }
        }

        public void TestGetLoadsByDateRange(IRfsDataContext context)
        {
            var beginDate = new DateTime(2015, 01, 01);
            var endDate = new DateTime(2015, 01, 03);

            Console.WriteLine("Getting loads where {0} <= Load Date <= {1}:", beginDate, endDate);

            var loads = context.GetLoadsByLoadDateRange(beginDate, endDate);

            Assert.IsNotNull(loads);
            Assert.Greater(loads.Count, 0);

            foreach (var load in loads)
            {
                Assert.GreaterOrEqual(load.LoadDate, beginDate);
                Assert.LessOrEqual(load.LoadDate, endDate);

                Console.WriteLine("Load Ref = {0}, Load Key = {1}, BOL = {2}, Log Out Date = {3}, Load Date = {4}",
                    load.LoadReference, load.LoadKey, load.BillOfLading, load.LogOutDate, load.LoadDate);
            }
        }

        public void TestGetCalculationResultsByLoadReference(IRfsDataContext context)
        {
            const string loadRef = "S9N0215";

            Console.WriteLine("Getting calculation results for load ref = {0}", loadRef);

            var results = context.GetCalculationResultsByLoadReference(loadRef);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Load Ref = {1}, Result Type = {2}",
                    result.ResultId, result.LoadReference, result.ResultType);
            }
        }

        public void TestGetCalculationResultsByLoadReferences(IRfsDataContext context)
        {
            var loadRefs = new[] { "S8H3115", "P1108611", "P1108608", "P1108607", "P1108605", "P1108603" };

            Console.WriteLine("Getting calculation results for the following load refs:");
            foreach (var loadRef in loadRefs)
            {
                Console.WriteLine("\t{0}", loadRef);
            }
            Console.WriteLine();

            var results = context.GetCalculationResultsByLoadReferences(loadRefs);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Load Ref = {1}, Result Type = {2}",
                    result.ResultId, result.LoadReference, result.ResultType);
            }
        }

        public void TestGetServiceCalculationResultsByLoadReferences(IRfsDataContext context)
        {
            var loadRefs = new[] { "S8H3115", "P1108611", "P1108608", "P1108607", "P1108605", "P1108603" };

            Console.WriteLine("Getting service calculation results for the following load refs:");
            foreach (var loadRef in loadRefs)
            {
                Console.WriteLine("\t{0}", loadRef);
            }
            Console.WriteLine();

            var results = context.GetServiceCalculationResultsByLoadReferences(loadRefs);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Load Ref = {1}, Billing Status = {2}",
                    result.ResultId, result.LoadRef, result.BillingStatus);
            }
        }

        public void TestGetServiceCalculationResultsByIds(IRfsDataContext context)
        {
            var resultIds = new[] { 564679, 564680, 564681, 564682, 564683 };

            Console.WriteLine("Getting service calculation results for the following IDs:");
            foreach (var id in resultIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var results = context.GetServiceCalculationResultsByIds(resultIds);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Load Ref = {1}, Billing Status = {2}",
                    result.ResultId, result.LoadRef, result.BillingStatus);
            }
        }

        public void TestGetServiceCalculationResultsByLoadReference(IRfsDataContext context)
        {
            const string loadRef = "S9N0215";

            Console.WriteLine("Getting calculation results for load ref = {0}", loadRef);

            var results = context.GetServiceCalculationResultsByLoadReference(loadRef);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);
            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Load Ref = {1}, Billing Status = {2}",
                    result.ResultId, result.LoadRef, result.BillingStatus);
            }
        }

        public void TestGetServiceCalculationResultById(IRfsDataContext context)
        {
            const int resultId = 567017;
            
            Console.WriteLine("Getting service calculation results for ID = {0}", resultId);

            var result = context.GetServiceCalculationResultById(resultId);
            Assert.IsNotNull(result);

            Console.WriteLine("Result ID = {0}, Load Ref = {1}, Billing Status = {2}",
                result.ResultId, result.LoadRef, result.BillingStatus);
        }

        public void TestGetReceiverById(IRfsDataContext context)
        {
            const int receiverId = 97704;
            
            Console.WriteLine("Getting receiver for ID = {0}", receiverId);

            var receiver = context.GetReceiverById(receiverId);
            Assert.IsNotNull(receiver);

            Console.WriteLine("ID = {0}, Date Received = {1}, Receiver Type = {2}",
                receiver.ReceiverId, receiver.DateReceived, receiver.ReceiverType);
        }

        public void TestGetReceiversByIDs(IRfsDataContext context)
        {
            var receiverIds = new[] { 97704, 97705, 97771, 97859, 97860 };

            Console.WriteLine("Getting receivers for the following IDs:");
            foreach (var id in receiverIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var receivers = context.GetReceiversByIDs(receiverIds);
            Assert.IsNotNull(receivers);
            Assert.Greater(receivers.Count, 0);

            foreach (var receiver in receivers)
            {
                Console.WriteLine("ID = {0}, Date Received = {1}, Receiver Type = {2}",
                    receiver.ReceiverId, receiver.DateReceived, receiver.ReceiverType);
            }
        }

        public void TestGetReceiversByDateReceivedRange(IRfsDataContext context)
        {
            var beginDate = new DateTime(2015, 01, 01);
            var endDate = new DateTime(2015, 01, 03);

            Console.WriteLine("Getting receivers where {0} <= Date Received <= {1}:", beginDate, endDate);

            var receivers = context.GetReceiversByDateReceivedRange(beginDate, endDate);
            Assert.IsNotNull(receivers);
            Assert.Greater(receivers.Count, 0);

            foreach (var receiver in receivers)
            {
                Assert.GreaterOrEqual(receiver.DateReceived, beginDate);
                Assert.LessOrEqual(receiver.DateReceived, endDate);

                Console.WriteLine("ID = {0}, Date Received = {1}, Receiver Type = {2}",
                    receiver.ReceiverId, receiver.DateReceived, receiver.ReceiverType);
            }
        }

        public void TestGetShipperById(IRfsDataContext context)
        {
            const int shipperId = 184271;

            Console.WriteLine("Getting shipper for ID = {0}", shipperId);

            var shipper = context.GetShipperById(shipperId);
            Assert.IsNotNull(shipper);

            Console.WriteLine("Load ID = {0}, Shipment Date = {1}, Load Type = {2}",
                shipper.LoadId, shipper.ShipmentDate, shipper.LoadType);
        }

        public void TestGetShippersByIDs(IRfsDataContext context)
        {
            var shipperIds = new[] { 184271, 185182, 185183, 185184, 185185, 185186 };

            Console.WriteLine("Getting shippers for the following IDs:");
            foreach (var id in shipperIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var shippers = context.GetShippersByIDs(shipperIds);
            Assert.IsNotNull(shippers);
            Assert.Greater(shippers.Count, 0);

            foreach (var shipper in shippers)
            {
                Console.WriteLine("Load ID = {0}, Shipment Date = {1}, Load Type = {2}",
                    shipper.LoadId, shipper.ShipmentDate, shipper.LoadType);
            }
        }

        public void TestGetShippersByShipmentDateRange(IRfsDataContext context)
        {
            var beginDate = new DateTime(2015, 01, 01);
            var endDate = new DateTime(2015, 01, 03);

            Console.WriteLine("Getting shippers where {0} <= Date Received <= {1}:", beginDate, endDate);

            var shippers = context.GetShippersByShipmentDateRange(beginDate, endDate);
            Assert.IsNotNull(shippers);
            Assert.Greater(shippers.Count, 0);

            foreach (var shipper in shippers)
            {
                Assert.GreaterOrEqual(shipper.ShipmentDate, beginDate);
                Assert.LessOrEqual(shipper.ShipmentDate, endDate);

                Console.WriteLine("Load ID = {0}, Shipment Date = {1}, Load Type = {2}",
                    shipper.LoadId, shipper.ShipmentDate, shipper.LoadType);
            }
        }

        public void TestGetCalculationResultsByReceiverId(IRfsDataContext context)
        {
            const int receiverId = 97704;

            Console.WriteLine("Getting calculation results for ID = {0}", receiverId);

            var results = context.GetCalculationResultsByReceiverId(receiverId);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Warehouse Document Type = {1}, Warehouse Document ID = {2}, Result Type = {3}",
                    result.ResultId, result.WarehouseDocumentType, result.WarehouseDocumentId, result.ResultType);
            }
        }

        public void TestGetServiceCalculationResultsByReceiverId(IRfsDataContext context)
        {
            const int receiverId = 97704;

            Console.WriteLine("Getting service calculation results for receiver ID = {0}", receiverId);

            var results = context.GetServiceCalculationResultsByReceiverId(receiverId);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Warehouse Document Type = {1}, Warehouse Document ID = {2}, Billing Status = {3}",
                    result.ResultId, result.DocumentType, result.DocumentId, result.BillingStatus);
            }
        }

        public void TestGetServiceCalculationResultsByShipperId(IRfsDataContext context)
        {
            const int shipperId = 184271;

            Console.WriteLine("Getting service calculation results for shipper ID = {0}", shipperId);

            var results = context.GetServiceCalculationResultsByShipperId(shipperId);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Warehouse Document Type = {1}, Warehouse Document ID = {2}, Billing Status = {3}",
                    result.ResultId, result.DocumentType, result.DocumentId, result.BillingStatus);
            }
        }

        public void TestGetCalculationResultsByShipperId(IRfsDataContext context)
        {
            const int shipperId = 184271;

            Console.WriteLine("Getting calculation results for shipper ID = {0}", shipperId);

            var results = context.GetCalculationResultsByShipperId(shipperId);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Warehouse Document Type = {1}, Warehouse Document ID = {2}, Result Type = {3}",
                    result.ResultId, result.WarehouseDocumentType, result.WarehouseDocumentId, result.ResultType);
            }
        }

        public void TestGetCalculationResultsByWarehouseDocumentIds(IRfsDataContext context)
        {
            var shipperIds = new[] { 184271, 185182, 185183, 185184, 185185, 185186 };
            var receiverIds = new[] { 97704, 97705, 97771, 97859, 97860 };
            var unionIds = shipperIds.Union(receiverIds).ToArray();

            var results = context.GetCalculationResultsByWarehouseDocumentIds(unionIds);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Warehouse Document Type = {1}, Warehouse Document ID = {2}, Result Type = {3}",
                    result.ResultId, result.WarehouseDocumentType, result.WarehouseDocumentId, result.ResultType);
            }
        }

        public void TestGetServiceCalculationResultsByWarehouseDocumentIds(IRfsDataContext context)
        {
            var shipperIds = new[] { 184271, 185182, 185183, 185184, 185185, 185186 };
            var receiverIds = new[] { 97704, 97705, 97771, 97859, 97860 };
            var unionIds = shipperIds.Union(receiverIds).ToArray();

            var results = context.GetServiceCalculationResultsByWarehouseDocumentIds(unionIds);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Warehouse Document Type = {1}, Warehouse Document ID = {2}, Billing Status = {3}",
                    result.ResultId, result.DocumentType, result.DocumentId, result.BillingStatus);
            }
        }

        public void TestGetRfs(IRfsDataContext context)
        {
            var rfs = context.GetRfs(0, 100, 0);
            Assert.IsNotNull(rfs);
            Assert.Greater(rfs.Count, 0);

            foreach (var r in rfs)
            {
                Console.WriteLine("ID = {0}, Begin Date = {1}, Description = {2}", 
                    r.RfsId, r.BeginDate, r.WorkDescription);
            }
        }

        public void TestGetRfsById(IRfsDataContext context)
        {
            const int rfsId = 1977;

            Console.WriteLine("Getting RFS for ID = {0}", rfsId);

            var r = context.GetRfsById(rfsId);
            Assert.IsNotNull(r);

            Console.WriteLine("ID = {0}, Begin Date = {1}, Description = {2}",
                r.RfsId, r.BeginDate, r.WorkDescription);
        }

        public void TestGetRfsByIds(IRfsDataContext context)
        {
            var rfsIds = new[] { 1977, 1978, 1979, 1980, 1981, 1982, 1983 };

            Console.WriteLine("Getting RFS for the following IDs:");
            foreach (var id in rfsIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var rfs = context.GetRfsByIds(rfsIds);
            Assert.IsNotNull(rfs);
            Assert.Greater(rfs.Count, 0);

            foreach (var r in rfs)
            {
                Console.WriteLine("ID = {0}, Begin Date = {1}, Description = {2}",
                    r.RfsId, r.BeginDate, r.WorkDescription);
            }
        }

        public void TestGetInvoiceDetailsByInvoiceId(IRfsDataContext context)
        {
            const int invoiceId = 412751;

            Console.WriteLine("Getting invoice details for invoice ID = {0}", invoiceId);

            var details = context.GetInvoiceDetailsByInvoiceId(invoiceId);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            foreach (var d in details)
            {
                Console.WriteLine("Line Number = {0}, Item Date = {1}, Item Description = {2}",
                    d.LineNumber, d.ItemDate, d.ItemDescription);
            }
        }

        public void TestGetInvoiceDetailsByInvoiceIds(IRfsDataContext context)
        {
            var invoiceIds = new[] { 412768, 412769, 412770, 412771, 412782 };

            Console.WriteLine("Getting invoice details for the following invoice IDs:");
            foreach (var id in invoiceIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var details = context.GetInvoiceDetailsByInvoiceIds(invoiceIds);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            foreach (var d in details)
            {
                Console.WriteLine("Invoice ID = {0}, Line Number = {1}, Item Date = {2}, Item Description = {3}",
                    d.InvoiceRef, d.LineNumber, d.ItemDate, d.ItemDescription);
            }
        }

        public void TestGetInvoiceDetailsFromServiceCalculationResults(IRfsDataContext context)
        {
            var resultIds = new[] { 561258, 561271, 564056, 564057, 564059 };

            Console.WriteLine("Getting invoice details for the following service calculation result IDs:");
            foreach (var id in resultIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var details = context.GetInvoiceDetailsFromServiceCalculationResults(resultIds);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            foreach (var d in details)
            {
                Console.WriteLine("Invoice ID = {0}, Line Number = {1}, Item Date = {2}, Item Description = {3}",
                    d.InvoiceRef, d.LineNumber, d.ItemDate, d.ItemDescription);
            }
        }

        public void TestGetDestinations(IRfsDataContext context)
        {
            var destinations = context.GetDestinations(0, 100, 0);
            Assert.IsNotNull(destinations);
            Assert.Greater(destinations.Count, 0);

            foreach (var d in destinations)
            {
                Console.WriteLine("ID = {0}, Destination = {1}",
                    d.DestinationId, d);
            }
        }

        public void TestGetDestinationById(IRfsDataContext context)
        {
            const int destinationId = 2145383943;

            Console.WriteLine("Getting destination for ID = {0}", destinationId);

            var d = context.GetDestinationById(destinationId);
            Assert.IsNotNull(d);

            Console.WriteLine("ID = {0}, Destination = {1}",
                d.DestinationId, d);
        }

        public void TestGetDestinationsByIds(IRfsDataContext context)
        {
            var destinationIds = new[] { 2145383943, 2145321400, 166073081, 547021467, 2145395029 };

            Console.WriteLine("Getting destinations for the following IDs:");
            foreach (var id in destinationIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var destinations = context.GetDestinationsByIds(destinationIds);
            Assert.IsNotNull(destinations);
            Assert.Greater(destinations.Count, 0);

            foreach (var d in destinations)
            {
                Console.WriteLine("ID = {0}, Destination = {1}",
                    d.DestinationId, d);
            }
        }

        public void TestGetCostMethodById(IRfsDataContext context)
        {
            const int methodId = 1;

            Console.WriteLine("Getting cost method for ID = {0}", methodId);

            var method = context.GetCostMethodById(methodId);
            Assert.IsNotNull(method);

            Console.WriteLine("ID = {0}, Name = {1}", 
                method.CostMethodId, method.Name);
        }

        public void TestGetUnitsOfMeasure(IRfsDataContext context)
        {
            var uom = context.GetUnitsOfMeasure();
            Assert.IsNotNull(uom);
            Assert.Greater(uom.Count, 0);

            foreach (var u in uom)
            {
                Console.WriteLine("ID = {0}, Unit = {1}",
                    u.UnitId, u.Name);
            }
        }

        public void TestGetUnitOfMeasureById(IRfsDataContext context)
        {
            const int unitId = 1;

            Console.WriteLine("Getting unit of measure for ID = {0}", unitId);

            var u = context.GetUnitOfMeasureById(unitId);
            Assert.IsNotNull(u);

            Console.WriteLine("ID = {0}, Unit = {1}",
                u.UnitId, u.Name);
        }

        public void TestGetCostMatrixById(IRfsDataContext context)
        {
            const int matrixId = 1;

            Console.WriteLine("Getting cost matrix for ID = {0}", matrixId);

            var m = context.GetCostMatrixById(matrixId);
            Assert.IsNotNull(m);

            Console.WriteLine("ID = {0}, Name = {1}",
                m.MatrixId, m.Name);
        }

        public void TestGetEmployeesByRoleType(IRfsDataContext context)
        {
            const EmployeeRoleTypes roleType = EmployeeRoleTypes.Sales;

            Console.WriteLine("Getting employees for role type = {0}", roleType);

            var employees = context.GetEmployeesByRoleType(roleType);
            Assert.IsNotNull(employees);
            Assert.Greater(employees.Count, 0);

            foreach (var e in employees)
            {
                Console.WriteLine("ID = {0}, First Name = {1}, Last Name = {2}", 
                    e.DriverId, e.FirstName, e.LastName);
            }
        }

        public void TestGetProducts(IRfsDataContext context)
        {
            var products = context.GetProducts();
            Assert.IsNotNull(products);
            Assert.Greater(products.Count, 0);

            foreach (var p in products)
            {
                Console.WriteLine("ID = {0}, Name = {1}",
                    p.AtsfProductId, p.Name);
            }
        }

        public void TestGetWorkTypes(IRfsDataContext context)
        {
            var workTypes = context.GetWorkTypes();
            Assert.IsNotNull(workTypes);
            Assert.Greater(workTypes.Count, 0);

            foreach (var t in workTypes)
            {
                Console.WriteLine("ID = {0}, Type = {1}",
                    t.WorkTypeId, t.WorkType);
            }
        }

        public void TestGetStakeholderById(IRfsDataContext context)
        {
            const int stakeholderId = 22862;

            Console.WriteLine("Getting stakeholder for ID = {0}", stakeholderId);

            var s = context.GetStakeholderById(stakeholderId);
            Assert.IsNotNull(s);

            Console.WriteLine("ID = {0}, RFS = {1}, Role = {2}, Client = {3}", 
                s.StakeholderId, s.RfsRef, s.RoleRef, s.ClientRef);
        }

        public void TestGetStakeholdersByRfsId(IRfsDataContext context)
        {
            const int rfsId = 1977;

            Console.WriteLine("Getting stakeholders for RFS ID = {0}", rfsId);

            var stakeholders = context.GetStakeholdersByRfsId(rfsId);
            Assert.IsNotNull(stakeholders);
            Assert.Greater(stakeholders.Count, 0);

            foreach (var s in stakeholders)
            {
                Console.WriteLine("ID = {0}, RFS = {1}, Role = {2}, Client = {3}",
                    s.StakeholderId, s.RfsRef, s.RoleRef, s.ClientRef);
            }
        }

        public void TestGetStakeholderRoles(IRfsDataContext context)
        {
            var roles = context.GetStakeholderRoles();
            Assert.IsNotNull(roles);
            Assert.Greater(roles.Count, 0);

            foreach (var r in roles)
            {
                Console.WriteLine("ID = {0}, Name = {1}",
                    r.Id, r.Name);
            }
        }

        public void TestGetServicesOffered(IRfsDataContext context)
        {
            var services = context.GetServicesOffered(0);
            Assert.IsNotNull(services);
            Assert.Greater(services.Count, 0);

            foreach (var s in services)
            {
                Console.WriteLine("ID = {0}, Name = {1}",
                    s.Id, s.Name);
            }
        }

        public void TestGetServiceOfferedById(IRfsDataContext context)
        {
            const int serviceId = 1;

            Console.WriteLine("Getting service offered for ID = {0}", serviceId);

            var service = context.GetServiceOfferedById(serviceId);
            Assert.IsNotNull(service);

            Console.WriteLine("ID = {0}, Name = {1}", service.Id, service.Name);
        }

        public void TestGetServicesOfferedByIds(IRfsDataContext context)
        {
            var serviceIds = new[] { 1, 2, 3, 4, 5 };

            Console.WriteLine("Getting services offered for the following IDs:");
            foreach (var id in serviceIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var services = context.GetServicesOfferedByIds(serviceIds);
            Assert.IsNotNull(services);
            Assert.Greater(services.Count, 0);

            foreach (var s in services)
            {
                Console.WriteLine("ID = {0}, Name = {1}", s.Id, s.Name);
            }
        }

        public void TestGetServiceOfferedByServiceRequestedId(IRfsDataContext context)
        {
            // 6, 1, RFS 24

            const int serviceId = 6;

            Console.WriteLine("Getting service offered for service requested ID = {0}", serviceId);

            var service = context.GetServiceOfferedByServiceRequestedId(serviceId);
            Assert.IsNotNull(service);
            Assert.AreEqual(1, service.Id);

            Console.WriteLine("ID = {0}, Name = {1}", service.Id, service.Name);
        }

        public void TestGetServicesRequested(IRfsDataContext context)
        {
            var services = context.GetServicesRequested(0, 100, 0);
            Assert.IsNotNull(services);
            Assert.Greater(services.Count, 0);

            foreach (var s in services)
            {
                Console.WriteLine("ID = {0}, Service Offered = {1}, RFS = {2}",
                    s.ServiceRequestedId, s.ServiceOfferedRef, s.RfsRef);
            }
        }

        public void TestGetServicesRequestedByRfsId(IRfsDataContext context)
        {
            const int rfsId = 1977;

            Console.WriteLine("Getting services requested for RFS ID = {0}", rfsId);

            var services = context.GetServicesRequestedByRfsId(rfsId);
            Assert.IsNotNull(services);
            Assert.Greater(services.Count, 0);

            foreach (var s in services)
            {
                Console.WriteLine("ID = {0}, Service Offered = {1}, RFS = {2}",
                    s.ServiceRequestedId, s.ServiceOfferedRef, s.RfsRef);
            }
        }

        public void TestGetInvoiceById(IRfsDataContext context)
        {
            const int invoiceId = 412751;

            Console.WriteLine("Getting invoice for ID = {0}", invoiceId);

            var i = context.GetInvoiceById(invoiceId);
            Assert.IsNotNull(i);

            Console.WriteLine("Batch ID = {0}, Invoice ID = {1}, Type = {2}, Date = {3}, Status = {4}, Total = {5}",
                i.BatchId, i.InvoiceId, i.InvoiceType, i.InvoiceDate, i.InvoiceStatus, i.InvoiceTotal);
        }

        public void TestGetInvoicesByIds(IRfsDataContext context)
        {
            var invoiceIds = new[] { 412768, 412769, 412770, 412771, 412782 };

            Console.WriteLine("Getting invoices for the following invoice IDs:");
            foreach (var id in invoiceIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var invoices = context.GetInvoicesByIds(invoiceIds);
            Assert.IsNotNull(invoices);
            Assert.Greater(invoices.Count, 0);

            foreach (var i in invoices)
            {
                Console.WriteLine("Batch ID = {0}, Invoice ID = {1}, Type = {2}, Date = {3}, Status = {4}, Total = {5}",
                    i.BatchId, i.InvoiceId, i.InvoiceType, i.InvoiceDate, i.InvoiceStatus, i.InvoiceTotal);
            }
        }

        public void TestGetInvoicesByBatchIds(IRfsDataContext context)
        {
            var batchIds = new[] { 2, 3, 4, 5 };

            Console.WriteLine("Getting invoices for the following batch IDs:");
            foreach (var id in batchIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var invoices = context.GetInvoicesByBatchIds(batchIds);
            Assert.IsNotNull(invoices);
            Assert.Greater(invoices.Count, 0);

            foreach (var i in invoices)
            {
                Console.WriteLine("Batch ID = {0}, Invoice ID = {1}, Type = {2}, Date = {3}, Status = {4}, Total = {5}",
                    i.BatchId, i.InvoiceId, i.InvoiceType, i.InvoiceDate, i.InvoiceStatus, i.InvoiceTotal);
            }
        }

        public void TestGetInvoicesByDates(IRfsDataContext context)
        {
            var beginDate = new DateTime(2015, 01, 01);
            var endDate = new DateTime(2015, 01, 03);

            Console.WriteLine("Getting invoices where {0} <= Invoice Date <= {1}:", beginDate, endDate);

            var invoices = context.GetInvoicesByDates(beginDate, endDate, 0);
            Assert.IsNotNull(invoices);
            Assert.Greater(invoices.Count, 0);

            foreach (var i in invoices)
            {
                Assert.GreaterOrEqual(i.InvoiceDate, beginDate);
                Assert.LessOrEqual(i.InvoiceDate, endDate);

                Console.WriteLine("Batch ID = {0}, Invoice ID = {1}, Type = {2}, Date = {3}, Status = {4}, Total = {5}, Company ID = {6}",
                    i.BatchId, i.InvoiceId, i.InvoiceType, i.InvoiceDate, i.InvoiceStatus, i.InvoiceTotal, i.CompanyRef);
            }
        }

        public void TestGetStakeholders(IRfsDataContext context)
        {
            var stakeholders = context.GetStakeholders(0, 100, 100);
            Assert.IsNotNull(stakeholders);
            Assert.Greater(stakeholders.Count, 0);

            foreach (var s in stakeholders)
            {
                Console.WriteLine("ID = {0}, RFS = {1}, Role = {2}, Client = {3}",
                    s.StakeholderId, s.RfsRef, s.RoleRef, s.ClientRef);
            }
        }

        public void TestGetServiceCalculationResultsByDatesAndBillingStatus(IRfsDataContext context)
        {
            var beginDate = new DateTime(2015, 01, 01);
            var endDate = new DateTime(2015, 01, 03);
            const RfsBillingStatus billingStatus = RfsBillingStatus.Exported;

            Console.WriteLine("Getting service calculation results where {0} <= Billing Date <= {1} and Status = {2}:", 
                beginDate, endDate, billingStatus);

            var results = context.GetServiceCalculationResultsByDatesAndBillingStatus(beginDate, endDate, billingStatus, 0);
            Assert.IsNotNull(results);
            Assert.Greater(results.Count, 0);

            foreach (var result in results)
            {
                Console.WriteLine("Result ID = {0}, Warehouse Document Type = {1}, Warehouse Document ID = {2}, Billing Status = {3}",
                    result.ResultId, result.DocumentType, result.DocumentId, result.BillingStatus);
            }
        }

        public void TestGetStorageBillsToInvoice(IRfsDataContext context)
        {
            // There really isn't much we can test here. The count of bills to invoice can sometimes
            // be zero. So the best we can do is exercise the function and make sure it returns
            // nothing negative.

            var count = context.GetStorageBillsToInvoice();
            Assert.Greater(count, -1);
        }

        public void TestGetStorageBillingDetailsByIds(IRfsDataContext context)
        {
            var detailIds = new[] { 723406, 723407, 723408, 723409, 723410 };

            Console.WriteLine("Getting storage billing details for the following IDs:");
            foreach (var id in detailIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var details = context.GetStorageBillingDetailsByIds(detailIds);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            foreach (var d in details)
            {
                Console.WriteLine("Detail ID = {0}, Billing Ref = {1}, Inventory Ref = {2}, Revenue = {3}",
                    d.DetailId, d.BillingRef, d.InventoryRef, d.Revenue);
            }
        }

        public void TestGetStorageBillingDetailsByBillingId(IRfsDataContext context)
        {
            const int billingId = 108;

            Console.WriteLine("Getting storage billing details for billing ID = {0}", billingId);

            var details = context.GetStorageBillingDetailsByBillingId(billingId);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            foreach (var d in details)
            {
                Console.WriteLine("Detail ID = {0}, Billing Ref = {1}, Inventory Ref = {2}, Revenue = {3}",
                    d.DetailId, d.BillingRef, d.InventoryRef, d.Revenue);
            }
        }

        public void TestGetStorageBillingDetailById(IRfsDataContext context)
        {
            const int detailId = 723424;

            Console.WriteLine("Getting storage billing details for ID = {0}", detailId);

            var d = context.GetStorageBillingDetailById(detailId);
            Assert.IsNotNull(d);

            Console.WriteLine("Detail ID = {0}, Billing Ref = {1}, Inventory Ref = {2}, Revenue = {3}",
                d.DetailId, d.BillingRef, d.InventoryRef, d.Revenue);
        }

        public void TestGetStorageBillingDetailsUpToBillingStatus(IRfsDataContext context)
        {
            // The commented out status produces something like 400k results, so I switched
            // to the status in use. I don't know why there's a single row out there with that 
            // status, but it looks like an old record and makes it far faster for a unit test.

            //const RfsBillingStatus status = RfsBillingStatus.Exported;    
            const RfsBillingStatus status = RfsBillingStatus.Invoiced;

            Console.WriteLine("Getting storage billing details for status = {0}", status);

            var details = context.GetStorageBillingDetailsUpToBillingStatus(status);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            const int max = 100;
            foreach (var d in details.Take(max))
            {
                Console.WriteLine("Detail ID = {0}, Billing Ref = {1}, Inventory Ref = {2}, Revenue = {3}",
                    d.DetailId, d.BillingRef, d.InventoryRef, d.Revenue);
            }
        }

        public void TestGetStorageBillingDetailsByBillingIdAndUpToBillingStatus(IRfsDataContext context)
        {
            const int billingId = 108;
            const RfsBillingStatus status = RfsBillingStatus.Exported;

            Console.WriteLine("Getting storage billing details for billing ID = {0} and status = {1}", billingId, status);

            var details = context.GetStorageBillingDetailsByBillingIdAndUpToBillingStatus(billingId, status);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            foreach (var d in details)
            {
                Console.WriteLine("Detail ID = {0}, Billing Ref = {1}, Inventory Ref = {2}, Revenue = {3}",
                    d.DetailId, d.BillingRef, d.InventoryRef, d.Revenue);
            }
        }

        public void TestGetStorageBillings(IRfsDataContext context)
        {
            var billings = context.GetStorageBillings();
            Assert.IsNotNull(billings);
            Assert.Greater(billings.Count, 0);

            foreach (var b in billings)
            {
                Console.WriteLine("Storage Billing ID = {0}, Date Billed Through = {1}, Date Generated = {2}, User ID = {3}",
                    b.BillingId, b.DateBilledThrough, b.DateGenerated, b.UserId);
            }
        }

        public void TestGetStorageBillingById(IRfsDataContext context)
        {
            const int billingId = 108;

            Console.WriteLine("Getting storage billing for ID = {0}", billingId);

            var b = context.GetStorageBillingById(billingId);
            Assert.IsNotNull(b);

            Console.WriteLine("Storage Billing ID = {0}, Date Billed Through = {1}, Date Generated = {2}, User ID = {3}",
                b.BillingId, b.DateBilledThrough, b.DateGenerated, b.UserId);
        }

        public void TestGetStorageBillingsByIDs(IRfsDataContext context)
        {
            var billingIds = new[] { 1, 2, 3, 4, 9 };

            Console.WriteLine("Getting storage billings for the following IDs:");
            foreach (var id in billingIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var billings = context.GetStorageBillingsByIDs(billingIds);
            Assert.IsNotNull(billings);
            Assert.Greater(billings.Count, 0);

            foreach (var b in billings)
            {
                Console.WriteLine("Storage Billing ID = {0}, Date Billed Through = {1}, Date Generated = {2}, User ID = {3}",
                    b.BillingId, b.DateBilledThrough, b.DateGenerated, b.UserId);
            }
        }

        public void TestGetInventoryDetailsByIDs(IRfsDataContext context)
        {
            var detailIds = new[] { 2919565, 2919511, 2919512, 2919513, 2919514, 2919515 };

            Console.WriteLine("Getting inventory details for the following IDs:");
            foreach (var id in detailIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var details = context.GetInventoryDetailsByIDs(detailIds);
            Assert.IsNotNull(details);
            Assert.Greater(details.Count, 0);

            foreach (var d in details)
            {
                Console.WriteLine("ID = {0}, Receiver Ref = {1}, PG1 = {2}, PG2 = {3}, PG3 = {4}",
                    d.DetailId, d.ReceiverRef, d.ProductGroup1, d.ProductGroup2, d.ProductGroup3);
            }
        }

        public void TestGetProductProfileById(IRfsDataContext context)
        {
            const int profileId = 1;

            Console.WriteLine("Getting product profile for ID = {0}", profileId);

            var p = context.GetProductProfileById(profileId);
            Assert.IsNotNull(p);

            Console.WriteLine("Profile ID = {0}, Receiving Client Ref = {1}, Product Class Description = {2}",
                p.ProfileId, p.ReceivingClientRef, p.ProductClassDescription);
        }

        public void TestGetProductProfilesByIDs(IRfsDataContext context)
        {
            var profileIds = new[] { 1, 2, 3, 4, 5 };

            Console.WriteLine("Getting product profiles for the following IDs:");
            foreach (var id in profileIds)
            {
                Console.WriteLine("\t{0}", id);
            }
            Console.WriteLine();

            var profiles = context.GetProductProfilesByIDs(profileIds);
            Assert.IsNotNull(profiles);
            Assert.Greater(profiles.Count, 0);

            foreach (var p in profiles)
            {
                Console.WriteLine("Profile ID = {0}, Receiving Client Ref = {1}, Product Class Description = {2}",
                    p.ProfileId, p.ReceivingClientRef, p.ProductClassDescription);
            }

        }

        public void TestGetLocations(IRfsDataContext context)
        {
            var locations = context.GetLocations(0);
            Assert.IsNotNull(locations);
            Assert.Greater(locations.Count, 0);

            foreach (var l in locations)
            {
                Console.WriteLine("Code = {0}, Name = {1}",
                    l.LocationCode, l.Name);
            }
        }

        public void TestGetCompanyUsers(IRfsDataContext context)
        {
            var companyUsers = context.GetCompanyUsers();
            Assert.IsNotNull(companyUsers);
            Assert.Greater(companyUsers.Count, 0);

            foreach (var u in companyUsers)
            {
                Console.WriteLine(
                    "CompanyUserId = {0}, CurrentUserId = {1}, CompanyRef = {2}, UserPermissionRef = {3}, WindowsId = {4}",
                    u.CompanyUserId, u.CurrentUserId, u.CompanyRef, u.UserPermissionRef, u.WindowsUserId);
            }
        }

        public void TestGetCompanies(IRfsDataContext context)
        {
            var companies = context.GetCompanies();
            Assert.IsNotNull(companies);
            Assert.Greater(companies.Count, 0);

            foreach (var c in companies)
            {
                Console.WriteLine(
                    "CompanyUserId = {0}, Name = {1}, City = {2}",
                    c.CompanyId, c.Name, c.City);
            }
        }

        public void TestGetCompanyUserPermissions(IRfsDataContext context)
        {
            var permissions = context.GetCompanyUserPermissions();
            Assert.IsNotNull(permissions);
            Assert.Greater(permissions.Count, 0);

            foreach (var p in permissions)
            {
                Console.WriteLine(
                    "PermissionId = {0}, Title = {1}, Description = {2}",
                    p.PermissionId, p.Title, p.Description);
            }
        }

        public void TestGetFuelSurcharge(IRfsDataContext context)
        {
            var fsc = context.GetFuelSurcharge();
            Assert.IsNotNull(fsc);
            Assert.Greater(fsc.Count, 0);

            foreach (var f in fsc)
            {
                Console.WriteLine("FscId = {0}, BeginDate = {1}, CostMethodRef = {2}, EndDate = {3}, Description = {4}, Name = {5}",
                    f.FscId, f.BeginDate, f.CostMethodRef, f.EndDate, f.Description, f.Name);
            }
        }

        public void TestGetFuelSurchargeById(IRfsDataContext context)
        {
            const int fscId = 1;
            var fsc = context.GetFuelSurchargeById(fscId);
            Assert.IsNotNull(fsc);

            Console.WriteLine("FscId = {0}, BeginDate = {1}, CostMethodRef = {2}, EndDate = {3}, Description = {4}, Name = {5}",
                fsc.FscId, fsc.BeginDate, fsc.CostMethodRef, fsc.EndDate, fsc.Description, fsc.Name);
        }

        public void TestGetScansByDocumentIdsSignedAndReject(IRfsDataContext context)
        {
            var loadRefs = new[] { "T714305", "T714705", "T595905", "99450FON", "J428208" };

            var scans = context.GetScansByDocumentIdsSignedAndReject(loadRefs, true, 0);
            Assert.IsNotNull(scans);
            Assert.Greater(scans.Count, 0);

            foreach (var scan in scans)
            {
                Console.WriteLine("ScanId = {0}, DocScanned = {1}, DocTypeRef = {2}, FileName = {3}",
                    scan.ScanId, scan.DocScanned, scan.DocTypeRef, scan.FileName);
            }
        }

        public void TestGetInvoiceSupportingDocuments(IRfsDataContext context)
        {
            // This invoice was selected by finding invoices with lots of lines and looking
            // at their contents.

            //var invoiceId = 258295;
            //var invoiceId = 252025;
            var invoiceId = 446902;

            var scans = context.GetInvoiceSupportingDocuments(invoiceId);
            Assert.IsNotNull(scans);
            Assert.Greater(scans.Count, 0);

            foreach (var scan in scans)
            {
                Console.WriteLine("ScanId = {0}, DocScanned = {1}, DocTypeRef = {2}, FileName = {3}",
                    scan.ScanId, scan.DocScanned, scan.DocTypeRef, scan.FileName);
            }
        }
    }
}
