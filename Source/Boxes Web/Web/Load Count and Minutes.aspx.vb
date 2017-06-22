
Partial Class Load_Count_and_Minutes
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        GridViewExporter1.WriteXlsxToResponse("Daily Load Count and Minutes")
    End Sub
End Class
