
Partial Class Tons_Handled_by_month
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        Exporter1.WriteXlsxToResponse()
    End Sub
End Class
