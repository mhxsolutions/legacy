
Partial Class rail_without_prerecv
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As System.EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse("rail without pre-receiver")
    End Sub
End Class
