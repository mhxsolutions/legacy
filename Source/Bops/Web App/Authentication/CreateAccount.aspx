<%@ Page Language="C#" AutoEventWireup="true" Inherits="Authentication_CreateAccount" Codebehind="CreateAccount.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Budway Operations Software</title>
    <style type="text/css">
         html, body   { height: 100%; margin: 0; padding: 0; text-align: center; background-color: white; }
         div#centered { border: 0; height: 50%; width: 50%; position: absolute; left: 25%; top: 25%; background-color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server" DefaultFocus="CreateUserWizard1">
        <div id="centered">
            <asp:Image ID="BopsWebLogo" runat="server" ImageUrl="~/Images/Bops Web Logo.gif" /><br />
            <br />
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE"
                BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ContinueDestinationPageUrl="~/Default.aspx" OnCreatedUser="CreateUserWizard1_CreatedUser">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                    </asp:CompleteWizardStep>
                </WizardSteps>
                <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
                <TitleTextStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
                <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
                    Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
                <CreateUserButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <ContinueButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <StepStyle Font-Size="0.8em" />
            </asp:CreateUserWizard>
            <br />
            <a href="Login.aspx">Or Click Here to Login</a>
        </div>
    </form>
</body>
</html>
