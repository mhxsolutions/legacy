using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class All_Distance : System.Web.UI.Page
{
    private const string API_KEY = "AIzaSyARwYxqSLTcxbK8Wnpm9JcVccEbtpZ_czI";
    private const string API_URL = "https://maps.googleapis.com/maps/api/distancematrix/";

    protected void Page_Load(object sender, EventArgs e)
    {
        litMessage.Text = string.Empty;
    }

    protected void btnGetDistance_Click(object sender, EventArgs e)
    {
        ClearResult();
        try
        {
            GoogleDistance distance = GetDistanceFromAPI(txtFrom.Text.Trim(), txtTo.Text.Trim());
            if (distance != null)
            {
                if (distance.status == "OK")
                {
                    ShowData(distance);
                }
                else
                {
                    litMessage.Text = distance.status;
                }
            }
        }
        catch (Exception ex)
        {
            litMessage.Text = ex.Message;
        }
    }

    private GoogleDistance GetDistanceFromAPI(string source, string destination)
    {
        string url = string.Format("{0}json?units=imperial&origins={1}&destinations={2}&key={3}", API_URL, HttpUtility.UrlEncode(source), HttpUtility.UrlEncode(destination), API_KEY);
        string responseString = GetResponseFromServer(url);
        GoogleDistance returnValue = new JavaScriptSerializer().Deserialize<GoogleDistance>(responseString);
        return returnValue;
    }


    private string GetResponseFromServer(string url)
    {
        string responseFromServer = string.Empty;
        try
        {
            // Create a request for the URL. 		
            WebRequest request = WebRequest.Create(url);
            // If required by the server, set the credentials.
            request.Credentials = CredentialCache.DefaultCredentials;
            // Get the response.
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            // Display the status.
            Console.WriteLine(response.StatusDescription);
            // Get the stream containing content returned by the server.
            Stream dataStream = response.GetResponseStream();
            // Open the stream using a StreamReader for easy access.
            StreamReader reader = new StreamReader(dataStream);
            // Read the content.
            responseFromServer = reader.ReadToEnd();
            // Display the content.
            Console.WriteLine(responseFromServer);
            // Cleanup the streams and the response.
            reader.Close();
            dataStream.Close();
            response.Close();
        }
        catch (Exception ex)
        {

        }

        return responseFromServer;
    }

    private void ClearResult()
    {
        litSource.Text = string.Empty;
        litDestination.Text = string.Empty;
    }

    private void ShowData(GoogleDistance distance)
    {
        ClearResult();
        litSource.Text = distance.origin_addresses.FirstOrDefault();
        litDestination.Text = distance.destination_addresses.FirstOrDefault();


        if (distance.rows != null && distance.rows.Count > 0 && distance.rows[0].elements != null && distance.rows[0].elements.Count > 0)
        {
            rptrRoutes.DataSource = distance.rows[0].elements;
            rptrRoutes.DataBind();


            //if (distance.rows[0].elements.Count > 0)
            //{
            //    Element element = distance.rows[0].elements.OrderBy(d => d.duration.value).FirstOrDefault();
            //    litDistance.Text = element.distance.text;
            //    litTime.Text = element.duration.text;

            //}
        }
    }


    private void ReadSourceAndDestination()
    {
        string content = ReadExcelFile();
        if (content.Contains('\n'))
        {
            string[] lines = content.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            if (lines.Length > 1)
            {
                List<GoogleDistance> distanceList = new List<GoogleDistance>();
                for (int i = 1; i < lines.Length; i++)
                {
                    string[] columns = lines[i].Split(new string[] { "\t" }, StringSplitOptions.RemoveEmptyEntries);

                    string source = GetStr(columns[2]) + GetStr(columns[3]) + GetStr(columns[4]) + GetStr(columns[5]) + GetStr(columns[6]);
                    string destination = GetStr(columns[8]) + GetStr(columns[9]) + GetStr(columns[10]) + GetStr(columns[11]) + GetStr(columns[12]);

                    GoogleDistance distance = GetDistanceFromAPI(source.Trim(), destination.Trim());
                    distanceList.Add(distance);
                }

                BindRepeater(distanceList);
            }
        }

    }

    private string ReadExcelFile()
    {
        string content = string.Empty;
        string path = Server.MapPath("~") + @"/App_Data/Destinations.txt";
        using (TextReader reader = new StreamReader(path))
        {
            content = reader.ReadToEnd();
        }
        return content;
    }

    private string GetStr(string value)
    {
        return string.IsNullOrWhiteSpace(value) ? " " : value.ToUpper().Equals("NULL") ? " " : value.Trim() + " ";
    }

    private void BindRepeater(List<GoogleDistance> resultList)
    {
        List<DistanceToShow> distanceToShowList = new List<DistanceToShow>();
        foreach (var distance in resultList)
        {
            DistanceToShow toShow = new DistanceToShow();
            if (distance != null)
            {
                toShow.Response = distance.status;
                toShow.Source = distance.origin_addresses.FirstOrDefault();
                toShow.Destination = distance.destination_addresses.FirstOrDefault();
                toShow.Distance = distance.rows != null ? (distance.rows.FirstOrDefault() != null ? (distance.rows.FirstOrDefault().elements != null ? distance.rows.FirstOrDefault().elements.FirstOrDefault().distance.text : "") : "") : "";
                toShow.Time = distance.rows != null ? (distance.rows.FirstOrDefault() != null ? (distance.rows.FirstOrDefault().elements != null ? distance.rows.FirstOrDefault().elements.FirstOrDefault().duration.text : "") : "") : "";
                toShow.Result = distance.rows != null ? (distance.rows.FirstOrDefault() != null ? (distance.rows.FirstOrDefault().elements != null ? distance.rows.FirstOrDefault().elements.FirstOrDefault().status : "") : "") : "";
                distanceToShowList.Add(toShow);
            }
        }

        Repeater2.DataSource = distanceToShowList;
        Repeater2.DataBind();
    }

    protected void btnShowList_Click(object sender, EventArgs e)
    {
        ReadSourceAndDestination();
    }



}