
<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    Inherits="Customers__Assigned_Rail_Summary_with_Preferred_Date" Title="BudwayDirect | Custom Reports | Rail Summary with Preferred Date" Codebehind="Rail Summary with Preferred Date.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <script language="javascript" type="text/javascript">
    
        function GetObj(name)
        {
            // DHTML Micro API
            // Source: http://www.quirksmode.org/js/dhtmloptions.html
            
            if (document.getElementById) // test if browser supports document.getElementById
            {
                this.obj = document.getElementById(name);
                this.style = document.getElementById(name).style;
            }
            else if (document.all) // test if browser supports document.all
            {
                this.obj = document.all[name];
                this.style = document.all[name].style;
            }
            else if (document.layers) // test if browser supports document.layers
            {
                this.obj = document.layers[name];
                this.style = document.layers[name].style;
            }
        }

        function ClientValidatePreferredDate(source, arguments)
        {
            var PreferredDateTextbox = new GetObj(PreferredDateControlId);
            var PreferredDate = new Date(PreferredDateTextbox.obj.value);

            // When Javascript parses two-digit years, it works on the same assumption as so
            // much other software: if the number is less than 70, then it's in the 1900s. So
            // if somebody types 09-25-09, for example, Javascript will interpret this as 
            // 09-25-1909, not 09-25-2009. So we check here to see if the year is less than
            // 2000 and increment by 100 as needed.
            
            if (PreferredDate.getFullYear() < 2000)
                PreferredDate.setFullYear(PreferredDate.getFullYear() + 100);
            
            var MidnightToday = new Date();
            MidnightToday.setHours(0);
            MidnightToday.setMinutes(0);
            MidnightToday.setSeconds(0);
            MidnightToday.setMilliseconds(0);
            
            arguments.IsValid = (MidnightToday <= PreferredDate);
        }
    
    </script>

    <h2>Rail Summary with Preferred Date</h2>
    
	Budway Terminal:
	
	<%-- 
	    The following provides the terminal names dynamically, which is better than the method I'm using,
	    at least in the sense that there's no need to update it if things change. However, the values in
	    the database include an ugly all-capital name for FONTANA, so I've gone with what looks better for now.
    --%>
	
<%--	
    <asp:DropDownList id="_TerminalDropDownList" runat="server" AutoPostBack="True" DataSourceID="_TerminalsDataSource" 
	    DataTextField="Terminal" DataValueField="Terminal" Width="150">
	</asp:DropDownList>
	
	<asp:SqlDataSource ID="_TerminalsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Terminal] FROM [Rail Detail] ORDER BY [Terminal]">
	</asp:SqlDataSource>
