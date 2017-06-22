
Partial Class GP_sheets
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        exporter1.WriteXlsxToResponse("GPsheets")
    End Sub
End Class
