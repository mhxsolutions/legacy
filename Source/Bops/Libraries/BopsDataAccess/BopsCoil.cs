using System;

namespace BopsDataAccess
{
    [Serializable]
    public class BopsCoil
    {
        private string _LoadReference;
        private string _Coil;
        private string _Location;
        private double _Weight;
        private bool _Staged;
        private bool _Loaded;
        private int _StageQuad;
        private bool _Lost;
        private DateTime? _StageTime;
        private DateTime? _LoadTime;

        public string LoadReference
        {
            get { return _LoadReference; }
            set { _LoadReference = value; }
        }

        public string Coil
        {
            get { return _Coil; }
            set { _Coil = value; }
        }

        public string Location
        {
            get { return _Location; }
            set { _Location = value; }
        }

        public double Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public bool Staged
        {
            get { return _Staged; }
            set { _Staged = value; }
        }

        public bool Loaded
        {
            get { return _Loaded; }
            set { _Loaded = value; }
        }

        public int StageQuad
        {
            get { return _StageQuad; }
            set { _StageQuad = value; }
        }

        public bool Lost
        {
            get { return _Lost; }
            set { _Lost = value; }
        }

        public DateTime? StageTime
        {
            get { return _StageTime; }
            set { _StageTime = value; }
        }

        public DateTime? LoadTime
        {
            get { return _LoadTime; }
            set { _LoadTime = value; }
        }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
                return false;

            BopsCoil that = obj as BopsCoil;
            return _Coil == that._Coil && _LoadReference == that._LoadReference;
        }

        public override int GetHashCode()
        {
            string Key = _LoadReference + _Coil;
            return Key.GetHashCode();
        }
    }
}
