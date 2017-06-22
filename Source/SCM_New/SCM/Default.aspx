<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="SCM._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SCM: Login</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
    <style>
        /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
        @import url(http://fonts.googleapis.com/css?family=Exo:100,200,400);
        @import url(http://fonts.googleapis.com/css?family=Source+Sans+Pro:700,400,300);

        body {
            margin: 0;
            padding: 0;
            background: #fff;
            color: #fff;
            font-family: Arial;
            font-size: 12px;
        }

        .body {
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
            width: auto;
            height: auto;
            background-image: url(Content/Images/BackImg.jpg);
            background-size: cover;
            -webkit-filter: blur(5px);
            z-index: -1;
        }

        .logoContent {
            height: auto;
            margin: 0px auto;
            max-width: 300px;
            z-index: 9;
        }

        img.responsiveImg {
            max-width: 100%;
            height: auto;
            z-index: 99;
        }

        .grad {
            position: absolute;
            top: -20px;
            left: -20px;
            right: -40px;
            bottom: -40px;
            width: auto;
            height: auto;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(0,0,0,0)), color-stop(100%,rgba(0,0,0,0.65))); /* Chrome,Safari4+ */
            z-index: 1;
            opacity: 0.7;
        }

        .header {
            position: absolute;
            top: calc(50% - 35px);
            left: calc(50% - 255px);
            z-index: 2;
        }

            .header div {
                float: left;
                color: #fff;
                font-family: 'Exo', sans-serif;
                font-size: 35px;
                font-weight: 200;
            }

                .header div span {
                    color: #5379fa !important;
                }

        .info {
            font-size: 12px;
            text-shadow: 1px 1px #666666;
            width: 265px;
            z-index: 2;
        }

        .login {
            position: absolute;
            top: calc(25% - 25px);
            left: calc(50% - 135px);
            height: 150px;
            width: 270px;
            padding: 10px;
            z-index: 2;
        }

            .login input[type=text] {
                width: 250px;
                height: 30px;
                background: transparent;
                border: 1px solid rgba(255,255,255,0.6);
                border-radius: 2px;
                color: #fff;
                font-family: 'Exo', sans-serif;
                font-size: 16px;
                font-weight: 400;
                padding: 4px;
            }

            .login input[type=password] {
                width: 250px;
                height: 30px;
                background: transparent;
                border: 1px solid rgba(255,255,255,0.6);
                border-radius: 2px;
                color: #fff;
                font-family: 'Exo', sans-serif;
                font-size: 16px;
                font-weight: 400;
                padding: 4px;
                margin-top: 10px;
            }

            .login input[type=submit] {
                width: 260px;
                height: 35px;
                background: #fff;
                border: 1px solid #fff;
                cursor: pointer;
                border-radius: 2px;
                color: #666666;
                font-family: 'Exo', sans-serif;
                font-size: 16px;
                font-weight: 400;
                padding: 6px;
                margin-top: 10px;
            }

                .login input[type=submit]:hover {
                    opacity: 0.8;
                }

                .login input[type=submit]:active {
                    opacity: 0.6;
                }

            .login input[type=text]:focus {
                outline: none;
                border: 1px solid rgba(255,255,255,0.9);
            }

            .login input[type=password]:focus {
                outline: none;
                border: 1px solid rgba(255,255,255,0.9);
            }

            .login input[type=submit]:focus {
                outline: none;
            }

        ::-webkit-input-placeholder {
            color: rgba(255,255,255,0.6);
        }

        ::-moz-input-placeholder {
            color: rgba(255,255,255,0.6);
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="body"></div>
        <div class="logoContent">
            <img src="Content/Images/ScmLogoTrans.png" alt="SCM - Supply Chain Management" class="responsiveImg" />
        </div>
        <%--<div class="header">
            <div>SCM<span>Supply Chain Management</span></div>
        </div>--%>
        <br />
        <%--        <div class="login">
            <input type="text" placeholder="username" name="user" /><br />
            <input type="password" placeholder="password" name="password" /><br />
            <input type="button" value="Login" />
        </div>--%>

        <asp:Login ID="SCMLogin" runat="server" DisplayRememberMe="false" DestinationPageUrl="~/All/Default.aspx" OnLoggedIn="SCMLogin_LoggedIn">
            <LayoutTemplate>
                <div class="login">
                    <asp:TextBox runat="server" ID="UserName" placeholder="username"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ID="UserNameRequired">*</asp:RequiredFieldValidator><br />

                    <asp:TextBox runat="server" TextMode="Password" ID="Password" placeholder="password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ID="PasswordRequired">*</asp:RequiredFieldValidator><br />
                    <asp:Button runat="server" type="button" CommandName="Login" Text="Login" ID="LoginButton"></asp:Button>
                    <%--<input type="button" value="Login" runat="server" id="LoginButton" CommandName="Login" />--%>

                    <%--<input type="text" placeholder="username" name="user" />
                    <input type="password" placeholder="password" name="password" /><br />
                    <input type="button" value="Login" />--%>

                    <div class="info">
                        <br />
                        <p style="text-align: center; color: #000000; background-color: #FFFFFF">
                            <a href="mailto:info@sc-man.com">Contact Us</a> for access or support</p>
                    </div>
                </div>
            </LayoutTemplate>
        </asp:Login>


    </form>
</body>
</html>
