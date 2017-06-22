using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security;
using System.Text;
using BopsDataAccess;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace Scm.OpsCore.Legacy.NHibernate
{
    /// <summary>
    /// An NHibernate implementation of the Solomon invoice transfer interface.
    /// </summary>
    class SolomonInvoiceTransfer : ISolomonInvoiceTransfer
    {
        //private static readonly ILog Log = LogManager.GetLogger(typeof(SolomonInvoiceTransfer));
        private readonly ILog _log;

        private IRfsDataContext _rfsDataContext;
        private string _connectionString;
        private SqlConnection _connection;
        private SqlTransaction _transaction;

        private Dictionary<string, BopsRfsLocation> _rfsLocations;
        private Dictionary<int, BopsRfsServicesOffered> _servicesOfferedMap;

        /// <summary>
        /// Initializes a new instance of the <see cref="SolomonInvoiceTransfer"/> class.
        /// </summary>
        /// <param name="log">Should be supplied through dependency injection.</param>
        public SolomonInvoiceTransfer(ILog log)
        {
            _log = log;
        }

        #region Helper Methods

        private void LazyConnect()
        {
            if (_connection != null) return;
            _connection = new SqlConnection(_connectionString);
            _connection.Open();
            _transaction = _connection.BeginTransaction();
        }

        private void Disconnect(bool commit)
        {
            if (_connection == null) return;
            if (_transaction != null)
            {
                if (commit)
                    _transaction.Commit();
                else
                    _transaction.Rollback();
            }
            _connection.Dispose();
        }

        private static string GetCurrentUserId()
        {
            var currentIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (currentIdentity == null)
                throw new SecurityException("Could not obtain Windows identity.");
            return currentIdentity.Name;
        }

        private static void SetNullParameter(SqlCommand command)
        {
            foreach (SqlParameter parameter in command.Parameters)
            {
                if (parameter.Value == null)
                {
                    parameter.Value = DBNull.Value;
                }
            }
        }

        public void SwitchToDatabase(string databaseName)
        {
            if (_connection == null) return;
            _connection.ChangeDatabase(databaseName);
        }

        private Dictionary<int, List<BopsRfsInvoice>> GetBatchInvoicesMap(int[] batchIds)
        {
            var invoices = _rfsDataContext.GetInvoicesByBatchIds(batchIds);
            var returnValue = new Dictionary<int, List<BopsRfsInvoice>>();

            foreach (var invoice in invoices)
            {
                List<BopsRfsInvoice> targetList;

                if (returnValue.ContainsKey(invoice.BatchId.Value))
                {
                    targetList = returnValue[invoice.BatchId.Value];
                }
                else
                {
                    targetList = new List<BopsRfsInvoice>();
                    returnValue.Add(invoice.BatchId.Value, targetList);
                }

                targetList.Add(invoice);
            }

            return returnValue;
        }

        #endregion

        /// <inheritdoc/>
        public void Open(IRfsDataContext rfsDataContext, string connectionString)
        {
            _connectionString = connectionString;

            _rfsDataContext = rfsDataContext;
            _servicesOfferedMap = _rfsDataContext.GetServicesOffered().ToDictionary(s => s.Id, s => s);
            _rfsLocations = _rfsDataContext.GetLocations().ToDictionary(l => l.LocationCode, l => l);
        }

        /// <inheritdoc/>
        public void TransferArDoc(BopsRfsInvoice invoice, BopsRfsLocation location, string mas90ClientCode, 
            List<BopsRfsInvoiceDetail> details)
        {
            LazyConnect();

            using (var command = new SqlCommand("xsp_SCM_xTrnsfrARDoc_Add", _connection))
            {
                command.Transaction = _transaction;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = 120;
                command.Parameters.Add("@psCpnyId", SqlDbType.VarChar, 10);
                command.Parameters.Add("@psCustID", SqlDbType.VarChar, 15);
                command.Parameters.Add("@psCustOrdNbr", SqlDbType.VarChar, 25);
                command.Parameters.Add("@psDocType", SqlDbType.Char, 2);
                command.Parameters.Add("@pdInvcDate", SqlDbType.SmallDateTime);
                command.Parameters.Add("@pdPostDate", SqlDbType.SmallDateTime);
                command.Parameters.Add("@psComment", SqlDbType.VarChar, 762);
                command.Parameters.Add("@pnTransBatNbr", SqlDbType.Int);
                command.Parameters.Add("@psSCMfield1", SqlDbType.VarChar, 3);
                command.Parameters.Add("@psSCMfield2", SqlDbType.VarChar, 20);
                command.Parameters.Add("@pnSCMfield3", SqlDbType.Int);
                command.Parameters.Add("@pnSCMfield4", SqlDbType.Int);
                command.Parameters.Add("@psRefNbr", SqlDbType.Char, 10);
                command.Parameters.Add("@psTerms", SqlDbType.VarChar, 2);
                command.Parameters.Add("@pdDueDate", SqlDbType.SmallDateTime);
                command.Parameters.Add("@psUser", SqlDbType.VarChar, 20);
                command.Parameters.Add("@pnResult", SqlDbType.Int).Direction = ParameterDirection.Output;

                command.Parameters["@psCpnyId"].Value = location.CpnyID;
                command.Parameters["@psCustID"].Value = mas90ClientCode;
                command.Parameters["@psCustOrdNbr"].Value = invoice.InvoiceId;
                command.Parameters["@psDocType"].Value = invoice.InvoiceTotal > 0 ? "IN" : "CM";
                command.Parameters["@pdInvcDate"].Value = invoice.InvoiceDate;
                command.Parameters["@pdPostDate"].Value = invoice.DateClosed;
                command.Parameters["@psComment"].Value = invoice.PublicNotes;
                command.Parameters["@pnTransBatNbr"].Value = invoice.BatchId;
                command.Parameters["@psSCMfield1"].Value = DBNull.Value;
                command.Parameters["@psSCMfield2"].Value = DBNull.Value;
                command.Parameters["@pnSCMfield3"].Value = DBNull.Value;
                command.Parameters["@pnSCMfield4"].Value = DBNull.Value;
                command.Parameters["@psRefNbr"].Value = invoice.InvoiceId;
                command.Parameters["@psTerms"].Value = DBNull.Value;
                command.Parameters["@pdDueDate"].Value = DBNull.Value;
                command.Parameters["@psUser"].Value = GetCurrentUserId();

                SetNullParameter(command);

                command.ExecuteNonQuery();

                invoice.ARDocRecId = Convert.ToInt32(command.Parameters["@pnResult"].Value);
            }

            double storageTotal = 0;

            foreach (var detail in details)
            {
                var serviceOffered = _servicesOfferedMap[detail.ServiceOfferedRef];

                if (detail.IsServiceBill)
                {
                    // The following is the original code. I don't know why I was fetching a single 
                    // RFS service calculation result in this way. But in the new data layer it's
                    // just a single call to get it by its ID, so I've substituted that. My hope is
                    // that everything will continue to work as intended. (JBW 09/28/2015)
                    //
                    //BopsRfsServiceCalculationResult serviceResults = _DwsNoRepSession.CreateCriteria(typeof(BopsRfsServiceCalculationResult))
                    //    .Add(Restrictions.Eq("ResultId", detail.ServiceCalculationResultRef.Value))
                    //    .List<BopsRfsServiceCalculationResult>().FirstOrDefault();

                    var serviceCalculationResult = _rfsDataContext.GetServiceCalculationResultById(detail.ServiceCalculationResultRef.Value);

                    var itemTotal = (serviceCalculationResult != null && serviceCalculationResult.PublicRate.FscRevenue != 0)
                        ? serviceCalculationResult.PublicRate.RfsRevenue
                        : detail.ItemTotal;

                    if (itemTotal > 0)
                    {
                        detail.ArTrnRecId = TransferArTran(invoice, detail, serviceOffered.SLCOA, serviceOffered.SLSUB, itemTotal);
                    }

                    if (serviceCalculationResult != null && serviceCalculationResult.PublicRate.FscRevenue != 0)
                    {
                        TransferArTran(invoice, detail, location.SLCOA, location.SLSUB, serviceCalculationResult.PublicRate.FscRevenue);
                    }
                }
                else if (detail.IsManualBill)
                {
                    //if (Detail.ItemTotal > 0)
                    //{
                    TransferArTran(invoice, detail, serviceOffered.SLCOA, serviceOffered.SLSUB, detail.ItemTotal);
                    //}
                }
                else if (detail.IsStorageBill)
                {
                    // if storage Type, accumulate the total
                    storageTotal = storageTotal + detail.ItemTotal;
                }
            }

            if (storageTotal > 0)
            {
                var detail = details.First();

                var serviceOffered = _servicesOfferedMap[detail.ServiceOfferedRef];

                if (serviceOffered != null)
                {
                    TransferArTran(invoice, detail, serviceOffered.SLCOA, serviceOffered.SLSUB, storageTotal);
                }
                else
                {
                    TransferArTran(invoice, detail, location.SLCOA, location.SLSUB, storageTotal);
                }
            }

        }

        /// <inheritdoc/>
        public int TransferArTran(BopsRfsInvoice invoice, BopsRfsInvoiceDetail detail, string account, 
            string subAccount, double itemTotal)
        {
            using (var command = new SqlCommand("xsp_SCM_xTrnsfrARTran_Add", _connection))
            {
                command.Transaction = _transaction;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = 120;
                command.Parameters.Add("@psARDocRecId", SqlDbType.VarChar, 10);
                command.Parameters.Add("@pnSCMLineNbr", SqlDbType.Int);
                command.Parameters.Add("@psAcct", SqlDbType.VarChar, 10);
                command.Parameters.Add("@psSub", SqlDbType.VarChar, 24);
                command.Parameters.Add("@pnQty", SqlDbType.Float);
                command.Parameters.Add("@pnCuryUnitPrice", SqlDbType.Float);
                command.Parameters.Add("@pnCuryTranAmt", SqlDbType.Float);
                command.Parameters.Add("@psComment", SqlDbType.VarChar, 762);
                command.Parameters.Add("@pnTransBatNbr", SqlDbType.Int);
                command.Parameters.Add("@psSCMfield1", SqlDbType.VarChar, 3);
                command.Parameters.Add("@pnSCMfield2", SqlDbType.Int);
                command.Parameters.Add("@psRefNbr", SqlDbType.Char, 10);
                command.Parameters.Add("@pnLineNbr", SqlDbType.SmallInt);
                command.Parameters.Add("@psUser", SqlDbType.VarChar, 20);
                command.Parameters.Add("@pnResult", SqlDbType.Int).Direction = ParameterDirection.Output;

                command.Parameters["@psARDocRecId"].Value = invoice.ARDocRecId;
                command.Parameters["@pnSCMLineNbr"].Value = detail.LineNumber;
                command.Parameters["@psAcct"].Value = account;
                command.Parameters["@psSub"].Value = subAccount;
                command.Parameters["@pnQty"].Value = 1;
                command.Parameters["@pnCuryUnitPrice"].Value = invoice.InvoiceTotal > 0 ? itemTotal : Math.Abs(itemTotal);
                command.Parameters["@psComment"].Value = detail.ItemDescription;
                command.Parameters["@pnCuryTranAmt"].Value = invoice.InvoiceTotal > 0 ? itemTotal : Math.Abs(itemTotal);
                command.Parameters["@pnTransBatNbr"].Value = invoice.BatchId;
                command.Parameters["@psSCMfield1"].Value = detail.LocationCode;
                command.Parameters["@pnSCMfield2"].Value = 0;
                command.Parameters["@psRefNbr"].Value = invoice.InvoiceId;
                command.Parameters["@pnLineNbr"].Value = detail.LineNumber;
                command.Parameters["@psUser"].Value = GetCurrentUserId();

                SetNullParameter(command);

                command.ExecuteNonQuery();

                return Convert.ToInt32(command.Parameters["@pnResult"].Value);
            }
        }

        /// <inheritdoc/>
        public string ValidateInvoiceTransferBatches(int[] batchIds)
        {
            // Fail if we cannot get the current user ID.

            var currentIdentity = System.Security.Principal.WindowsIdentity.GetCurrent();
            if (currentIdentity == null || string.IsNullOrEmpty(currentIdentity.Name))
                return "Cannot obtain current user ID.";

            // Fail if the caller didn't provide any invoice IDs.

            if (batchIds == null || batchIds.Length < 1)
                throw new ArgumentException("Must provide at least one invoice ID", "batchIds");

            // Fail if any of the desired invoice records cannot be found.

            var batches = _rfsDataContext.GetInvoiceTransferBatchesByIds(batchIds);
            if (batches.Count != batchIds.Length)
            {
                return string.Format("Of the {0} batch IDs selected for post, only {1} could be found.",
                    batchIds.Length, batches.Count);
            }

            // Process each of the invoices, checking it for failure conditions.

            var returnValue = new StringBuilder();
            var batchInvoicesMap = GetBatchInvoicesMap(batchIds);

            foreach (var batch in batches)
            {
                // Add failure for the invoice not being finalized.

                if (batch.PostedDate != null)
                {
                    returnValue.AppendFormat("Batch {0} has been posted.", batch.BatchId);
                    returnValue.AppendLine();
                }

                // Add failure if the invoice has no detail lines.

                if (!batchInvoicesMap.ContainsKey(batch.BatchId))
                {
                    returnValue.AppendFormat("Batch {0} has no invoices.", batch.BatchId);
                    returnValue.AppendLine();
                }
            }

            return returnValue.Length > 0 ? returnValue.ToString() : null;
            
        }

        /// <inheritdoc/>
        public bool PostTransferBatch(int[] batchIds)
        {
            LazyConnect();

            var errors = ValidateInvoiceTransferBatches(batchIds);
            if (errors != null)
                return false;

            var batches = _rfsDataContext.GetInvoiceTransferBatchesByIds(batchIds);
            var postedDate = DateTime.Now;

            try
            {
                foreach (var batch in batches)
                {
                    var location = _rfsLocations[batch.LocationCode];
                    var databaseName = location.DatabaseName;
                    SwitchToDatabase(databaseName);

                    using (var command = new SqlCommand("xsp_SCM_Batch_AR", _connection))
                    {
                        //command.Transaction = PostTransaction;
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 120;
                        command.Parameters.Add("@pnTransBatNbr", SqlDbType.Int);
                        //command.Parameters.Add("@psCpnyId", SqlDbType.VarChar, 10);
                        command.Parameters.Add("@psProgram", SqlDbType.VarChar, 8);
                        command.Parameters.Add("@psUser", SqlDbType.VarChar, 10);

                        command.Parameters["@pnTransBatNbr"].Value = batch.BatchId;
                        //command.Parameters["@psCpnyId"].Value = Location.CpnyID;
                        command.Parameters["@psProgram"].Value = "RFS";
                        command.Parameters["@psUser"].Value = GetCurrentUserId();

                        SetNullParameter(command);

                        command.ExecuteNonQuery();
                    }

                    batch.PostedDate = postedDate;
                    _rfsDataContext.SaveChanges();
                }

                Disconnect(true);
                return true;
            }
            catch (Exception e)
            {
                _log.Error("An exception occurred exporting invoices. Details follow.", e);
                Disconnect(false);
            }

            return false;
        }

        /// <inheritdoc/>
        public void Close(bool commitTransaction)
        {
            Disconnect(commitTransaction);
        }
    }
}
