<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Authentication_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Budway Accounting Web | Login</title>
    <style type="text/css">
         html, body   { height: 100%; margin: 0; padding: 0; text-align: center; background-color: white; }
         div#centered { border: 0; height: 50%; width: 50%; position: absolute; left: 25%; top: 25%; background-color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultfocus="Login1">
        <div id="centered">
            <asp:Image ID="BopsWebLogo" runat="server" ImageUrl="~/Images/Accounting Web Logo.gif" /><br /><br />
            <asp:Login ID="Login1" runat="server" BackColor="#950000" BorderColor="#000000" BorderPadding="4"
                BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em"
                ForeColor="White">
                <TitleTextStyle BackColor="Maroon" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <TextBoxStyle Font-Size="0.8em" />
                <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px"
                    Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                <ValidatorTextStyle Font-Strikeout="True" ForeColor="Yellow" />
                <FailureTextStyle ForeColor="Yellow" />
            </asp:Login>
        </div>
    </form>
</body>
</html>
