using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Xml;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using NHibernateUtilities;

namespace CopsUtilities
{
    public class CopsSiteMapProvider : StaticSiteMapProvider
    {
        private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";
        private const String SiteMapNodeName = "siteMapNode";

        private String _siteMapFileName;
        private SiteMapNode _rootNode = null;

        private static string _WebApplicationRootDirectory;

        public static void SetWebApplicationRootDirectory(string WebRoot)
        {
            _WebApplicationRootDirectory = WebRoot;
        }

        public override SiteMapNode RootNode
        {
            get { return BuildSiteMap(); }
        }

        public override void Initialize(string name, NameValueCollection attributes)
        {
            base.Initialize(name, attributes);
            _siteMapFileName = attributes["siteMapFile"];
        }

        protected override void Clear()
        {
            lock (this)
            {
                _rootNode = null;
                base.Clear();
            }
        }

        private XmlDocument LoadSiteMapXml()
        {
            XmlDocument siteMapXml = new XmlDocument();
            siteMapXml.Load(AppDomain.CurrentDomain.BaseDirectory + _siteMapFileName);
            return siteMapXml;
        }

        private static XmlElement AddDynamicChildElement(XmlElement Parent, String Url, String Title, String Description)
        {
            // Create new element from the parameters
            XmlElement NewChild = Parent.OwnerDocument.CreateElement(SiteMapNodeName);
            NewChild.SetAttribute("url", Url);
            NewChild.SetAttribute("title", Title);
            NewChild.SetAttribute("description", Description);
            NewChild.SetAttribute("roles", "*");

            // Add it to the parent
            Parent.AppendChild(NewChild);

            return NewChild;
        }

        private string GetConfigurationFilePath()
        {
            return Path.Combine(_WebApplicationRootDirectory, _DwsNoRepData);
        }

        private void AddDynamicNodes(XmlElement rootElement)
        {
            // Add the user reports.

            XmlElement ReportsNode = AddDynamicChildElement(rootElement, "", "Reports", "");

            SessionManager<string> Mgr = new SessionManager<string>();
            ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, GetConfigurationFilePath());
            IList<CopsReport> ReportList = DwsNoRepData.CreateCriteria(typeof(CopsReport))
                .Add(Expression.Eq("PubliclyVisible", true))
                .List<CopsReport>();
            Mgr.RemoveAllSessions(false);

            foreach (CopsReport Report in ReportList)
            {
                if (Report.PubliclyVisible)
                    AddDynamicChildElement(ReportsNode, Report.Url, Report.Title, "");
            }
        }

        private void GenerateSiteMapNodes(XmlElement rootElement)
        {
            _rootNode = GetSiteMapNodeFromElement(rootElement);
            AddNode(_rootNode);
            CreateChildNodes(rootElement, _rootNode);
        }

        private void CreateChildNodes(XmlElement parentElement, SiteMapNode parentNode)
        {
            foreach (XmlNode xmlElement in parentElement.ChildNodes)
            {
                if (xmlElement.Name == SiteMapNodeName)
                {
                    SiteMapNode childNode = GetSiteMapNodeFromElement((XmlElement)xmlElement);
                    AddNode(childNode, parentNode);
                    CreateChildNodes((XmlElement)xmlElement, childNode);
                }
            }
        }

        private SiteMapNode GetSiteMapNodeFromElement(XmlElement rootElement)
        {
            SiteMapNode newSiteMapNode;
            String url = rootElement.GetAttribute("url");
            String title = rootElement.GetAttribute("title");
            String description = rootElement.GetAttribute("description");

            // The key needs to be unique, so hash the url and title.
            newSiteMapNode = new SiteMapNode(this, (url + title).GetHashCode().ToString(), url, title, description);

            return newSiteMapNode;
        }
        
        ///<summary>
        ///When overridden in a derived class, loads the site map information from persistent storage and builds it in memory.
        ///</summary>
        ///
        ///<returns>
        ///The root <see cref="T:System.Web.SiteMapNode"></see> of the site map navigation structure.
        ///</returns>
        ///
        public override SiteMapNode BuildSiteMap()
        {
            lock (this)
            {
                if (null == _rootNode)
                {
                    Clear();

                    // Load the sitemap's xml from the file.
                    XmlDocument siteMapXml = LoadSiteMapXml();

                    // Create the first site map item from the top node in the xml.
                    XmlElement rootElement = (XmlElement)siteMapXml.GetElementsByTagName(SiteMapNodeName)[0];

                    // This is the key method - add the dynamic nodes to the xml
                    AddDynamicNodes(rootElement);

                    // Now build up the site map structure from the xml
                    GenerateSiteMapNodes(rootElement);
                }
            }

            return _rootNode;
        }

        ///<summary>
        ///When overidden in a derived class, retrieves the root node of all the nodes that are currently managed by the current provider. 
        ///</summary>
        ///
        ///<returns>
        ///A <see cref="T:System.Web.SiteMapNode"></see> that represents the root node of the set of nodes that the current provider manages. 
        ///</returns>
        ///
        protected override SiteMapNode GetRootNodeCore()
        {
            return null;
        }
    }
}
