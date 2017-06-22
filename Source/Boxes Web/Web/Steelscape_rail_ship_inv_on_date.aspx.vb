
Partial Class Steelscape_rail_ship_inv_on_date
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub
End Class
