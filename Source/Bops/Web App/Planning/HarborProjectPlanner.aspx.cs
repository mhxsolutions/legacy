using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using FarPoint.Web.Spread;
using FarPoint.Web.Spread.Model;
using log4net;
using log4net.Config;
[assembly: XmlConfigurator(Watch = true)]

public partial class Planning_HarborProjectPlanner : Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Planning_HarborProjectPlanner));

    protected Image _ExportButton;

    #region Helper Classes

    public class ProjectRowData
    {
        #region Members
        private readonly int _Row;
        private int _PlanLoadsOffSheet;
        #endregion

        #region Properties
        public int Row
        {
            get { return _Row; }
        }

        public int PlanLoadsOffSheet
        {
            get { return _PlanLoadsOffSheet; }
            set { _PlanLoadsOffSheet = value; }
        }

        #endregion

        #region Construction

        public ProjectRowData(int Row)
        {
            _Row = Row;
        }

        public ProjectRowData(int Row, int PlanLoadsOffSheet)
        {
            _Row = Row;
            _PlanLoadsOffSheet = PlanLoadsOffSheet;
        }

        #endregion
    }

    public struct ColumnConfigurationData
    {
        private string _Name;
        private int _Width;

        public ColumnConfigurationData(string Name, int Width)
        {
            _Name = Name;
            _Width = Width;
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public int Width
        {
            get { return _Width; }
            set { _Width = value; }
        }
    }

    #endregion

    #region Enumerations

    public enum DataColumns
    {
        PlannerStatus,
        ProjectId,
        RfsId,
        Status,
        Vessel,
        Berth,
        Destination,
        EstLoads,
        PlannedLoads,
        LoadsOS,
        FFD,
        LFD,
        Product,

        FirstDateColumn     // Placeholder used for formatting
    }

    #endregion

    #region String Constants
    private const string DATE_FORMAT_FOR_HEADERS = "ddd MM/dd";
    private const string DATE_FORMAT_FOR_DISPLAY = "MM/dd";
    private const string DATE_FORMAT_FOR_QUERIES = "MM/dd/yyyy";

    private const string UPDATE_PLANNER_DATA =
        "BEGIN TRANSACTION " + 
        "CREATE TABLE #ProjectPlannerReconcile ( " +
            "[PMID ref] [int], " +
            "[Destination ref] [int] " +
            ") " +
        "INSERT INTO #ProjectPlannerReconcile " +
            "SELECT DISTINCT  " +
                "HPP.[PMID ref],	 " +
                "HPP.[Destination ref] " +
            "FROM  " +
                "[Harbor Project Planner] AS HPP " +
            "WHERE " +
                "[Planning Status] >= 0 " +
            "EXCEPT " +
            "SELECT DISTINCT  " +
                "BOL.[PMDO ref] AS [PMID ref],  " +
                "BOL.[Destination ref]  " +
            "FROM  " +
                "[Project Manager BOL] AS BOL " +
        "UPDATE	 " +
            "[Harbor Project Planner] " +
        "SET		 " +
            "[Planning Status] = -1 " +
        "WHERE	 " +
            "PPID IN ( " +
                "SELECT " +
                    "HPP.PPID " +
                "FROM  " +
                    "[Harbor Project Planner] AS HPP " +
                    "INNER JOIN #ProjectPlannerReconcile AS PPR ON (HPP.[PMID ref] = PPR.[PMID ref] AND HPP.[Destination ref] = PPR.[Destination ref]) " +
                ") " +
        "INSERT INTO [Harbor Project Planner] ([PMID ref], [Destination ref], [Planning Status]) " +
            "SELECT DISTINCT  " +
                "BOL.[PMDO ref] AS [PMID ref],  " +
                "BOL.[Destination ref], " +
                "'0' AS [Planning Status] " +
            "FROM  " +
                "[Project Manager DO] AS DO " +
                "INNER JOIN [Project Manager BOL] AS BOL ON DO.PMID = BOL.[PMDO ref] " +
            "WHERE " +
                "BOL.[Destination ref] IS NOT NULL " +
                "AND DO.Berth IS NOT NULL " +
            "EXCEPT " +
            "SELECT DISTINCT  " +
                "HPP.[PMID ref],	 " +
                "HPP.[Destination ref], " +
                "'0' AS [Planning Status] " +
            "FROM  " +
                "[Harbor Project Planner] AS HPP " +
        "DROP TABLE #ProjectPlannerReconcile " +
        "COMMIT TRANSACTION";

    private const string PROJECT_QUERY =
        "SELECT " +
            "HPP.PPID, " +
            "HPP.[Planning Status], " +
            "DO.PMID AS [Project ID],	 " +
            "[RFS Main].[RFS ID] AS RFS, " +
            "STAT.Status, " +
            "DO.Vessel, " +
            "DO.Berth, " +
            "DO.[Start Project] AS FFD, " +
            "DO.[End Project] AS LFD, " +
            "PROD.[Product Type] AS Product, " +
            "HPP.[PMID ref], " +
            "BOL.[Destination ref], " +
            "PKGDST.Destination, " +
            "SUM(BOL.[Load Ct]) AS [Est Loads] " +
        "FROM " +
            "[Harbor Project Planner] AS HPP " +
            "INNER JOIN [Project Manager BOL] AS BOL ON (HPP.[PMID ref] = BOL.[PMDO ref] AND HPP.[Destination ref] = BOL.[Destination ref]) " +
            "INNER JOIN [Project Manager DO] AS DO ON HPP.[PMID ref] = DO.PMID " +
            "INNER JOIN [Proj Status] AS STAT ON DO.[Proj Status Ref] = STAT.[Project Status ID] " +
            "INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] AS PROD ON DO.[Product Ref] = PROD.[ATSF Product ID] " +
            "INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS PKGDST ON HPP.[Destination ref] = PKGDST.[Destination id] " +
            "LEFT OUTER JOIN [RFS Main] ON DO.[PMID] = [RFS Main].[PMID ref] " +
        "WHERE " +
            "(DO.PMID IN (SELECT [PMID ref] FROM [Harbor Project Planner]))  " +
            "AND DO.[Proj Status Ref] IN ({0}) " +
            "AND HPP.[Planning Status] >= 0 " +
            "AND HPP.[Hidden] = 0" +
        "GROUP BY " +
            "HPP.PPID, " +
            "HPP.[Planning Status], " +
            "DO.PMID, " +
            "[RFS Main].[RFS ID], "+
            "STAT.Status, " +
            "DO.Vessel, " +
            "DO.Berth, " +
            "DO.[Start Project], " +
            "DO.[End Project], " +
            "PROD.[Product Type], " +
            "HPP.[PMID ref], " +
            "BOL.[Destination ref], " +
            "PKGDST.Destination " +
        "ORDER BY Status, Berth, FFD, Vessel, Destination";

    private const string LOAD_QUERY =
        "SELECT PPDID, [PPID ref], Date, [Load Ct] " +
        "FROM [Harbor Project Planner Detail] " +
        "WHERE [PPID ref] IN ({0}) " +
        "ORDER BY Date";

    private const string UPDATE_LOAD_COUNT = "UPDATE [Harbor Project Planner Detail] SET [Load Ct] = '{1}' WHERE PPDID = '{0}'";
    private const string INSERT_LOAD_COUNT = "INSERT INTO [Harbor Project Planner Detail] ([PPID ref], [Date], [Load Ct]) VALUES ('{0}', '{1}', '{2}') SELECT SCOPE_IDENTITY()";
    private const string DELETE_LOAD_COUNT = "DELETE FROM [Harbor Project Planner Detail] WHERE PPDID = '{0}'";

    #endregion

    #region Other Constants

    private readonly int _DefaultRowHeight = 14;

    private readonly ColumnConfigurationData[] DataColumnData = 
        {
            new ColumnConfigurationData(" ", 18),
            new ColumnConfigurationData("ID", 30),
            new ColumnConfigurationData("RFS", 30),
            new ColumnConfigurationData("Status", 40),
            new ColumnConfigurationData("Vessel", 70),
            new ColumnConfigurationData("Berth", 70),
            new ColumnConfigurationData("Destination", 80),
            new ColumnConfigurationData("Est", 25),
            new ColumnConfigurationData("Plan", 25),
            new ColumnConfigurationData("O/S", 25),
            new ColumnConfigurationData("FFD", 30),
            new ColumnConfigurationData("LFD", 30),
            new ColumnConfigurationData("Product", 50)
        };

    #endregion
    
    #region Properties
    
    public int DateColumns
    {
        get { return Convert.ToInt32(Session["DateColumns"]); }
        set { Session["DateColumns"] = value; }
    }

    public DateTime AnchorDate
    {
        get { return Convert.ToDateTime(Session["AnchorDate"]); }
        set { Session["AnchorDate"] = value; }
    }
	
    public string ProjectStatusFilter
    {
        get
        {
            object ProjStatus = Session["ProjectStatusFilter"];
            if (ProjStatus == null)
                return string.Empty;
            else 
                return ProjStatus.ToString();
        }
        
        set { Session["ProjectStatusFilter"] = value; }
    }
    
    #endregion

    #region Spreadsheet Configuration

    protected override void Render(HtmlTextWriter writer)
    {
        RemoveCommandBarButton("Update");
        RemoveCommandBarButton("Cancel");
        RemoveCommandBarButton("Prev");
        RemoveCommandBarButton("Next");

        Control AnchorButton = FpSpread1.FindControl("Copy");
        if (AnchorButton != null)
        {
            TableCell ParentCell = AnchorButton.Parent as TableCell;
            TableRow ParentRow = ParentCell.Parent as TableRow;
            TableCell NewButtonCell = new TableCell();
            NewButtonCell.Controls.Add(_ExportButton);
            ParentRow.Cells.Add(NewButtonCell);
        }

        base.Render(writer);
    }

    private void RemoveCommandBarButton(string Name)
    {
        Control DoomedButton = FpSpread1.FindControl(Name);
        if (DoomedButton != null)
        {
            TableCell ParentCell = DoomedButton.Parent as TableCell;

            if (ParentCell != null)
            {
                TableRow ParentRow = ParentCell.Parent as TableRow;
                if (ParentRow != null)
                    ParentRow.Cells.Remove(ParentCell);
            }
        }
    }

    private void ConfigureProjectColumnHeaders()
    {
        for (int i = (int)DataColumns.ProjectId; i < (int)DataColumns.FirstDateColumn; i++)
        {
            FpSpread1.Columns[i].Label = DataColumnData[i].Name;
            FpSpread1.Columns[i].Width = DataColumnData[i].Width;
            FpSpread1.Columns[i].Locked = true;
        }
    }
    
    private void ConfigureSpreadsheet()
    {
        ConfigureProjectColumnHeaders();
        FpSpread1.ActiveSheetView.DefaultStyle.Font.Size = 8;
        FpSpread1.ActiveSheetView.DefaultStyle.Font.Name = "Arial";
        FpSpread1.ActiveSheetView.DefaultRowHeight = _DefaultRowHeight;

        // Set the default cell type for all columns.
        
        GeneralCellType DefaultCellType = new GeneralCellType();
        DefaultCellType.AllowWrap = false;
        for (int i = 0; i < (int)DataColumns.FirstDateColumn; i++)
            FpSpread1.Sheets[0].Columns[i].CellType = DefaultCellType;

        // Then override the cell type for the date columns.
        
        DateTimeCellType objDateCell = new DateTimeCellType();
        objDateCell.FormatString = DATE_FORMAT_FOR_DISPLAY;
        FpSpread1.Sheets[0].Columns[(int)DataColumns.FFD].CellType = objDateCell;
        FpSpread1.Sheets[0].Columns[(int)DataColumns.LFD].CellType = objDateCell;

        DateColumns = 4 * 7;    // Show four weeks of seven days.
        int DateIncrement = 1;  // Each column represents one day.

        if (AnchorDate == DateTime.MinValue)
        {
            DateTime NewAnchorDate = DateTime.Now.AddDays(-(DateTime.Now.DayOfWeek - DayOfWeek.Sunday));
            _Log.DebugFormat("ConfigureSpreadsheet: setting anchor date to {0}", NewAnchorDate);
            AnchorDate = NewAnchorDate;
        }
        
        // Set the overall column count and freeze the desired columns.
        
        FpSpread1.Sheets[0].ColumnCount = (int)DataColumns.FirstDateColumn + DateColumns;
        FpSpread1.Sheets[0].FrozenColumnCount = (int)DataColumns.Product;
        
        // And configure the planned loads columns.        
        
        DateTime ColumnDate = AnchorDate;
        for (int i = 0; i < DateColumns; i++)
        {
            FpSpread1.Sheets[0].Columns[(int)DataColumns.FirstDateColumn + i].Label = ColumnDate.ToString(DATE_FORMAT_FOR_HEADERS);
            FpSpread1.Sheets[0].Columns[(int)DataColumns.FirstDateColumn + i].Tag = ColumnDate;
            FpSpread1.Sheets[0].Columns[(int)DataColumns.FirstDateColumn + i].Width = 45;
            ColumnDate = ColumnDate.AddDays(DateIncrement);
        }
    }

    private void ConfigureTotalsRow(int TotalsRow, int UpperLeftRow, int UpperLeftColumn, int LowerRightRow, int LowerRightColumn)
    {
        // Span several columns to make sure we have enough room for the text.
        
        FpSpread1.Sheets[0].Rows[TotalsRow].Locked = true;
        FpSpread1.Sheets[0].Rows[TotalsRow].Font.Bold = true;
        FpSpread1.ActiveSheetView.AddSpanCell(0, (int)DataColumns.EstLoads, 1, 5);
        FpSpread1.Sheets[0].Cells[TotalsRow, (int)DataColumns.EstLoads].Value = "DAILY TOTALS:";
        FpSpread1.Sheets[0].Cells[TotalsRow, (int)DataColumns.EstLoads].HorizontalAlign = HorizontalAlign.Right;

        for (int Column = UpperLeftColumn; Column <= LowerRightColumn; Column++)
        {
            Cell TotalCell = FpSpread1.Sheets[0].Cells[TotalsRow, Column];
            string TopCellRef = FpSpread1.Sheets[0].Cells[UpperLeftRow, Column].ToString(TotalCell);
            string BottomCellRef = FpSpread1.Sheets[0].Cells[LowerRightRow, Column].ToString(TotalCell);
            string Formula = string.Format("SUM({0}:{1})", TopCellRef, BottomCellRef);
            TotalCell.Formula = Formula;
        }
    }

    private void ConfigureBerthTotals(int FirstBerthRow, int LastBerthRow, int TotalsRow)
    {
        _Log.DebugFormat("ConfigureBerthTotals: FirstRow = {0}, LastRow = {1}, TotalsRow = {2}", FirstBerthRow, LastBerthRow, TotalsRow);

        int StartColumn = (int)DataColumns.Berth;
        FpSpread1.ActiveSheetView.AddSpanCell(TotalsRow, StartColumn, 1, 2);
        FpSpread1.Sheets[0].Cells[TotalsRow, StartColumn].Value = "BERTH TOTALS:";
        FpSpread1.Sheets[0].Cells[TotalsRow, StartColumn].HorizontalAlign = HorizontalAlign.Right;
        FpSpread1.Rows[TotalsRow].Locked = true;

        for (DataColumns Column = DataColumns.EstLoads; Column <= DataColumns.LoadsOS; Column++)
        {
            Cell BerthTotalCell = FpSpread1.Sheets[0].Cells[TotalsRow, (int)Column];
            string FirstBerthRef = FpSpread1.Sheets[0].Cells[FirstBerthRow, (int)Column].ToString(BerthTotalCell);
            string LastBerthRef = FpSpread1.Sheets[0].Cells[LastBerthRow, (int)Column].ToString(BerthTotalCell);
            BerthTotalCell.Formula = string.Format("SUM({0}:{1})", FirstBerthRef, LastBerthRef);
        }
    }

    #endregion

    #region Spreadsheet Population

    private void UpdatePlannerRows(SqlConnection Connection)
    {
        SqlCommand Insert = new SqlCommand(UPDATE_PLANNER_DATA, Connection);
        Insert.ExecuteNonQuery();
    }
    
    private void PopulateSpreadsheet()
    {
        PrevWeek.Enabled = false;
        NextWeek.Enabled = false;
        
        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
        _Log.DebugFormat("PopulateSpreadsheet: using database connection string: {0}", DbServer);
        
        string ProjFilter = ProjectStatusFilter;
        if (ProjFilter == string.Empty)
        {
            ProjFilter = "1,9";
            _Log.InfoFormat("PopulateSpreadsheet: setting default project filter to {0}", ProjFilter);
            ProjectStatusFilter = ProjFilter;
        }

        IDictionary<int, ProjectRowData> ProjectToRowDataMap = new Dictionary<int, ProjectRowData>();
        
        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            Connection.Open();

            // Make sure all the latest projects are available for planning.
            
            UpdatePlannerRows(Connection);

            string Query = string.Format(PROJECT_QUERY, ProjFilter);
            SqlCommand Select = new SqlCommand(Query, Connection);
            SqlDataReader Reader = Select.ExecuteReader();

            int Row = 0;
            string LastBerth = String.Empty;

            // Add the totals row at the top.
            
            FpSpread1.Sheets[0].Rows.Add(Row, 1);
            int FirstBerthRow = ++Row;

            while (Reader.Read())
            {
                int PPID = Convert.ToInt32(Reader["PPID"]);

                // Check for and add a blank line in-between berths.
                
                string Berth = Reader["Berth"].ToString();
                if (LastBerth != String.Empty && LastBerth != Berth)
                {
                    FpSpread1.Sheets[0].Rows.Add(Row, 1);
                    ConfigureBerthTotals(FirstBerthRow, Row - 1, Row);
                    FpSpread1.Sheets[0].Rows[Row].Locked = true;
                    FirstBerthRow = ++Row;
                }

                // Add a new row to the spreadsheet and set the tag for the project ID column with
                // the ID of the associated harbor project planner row.
                
                FpSpread1.Sheets[0].Rows.Add(Row, 1);
                ProjectToRowDataMap.Add(PPID, new ProjectRowData(Row));
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.ProjectId].Tag = PPID.ToString();

                // Configure the planning status link for auto-advance behavior when clicked.

                string PlannerStatusUrl = string.Format("~/Planning/HarborProjectPlannerConfigureProject.aspx?PPID={0}", PPID);
                string ImageUrl = string.Format("~/Planning/Images/Planning Status {0}.gif", Reader["Planning Status"]);
                HyperLinkCellType StatusLink = new HyperLinkCellType();
                StatusLink.ImageUrl= ImageUrl;
                StatusLink.Target = "_self";
                StatusLink.NavigateUrl = PlannerStatusUrl;
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.PlannerStatus].CellType = StatusLink;
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.PlannerStatus].HorizontalAlign = HorizontalAlign.Center;
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.PlannerStatus].VerticalAlign = VerticalAlign.Middle;
                
                // Now add data columns and the formula for the loads over/short (O/S) column.
                
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.ProjectId].Value = Reader["Project ID"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.RfsId].Value = Reader["RFS"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.Status].Value = Reader["Status"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.Vessel].Value = Reader["Vessel"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.Berth].Value = Reader["Berth"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.EstLoads].Value = Reader["Est Loads"];

                Cell ThisCell = FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.LoadsOS];
                string LeftCellRef = FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.EstLoads].ToString(ThisCell);
                string RightCellRef = FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.PlannedLoads].ToString(ThisCell);
                string Formula = string.Format("IF(ISNUMBER({0}),{0}-{1},\"\")", LeftCellRef, RightCellRef);
                ThisCell.Formula = Formula;
                
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.FFD].Value = Reader["FFD"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.LFD].Value = Reader["LFD"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.Product].Value = Reader["Product"];
                FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.Destination].Value = Reader["Destination"];

                // Finally, update the last berth and row count control variables for the next iteration.
                
                LastBerth = Berth;
                Row++;
            }
            
            Reader.Close();
            int LastDataRow = Row - 1;

            if (LastDataRow > 0)
            {
                FpSpread1.Sheets[0].Rows.Add(Row, 1);
                ConfigureBerthTotals(FirstBerthRow, LastDataRow, Row);
                Row++;

                // I'm not sure why this is needed, but to ensure that all the data is visible without
                // scrolling (when browser size allows), I have to add some dummy rows and kick up the 
                // page size.
                
                int DummyRowsToAdd = 3;
                FpSpread1.Sheets[0].Rows.Add(Row, DummyRowsToAdd);
                FpSpread1.ActiveSheetView.PageSize = Row + DummyRowsToAdd;
                for (int i = 0; i < DummyRowsToAdd; i++)
                    FpSpread1.Sheets[0].Rows[Row + i].Locked = true;

                // Add the planned load values to the sheet.

                StringBuilder PpidList = new StringBuilder();
                foreach (KeyValuePair<int, ProjectRowData> Pair in ProjectToRowDataMap)
                    PpidList.AppendFormat("{0},", Pair.Key);
                if (PpidList.Length > 0)
                    PpidList.Length = PpidList.Length - 1;

                DateTime LeftDate = AnchorDate.Date, RightDate = AnchorDate.AddDays(DateColumns).Date;
                Query = String.Format(LOAD_QUERY, PpidList);
                Select = new SqlCommand(Query, Connection);
                Reader = Select.ExecuteReader();

                while (Reader.Read())
                {
                    int PPDID = Convert.ToInt32(Reader["PPDID"]);
                    int PPID = Convert.ToInt32(Reader["PPID Ref"]);
                    DateTime Date = Convert.ToDateTime(Reader["Date"]);
                    int NumLoads = Convert.ToInt32(Reader["Load Ct"]);

                    if (LeftDate <= Date && Date < RightDate)
                    {
                        int DateIndex = (Date.AddDays(1) - AnchorDate).Days;

                        if (ProjectToRowDataMap.ContainsKey(PPID))
                        {
                            ProjectRowData RowData = ProjectToRowDataMap[PPID];
                            int Column = (int)DataColumns.FirstDateColumn + DateIndex;
                            FpSpread1.Sheets[0].Cells[RowData.Row, Column].Value = NumLoads;
                            FpSpread1.Sheets[0].Cells[RowData.Row, Column].Tag = PPDID;
                        }
                        else
                        {
                            _Log.DebugFormat("PopulateSpreadsheet: invalid link from PPDID {0} to PPID {1}; {2} loads will not appear for date {3}.",
                                             PPDID, PPID, NumLoads, Convert.ToDateTime(Reader["Date"]));
                        }
                    }
                    else
                    {
                        if (ProjectToRowDataMap.ContainsKey(PPID))
                        {
                            ProjectRowData RowData = ProjectToRowDataMap[PPID];
                            RowData.PlanLoadsOffSheet += NumLoads;
                        }
                        else
                        {
                            _Log.DebugFormat("PopulateSpreadsheet: invalid link from PPDID {0} to PPID {1}; {2} loads too many for date {3} will be included in total plan.",
                                             PPDID, PPID, NumLoads, Convert.ToDateTime(Reader["Date"]));
                        }
                    }
                }

                Reader.Close();

                // Configure the plan loads column for each row, now that we have all the values.
                
                foreach (KeyValuePair<int, ProjectRowData> Pair in ProjectToRowDataMap)
                {
                    Cell ThisCell = FpSpread1.Sheets[0].Cells[Pair.Value.Row, (int)DataColumns.PlannedLoads];
                    string LeftCellRef = FpSpread1.Sheets[0].Cells[Pair.Value.Row, (int)DataColumns.FirstDateColumn].ToString(ThisCell);
                    string RightCellRef = FpSpread1.Sheets[0].Cells[Pair.Value.Row, (int)DataColumns.FirstDateColumn + DateColumns - 1].ToString(ThisCell);
                    string Formula = string.Format("{0} + SUM({1}:{2})", Pair.Value.PlanLoadsOffSheet, LeftCellRef, RightCellRef);
                    ThisCell.Formula = Formula;
                }
                
                // Finally, configure the totals row with the proper formulae.

                FpSpread1.Sheets[0].FrozenRowCount = 1;
                ConfigureTotalsRow(0, 1, (int)DataColumns.FirstDateColumn, LastDataRow, (int)DataColumns.FirstDateColumn + DateColumns - 1);

                PrevWeek.Enabled = true;
                NextWeek.Enabled = true;
            }
            else
            {
                _Log.Info("PopulateSpreadsheet: no projects found; providing help.");
                
                FpSpread1.ActiveSheetView.RowCount = 5;
                FpSpread1.ActiveSheetView.PageSize = 5;
                FpSpread1.ActiveSheetView.AddSpanCell(0, (int)DataColumns.ProjectId, 1, (int)DataColumns.FirstDateColumn);
                FpSpread1.Sheets[0].Cells[0, 0].Value = "No project data; try changing the filter settings.";

                // Lock the columns to prevent spurious updates.
                
                for (int i = 0; i < DateColumns; i++)
                    FpSpread1.Sheets[0].Columns[(int)DataColumns.FirstDateColumn + i].Locked = true;
                
                PrevWeek.Enabled = false;
                NextWeek.Enabled = false;
            }

            Connection.Close();
        }
    }

    private void HandleCellUpdate(int Row, int Column, string NewValue)
    {
        _Log.DebugFormat("HandleCellUpdate called with Row, Column, NewValue = {0}, {1}, {2}", Row, Column, NewValue);
        
        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            object CellTag = FpSpread1.Sheets[0].Cells[Row, Column].Tag;

            if (CellTag != null)
            {
                if (NewValue == "")
                {
                    int PPDID = Convert.ToInt32(CellTag);
                    _Log.DebugFormat("HandleCellUpdate cell had data, deleting where PPDID = {0}", PPDID);
                    string CommandString = string.Format(DELETE_LOAD_COUNT, PPDID);

                    Connection.Open();
                    SqlCommand Command = new SqlCommand(CommandString, Connection);
                    Command.ExecuteNonQuery();
                    Connection.Close();

                    FpSpread1.Sheets[0].Cells[Row, Column].Tag = null;
                }
                else
                {
                    int Loads = Convert.ToInt32(NewValue);
                    int PPDID = Convert.ToInt32(CellTag);
                    _Log.DebugFormat("HandleCellUpdate cell had data, updating where PPDID = {0}", PPDID);
                    string CommandString = string.Format(UPDATE_LOAD_COUNT, PPDID, Loads);

                    Connection.Open();
                    SqlCommand Command = new SqlCommand(CommandString, Connection);
                    Command.ExecuteNonQuery();
                    Connection.Close();
                }
            }
            else if (NewValue != string.Empty)
            {
                int Loads = Convert.ToInt32(NewValue);
                int PPID = Convert.ToInt32(FpSpread1.Sheets[0].Cells[Row, (int)DataColumns.ProjectId].Tag);
                DateTime ColumnDate = Convert.ToDateTime(FpSpread1.Columns[Column].Tag);
                string DateString = ColumnDate.ToString(DATE_FORMAT_FOR_QUERIES);
                _Log.DebugFormat("HandleCellUpdate cell was empty, inserting with PPID, Loads, Date = {0}, {1}, {2}", PPID, Loads, DateString);
                string CommandString = string.Format(INSERT_LOAD_COUNT, PPID, DateString, Loads);

                Connection.Open();
                SqlCommand Command = new SqlCommand(CommandString, Connection);
                int NewPPDID = Convert.ToInt32(Command.ExecuteScalar());
                Connection.Close();

                _Log.DebugFormat("HandleCellUpdate setting cell tag to new PPDID = {0}", NewPPDID);
                FpSpread1.Sheets[0].Cells[Row, Column].Tag = NewPPDID;
            }
        }
    }

    #endregion

    protected override void OnInit(EventArgs e)
    {
        _ExportButton = new Image();
        _ExportButton.Enabled = true;
        _ExportButton.Attributes.Add("onclick", "javascript:" + ClientScript.GetPostBackEventReference(FpSpread1, "Export") + "; return false;");
        _ExportButton.ImageUrl = "~/Controls/fp_client/fpspread/5_0_3524_2008/img/Save.gif";
        _ExportButton.ToolTip = "Export";
        FpSpread1.ButtonCommand += FpSpread1_ButtonCommand;

        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Add a refresh meta-tag to redraw the sheet every ten minutes.
            HtmlMeta RefreshTag = new HtmlMeta();
            RefreshTag.HttpEquiv = "refresh";
            RefreshTag.Content = "600";
            Header.Controls.Add(RefreshTag);

            ConfigureSpreadsheet();
            PopulateSpreadsheet();
        }            
    }
    
    protected void FpSpread1_UpdateCommand(object sender, SpreadCommandEventArgs e)
    {
        int ChangesDetected = 0;
        _Log.DebugFormat("FpSpread1_UpdateCommand: called with command name, argument = {0}, {1}", e.CommandName, e.CommandArgument);
        
        for (int Column = 0; Column < e.EditValues.Count; Column++)
        {
            if (!ReferenceEquals(e.EditValues[Column], FpSpread.Unchanged))
            {
                int Row = Convert.ToInt32(e.CommandArgument);
                HandleCellUpdate(Row, Column, e.EditValues[Column].ToString());
                ChangesDetected++;
            }
        }

        if (ChangesDetected == 0)
            _Log.Debug("FpSpread1_UpdateCommand: no changes detected.");
    }

    protected void PrevWeek_Click(object sender, EventArgs e)
    {
        DateTime NewAnchorDate = AnchorDate.AddDays(-7);
        _Log.DebugFormat("PrevWeek_Click: setting new anchor date = {0}", NewAnchorDate);
        AnchorDate = NewAnchorDate;
        FpSpread1.Sheets[0].RemoveRows(0, FpSpread1.Sheets[0].RowCount);
        ConfigureSpreadsheet();
        PopulateSpreadsheet();
    }

    protected void NextWeek_Click(object sender, EventArgs e)
    {
        DateTime NewAnchorDate = AnchorDate.AddDays(7);
        _Log.DebugFormat("NextWeek_Click: setting new anchor date = {0}", NewAnchorDate);
        AnchorDate = NewAnchorDate;
        FpSpread1.Sheets[0].RemoveRows(0, FpSpread1.Sheets[0].RowCount);
        ConfigureSpreadsheet();
        PopulateSpreadsheet();
    }

    private void FpSpread1_ButtonCommand(object sender, SpreadCommandEventArgs e)
    {
        if (e.CommandName == "Export" && e.Handled == false)
        {
            string FilePath = Path.Combine(Server.MapPath(""), "temp");
            if (!Directory.Exists(FilePath))
                Directory.CreateDirectory(FilePath);
            string FileName = "Hpp_" + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss") + ".xls";
            string OutputFile = Path.Combine(FilePath, FileName);

            bool OldProtect = FpSpread1.Sheets[0].Protect;
            FpSpread1.Sheets[0].Protect = false;
            FpSpread1.SaveExcel(OutputFile, IncludeHeaders.ColumnHeadersCustomOnly);
            FpSpread1.Sheets[0].Protect = OldProtect;

            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + FileName);
            Response.ContentType = "application/vnd.ms-excel";
            Response.Flush();
            Response.WriteFile(OutputFile); 
        }
    }
}
