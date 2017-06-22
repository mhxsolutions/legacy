<html>
<head>




</head>
<body>
<% 
'=========================================================================
'  File: 	    FPselect.asp, version 1.303
'  Author:      Jim Cheshire, Microsoft
'  Purpose: 	For testing FrontPage ASP pages
'  Disclaimer: 	This code is to be used for testing purposes only.
'=========================================================================

Dim fpDBConns()
Dim iNumConn

'=========================================================================
'  This function reverses slashes on the string passed to it.
'=========================================================================
Function FlipSlash(strPath)
	If InStr(1, strPath, "\") Then
		FlipSlash = Replace(UCase(strPath), "\", "/")
	Else
		FlipSlash = Replace(UCase(strPath), "/", "\")
	End If
End Function


'=========================================================================
'  This function parses the DB connection from the application variable
'  passed to it.  It takes one argument:
'          strConnect = Application variable from global.asa
'=========================================================================
Function ParseConnection(strConnect)
    Dim intConLoc, intConLen
    intConLoc = InStr(1, strConnect, "_ConnectionString"")")
    intConLen = CInt(intConLoc) - 14
    strConnect = Mid(strConnect, 16, intConLen - 2)
	ParseConnection = strConnect
End Function


'=========================================================================
'  This function determines the number of connections in the global.asa
'  by parsing it out of the Dim statement in the global.asa
'=========================================================================
Function GetNumConnections(strDimString)
	Dim strHold, strNew
	strHold = Right(strDimString, 4)
	If Left(strHold, 1) = "(" Then
		strNew = Mid(strHold, 2, 2)
	Else
		strNew = Mid(strHold, 3, 1)
	End If
	GetNumConnections = CInt(strNew)
End Function

'========================================================================
'  This function will populate an array with the connection names in the
'  current application.  It populates the following variables:
'     strGlobal   = Absolute path to the application's global.asa
'     fpDBConns() = An array that stores the name(s) of the connection(s)
'========================================================================
Function GetFPConnections()
	strGlobal = Replace(UCase(Request.ServerVariables("APPL_PHYSICAL_PATH")), "FPSELECT.ASP", "")
	strGlobal = Replace(strGlobal, "/", "\") & "global.asa"
	
	Set objFPFSO = CreateObject("Scripting.FileSystemObject")
	Set objFPFile = objFPFSO.OpenTextFile(strGlobal)
	
	Do While Not objFPFile.AtEndOfStream
		strL = objFPFile.ReadLine
		If InStr(1, UCase(strL), "DIM FRONTPAGE_URLVARS") Then
			iNumConn = GetNumConnections(strL)
			ReDim fpDBConns(iNumConn)
			Exit Do
		End If
	Loop
		
	i = 0
	
	Do While Not objFPFile.AtEndOfStream
		strL = objFPFile.ReadLine
		If Instr(1, UCase(strL), "_CONNECTIONSTRING"")") Then
			fpDBConns(i) = ParseConnection(strL)
			i = i + 1
			If i > iNumConn Then Exit Do
		End If
	Loop
	objFPFile.Close	
End Function

'=========================================================================
'  This function returns TRUE if the current web is an application, and
'  FALSE if it is not an application.
'=========================================================================
Function IsWebApplication()
	strGlobal = Replace(UCase(Request.ServerVariables("APPL_PHYSICAL_PATH")), "FPSELECT.ASP", "")
	strGlobal = Replace(strGlobal, "/", "\") & "global.asa"
	strLocal = Server.MapPath("/") & Replace(UCase(Request.ServerVariables("PATH_INFO")), "FPSELECT.ASP", "")
	strLocal = Replace(strLocal, "/", "\") & "global.asa"
	
	If UCase(strGlobal) <> UCase(strLocal) Then
		IsWebApplication = "False"
	Else
		IsWebApplication = "True"
	End If
End Function


'=========================================================================
'  This function checks to see if there is a global.asa at the app root.
'=========================================================================
Function IsGlobal()
	strGlobal = Request.ServerVariables("APPL_PHYSICAL_PATH") & "global.asa"
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(strGlobal) Then
		IsGlobal = "True"
	Else
		IsGlobal = "False"
	End If
End Function

'=========================================================================
'  Check the value of REQUESTTYPE.  If it's not POST, display the form.
'=========================================================================
If Request("REQUESTTYPE") <> "POST" And IsGlobal = "True" Then
	
	If IsWebApplication = "False" Then
%> 
<table border="2" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" bgcolor="#FF0000">
  <tr>
    <td width="100%">
    <p align="center"><b><font face="Arial" color="#FFFFFF">*** WARNING ***</font><font color="#FFFFFF"><br>
</font>
    <font face="Arial" 
    color="#FFFFFF">The global.asa that was fired is outside of this Web<br>
    or you are running this file from a subdirectory!<br>
    <font size="2">Fpselect.asp should always be run from the root folder of 
    your Web.</font><br>
    <br>
    <font size="2">If you are running FPSelect.asp from the root folder of this 
    Web, </font>
    </font><font face="Arial" size="2" color="#FFFFFF"><br>
    this error indicates that this Web is not marked as an application root.</font></b><p align="left">
    <font face="Arial" size="2" color="#FFFFFF">The global.asa that was fired is 
    located at the following physical location on the Web server:<br>
<%
Response.Write "&nbsp;&nbsp;&nbsp;" & LCase(Request.ServerVariables("APPL_PHYSICAL_PATH") & "global.asa")
%>
</font></td>
  </tr>
</table>
	<% Else	'If IsWebApplication %>
<table border="2" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2" bgcolor="#008000">
  <tr>
    <td width="100%">
    <p align="center"><font face="Arial" color="#FFFFFF"><b>Global.asa 
    successfully fired<br>
    </b><font size="2">The global.asa that was fired is inside of this Web.<br>
    This means that this Web is an application root.</font></font></td>
  </tr>
</table>
<% 		End If 'If IsWebApplication
		GetFPConnections	'Call the function to get all database connections.	
		If fpDBConns(0) = "" Then
	%>
	<table border="2" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" bgcolor="#FF0000">
  <tr>
    <td width="100%">
    <p align="center"><b><font face="Arial" color="#FFFFFF">*** WARNING ***</font><font color="#FFFFFF"><br>
    <font face="Arial">There were no connections found in the global.asa!</font></font></b><p align="left">
    <font face="Arial" size="2" color="#FFFFFF">To create a database connection, 
    use the Database tab in the Web Settings dialog.<br>
&nbsp;</font></td>
  </tr>
</table>
<%		Else	'If fpDBConns %> <script Language="JavaScript" Type="text/javascript"><!--
function fpselect_validate(theForm)
{

  if (theForm.table.value == "")
  {
    alert("Please enter a value for the \"table\" field.");
    theForm.table.focus();
    return (false);
  }
  return (true);
}
//--></script><!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form1_onsubmit()
  Set theForm = document.FrontPage_Form1

  If (theForm.table.value = "") Then
    MsgBox "Please enter a value for the ""table"" field.", 0, "Validation Error"
    theForm.table.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If
  FrontPage_Form1_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form ACTION="fpselect.asp" method="POST" name="FrontPage_Form1">
  <p><b><font face="Arial" color="#0000FF">FrontPage Database Test Page<br>
  <font size="2">Microsoft PSS</font></font></b></p>
  <p><font face="Arial" size="2">1.&nbsp; 
  Select the name of the connection that 
  is defined in FrontPage for your database.<br>
  2.&nbsp; Enter the name of a table in your database.<br>
  3.&nbsp; Enter a username and password only if necessary for your connection.<br>
  4.&nbsp; Click &quot;Execute Query&quot; to query the database.</font></p>
  <table cellpadding="4" cellspacing="0" border="0">
    <tr>
      <td><b><font face="Arial" size="2">You are authenticated as: </font></b>
      </td>
      <td><%
	If Request.ServerVariables("REMOTE_USER") = "" Then
		Response.write "<font face=""arial"" size=""2"">Web not browse-restricted.</font>"
	Else
		Response.write "<font face=""arial"" size=""2"">"
		Response.write Request.ServerVariables("REMOTE_USER")
		Response.write "</font>"
	End If
	
%> </td>
    </tr>
    <tr>
      <td><b><font face="Arial" size="2">FrontPage Connection:</font></b></td>
      <td><font face="Arial">
		 <select size="1" name="connection">
         <option selected><% =fpDBConns(0)%></option>
    <%		For x = 1 to iNumConn - 1  %>
		 <option><% =fpDBConns(x) %></option>
	<%		Next %>
      </select>
      </font>
      </td>
    </tr>
    <tr>
      <td><b><font face="Arial" size="2">Table to Display:</font></b></td>
      <td><font face="Arial">
      <!--webbot bot="Validation" b-value-required="TRUE" --><input NAME="table" size="20">
      <font size="1" color="#FF0000">Required</font></font></td>
    </tr>
    <tr>
      <td><b><font face="Arial" size="2">Username:</font></b></td>
      <td><font face="Arial"><input NAME="username" size="20"></font></td>
    </tr>
    <tr>
      <td><b><font face="Arial" size="2">Password:</font></b></td>
      <td><font face="Arial"><input TYPE="password" NAME="password" size="20"></font></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td align="right"><input TYPE="submit" VALUE="Execute Query"></td>
    </tr>
  </table>
  <input TYPE="HIDDEN" NAME="REQUESTTYPE" VALUE="POST">&nbsp;<hr>
</form>
<%
End If	'If fpDBConns() 
ElseIf IsGlobal = "False" Then
%>
<table border="2" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" bgcolor="#FF0000">
  <tr>
    <td width="100%">
    <p align="center"><b><font face="Arial" color="#FFFFFF">*** WARNING ***<br>
    No global.asa was found in the application root!</font></b><p align="left">
    <font face="Arial" size="2" color="#FFFFFF">The application root is located 
    at the following physical disk path on the server:<br>
<%
Response.Write "&nbsp;&nbsp;&nbsp;" & LCase(Request.ServerVariables("APPL_PHYSICAL_PATH"))
%>
</font><p align="left"><b><font face="Arial" color="#FFFFFF">
    <br>
    <font size="2">To create a global.asa automatically:</font></font></b><ul>
      <li>
    <p align="left"><b><font size="2" face="Arial" color="#FFFFFF">Create a new 
    page in your Web.</font></b></li>
      <li>
    <p align="left"><b><font face="Arial" size="2" color="#FFFFFF">On the Insert 
    menu, point to Database and click Results.</font></b></li>
      <li>
    <p align="left"><b><font face="Arial" size="2" color="#FFFFFF">Choose to use 
    a sample connection.</font></b></li>
      <li>
    <p align="left"><b><font face="Arial" size="2" color="#FFFFFF">Click Next.</font></b></li>
      <li>
    <p align="left"><b><font face="Arial" size="2" color="#FFFFFF">When the next 
    step appears, click Cancel.</font></b></li>
      <li>
    <p align="left"><b><font face="Arial" size="2" color="#FFFFFF">Close the 
    page without saving changes.&nbsp; </font></b></li>
    </ul>
    </td>
  </tr>
</table>

<%

Else	'If REQUESTTYPE

'=========================================================================
'  Code to query the database and return data
'=========================================================================

	Set fpRS = Server.CreateObject("ADODB.Recordset")
	Set fpConn = Server.CreateObject("ADODB.Connection")
	fpConStr = Application(Request("connection") & "_ConnectionString")
	fpUser = Request("username")
	fpPass = Request("password")
	
	fpSQL = "SELECT * FROM " & Request("table")

If fpConStr <> "" Then
	 
		If fpUser = "" Or fpPass = "" Then
			fpConn.Open fpConStr
		Else
			fpConn.Open fpConStr, fpUser, fpPass
		End If
	
		fpRS.ActiveConnection = fpConn
	
		fpRS.Open fpSQL
			
%>	
<p>
<font face="Arial"><b>The following data were returned by your query: <br>
</b>
<font size="1" 
color="#0000FF">
Connection 
String:&nbsp;<% = fpConStr %>
</font><b>
<br><br></b>
</font>
</p>
<table BORDER="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr>
    <% 
'=========================================================================
'  Display data from the database
'=========================================================================
		
	For x = 0 to fpRS.Fields.Count - 1 
%>
    <td><b><% = fpRS(x).Name %></b> </td>
 <% Next %>
  </tr>
<% 
	Do While Not fpRS.EOF 
%>
  <tr>
    <% For x = 0 to fpRS.Fields.Count - 1 %>
    <td VALIGN="TOP"><% = fpRS(x) %> </td>
<% Next %>
  </tr>
  <%
			fpRS.MoveNext
			Loop
			fpRS.Close
			fpConn.Close
			Set fpRS = Nothing
			Set fpConn = Nothing
			%>
</table>

<% Else		'If fpConStr %>
<table border="2" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" bgcolor="#FF0000">
  <tr>
    <td width="100%">
    <p align="center"><b><font face="Arial" color="#FFFFFF">*** WARNING ***<br>
    The 
    global.asa did not fire!<br>
    <font size="2">
    This 
    indicates 
    that 
    this 
    Web 
    is 
    not 
    an 
    application 
    root.</font></font></b></td>
  </tr>
</table>
<% End If 	'If fpConStr 
   End If 	'If REQUESTTYPE %>
</html>
</body>