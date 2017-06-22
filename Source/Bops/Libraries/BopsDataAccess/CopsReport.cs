namespace BopsDataAccess
{
    public class CopsReport
    {
        private int _ReportId;
        private string _Title;
        private string _Url;
        private bool _PubliclyVisible;

        public int ReportId
        {
            get { return _ReportId; }
            set { _ReportId = value; }
        }

        public string Title
        {
            get { return _Title; }
            set { _Title = value; }
        }

        public string Url
        {
            get { return _Url; }
            set { _Url = value; }
        }

        public bool PubliclyVisible
        {
            get { return _PubliclyVisible; }
            set { _PubliclyVisible = value; }
        }
    }
}
