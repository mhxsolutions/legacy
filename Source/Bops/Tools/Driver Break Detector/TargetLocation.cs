using System.Collections.Generic;
using System.Diagnostics;
using System.Xml;

namespace Driver_Break_Detector
{
    public class TargetLocation
    {
        private string _Name;
        private double _Latitude;
        private double _Longitude;
        private double _Distance;

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public double Latitude
        {
            get { return _Latitude; }
            set { _Latitude = value; }
        }

        public double Longitude
        {
            get { return _Longitude; }
            set { _Longitude = value; }
        }

        public double Distance
        {
            get { return _Distance; }
            set { _Distance = value; }
        }

        public TargetLocation(string Name, double Latitude, double Longitude, double Distance)
        {
            _Name = Name;
            _Latitude = Latitude;
            _Longitude = Longitude;
            _Distance = Distance;
        }

        public override string ToString()
        {
            return _Name;
        }

        private static string SafeXmlNodeElementAttributeValue(XmlNode Node, string AttributeName, string NotFoundValue)
        {
            Debug.Assert(Node.NodeType == XmlNodeType.Element);
            XmlElement E = (XmlElement)Node;
            return E.HasAttribute(AttributeName) ? E.GetAttribute(AttributeName) : NotFoundValue;
        }

        public static List<TargetLocation> LoadFromXml(string FileName)
        {
            XmlDocument ConfigurationFile = new XmlDocument();
            ConfigurationFile.Load(FileName);

            XmlNode RootNode = ConfigurationFile["locations"];
            if (RootNode == null)
                return null;

            List<TargetLocation> ReturnValue = new List<TargetLocation>();

            foreach (XmlNode Node in RootNode.ChildNodes)
            {
                if (Node.Name != "location") continue;

                string Name = SafeXmlNodeElementAttributeValue(Node, "name", string.Empty);
                string Latitude = SafeXmlNodeElementAttributeValue(Node, "latitude", string.Empty);
                string Longitude = SafeXmlNodeElementAttributeValue(Node, "longitude", string.Empty);
                string Distance = SafeXmlNodeElementAttributeValue(Node, "distance", string.Empty);

                if (string.IsNullOrEmpty(Name) || string.IsNullOrEmpty(Latitude) || string.IsNullOrEmpty(Longitude) || string.IsNullOrEmpty(Distance))
                    continue;

                TargetLocation NewLocation = new TargetLocation(Name, XmlConvert.ToDouble(Latitude), XmlConvert.ToDouble(Longitude), XmlConvert.ToDouble(Distance));

                ReturnValue.Add(NewLocation);
            }

            return ReturnValue;
        }
    }
}
