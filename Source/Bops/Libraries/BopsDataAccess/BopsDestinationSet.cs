namespace BopsDataAccess
{
    public class BopsDestinationSet
    {
        private int _Id;
        private string _Name;
        private bool _AllowDelete;

        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public bool AllowDelete
        {
            get { return _AllowDelete; }
            set { _AllowDelete = value; }
        }

        public override string ToString()
        {
            return string.Format("Destination set {0}: {1}{2}", _Id, _Name, _AllowDelete ? string.Empty : " (no delete)");
        }
    }
}
