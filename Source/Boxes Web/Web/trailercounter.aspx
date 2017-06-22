<%@ Page Language="VB" AutoEventWireup="false" CodeFile="trailercounter.aspx.vb" Inherits="trailercounter" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trailer Count</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        Trailer Counter Test</h3>
        <br />
        <br />
        <asp:DataList ID="DataList1" runat="server" BackColor="White" 
            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            DataSourceID="SqlDataSource2" GridLines="Both">
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <ItemStyle BackColor="White" ForeColor="#003399" />
            <ItemTemplate>
                Total:
                <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
                <br />
<br />
            </ItemTemplate>
            <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        </asp:DataList>
        <br />
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" KeyFieldName="trailer ID" 
        CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" EnableTheming="True" Theme="Metropolis">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="In" ShowInColumn="In" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Out" ShowInColumn="Out" SummaryType="Sum" />
            <dx:ASPxSummaryItem ShowInColumn="Date" SummaryType="Custom" />
        </TotalSummary>
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn FieldName="Date" ReadOnly="True" VisibleIndex="3" 
                Caption="Time" ShowInCustomizationForm="True">
                <PropertiesDateEdit AllowNull="False" AllowUserInput="False" 
                    DisplayFormatString="t">
                </PropertiesDateEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="In" VisibleIndex="1" 
                ShowInCustomizationForm="True">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Out" VisibleIndex="2" 
                ShowInCustomizationForm="True">
            </dx:GridViewDataTextColumn>
        </Columns>
        <Settings ShowFooter="True" />
        <Images SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css">
            <LoadingPanelOnStatusBar Url="~/App_Themes/BlackGlass/GridView/gvLoadingOnStatusBar.gif">
            </LoadingPanelOnStatusBar>
            <LoadingPanel Url="~/App_Themes/BlackGlass/GridView/Loading.gif">
            </LoadingPanel>
        </Images>
        <ImagesFilterControl>
            <LoadingPanel Url="~/App_Themes/BlackGlass/Editors/Loading.gif">
            </LoadingPanel>
        </ImagesFilterControl>
        <Styles CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" 
            CssPostfix="BlackGlass">
            <Header ImageSpacing="5px" SortingImageSpacing="5px">
            </Header>
        </Styles>
        <StylesEditors>
            <CalendarHeader Spacing="1px">
            </CalendarHeader>
            <ProgressBar Height="25px">
            </ProgressBar>
        </StylesEditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConflictDetection="CompareAllValues" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        DeleteCommand="DELETE FROM [Trailer Counter] WHERE [trailer ID] = @original_trailer_ID AND [Date] = @original_Date AND (([In] = @original_In) OR ([In] IS NULL AND @original_In IS NULL)) AND (([Out] = @original_Out) OR ([Out] IS NULL AND @original_Out IS NULL))" 
        InsertCommand="INSERT INTO [Trailer Counter] ([Date], [In], [Out]) VALUES (getdate(), @In, @Out)" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT [trailer ID], Date, [In], Out FROM [Trailer Counter] ORDER BY Date DESC" 
        
        UpdateCommand="UPDATE [Trailer Counter] SET [Date] = @Date, [In] = @In, [Out] = @Out WHERE [trailer ID] = @original_trailer_ID AND [Date] = @original_Date AND (([In] = @original_In) OR ([In] IS NULL AND @original_In IS NULL)) AND (([Out] = @original_Out) OR ([Out] IS NULL AND @original_Out IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_trailer_ID" Type="Int32" />
            <asp:Parameter Name="original_Date" Type="DateTime" />
            <asp:Parameter Name="original_In" Type="Int32" />
            <asp:Parameter Name="original_Out" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="In" Type="Int32" />
            <asp:Parameter Name="Out" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Date" Type="DateTime" />
            <asp:Parameter Name="In" Type="Int32" />
            <asp:Parameter Name="Out" Type="Int32" />
            <asp:Parameter Name="original_trailer_ID" Type="Int32" />
            <asp:Parameter Name="original_Date" Type="DateTime" />
            <asp:Parameter Name="original_In" Type="Int32" />
            <asp:Parameter Name="original_Out" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [trailer counter total]"></asp:SqlDataSource>
    </form>
</body>
</html>
