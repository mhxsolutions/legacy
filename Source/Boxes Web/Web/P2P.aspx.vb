Imports DevExpress.Web

Partial Class P2P
    Inherits System.Web.UI.Page

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("sel_date") = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue()
        'Session("sel_fleet") = ASPxGridView1.GetSelectedFieldValues({"Fleet"})
    End Sub
End Class
