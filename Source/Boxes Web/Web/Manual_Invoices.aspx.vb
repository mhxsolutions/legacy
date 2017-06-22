
Partial Class Manual_Invoices
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As System.EventArgs) Handles ASPxButton1.Click
        ASPxGridView.WriteXlsxToResponse()
    End Sub
End Class
