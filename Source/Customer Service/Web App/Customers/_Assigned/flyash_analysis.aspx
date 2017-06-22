<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_flyash_analysis" CodeFile="flyash_analysis.aspx.cs" Codebehind="flyash_analysis.aspx.cs" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Fly Ash Time Analysis</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" 
            CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
            CssPostfix="Office2010Silver">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Pre Scale Time" ShowInColumn="Pre Scale Time" 
                    SummaryType="Average" />
                <dx:ASPxSummaryItem FieldName="Pre Scale Time" ShowInColumn="Pre Scale Time" 
                    SummaryType="Count" />
                <dx:ASPxSummaryItem FieldName="Scale Time" ShowInColumn="Scale Time" 
                    SummaryType="Average" />
                <dx:ASPxSummaryItem FieldName="Total Time" ShowInGroupFooterColumn="Total Time" 
                    SummaryType="Average" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Pre Scale Time" SummaryType="Count" />
                <dx:ASPxSummaryItem DisplayFormat="Pre Scale Avg ={0:n0}" 
                    FieldName="Pre Scale Time" SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="Scale Time Avg ={0:n0}" 
                    FieldName="Scale Time" SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="Total Time Avg ={0:n0}" 
                    FieldName="Total Time" SummaryType="Average" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataDateColumn FieldName="Date" GroupIndex="0" ReadOnly="True" 
                    SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Pre Scale Time" ReadOnly="True" 
                    VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Scale Time" ReadOnly="True" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total Time" ReadOnly="True" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Arrive" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="10">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Scale" VisibleIndex="11">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Depart" VisibleIndex="12">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Customer" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="100">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
            <Images SpriteCssFilePath="~/App_Themes/Office2010Silver/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
                CssPostfix="Office2010Silver">
                <Header ImageSpacing="5px" SortingImageSpacing="5px">
                </Header>
                <LoadingPanel ImageSpacing="5px">
                </LoadingPanel>
            </Styles>
            <StylesEditors ButtonEditCellSpacing="0">
                <ProgressBar Height="21px">
                </ProgressBar>
            </StylesEditors>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [fly ash time calcs]"></asp:SqlDataSource>
    </p>
</asp:Content>

