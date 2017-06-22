
Partial Class UnplannedLoadsSummary
    Inherits System.Web.UI.Page

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs) Handles ASPxButton1.Click
        GridViewExporter1.WriteXlsxToResponse()
    End Sub
    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)
        'Session("ScheduleDate") = TryCast(sender, DevExpress.Web.ASPxGridView).GetSelectedFieldValues("[Schedule Date]")
        'Session("OriginId") = TryCast(sender, DevExpress.Web.ASPxGridView).GetSelectedFieldValues("OriginId")
        'Session("DestinationId") = TryCast(sender, DevExpress.Web.ASPxGridView).GetSelectedFieldValues("DestinationId")
        Dim KeyValues As String = (TryCast(sender, DevExpress.Web.ASPxGridView).GetMasterRowKeyValue())
        Dim KeyArr() As String
        KeyArr = KeyValues.Split("|")
        Session("ScheduleDate") = KeyArr(0)
        Session("OriginId") = KeyArr(1)
        Session("DestinationId") = KeyArr(2)



    End Sub
End Class
