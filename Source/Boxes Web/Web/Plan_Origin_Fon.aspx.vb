
Partial Class Plan_Origin_Fon
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As System.EventArgs) Handles ASPxButton1.Click
        GridView.WriteXlsxToResponse()
    End Sub

    Protected Sub ASPxButton2_Click(sender As Object, e As System.EventArgs) Handles ASPxButton2.Click
        GridView.WritePdfToResponse()
    End Sub
End Class
