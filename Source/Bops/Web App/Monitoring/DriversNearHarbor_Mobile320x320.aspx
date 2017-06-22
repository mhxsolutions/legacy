<%@ Page Language="C#" AutoEventWireup="true" Inherits="Monitoring_DriversNearHarbor_Mobile320x320" Codebehind="DriversNearHarbor_Mobile320x320.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BOPS | Monitoring | Drivers Near Harbor (Mobile)</title>
    <meta http-equiv="refresh" content="120">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.1"></script>
</head>
<body onload="InitializeMap(); AddPins();">
    <form id="form1" runat="server">
        <div style="z-index: 103; left: 0px; width: 195px; position: absolute; top: 0px; height: 25px">
            <u>Drivers Near Harbor</u>
        </div>
        <div id='map1' style="position: relative; width: 320px; height: 320px; z-index: 101; left: 0px; top: 26px;"></div>
    </form>
</body>
</html>
