using BopsDataAccess;

namespace BopsBusinessLogicPlanning
{
    /// <summary>
    /// A data cache for the demurrage details of a single container within a paticular project.
    /// </summary>
    public class DemurrageDetails
    {
        private readonly BopsCpsDemurrage _Demurrage;
        private readonly BopsCpsMovement _ClockBeginMovement;
        private readonly BopsCpsMovement _ClockEndMovement;

        /// <summary>
        /// The demurrage record.
        /// </summary>
        public BopsCpsDemurrage Demurrage
        {
            get { return _Demurrage; }
        }

        /// <summary>
        /// The movement record that triggered the demurrage clock start event.
        /// </summary>
        public BopsCpsMovement ClockBeginMovement
        {
            get { return _ClockBeginMovement; }
        }

        /// <summary>
        /// The movement record that triggered the demurrage clock stop event.
        /// </summary>
        public BopsCpsMovement ClockEndMovement
        {
            get { return _ClockEndMovement; }
        }

        /// <summary>
        /// Construction from a demurrage record only.
        /// </summary>
        /// <param name="Demurrage">The demurrage record.</param>
        public DemurrageDetails(BopsCpsDemurrage Demurrage)
        {
            _Demurrage = Demurrage;
            _ClockBeginMovement = null;
            _ClockEndMovement = null;
        }

        /// <summary>
        /// Construction from a demurrage record and movements.
        /// </summary>
        /// <param name="Demurrage">The demurrage record.</param>
        /// <param name="ClockBeginMovement">The movement record that triggered the demurrage clock start event.</param>
        /// <param name="ClockEndMovement">The movement record that triggered the demurrage clock stop event.</param>
        public DemurrageDetails(BopsCpsDemurrage Demurrage, BopsCpsMovement ClockBeginMovement, BopsCpsMovement ClockEndMovement)
        {
            _Demurrage = Demurrage;
            _ClockBeginMovement = ClockBeginMovement;
            _ClockEndMovement = ClockEndMovement;
        }
    }
}
