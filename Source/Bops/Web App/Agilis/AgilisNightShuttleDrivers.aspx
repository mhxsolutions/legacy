<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="Agilis_AgilisNightShuttleDrivers" Title="BOPS | Agilis | Night Shuttle Drivers" Codebehind="AgilisNightShuttleDrivers.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h2>Night Shuttle Drivers</h2>
    <p>
        The following shows the drivers currently on the night shuttle plan. You may click
        the delete link to remove them.
    </p>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataSourceID="NightShuttleDriversDatasource" ForeColor="#333333" DataKeyNames="DriverId"
        GridLines="None" AllowSorting="True" OnRowDeleted="GridView1_RowDeleting">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteRecordLinkButton" runat="server" CausesValidation="False"
                        CommandName="Delete" OnClientClick='return confirm("Are you sure you want to remove the driver?");'
                        Text="Delete" ForeColor="controltext" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    
    <asp:SqlDataSource ID="NightShuttleDriversDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        InsertCommand="INSERT [Agilis Driver Plan Control] ([Driver Ref], [Upload Strategy], [Upload Hour]) VALUES (@DriverId, 2, 2)"
        SelectCommand="SELECT [Driver Ref] AS DriverId, tblDriverList.LastName, tblDriverList.FirstName FROM [Agilis Driver Plan Control] INNER JOIN tblDriverList ON [Agilis Driver Plan Control].[Driver Ref] = tblDriverList.EmployeeID"
        DeleteCommand="DELETE FROM [Agilis Driver Plan Control] WHERE [Driver Ref] = @DriverId">
        <InsertParameters>
            <asp:ControlParameter Name="DriverId" ControlID="NewDriverList" PropertyName="SelectedValue" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="DriverId" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
    <h3>
        Add A Driver
    </h3>
    <p>
        To add a driver to the night shuttle plan, select the proper name from the list
        below and click the button.
    </p>
    
    <asp:DropDownList ID="NewDriverList" runat="server" DataSourceID="DayDriversDatasource"
        DataTextField="Name" DataValueField="DriverId">
    </asp:DropDownList><asp:SqlDataSource ID="DayDriversDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT tblDriverList.EmployeeID AS DriverId, tblDriverList.FirstName + N' ' + tblDriverList.LastName AS Name FROM tblDriverList LEFT OUTER JOIN [Agilis Driver Plan Control] ON tblDriverList.EmployeeID = [Agilis Driver Plan Control].[Driver Ref] WHERE ([Agilis Driver Plan Control].[Driver Ref] IS NULL) ORDER BY tblDriverList.LastName, tblDriverList.FirstName">
    </asp:SqlDataSource>
    <asp:Button ID="SaveButton" runat="server" Text="Add Driver" OnClick="SaveButton_Click" />
    
</asp:Content>
