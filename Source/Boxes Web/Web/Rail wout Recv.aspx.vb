
Partial Class Rail_wout_Recv
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        GridViewExporter1.WriteXlsxToResponse("rail without receiver")
    End Sub
End Class
