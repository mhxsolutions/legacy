
Partial Class fly_ash_traffic
    Inherits System.Web.UI.Page
    
    Protected Sub ASPxGridView1_RowInserted(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertedEventArgs) Handles ASPxGridView1.RowInserted


    End Sub

    Protected Sub ASPxGridView1_InitNewRow(sender As Object, e As DevExpress.Web.Data.ASPxDataInitNewRowEventArgs) Handles ASPxGridView1.InitNewRow
        'initialize date/time columns to current date/time --DH: I think I just want the initial time set. Commenting lines for Scale and Depart
        e.NewValues("Arrive") = DateTime.Now
        'e.NewValues("Scale") = DateTime.Now
        'e.NewValues("Depart") = DateTime.Now

    End Sub
End Class
