<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Web.Authentication.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UPA | Login</title>
    <style type="text/css">
         html, body   { height: 100%; margin: 0; padding: 0; text-align: center; background-color: white; }
         div#centered { border: 0; height: 50%; width: 50%; position: absolute; left: 25%; top: 25%; background-color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultfocus="Login1">
    
        <div id="centered" align="center">
            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/Images/UPA-Website-Header-small.jpg" AlternateText="Logo" />
            <p></p>
            
            <asp:Login ID="_HydraLogin" runat="server" BackColor="#EEEEEE" BorderColor="#888888" BorderPadding="4"
                BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" DisplayRememberMe="false"
                ForeColor="#333333" DestinationPageUrl="~/Default.aspx" OnLoggedIn="_HydraLogin_LoggedIn">
                <TitleTextStyle BackColor="#1B74BB" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <TextBoxStyle Font-Size="0.8em" />
                <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px"
                    Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
            </asp:Login>
            <br />
            <p style="text-align: center">
                            <a href="../ForgetPassword.aspx" >Forget Password?</a><br /><br />
            </p>
            
            <p>
                If you are a UPA client and would like access to our system or you are experiencing technical issues please click here to email support:
                <a href="mailto:psepsupport@utilitypartners.com">psepsupport@utilitypartners.com</a>

            </p>
        </div>
        
    </form>
</body>
</html>
