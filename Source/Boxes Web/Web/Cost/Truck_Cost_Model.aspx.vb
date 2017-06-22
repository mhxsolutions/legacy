Imports DevExpress.Web

Partial Class Cost_Truck_Cost_Model
    Inherits System.Web.UI.Page


    Protected Sub ASPxGridView3_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("PID") = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue()
    End Sub
End Class
