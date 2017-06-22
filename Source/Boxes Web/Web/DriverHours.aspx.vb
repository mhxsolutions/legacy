
Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.Web

Partial Class DriverHours
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub


    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("PrimID") = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue()
    End Sub

    Protected Sub ASPxButton2_Click(sender As Object, e As EventArgs) Handles ASPxButton2.Click
        ASPxGridView1.ExpandAll()
    End Sub
End Class
