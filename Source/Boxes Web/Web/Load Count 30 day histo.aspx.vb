
Partial Class Load_Count_30_day_histo
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        GridViewExporter1.WriteXlsxToResponse("load count 30 day histo")
    End Sub
End Class
