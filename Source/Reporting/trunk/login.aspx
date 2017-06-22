


<html>

<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>Database Editor</title>
<script runat="server" language="C#">
	protected void Click_btnLogin(Object s, EventArgs e)
	{
		if(FormsAuthentication.Authenticate(txtUserName.Text, txtPassword.Text))
			FormsAuthentication.RedirectFromLoginPage(txtUserName.Text, false);
	}
</script>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<body>
<form runat="server">

<table>
<tr>
<td align="right"><b>User name:</b></td>
<td><asp:TextBox style="font-family: monospace;" ID="txtUserName" Runat="server" /></td>
</tr>
<tr>
<td align="right"><b>Password:</b></td>
<td>
<asp:TextBox style="font-family: monospace;" TextMode="Password" ID="txtPassword" Runat="server" /></td>
</tr>
</table>
<asp:Button Text="Log in" OnClick="Click_btnLogin" Runat="server" />

</form>
</body>

</html>