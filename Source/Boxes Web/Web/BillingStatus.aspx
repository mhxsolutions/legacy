<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BillingStatus.aspx.vb" Inherits="BillingStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Billing Status</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Billing Status
            (<a href="index.aspx">home</a>)<br />
            <br />
            Loads</h3>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
            <Fields>
                <dx:PivotGridField ID="fieldYr" Area="RowArea" AreaIndex="0" FieldName="Yr" Name="fieldYr">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMo" Area="RowArea" AreaIndex="1" FieldName="Mo" Name="fieldMo">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldLoad" Area="DataArea" AreaIndex="0" Caption="Load Ct" FieldName="Load" Name="fieldLoad" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldWillCall" Area="DataArea" AreaIndex="1" Caption="Will Calls" FieldName="Will Call" Name="fieldWillCall">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldRFSref" Area="DataArea" AreaIndex="2" Caption="RFS assigned ct" FieldName="RFS ref" Name="fieldRFSref" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldPublicRFSRevenue" Area="DataArea" AreaIndex="3" Caption="Billing Ct" FieldName="Public RFS Revenue" Name="fieldPublicRFSRevenue" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldRFSInvoiceRef" Area="DataArea" AreaIndex="5" Caption="Invoiced Ct" FieldName="RFS Invoice Ref" Name="fieldRFSInvoiceRef" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldItemTotal" Area="DataArea" AreaIndex="6" Caption="Invoiced" FieldName="Item Total" Name="fieldItemTotal">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldBilling" Area="DataArea" AreaIndex="4" FieldName="Billing" Name="fieldBilling">
                </dx:PivotGridField>
            </Fields>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load list for billing pivot] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <p>
            Load Date, No Manual Invoices</p>
        <h3>
            <br />
            Receivers</h3>
    
    </div>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid2" runat="server" ClientIDMode="AutoID" DataSourceID="SqlDataSource2" EnableTheming="True" Theme="MetropolisBlue">
            <Fields>
                <dx:PivotGridField ID="fieldYear" Area="RowArea" AreaIndex="0" FieldName="Year" Name="fieldYear">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth" Area="RowArea" AreaIndex="1" FieldName="Month" Name="fieldMonth">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldReceiverCt" Area="DataArea" AreaIndex="0" FieldName="Receiver Ct" Name="fieldReceiverCt" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldRFSAssignedCt" Area="DataArea" AreaIndex="1" FieldName="RFS Assigned Ct" Name="fieldRFSAssignedCt" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldBillingCt" Area="DataArea" AreaIndex="2" FieldName="Billing Ct" Name="fieldBillingCt" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldInvoicedCt" Area="DataArea" AreaIndex="4" FieldName="Invoiced Ct" Name="fieldInvoicedCt" SummaryType="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldInvoiced" Area="DataArea" AreaIndex="5" Caption="Invoiced Rev" FieldName="Invoiced" Name="fieldInvoiced">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldBilledRev" Area="DataArea" AreaIndex="3" FieldName="Billed Rev" Name="fieldBilledRev">
                </dx:PivotGridField>
            </Fields>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Receiver list for billing pivot] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
