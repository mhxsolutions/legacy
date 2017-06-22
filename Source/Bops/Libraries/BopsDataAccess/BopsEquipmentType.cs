namespace BopsDataAccess
{
    public enum BopsEquipmentTypes
    {
        Zero,
        Tractor,
        Trailer,
        Forklift,
        Lift,
        Auto1,
        None,
        Auto2 = 1957336799,
        Auto3 = 1957336800
    }

    class BopsEquipmentType
    {
        private int _EquipmentTypeId;
        private string _EquipmentType;

        public int EquipmentTypeId
        {
            get { return _EquipmentTypeId; }
            set { _EquipmentTypeId = value; }
        }

        public string EquipmentType
        {
            get { return _EquipmentType; }
            set { _EquipmentType = value; }
        }
    }
}
