<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Authentication_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Tubular Transport | Login</title>
    <style type="text/css">
         html, body   { height: 100%; margin: 0; padding: 0; text-align: center; background-color: white; }
         div#centered { border: 0; height: 50%; width: 50%; position: absolute; left: 25%; top: 25%; background-color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultfocus="Login1">
    
        <div id="centered" align="center">
            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/Images/TTL-Website-Header-small.jpg" AlternateText="Logo" />
            <p></p>
            
            <asp:Login ID="_TubularTransportLogin" runat="server" BackColor="#EEEEEE" BorderColor="#888888" BorderPadding="4"
                BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" DisplayRememberMe="false"
                ForeColor="#333333" DestinationPageUrl="~/Default.aspx" OnLoggedIn="_TubularTransportLogin_LoggedIn">
                <TitleTextStyle BackColor="#660000" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <TextBoxStyle Font-Size="0.8em" />
                <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px"
                    Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
            </asp:Login>
            <br />
            
            If you are a 
            TTL client and would like access to our Tubular Transport tools,
            <br />
            please click <a href="mailto:shelly@sc.man.com?subject=New TTL Account">here</a> to email Shelly Anthony.<br />
            <br />
            If you are experiencing technical problems with an existing account,<br />
            please click <a href="mailto:jorge@sc-man.com?subject=TTL web Issue">here</a> to email Jorge Sandoval.<br />
            <br />
            Tubular Transport: 562.280.7185</div>
        
    </form>
</body>
</html>
