using System;
using System.Web.UI;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;

public partial class GetDrivers : Page
{
    private string MakeRestUrl(string CompanyId, string Function, string UserName, string Password)
    {
        string BaseUrl = "http://ibis.agilissystems.com/ibis/rest";
        return string.Format("{0}/{1}/{2}?user_name={3}&password={4}", BaseUrl, CompanyId, Function, UserName, Password);
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string GetDriversUrl = MakeRestUrl("8231", "drivers/list", "jwilliston", "irronarr");

        Uri uri = new Uri(GetDriversUrl);
        System.Net.WebRequest webRequest = System.Net.HttpWebRequest.Create(uri);

        using (System.Net.WebResponse webResponse = webRequest.GetResponse())
        {
            using (System.IO.Stream stream = webResponse.GetResponseStream())
            {
                XmlTextReader DriversReader = new System.Xml.XmlTextReader(stream);

                XPathDocument XpDoc = new XPathDocument(DriversReader);
                XsltArgumentList XsltArgs = new XsltArgumentList();
                string backGroundColor = "Tan";
                XsltArgs.AddParam("BackGroundColor", "", backGroundColor);
                string XslPath = Server.MapPath("~/GetDrivers.xsl");
                XslCompiledTransform Xslt = new XslCompiledTransform();
                Xslt.Load(XslPath);
                Xslt.Transform(XpDoc, XsltArgs, Response.Output);

                stream.Close();
            }
            webResponse.Close();
        }
    }
}
