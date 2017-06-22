<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Load_INFO.aspx.vb" Inherits="Load_INFO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Load INFO</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Load and Plan INFO<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
            Theme="MetropolisBlue">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="LoadDate" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="7">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="6">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Will Call" VisibleIndex="8">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Client" ReadOnly="True" VisibleIndex="9">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Dest" ReadOnly="True" 
                    VisibleIndex="10">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Plan Origin" ReadOnly="True" 
                    VisibleIndex="12">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Plan Destination" ReadOnly="True" 
                    VisibleIndex="13">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="50">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" 
                ShowHeaderFilterButton="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Load and Plan INFO] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        If there is no Plan Date, the load is not on a plan.</p>
</body>
</html>
