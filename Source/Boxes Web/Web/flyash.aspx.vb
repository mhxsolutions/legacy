
Partial Class flyash
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        ASPxGridViewExporter1.WriteXlsxToResponse("fly ash traffic")
    End Sub
End Class
