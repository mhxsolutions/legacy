using System;
using System.Runtime.InteropServices;

namespace BopsUtilities
{
    [Serializable, StructLayout(LayoutKind.Sequential)]
    public class FormatEnabledKeyValuePair<TKey, TValue>
    {
        public enum FormatType
        {
            Default,    // Like the KeyValuePair class (i.e., [Key, Value])
            KeyOnly,
            ValueOnly
        }

        private TKey _Key;
        private TValue _Value;
        private FormatType _Format;

        public FormatEnabledKeyValuePair(TKey Key, TValue Value)
        {
            _Key = Key;
            _Value = Value;
            _Format = FormatType.Default;
        }

        public FormatEnabledKeyValuePair(TKey Key, TValue Value, FormatType Format)
        {
            _Key = Key;
            _Value = Value;
            _Format = Format;
        }

        private string GetKeyString()
        {
            return _Key != null ? _Key.ToString() : string.Empty;
        }

        private string GetValueString()
        {
            return _Value != null ? _Value.ToString() : string.Empty;
        }

        public override string ToString()
        {
            switch (_Format)
            {
                case FormatType.KeyOnly:
                    return GetKeyString();
                case FormatType.ValueOnly:
                    return GetValueString();
                default:
                    return string.Format("[{0}, {1}]", GetKeyString(), GetValueString());
            }
        }

        public TValue Value
        {
            get { return _Value; }
            set { throw new NotSupportedException(); }
        }

        public TKey Key
        {
            get { return _Key; }
            set { throw new NotSupportedException(); }
        }

        public FormatType Format
        {
            get { return _Format; }
            set { throw new NotSupportedException(); }
        }
    }
}
