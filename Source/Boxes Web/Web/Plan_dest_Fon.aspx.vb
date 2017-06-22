
Partial Class Plan_dest_Fon
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub

    Protected Sub Button2_Click(sender As Object, e As System.EventArgs) Handles Button2.Click
        GridViewExporter1.WritePdfToResponse()
    End Sub
End Class
