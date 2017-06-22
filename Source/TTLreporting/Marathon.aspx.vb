
Partial Class Marathon
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As System.EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsToResponse()
    End Sub

    Protected Sub ASPxButton2_Click(sender As Object, e As System.EventArgs) Handles ASPxButton2.Click
        GridViewExporter2.WriteXlsToResponse()
    End Sub
End Class
