using System;
using System.Collections.Generic;

namespace BopsDataAccess
{
    public class HopsDrEntry
    {
        public const double MaximumWeight = 60000;

        private int _DrId;
        private int? _ProjectManagerBolRef;
        private int? _Count;
        private double? _Weight;
        private DateTime _LastUpdateTime;
        private bool _Finalized;
        private string _GatePass;
        private string _LoadRef;
        private string _Tractor;

        public int DrId
        {
            get { return _DrId; }
            set { _DrId = value; }
        }

        public int? ProjectManagerBolRef
        {
            get { return _ProjectManagerBolRef; }
            set { _ProjectManagerBolRef = value; }
        }

        public int? Count
        {
            get { return _Count; }
            set { _Count = value; }
        }

        public double? Weight
        {
            get { return _Weight; }
            set 
            {
                if (value == null)
                {
                    _Weight = null;
                }
                else
                {
                    if (0 <= value && value < MaximumWeight)
                        _Weight = value;
                    else
                        throw new ArgumentOutOfRangeException("value", string.Format("Weight must be from zero to {0} pounds", MaximumWeight));
                }
            }
        }

        public DateTime LastUpdateTime
        {
            get { return _LastUpdateTime; }
            set { _LastUpdateTime = value; }
        }

        public bool Finalized
        {
            get { return _Finalized; }
            set { _Finalized = value; }
        }

        public string GatePass
        {
            get { return _GatePass; }
            set { _GatePass = value; }
        }

        public string LoadRef
        {
            get { return _LoadRef; }
            set { _LoadRef = value; }
        }

        public string Tractor
        {
            get { return _Tractor; }
            set { _Tractor = value; }
        }

        public HopsDrEntry()
        {
        }

        ///<summary>
        ///Returns a <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        ///</summary>
        ///
        ///<returns>
        ///A <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        ///</returns>
        ///<filterpriority>2</filterpriority>
        public override string ToString()
        {
            return
                string.Format("DrId = {0}, BlId = {1}, Count = {2}, LastUpdate = {3}, Finalized = {4}, GatePass = {5}, LoadRef = {6}, Tractor = {7}",
                    _DrId, _ProjectManagerBolRef, _Count, _LastUpdateTime, _Finalized, _GatePass, _LoadRef, _Tractor);
        }
    }
}
