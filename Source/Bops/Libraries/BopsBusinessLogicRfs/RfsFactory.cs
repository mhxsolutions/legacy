using NHibernate;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    /// <summary>
    /// Status sink to be used internally for dumping notifications.
    /// </summary>
    internal class RfsCalculatorStatusSink : IRfsCalculatorStatus
    {
        public void InitializeProgressMeter(int minimumNumber, int maximumNumber)
        {
            // Do nothing; that's why it's called a sink.
        }

        public void ProgressUpdate(string primaryText, string secondaryText, int currentNumber, int totalNumber)
        {
            // Do nothing; that's why it's called a sink.
        }

        public void UninitializeProgressMeter()
        {
            // Do nothing; that's why it's called a sink.
        }
    }

    /// <summary>
    /// Manufactures interfaces useful for working with RFS invoices.
    /// </summary>
    public class RfsFactory
    {
        /// <summary>
        /// Manufactures an RFS revenue calculator.
        /// </summary>
        /// <param name="rfsDataContext">RFS data context for data access.</param>
        /// <param name="status">The status interface to receive notifications, which may be null if notifications are not required.</param>
        /// <returns>The created RFS revenue calculator.</returns>
        public static IRfsRevenueCalculator GetRfsRevenueCalculator(IRfsDataContext rfsDataContext, 
            IRfsCalculatorStatus status)
        {
            var returnValue = new RfsRevenueCalculator
            {
                RfsDataContext = rfsDataContext,
                StatusCallback = status ?? new RfsCalculatorStatusSink()
            };
            return returnValue;
        }

        /// <summary>
        /// Manufactures an RFS estimated service throughput calculator.
        /// </summary>
        /// <param name="rfsDataContext">RFS data context for data access.</param>
        /// <returns>The created RFS estimated throughput calculator.</returns>
        public static IRfsEstimatedThroughputCalculator GetRfsEstimatedServiceThroughputCalculator(IRfsDataContext rfsDataContext)
        {
            var returnValue = new RfsEstimatedServiceThroughputCalculator(rfsDataContext);
            return returnValue;
        }

        /// <summary>
        /// Manufactures an RFS duplicator.
        /// </summary>
        /// <param name="rfsDataContext">RFS data context for data access.</param>
        /// <returns>The created RFS duplicator.</returns>
        public static IRfsDuplicator GetRfsDuplicator(IRfsDataContext rfsDataContext)
        {
            var returnValue = new RfsDuplicator(rfsDataContext);
            return returnValue;
        }

        /// <summary>
        /// Manufactures an RFS validator.
        /// </summary>
        /// <param name="rfsDataContext">RFS data context for data access.</param>
        /// <returns>The created RFS validator.</returns>
        public static IRfsValidator GetRfsValidator(IRfsDataContext rfsDataContext)
        {
            var returnValue = new RfsValidator(rfsDataContext);
            return returnValue;
        }

        /// <summary>
        /// Manufactures an RFS invoice exporter.
        /// </summary>
        /// <param name="rfsDataContext">RFS data context for data access.</param>
        /// <returns>The created RFS invoice exporter.</returns>
        public static IRfsInvoiceExporter GetRfsInvoiceExporter(IRfsDataContext rfsDataContext)
        {
            var returnValue = new RfsInvoiceExporter(rfsDataContext);
            return returnValue;
        }

        /// <summary>
        /// Manufactures an RFS invoice transferrer.
        /// </summary>
        /// <param name="rfsDataContext">RFS data context for data access.</param>
        /// <returns>The created RFS invoice exporter.</returns>
        public static IRfsInvoiceTransferrer GetRfsInvoiceTransferrer(IRfsDataContext rfsDataContext)
        {
            var returnValue = new RfsInvoiceTransferrer(rfsDataContext);
            return returnValue;
        }

        /// <summary>
        /// Manufactures an RFS lifecycle manager.
        /// </summary>
        /// <param name="rfsDataContext">RFS data context for data access.</param>
        /// <returns>The created RFS lifecycle manager.</returns>
        public static IRfsInvoiceLifecycleManager GetRfsInvoiceLifecycleManager(IRfsDataContext rfsDataContext)
        {
            var returnValue = new RfsInvoiceLifecycleManager(rfsDataContext);
            return returnValue;
        }

        /// <summary>
        /// Manufactures an RFS storage billing calculator.
        /// </summary>
        /// <returns>The created RFS storage billing calculator.</returns>
        public static IRfsStorageBillingCalculator GetRfsStorageBillingCalculator()
        {
            return new RfsStorageBillingCalculator();
        }

        public static IRfsLifecycleManager GetRfsLifecycleManager()
        {
            return new RfsLifecycleManager();
        }
    }
}
