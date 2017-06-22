
Partial Class RFSauditdetail
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        exportloads.WriteXlsxToResponse()
    End Sub
End Class
