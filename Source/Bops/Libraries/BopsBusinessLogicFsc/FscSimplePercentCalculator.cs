using System.Text;
using BopsDataAccess;

namespace BopsBusinessLogicFsc
{
    /// <summary>
    /// Performs a simple, percentage based FSC calculation.
    /// </summary>
    internal class FscSimplePercentCalculator : IFscCalculator
    {
        private const double _DefaultFscPercentage = 0.10;
        private double _FscPercentage;

        public FscSimplePercentCalculator()
        {
            _FscPercentage = _DefaultFscPercentage;
        }

        public FscSimplePercentCalculator(double _FscPercentage)
        {
            this._FscPercentage = _FscPercentage;
        }

        public double FscPercentage
        {
            get { return _FscPercentage; }
            set { _FscPercentage = value; }
        }

        public void PrecacheFscData()
        {
            // No precaching needed for this variant.
        }

        public FscCalculationResult CalculateFsc(BopsLoad load, BopsRfsRateDetails rateDetails, double baseRevenue, StringBuilder calculationDetails)
        {
            return new FscCalculationResult(FscCalculationResultType.Success, baseRevenue * _FscPercentage);
        }
    }
}
