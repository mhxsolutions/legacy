<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EQinfo.aspx.vb" Inherits="EQinfo" %>

<%@ Register assembly="DevExpress.Web.v16.2" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EQ Info</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        EQ Info</h3>
    </div>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" KeyFieldName="EquipmentID">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="EquipmentIdentifier" SummaryType="Count" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="EquipmentIdentifier" SummaryType="Count" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1" GroupIndex="0" 
                    SortIndex="0" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EquipmentIdentifier" VisibleIndex="3" 
                    Caption="EQ No.">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="VehicleType" VisibleIndex="2" 
                    GroupIndex="1" SortIndex="1" SortOrder="Ascending" Caption="Type">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Year" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TrailerLength" VisibleIndex="7" 
                    Caption="Trailer Len">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="WheelBase" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="HeadacheRack" VisibleIndex="9">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="ABS" VisibleIndex="10">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="SpreadAxel" VisibleIndex="15">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Slider" VisibleIndex="16">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="LandingGear" VisibleIndex="17">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Weight-Light" VisibleIndex="18">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Weight-Equiped" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DeckType" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MFGName" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ModelName" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FrameType" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EngineType" VisibleIndex="21">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FrontWheelSize" VisibleIndex="22">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EquipmentComment" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ApplicationFor" VisibleIndex="23">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Jake Brake" VisibleIndex="24">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="StatusText" VisibleIndex="25">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status ref" VisibleIndex="26">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="CrossFire" VisibleIndex="27">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Parked" VisibleIndex="28">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Dispatch Comment" VisibleIndex="29">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Restrictions" VisibleIndex="31">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Classifications" VisibleIndex="32">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="VIN" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LICENCE" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="100">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:EQ ManagerConnectionSQL4 %>" 
            SelectCommand="SELECT * FROM [EQinfo with location]"></asp:SqlDataSource>
    </p>
    </form>
    </body>
</html>
