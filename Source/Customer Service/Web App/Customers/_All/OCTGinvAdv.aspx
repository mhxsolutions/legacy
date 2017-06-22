<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_OCTGinvAdv" 
    CodeBehind="OCTGinvAdv.aspx.cs" CodeFile="OCTGinvAdv.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        OCTG Inventory</h3>
    <p>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Xlsx" />
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
            DataSourceID="SqlDataSource1">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Linear Ft" ShowInColumn="Linear Ft" 
                    SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="{0:n1} lb" FieldName="Pounds" 
                    ShowInColumn="Terminal" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n1} LNFT" FieldName="Linear Ft" 
                    ShowInColumn="Terminal" SummaryType="Sum" Tag="LNFT" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" 
                    ShowInCustomizationForm="True" SortIndex="0" SortOrder="Ascending" 
                    VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" ShowInCustomizationForm="True" 
                    SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" 
                    ShowInCustomizationForm="True" SortIndex="2" SortOrder="Ascending" 
                    VisibleIndex="3">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mill" ShowInCustomizationForm="True" 
                    SortIndex="3" SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inspection" 
                    ShowInCustomizationForm="True" SortIndex="4" SortOrder="Ascending" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="poundsx" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}lb">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pounds" ShowInCustomizationForm="True" 
                    VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" ShowInCustomizationForm="True" 
                    VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="{0:n0}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" ShowInCustomizationForm="True" 
                    VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="150" Position="TopAndBottom">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                ShowGroupPanel="True" />
            <SettingsLoadingPanel ImagePosition="Top" />
            <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesEditors>
                <DropDownEditDropDown>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                        PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                </DropDownEditDropDown>
                <SpinEditIncrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
                </SpinEditIncrement>
                <SpinEditDecrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
                </SpinEditDecrement>
                <SpinEditLargeIncrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
                </SpinEditLargeIncrement>
                <SpinEditLargeDecrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
                </SpinEditLargeDecrement>
            </ImagesEditors>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                <LoadingPanel ImageSpacing="8px">
                </LoadingPanel>
            </Styles>
            <StylesEditors>
                <CalendarHeader Spacing="1px">
                </CalendarHeader>
                <ProgressBar Height="25px">
                </ProgressBar>
            </StylesEditors>
        </dx:ASPxGridView>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT Terminal, Profile, Description, Product, Mill, Inspection, Pounds, Count, [Linear Ft], [Client ref], CASE count WHEN 0 THEN 0 ELSE pounds END AS poundsx FROM [COPS OCTG Inventory Summary] WHERE ([Client ref] = @Client_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" 
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="gridexport" runat="server" 
            GridViewID="ASPxGridView2">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>

