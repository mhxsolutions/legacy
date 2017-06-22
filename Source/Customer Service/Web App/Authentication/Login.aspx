<%@ Page Language="C#" AutoEventWireup="true" Inherits="Authentication_Login" Codebehind="Login.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Inventory | Login</title>
    <style type="text/css">
         html, body   { height: 100%; margin: 0; padding: 0; text-align: center; background-color: white; }
         div#centered { border: 0; height: 50%; width: 50%; position: absolute; left: 25%; top: 25%; background-color: white; }
        .style1
        {
            width: 1272px;
            height: 100px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultfocus="Login1">
        <div id="centered" align="center">
            <br /><br />
            <asp:Login ID="Login1" runat="server" BackColor="#EEEEEE" BorderColor="#888888" BorderPadding="4"
                BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" DisplayRememberMe="false"
                ForeColor="#333333" OnLoggedIn="Login1_OnLoggedIn" DestinationPageUrl="~/Customers/_All/PlannedDeliveriesToday.aspx">
                <TitleTextStyle BackColor="#660000" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <TextBoxStyle Font-Size="0.8em" />
                <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px"
                    Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
            </asp:Login>
            <br />
<%--
            <a href="PasswordReminder.aspx">Click Here if You Can't Remember Your Password and Need It Reset</a><br />
            <a href="CreateAccount.aspx">Or Click Here to Create an Account</a>
--%>        If you would like access to our BudwayDirect tools,
            <br />
            or if you are experiencing technical problems with an existing account,<br />
            please click <a href="mailto:jorge@sc-man.com?subject=Budway Direct Issue">here</a> to email Jorge Sandoval.<br />
            <br />
            SC Data Solutions: 909.641.5461</div>
    </form>
    <p>
        <img alt="Budway Direct Logo" class="style1" 
            src="../Images/budway_header_for_web_apps.png" /></p>
</body>
</html>