--%>	

	<asp:DropDownList id="_TerminalDropDownList" runat="server" AutoPostBack="True" Width="150">
		<asp:ListItem value="Fontana" selected="True">Fontana</asp:ListItem>
		<asp:ListItem value="New Jersey">New Jersey</asp:ListItem>
	</asp:DropDownList>
	
	<p></p>
	
	<asp:GridView id="_GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
	    DataSourceID="_RailDetailDataSource" DataKeyNames="RailCarId"
	    ForeColor="#333333" GridLines="None" PageSize="100" OnRowDataBound="_GridView1_RowDataBound">
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<Columns>

            <asp:CommandField ShowEditButton="True" EditText="Edit Date" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" Wrap="False" />
            </asp:CommandField>

            <asp:TemplateField HeaderText="Client" SortExpression="Client">
                <EditItemTemplate>
                    <asp:Label ID="_ClientLabel" runat="server" Text='<%# Eval("Client") %>' Width="200"></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_ClientLabel" runat="server" Text='<%# Eval("Client") %>' Width="200"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Preferred Date" SortExpression="ClientPreferredDate">
                <EditItemTemplate>
                    <asp:TextBox ID="_ClientPreferredDateTextbox" runat="server" Text='<%# Bind("ClientPreferredDate", "{0:MM-dd-yyyy}") %>' Width="75"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="_ClientPreferredDateRequiredValidator" runat="server" Display="Dynamic" 
                        ControlToValidate="_ClientPreferredDateTextbox" ErrorMessage="You must provide a preferred date" />
                    <asp:CustomValidator ID="_ClientPreferredDateCustomValidator" runat="server" Display="Dynamic" 
                        OnServerValidate="ServerValidateClientPreferredDate" ClientValidationFunction="ClientValidatePreferredDate"
                        ErrorMessage="Preferred date must be today or later"></asp:CustomValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_ClientPreferredDateLabel" runat="server" Text='<%# Bind("ClientPreferredDate", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Car" SortExpression="Car">
                <EditItemTemplate>
                    <asp:Label ID="_CarLabel" runat="server" Text='<%# Eval("Car") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_CarLabel" runat="server" Text='<%# Eval("Car") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Commodity" SortExpression="Commodity">
                <EditItemTemplate>
                    <asp:Label ID="_CommodityLabel" runat="server" Text='<%# Eval("Commodity") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_CommodityLabel" runat="server" Text='<%# Eval("Commodity") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Product" SortExpression="Product">
                <EditItemTemplate>
                    <asp:Label ID="_ProductLabel" runat="server" Text='<%# Eval("Product") %>' Width="100"></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_ProductLabel" runat="server" Text='<%# Eval("Product") %>' Width="100"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Carrier" SortExpression="Carrier">
                <EditItemTemplate>
                    <asp:Label ID="_CarrierLabel" runat="server" Text='<%# Eval("Carrier") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_CarrierLabel" runat="server" Text='<%# Eval("Carrier") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                <EditItemTemplate>
                    <asp:Label ID="_EtaLabel" runat="server" Text='<%# Eval("ETA", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_EtaLabel" runat="server" Text='<%# Eval("ETA", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                <EditItemTemplate>
                    <asp:Label ID="_StatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_StatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" Wrap="False" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Rail Yard" SortExpression="RailYard">
                <EditItemTemplate>
                    <asp:Label ID="_RailYardLabel" runat="server" Text='<%# Eval("RailYard", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_RailYardLabel" runat="server" Text='<%# Eval("RailYard", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Days In Yard" SortExpression="DaysInYard">
                <EditItemTemplate>
                    <asp:Label ID="_DaysInYardLabel" runat="server" Text='<%# Eval("DaysInYard") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_DaysInYardLabel" runat="server" Text='<%# Eval("DaysInYard") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Start Demurrage" SortExpression="StartDemurrage">
                <EditItemTemplate>
                    <asp:Label ID="_StartDemurrageLabel" runat="server" Text='<%# Eval("StartDemurrage", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_StartDemurrageLabel" runat="server" Text='<%# Eval("StartDemurrage", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Placed" SortExpression="Placed">
                <EditItemTemplate>
                    <asp:Label ID="_PlacedLabel" runat="server" Text='<%# Eval("Placed", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_PlacedLabel" runat="server" Text='<%# Eval("Placed", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Unloaded" SortExpression="Unloaded">
                <EditItemTemplate>
                    <asp:Label ID="_UnloadedLabel" runat="server" Text='<%# Eval("Unloaded", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_UnloadedLabel" runat="server" Text='<%# Eval("Unloaded", "{0:MM-dd-yy}") %>' Width="75"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                <EditItemTemplate>
                    <asp:Label ID="_CommentsLabel" runat="server" Text='<%# Eval("Comments") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_CommentsLabel" runat="server" Text='<%# Eval("Comments") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
			
		</Columns>

        <EmptyDataTemplate>
            <p>Sorry, but there is no data available for the current user and specified terminal.</p>
        </EmptyDataTemplate>
		
		<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
		<HeaderStyle BackColor="#660000" Font-Bold="True" ForeColor="White" />
		<AlternatingRowStyle BackColor="White" />
		
	</asp:GridView>
	
	<asp:SqlDataSource ID="_RailDetailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
	    SelectCommand="SELECT ATSF.UKEY AS RailCarId, ATSF.[Client Preferred Date] AS ClientPreferredDate, ATSF.Terminal, ATSF.[Car Number] AS Car, [ATSF Status].Status, ATSF.Shipper, [DWS No Rep Data].dbo.vParents.[Parents Name] AS Client, [ATSF Product Type].[Product Type] AS Commodity, [DWS No Rep Data].dbo.[sysReceiver Summary].[Product Group 1] AS Product, ATSF.bnsfuprr AS Carrier, DATEDIFF(d, ATSF.[CP Date], ISNULL(ATSF.[PL Date], GETDATE())) AS DaysInYard, ATSF.[E T A] AS ETA, ATSF.[CP Date] AS RailYard, ATSF.[PL Date] AS Placed, [DWS No Rep Data].dbo.[Receivers S locked].[Date Received] AS Unloaded, ATSF.[Status Flag], ATSF.[Car Comments] AS Comments, DATEADD(d, 3, ATSF.[CP Date]) AS StartDemurrage, [DWS No Rep Data].dbo.vParents.[Parent ref] AS [client ref] FROM [DWS No Rep Data].dbo.[sysReceiver Summary] RIGHT OUTER JOIN ATSF INNER JOIN [ATSF Status] ON ATSF.[Status Flag] = [ATSF Status].[Status Flag ID] ON [DWS No Rep Data].dbo.[sysReceiver Summary].[Source REF] = ATSF.UKEY LEFT OUTER JOIN [DWS No Rep Data].dbo.[Receivers S locked] ON ATSF.UKEY = [DWS No Rep Data].dbo.[Receivers S locked].[Source REF] LEFT OUTER JOIN [ATSF Product Type] ON ATSF.[Product Type Ref] = [ATSF Product Type].[ATSF Product ID] LEFT OUTER JOIN [DWS No Rep Data].dbo.vParents ON ATSF.[Client Ref] = [DWS No Rep Data].dbo.vParents.[Client ID] WHERE (ATSF.[Status Flag] < 5) AND (ATSF.Terminal = @Terminal) AND ([DWS No Rep Data].dbo.vParents.[Parent ref] = @Client) OR (ATSF.[Status Flag] < 5) AND (ATSF.Terminal = @Terminal) AND (@Client = 166073081) OR (ATSF.[Status Flag] < 5) AND (ATSF.Terminal = @Terminal) AND (@Client = 2145260460) ORDER BY Client, ETA, Car"
	    UpdateCommand="CopsSetAtsfClientPreferredDate" UpdateCommandType="StoredProcedure">
		<SelectParameters>
			<asp:controlparameter ControlID="_TerminalDropDownList" Name="Terminal" PropertyName="SelectedValue" Type="String" />
            <asp:SessionParameter Name="Client" SessionField="CONTEXT_CLIENTID" Type="String" />
		</SelectParameters>
		<UpdateParameters>
		    <asp:Parameter Name="RailCarId" />
		    <asp:Parameter Name="ClientPreferredDate" />
		    <asp:SessionParameter Name="ClientRef" SessionField="CONTEXT_CLIENTID" Type="String" />
		    <asp:SessionParameter Name="UserId" SessionField="CONTEXT_LOGINID" Type="String" />
		</UpdateParameters>
	</asp:SqlDataSource>    
    
</asp:Content>
