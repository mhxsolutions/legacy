
Partial Class Loads_And_Drivers
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub
End Class
