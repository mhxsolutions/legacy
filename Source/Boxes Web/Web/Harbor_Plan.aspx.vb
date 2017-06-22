
Partial Class Harbor_Plan
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        GridViewExporter1.WriteXlsToResponse()
    End Sub
End Class
