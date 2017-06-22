using System.Text;
using BopsDataAccess;

namespace BopsBusinessLogicFsc
{
    public struct FscCalculationResult
    {
        private readonly FscCalculationResultType _ResultCode;
        private readonly double _FscAmount;

        public FscCalculationResult(FscCalculationResultType _FscCalculationResult)
        {
            this._ResultCode = _FscCalculationResult;
            _FscAmount = 0;
        }

        public FscCalculationResult(FscCalculationResultType _ResultCode, double _FscAmount)
        {
            this._ResultCode = _ResultCode;
            this._FscAmount = _FscAmount;
        }

        public FscCalculationResultType ResultCode
        {
            get { return _ResultCode; }
        }

        public double FscAmount
        {
            get { return _FscAmount; }
        }
    }

    public interface IFscCalculator
    {
        FscCalculationResult CalculateFsc(BopsLoad load, BopsRfsRateDetails rateDetails, double baseRevenue, StringBuilder calculationDetails);
    }
}
