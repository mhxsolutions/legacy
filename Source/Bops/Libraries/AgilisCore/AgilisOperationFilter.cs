using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text.RegularExpressions;
using NHibernate;
using NHibernate.Criterion;

namespace AgilisCore
{
    public enum AgilisOperationFilterTypes
    {
        None,
        StringCompare,
        RegularExpression
    }

    public class AgilisOperationFilter
    {
        private int _FilterId;
        private AgilisDataTypes _DataType;
        private string _FilterField;
        private string _FilterRule;
        private AgilisOperationFilterTypes _FilterType;
        private AgilisOperationTypes _FilterScope;
        private bool _ReverseFilter;
        private DateTime _BeginDate;
        private DateTime _EndDate;

        private Regex _RegularExpression;

        public int FilterId
        {
            get { return _FilterId; }
            set { _FilterId = value; }
        }

        public AgilisDataTypes DataType
        {
            get { return _DataType; }
            set { _DataType = value; }
        }

        public string DataTypeString
        {
            get { return _DataType.ToString(); }
            set { _DataType = (AgilisDataTypes)Enum.Parse(typeof(AgilisDataTypes), value); }
        }

        public AgilisOperationFilterTypes FilterType
        {
            get { return _FilterType; }
            set { _FilterType = value; }
        }

        public string FilterTypeString
        {
            get { return _FilterType.ToString(); }
            set { _FilterType = (AgilisOperationFilterTypes) Enum.Parse(typeof (AgilisOperationFilterTypes), value); }
        }

        public AgilisOperationTypes FilterScope
        {
            get { return _FilterScope; }
            set { _FilterScope = value; }
        }

        public string FilterScopeString
        {
            get { return _FilterScope.ToString(); }
            set { _FilterScope = (AgilisOperationTypes)Enum.Parse(typeof(AgilisOperationTypes), value); }
        }

        public string FilterField
        {
            get { return _FilterField; }
            set { _FilterField = value; }
        }

        public string FilterRule
        {
            get { return _FilterRule; }
            set
            {
                _FilterRule = value;

                if (_FilterType == AgilisOperationFilterTypes.RegularExpression)
                    _RegularExpression = new Regex(_FilterRule);
            }
        }

        public DateTime BeginDate
        {
            get { return _BeginDate; }
            set { _BeginDate = value; }
        }

        public DateTime EndDate
        {
            get { return _EndDate; }
            set { _EndDate = value; }
        }

        public bool ReverseFilter
        {
            get { return _ReverseFilter; }
            set { _ReverseFilter = value; }
        }

        public override string ToString()
        {
            string DateDescription;
            if (BeginDate == DateTime.MinValue && EndDate == DateTime.MinValue)
                DateDescription = "always";
            else if (BeginDate == DateTime.MinValue && EndDate != DateTime.MinValue)
                DateDescription = string.Format("until {0}", EndDate.ToString("g"));
            else if (BeginDate != DateTime.MinValue && EndDate == DateTime.MinValue)
                DateDescription = string.Format("after {0}", BeginDate.ToString("g"));
            else
                DateDescription = string.Format("from {0} to {1}", BeginDate.ToString("g"), EndDate.ToString("g"));

            return string.Format("{0} {1} {2} filter field '{3}' rule '{4}', applies {5}",
                _DataType, _FilterType, (_ReverseFilter ? "reverse" : "normal"), _FilterField, _FilterRule, DateDescription);
        }

        private bool MatchStringValue(string Value)
        {
            bool ReturnValue = false;

            switch (_FilterType)
            {
                case AgilisOperationFilterTypes.None:
                    ReturnValue = ReverseFilter;
                    break;
                case AgilisOperationFilterTypes.StringCompare:
                    if (_ReverseFilter)
                        ReturnValue = (Value.CompareTo(_FilterRule) != 0);
                    else
                        ReturnValue = (Value.CompareTo(_FilterRule) == 0);
                    break;
                case AgilisOperationFilterTypes.RegularExpression:
                    Match m = _RegularExpression.Match(Value);
                    ReturnValue = _ReverseFilter ? !m.Success : m.Success;
                    break;
            }

            return ReturnValue;
        }

        public bool MatchFilter(string Field, string Value)
        {
            return (_FilterField.CompareTo(Field) == 0) ? MatchStringValue(Value) : false;
        }

        public bool MatchFilter(Type ObjectType, object o)
        {
            PropertyInfo TargetProperty = ObjectType.GetProperty(_FilterField);

            if (TargetProperty != null)
            {
                string Value = TargetProperty.GetValue(o, null).ToString();
                return MatchStringValue(Value);
            }

            return false;
        }

        static public List<AgilisOperationFilter> GetActiveFilters(ISession Session, DateTime t)
        {
            List<AgilisOperationFilter> ReturnValue = new List<AgilisOperationFilter>();

            IList<AgilisOperationFilter> ImportFilters = Session.CreateCriteria(typeof(AgilisOperationFilter))
                .Add(Expression.Disjunction()
                    .Add(Expression.And(Expression.IsNull("BeginDate"), Expression.IsNull("EndDate")))
                    .Add(Expression.And(Expression.Le("BeginDate", t), Expression.Gt("EndDate", t)))
                )
                .List<AgilisOperationFilter>();

            foreach (AgilisOperationFilter filter in ImportFilters)
            {
                ReturnValue.Add(filter);
            }

            return ReturnValue;
        }
    }
}
