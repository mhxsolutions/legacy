<%@ Page Language="C#" AutoEventWireup="true" Inherits="Monitoring_ShowLocation" Codebehind="ShowLocation.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Show Location Map</title>
</head>
<body onload="InitializeMap(); AddPins();">
    <form id="form1" runat="server">
        <h2>
            <asp:Label ID="TitleLabel" runat="server" Text="Location" />
        </h2>
        <div id='map1' style="position: relative; width: 600px; height: 480px; z-index: 101;" />
    </form>
</body>
</html>
