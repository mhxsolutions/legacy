<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="Administration_GeocodeDestinations" Title="BOPS | Administration | Geocode Destinations" Codebehind="GeocodeDestinations.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        Geocode Destinations</h2>
        
    <h3>Step 1: Select Destination and Check Address</h3>
    <p>
        When you select a destination in the combobox, the address details for the destination will be
        displayed in the textboxes below.
    </p>
    <table>
        <tr>
            <td style="width: 100px" valign="top">
                Destination:</td>
            <td style="width: 100px" valign="top">
                <asp:DropDownList ID="DestinationDropdown" runat="server" DataSourceID="DestinationsWithoutCoordinatesDatasource"
                    DataTextField="Name" DataValueField="DestinationId" AutoPostBack="true" OnSelectedIndexChanged="DestinationDropdown_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="DestinationsWithoutCoordinatesDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id] AS DestinationId, Destination + ': ' + City + ', ' + ISNULL(State, '') AS Name, Latitude, Longitude FROM tbldestinationList ORDER BY Name">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td valign="top">
                Address:</td>
            <td style="width: 100%" valign="top">
                <asp:TextBox ID="AddressTextbox" runat="server" Width="400px"></asp:TextBox><br />
                <asp:TextBox ID="CityTextbox" runat="server" Width="230px"></asp:TextBox>
                <asp:TextBox ID="StateTextbox" runat="server" Width="50px"></asp:TextBox>
                <asp:TextBox ID="ZipTextbox" runat="server" Width="100px"></asp:TextBox></td>
        </tr>
    </table>
    
    <h3>Step 2: Geocode the Address</h3>
    <p>
        When you click the button, the address information above will be used in a web-service query to
        obtain latitude and longitude values, which will be displayed in the textboxes below. If the query
        fails, it is likely due to bad address information; in such cases you may correct the address
        information and try again.
    </p>
    <table>
        <tr>
            <td style="width: 100px" valign="top">
            </td>
            <td style="width: 100px" valign="top">
                Latitude:</td>
            <td style="width: 100px" valign="top">
                Longitude:</td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:Button ID="GeocodeButton" runat="server" Text="Geocode" OnClick="GeocodeButton_Click" /></td>
            <td style="width: 100px" valign="top">
                <asp:TextBox ID="LatitudeTextbox" runat="server" ValidationGroup="UpdateValidationGroup"></asp:TextBox></td>
            <td style="width: 100px" valign="top">
                <asp:TextBox ID="LongitudeTextbox" runat="server" ValidationGroup="UpdateValidationGroup"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
            </td>
            <td colspan="2" valign="top">
                <asp:Label ID="GeocodingFailureLabel" runat="server" ForeColor="Red" Text="The address could not be geocoded."
                    Visible="False"></asp:Label>
                <asp:HyperLink ID="ShowLocationHyperlink" runat="server" Visible="false">
                    Click here to see a map of the co-ordinates</asp:HyperLink>
            </td>
        </tr>
    </table>
    <br />
    
    <h3>Step 3: Update the Destination</h3>
    <p>
        If the latitude and longitude seem right (check the map if needed), use one of the following buttons to update 
        the destination coordinates or the coordinates and the address (if changed).
    </p>
    <asp:Button ID="UpdateCoordinatesButton" runat="server" Text="Update Coordinates" OnClick="UpdateCoordinatesButton_Click" ValidationGroup="UpdateValidationGroup" />
    <asp:Button ID="UpdateCoordinatesAndAddressButton" runat="server" Text="Update Coordinates and Address" OnClick="UpdateCoordinatesAndAddressButton_Click" ValidationGroup="UpdateValidationGroup" /><br />
    <asp:RequiredFieldValidator ID="LatitudeRequiredValidator" runat="server" ControlToValidate="LatitudeTextbox"
        Display="Dynamic" ErrorMessage="Latitude is required" ValidationGroup="UpdateValidationGroup"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="LongitudeRequiredValidator" runat="server" ControlToValidate="LongitudeTextbox"
        Display="Dynamic" ErrorMessage="Longitude is required" ValidationGroup="UpdateValidationGroup"></asp:RequiredFieldValidator>
</asp:Content>
