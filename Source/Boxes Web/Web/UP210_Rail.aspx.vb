
Partial Class UP210_Rail
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub

    Protected Sub ASPxButton2_Click(sender As Object, e As EventArgs) Handles ASPxButton2.Click
        ASPxGridView1.ExpandAll()
    End Sub

    Protected Sub ASPxButton3_Click(sender As Object, e As EventArgs) Handles ASPxButton3.Click
        ASPxGridView1.CollapseAll()
    End Sub
End Class
