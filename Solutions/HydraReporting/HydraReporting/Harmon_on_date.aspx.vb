Public Class Harmon_on_date
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub

    Protected Sub ASPxButton2_Click(sender As Object, e As EventArgs) Handles ASPxButton2.Click
        GridViewExporter1.WritePdfToResponse()
    End Sub
End Class