namespace BopsDataAccess
{
    public class BopsRfsCalculationResultType
    {
        private int _ResultTypeId;
        private string _Description;
        private string _ResolutionSuggestions;

        public int ResultTypeId
        {
            get { return _ResultTypeId; }
            set { _ResultTypeId = value; }
        }

        public RfsCalculationResultType ResultTypeEnum
        {
            get { return (RfsCalculationResultType)_ResultTypeId; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public string ResolutionSuggestions
        {
            get { return _ResolutionSuggestions; }
            set { _ResolutionSuggestions = value; }
        }
    }
}
