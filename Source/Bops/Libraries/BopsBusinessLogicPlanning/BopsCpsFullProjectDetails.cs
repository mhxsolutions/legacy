using System.Collections.Generic;
using BopsDataAccess;

namespace BopsBusinessLogicPlanning
{
    /// <summary>
    /// A data cache for details relevant to a CPS project.
    /// </summary>
    public class BopsCpsFullProjectDetails
    {
        private readonly BopsCpsProject _Project;
        private readonly List<BopsCpsMovement> _Moves;
        private readonly List<BopsCpsDemurrage> _Demurrage;

        private int _Pickups;
        private int _Returns;

        /// <summary>
        /// The project details.
        /// </summary>
        public BopsCpsProject Project
        {
            get { return _Project; }
        }

        /// <summary>
        /// The list of moves for the project.
        /// </summary>
        public IList<BopsCpsMovement> Moves
        {
            get { return _Moves; }
        }

        /// <summary>
        /// The list of demurrage records for the project.
        /// </summary>
        public IList<BopsCpsDemurrage> Demurrage
        {
            get { return _Demurrage; }
        }

        /// <summary>
        /// The number of pickups made for the project.
        /// </summary>
        public int Pickups
        {
            get { return _Pickups; }
        }

        /// <summary>
        /// The number of returns made for the project.
        /// </summary>
        public int Returns
        {
            get { return _Returns; }
        }

        private void PerformAnalysis()
        {
            _Pickups = _Returns = 0;

            foreach (BopsCpsMovement Move in _Moves)
            {
                if (Move.OriginRef == _Project.DefaultOriginRef)
                    _Pickups++;
                else if (Move.DestinationRef == _Project.DefaultOriginRef)
                    _Returns++;
            }
        }

        /// <summary>
        /// Construction from a project, list of moves, and demurrage record.
        /// </summary>
        /// <param name="Project">The project details.</param>
        /// <param name="Moves">The list of moves for the project.</param>
        /// <param name="Demurrage">The list of demurrage records for the project.</param>
        public BopsCpsFullProjectDetails(BopsCpsProject Project, IEnumerable<BopsCpsMovement> Moves, IEnumerable<BopsCpsDemurrage> Demurrage)
        {
            _Project = Project;
            _Moves = new List<BopsCpsMovement>(Moves);
            _Demurrage = new List<BopsCpsDemurrage>(Demurrage);

            PerformAnalysis();
        }
    }
}
