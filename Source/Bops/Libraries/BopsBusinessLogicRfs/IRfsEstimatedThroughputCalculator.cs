using BopsDataAccess;

namespace BopsBusinessLogicRfs
{
    /// <summary>
    /// Defines the details of estimated throughput: (1) revenue, (2) minutes, and (3) the resulting throughput.
    /// </summary>
    public class RfsEstimatedThroughputDetails
    {
        private readonly double _EstimatedRevenue;
        private readonly double _EstimatedMinutes;
        private readonly double _EstimatedThroughput;

        /// <summary>
        /// Constructs the object from the supplied parameters.
        /// </summary>
        /// <param name="_EstimatedRevenue">Estimated revenue.</param>
        /// <param name="_EstimatedMinutes">Estimated minutes.</param>
        public RfsEstimatedThroughputDetails(double _EstimatedRevenue, double _EstimatedMinutes)
        {
            this._EstimatedRevenue = _EstimatedRevenue;
            this._EstimatedMinutes = _EstimatedMinutes;
            _EstimatedThroughput = _EstimatedRevenue / _EstimatedMinutes;
        }

        /// <summary>
        /// The estimated revenue.
        /// </summary>
        public double EstimatedRevenue
        {
            get { return _EstimatedRevenue; }
        }

        /// <summary>
        /// The estimated minutes.
        /// </summary>
        public double EstimatedMinutes
        {
            get { return _EstimatedMinutes; }
        }

        /// <summary>
        /// The estimated throughput, calculated as revenue per minute.
        /// </summary>
        public double EstimatedThroughput
        {
            get { return _EstimatedThroughput; }
        }
    }

    /// <summary>
    /// Defines the details of estimated throughput for a pair of rates, public and private. Refer to
    /// <see cref="RfsEstimatedThroughputDetails"/> for the details of estimated revenue.
    /// </summary>
    public class RfsEstimatedServiceThroughput
    {
        private RfsEstimatedThroughputDetails _PublicRate;
        private RfsEstimatedThroughputDetails _PrivateRate;

        /// <summary>
        /// Constructs the object from the supplied parameters.
        /// </summary>
        /// <param name="PrivateRevenue">Private estimated revenue details.</param>
        /// <param name="PublicRevenue">Public estimated revenue details.</param>
        /// <param name="Minutes">Estimated minutes.</param>
        public RfsEstimatedServiceThroughput(double PrivateRevenue, double PublicRevenue, double Minutes)
        {
            _PrivateRate = (PrivateRevenue > 0.0 && Minutes > 0.0) ? new RfsEstimatedThroughputDetails(PrivateRevenue, Minutes) : null;
            _PublicRate = (PublicRevenue > 0.0 && Minutes > 0.0) ? new RfsEstimatedThroughputDetails(PublicRevenue, Minutes) : null;
        }

        /// <summary>
        /// Public estimated revenue details.
        /// </summary>
        public RfsEstimatedThroughputDetails PublicRate
        {
            get { return _PublicRate; }
            set { _PublicRate = value; }
        }

        /// <summary>
        /// Private estimated revenue details.
        /// </summary>
        public RfsEstimatedThroughputDetails PrivateRate
        {
            get { return _PrivateRate; }
            set { _PrivateRate = value; }
        }
    }

    /// <summary>
    /// The interface defined by the RFS system for estimating throughput.
    /// </summary>
    public interface IRfsEstimatedThroughputCalculator
    {
        /// <summary>
        /// Calculates the estimated throughput for a service.
        /// </summary>
        /// <param name="service">The requested service of interest.</param>
        /// <returns>an object containing the estimated throughput details for both the private and public rates.</returns>
        RfsEstimatedServiceThroughput CalculateEstimatedServiceThroughput(BopsRfsServicesRequested service);
    }
}
