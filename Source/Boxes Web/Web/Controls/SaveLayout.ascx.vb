Imports DevExpress.Web
Imports System.Collections.Generic
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.ApplicationBlocks.Data
Imports System
Imports System.Web

Partial Class Controls_SaveLayout
    Inherits System.Web.UI.UserControl


    Private _GridViewID As String
    Public Property GridViewID() As String
        Get
            Return _GridViewID
        End Get
        Set(ByVal value As String)
            _GridViewID = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindSettingNames()
        End If
    End Sub

    Protected Sub btnLoadLayout_Click(sender As Object, e As EventArgs)
        Dim grid As ASPxGridView = GetGridView()
        If grid IsNot Nothing Then
            grid.LoadClientLayout(GetUserGridSettings(grid.ID, cmbLayout.Text))
        End If
    End Sub
    Protected Sub btnSaveLayout_Click(sender As Object, e As EventArgs)
        Dim grid As ASPxGridView = GetGridView()
        If grid IsNot Nothing Then
            SaveUserGridSettings(grid.ID, cmbLayout.Text, grid.SaveClientLayout())
            BindSettingNames()
        End If
    End Sub
    Private Sub BindSettingNames()
        Dim grid As ASPxGridView = GetGridView()
        If grid IsNot Nothing Then
            Dim ds As DataSet = GetUserGridSettingNames(grid.ID)
            If ds IsNot Nothing Then
                cmbLayout.DataSource = ds
                cmbLayout.TextField = "SettingName"
                cmbLayout.ValueField = cmbLayout.TextField
                cmbLayout.DataBind()
            End If
        End If
    End Sub
    Private Function GetGridView() As ASPxGridView
        Return DirectCast(Me.Parent.FindControl(GridViewID), ASPxGridView)
    End Function

    Private Function GetUserName() As String
        Dim str As String
        Dim strArr() As String
        str = System.Security.Principal.WindowsIdentity.GetCurrent().Name
        If str.Contains("\") Then
            strArr = str.Split("\")
            Return If(strArr.Length > 1, strArr(1), str)

        End If
        Return str



    End Function
    Private Function GetUserGridSettingNames(gridName As String) As DataSet
        Dim ds As New DataSet()

        Try
            Dim page As String = HttpContext.Current.Request.Url.LocalPath

            Dim sql As String = String.Format("SELECT SettingName FROM UserGridSetting " & vbCr & vbLf & "                            WHERE ApplicationName = '{0}' AND UserName = '{1}' AND Page = '{2}' AND GridName = '{3}'", "Boxes", GetUserName(), page, gridName)

            Dim connectionString As String = ConfigurationManager.ConnectionStrings("DWS No Rep DataConnectionString").ConnectionString

            ds = SqlHelper.ExecuteDataset(connectionString, System.Data.CommandType.Text, sql)
        Catch ex As Exception
        End Try
        Return ds
    End Function

    Private Function GetUserGridSettings(gridName As String, settingName As String) As String
        Dim setting As String = String.Empty


        Try
            Dim page As String = HttpContext.Current.Request.Url.LocalPath

            Dim sql As String = String.Format("SELECT Setting FROM UserGridSetting " & vbCr & vbLf & "                            WHERE ApplicationName = '{0}' AND UserName = '{1}' AND Page = '{2}' AND GridName = '{3}' AND SettingName = '{4}'", "Boxes", GetUserName(), page, gridName, settingName)

            Dim connectionString As String = ConfigurationManager.ConnectionStrings("DWS No Rep DataConnectionString").ConnectionString

            setting = Convert.ToString(SqlHelper.ExecuteScalar(connectionString, System.Data.CommandType.Text, sql))
        Catch ex As Exception
        End Try

        Return setting
    End Function



    Private Sub SaveUserGridSettings(gridName As String, settingName As String, setting As String)
        Try
            Dim page As String = HttpContext.Current.Request.Url.LocalPath

            Dim sql As String = "IF NOT EXISTS(SELECT 1 FROM UserGridSetting " & vbCr & vbLf & "                                WHERE ApplicationName = @ApplicationName AND UserName = @UserName AND Page = @Page AND GridName = @GridName AND SettingName = @SettingName)" & vbCr & vbLf & vbCr & vbLf & "                                INSERT INTO UserGridSetting " & vbCr & vbLf & "                                (ApplicationName, UserName, Page, GridName, SettingName, Setting)" & vbCr & vbLf & "                                VALUES" & vbCr & vbLf & "                                (@ApplicationName, @UserName, @Page, @GridName, @SettingName, @Setting)" & vbCr & vbLf & vbCr & vbLf & "                                ELSE" & vbCr & vbLf & vbCr & vbLf & "                                UPDATE UserGridSetting SET" & vbCr & vbLf & "                                Setting = @Setting" & vbCr & vbLf & "                                WHERE ApplicationName = @ApplicationName AND UserName = @UserName AND Page = @Page AND GridName = @GridName AND SettingName = @SettingName"

            Dim sqlParams As New List(Of SqlParameter)()
            sqlParams.Add(New SqlParameter("@ApplicationName", "Boxes"))
            sqlParams.Add(New SqlParameter("@UserName", GetUserName()))
            sqlParams.Add(New SqlParameter("@Page", page))
            sqlParams.Add(New SqlParameter("@GridName", gridName))
            sqlParams.Add(New SqlParameter("@SettingName", settingName))
            sqlParams.Add(New SqlParameter("@Setting", setting))


            Dim connectionString As String = ConfigurationManager.ConnectionStrings("DWS No Rep DataConnectionString").ConnectionString

            Dim recordsEffected As Integer = SqlHelper.ExecuteNonQuery(connectionString, System.Data.CommandType.Text, sql, sqlParams.ToArray())

        Catch ex As Exception
        End Try
    End Sub

End Class
