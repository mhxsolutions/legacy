<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Distance.aspx.cs" Inherits="All_Distance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        table {
            border: solid 1px #dddddd;
        }

        th {
            background: #eeeeee;
            border: solid 1px #dddddd;
            font-weight: bold;
            padding: 5px 10px;
        }

        td {
            border: solid 1px #dddddd;
            padding: 5px 10px;
        }
    </style>
    <h2>Manage Users</h2>
    <div class="contentDiv">
        From: 
        <asp:TextBox ID="txtFrom" runat="server" Width="500" Text="Attn: Beth Lindberg	Pittsburg CA 94565"></asp:TextBox>
        <br />
        <br />
        To: 
        <asp:TextBox ID="txtTo" runat="server" Width="500" Text="2200 Wilbur Ave Antioch CA 94509"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnGetDistance" runat="server" Text="Get Distance" OnClick="btnGetDistance_Click" />
        <br />
        <b>
            <asp:Literal ID="litMessage" Text="" runat="server" /></b>
        <br />
        <b>Source: </b>
        <asp:Literal runat="server" ID="litSource"></asp:Literal><br />
        <b>Destination: </b>
        <asp:Literal runat="server" ID="litDestination"></asp:Literal><br />
        <br />
        <br />
        <asp:Repeater runat="server" ID="rptrRoutes">
            <HeaderTemplate>
                <table>
                    <tr>
                        <th>Distance</th>
                        <th>Estimated Time</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("distance.text") %></td>
                    <td><%# Eval("duration.text") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <hr />
        <asp:Button ID="btnShowList" runat="server" Text="Show Distance List" OnClick="btnShowList_Click" />

        <br /><br />
        <asp:Repeater runat="server" ID="Repeater2">
            <HeaderTemplate>
                <table>
                    <tr>
                        <th>Source</th>
                        <th>Destination</th>
                        <th>Response</th>
                        <th>Distance</th>
                        <th>Estimated Time</th>
                        <th>Result</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Source") %></td>
                    <td><%# Eval("Destination") %></td>
                    <td><%# Eval("Response") %></td>
                    <td><%# Eval("Distance") %></td>
                    <td><%# Eval("Time") %></td>
                    <td><%# Eval("Result") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>

