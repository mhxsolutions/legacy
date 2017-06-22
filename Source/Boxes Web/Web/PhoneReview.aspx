<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PhoneReview.aspx.vb" Inherits="PhoneReview" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Phone Review</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver
            Phone Review</h3>
        <h3>
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                    VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#999999" />
                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                    Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                <TodayDayStyle BackColor="#CCCCCC" />
            </asp:Calendar>
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" DataSourceID="SqlDataSource1" 
        KeyFieldName="Planner Detail ID" Theme="Metropolis">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataTimeEditColumn Caption="Start" FieldName="STA Time" 
                VisibleIndex="9">
                <PropertiesTimeEdit DisplayFormatString="t">
                </PropertiesTimeEdit>
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn Caption="Arrive" FieldName="ARV Time" 
                VisibleIndex="12">
                <PropertiesTimeEdit DisplayFormatString="t">
                </PropertiesTimeEdit>
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn Caption="End" FieldName="CMP Time" 
                VisibleIndex="15">
                <PropertiesTimeEdit DisplayFormatString="t">
                </PropertiesTimeEdit>
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" GroupIndex="2" ReadOnly="True" 
                SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Order" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTimeEditColumn FieldName="Sch Arrive" VisibleIndex="13">
                <PropertiesTimeEdit DisplayFormatString="t">
                </PropertiesTimeEdit>
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="35">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <Images SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
            <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Blue/GridView/gvLoadingOnStatusBar.gif">
            </LoadingPanelOnStatusBar>
            <LoadingPanel Url="~/App_Themes/Office2003Blue/GridView/Loading.gif">
            </LoadingPanel>
        </Images>
        <ImagesFilterControl>
            <LoadingPanel Url="~/App_Themes/Office2003Blue/Editors/Loading.gif">
            </LoadingPanel>
        </ImagesFilterControl>
        <Styles CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
            CssPostfix="Office2003Blue">
            <Header ImageSpacing="5px" SortingImageSpacing="5px">
            </Header>
            <Cell Wrap="False">
            </Cell>
            <LoadingPanel ImageSpacing="10px">
            </LoadingPanel>
        </Styles>
        <StylesEditors>
            <ProgressBar Height="25px">
            </ProgressBar>
        </StylesEditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT [Plan Date], [Planner Detail ID], [STA Time], [ARV Time], [CMP Time], Driver, [Driver Ref], [O ref], Origin, [D ref], Destination, Transit, Dwell, [Order], [Sch Arrive], WorkPhone, Fleet, [Company ID ref] FROM [Agilis Work order Progression INFO] WHERE ([Plan Date] = @Plan_Date) AND ([Company ID ref] = 1)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
