
Partial Class UPI_Load_Lookup
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As System.EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub
End Class
