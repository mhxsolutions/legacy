namespace BopsDataAccess
{
    public class BopsEquipment
    {
        private int _EquipmentId;
        private int _EquipmentIdentifier;
        private int _EquipmentType;

        public int EquipmentId
        {
            get { return _EquipmentId; }
            set { _EquipmentId = value; }
        }

        public int EquipmentIdentifier
        {
            get { return _EquipmentIdentifier; }
            set { _EquipmentIdentifier = value; }
        }

        public int EquipmentType
        {
            get { return _EquipmentType; }
            set { _EquipmentType = value; }
        }
    }
}
