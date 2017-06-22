<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>Boxes - menu</title>
</head>
<body>
    <h3>
        Reports </h3>
    <p>
        <a href="index.aspx">MHX Reports</a></p>
    <h3>
        Budway</h3>
    <h3>
        <a href="mobile.aspx">Mobile Reports</a></h3>
    <h3>
        <a href="pitt_default.aspx">Pittsburg Fleet Reports</a></h3>
    <h3>
        <a href="fon.aspx">Fontana Fleet Reports</a></h3>
    <h3>
        <a href="Harbor.aspx">Harbor Reports</a></h3>
    <form id="form1" runat="server">
<p>
    &nbsp;Use filter box to find reports.</p>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" KeyFieldName="Report" 

        CssPostfix="Aqua" Theme="Aqua" EnableTheming="True">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="weblink" ReadOnly="True" VisibleIndex="3" 
                Caption="Report">
                <PropertiesTextEdit EncodeHtml="False">
                </PropertiesTextEdit>
                <Settings AutoFilterCondition="Contains" SortMode="DisplayText" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="4">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Category" VisibleIndex="1" SortIndex="0" 
                SortOrder="Ascending" GroupIndex="0">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Requested" VisibleIndex="5">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Report Title" SortIndex="1" 
                SortOrder="Ascending" Visible="False" VisibleIndex="2" Caption="Report Title">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <SettingsEditing Mode="Inline">
        </SettingsEditing>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" VerticalScrollableHeight="400" />
        <SettingsSearchPanel Visible="True" />
        <SettingsLoadingPanel ImagePosition="Top" />

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

        </ImagesFilterControl>

        <StylesEditors>
            <CalendarHeader Spacing="1px">
            </CalendarHeader>
            <ProgressBar Height="25px">
            </ProgressBar>
        </StylesEditors>

<Styles CssPostfix="Aqua"></Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        
        SelectCommand="SELECT * FROM [web reports with formatted link] WHERE ([Company_ID_ref] = @Company_ID_ref)" 
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        <br />
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
        <br />
        <br />

    <p>
        How to use data grid tools:</p>
        <ul>
            <li><a href="https://youtu.be/DhjrpVZNpdA">Filter and Sort</a></li>
            <li><a href="https://youtu.be/cogOtuUCeEI">Grouping</a></li>
            <li><a href="https://youtu.be/MtguFoSA_RA">Context Menu</a></li>
            <li><a href="https://youtu.be/ci5fW0ZOt1I">Avanced Filters</a></li>
        </ul>
        <p>
            &nbsp;</p>
    </form>
    </body>
</html>
