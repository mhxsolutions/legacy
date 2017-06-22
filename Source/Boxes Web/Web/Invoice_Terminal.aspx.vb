
Partial Class Invoice_Terminal
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        GridViewExporter1.WriteXlsxToResponse("Invoice Terminals")
    End Sub
End Class
