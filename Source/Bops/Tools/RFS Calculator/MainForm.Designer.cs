namespace RFS_Calculator
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.FindCalculableLoads = new System.Windows.Forms.Button();
            this.LoadsListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader3 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader4 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader5 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader6 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader7 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader8 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader9 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.LoadsContextMenuStrip = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.AssignRfsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.CalculateSelectedLoads = new System.Windows.Forms.Button();
            this.BeginDate = new System.Windows.Forms.DateTimePicker();
            this.EndDate = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStripProgressBar1 = new System.Windows.Forms.ToolStripProgressBar();
            this.SelectZeroRevenueLoads = new System.Windows.Forms.Button();
            this.CalculateAllLoads = new System.Windows.Forms.Button();
            this.SetEndDateToBeginDateButton = new System.Windows.Forms.Button();
            this.SetBeginDateToEndDateButton = new System.Windows.Forms.Button();
            this.CategoriesTabcontrol = new System.Windows.Forms.TabControl();
            this.LoadsTab = new System.Windows.Forms.TabPage();
            this.WarehouseTab = new System.Windows.Forms.TabPage();
            this.WarehouseListview = new System.Windows.Forms.ListView();
            this.columnHeader10 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader11 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader12 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader13 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader14 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader15 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader16 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.FindCalculableWarehouseButton = new System.Windows.Forms.Button();
            this.CalculateSelectedWarehouseButton = new System.Windows.Forms.Button();
            this.CalculateAllWarehouseButton = new System.Windows.Forms.Button();
            this.SelectZeroRevenueWarehouseButton = new System.Windows.Forms.Button();
            this.LoadsContextMenuStrip.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.CategoriesTabcontrol.SuspendLayout();
            this.LoadsTab.SuspendLayout();
            this.WarehouseTab.SuspendLayout();
            this.SuspendLayout();
            // 
            // FindCalculableLoads
            // 
            this.FindCalculableLoads.Location = new System.Drawing.Point(4, 6);
            this.FindCalculableLoads.Name = "FindCalculableLoads";
            this.FindCalculableLoads.Size = new System.Drawing.Size(165, 23);
            this.FindCalculableLoads.TabIndex = 0;
            this.FindCalculableLoads.Text = "Find Calculable Loads";
            this.FindCalculableLoads.UseVisualStyleBackColor = true;
            this.FindCalculableLoads.Click += new System.EventHandler(this.FindCalculableLoads_Click);
            // 
            // LoadsListview
            // 
            this.LoadsListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.LoadsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5,
            this.columnHeader6,
            this.columnHeader7,
            this.columnHeader8,
            this.columnHeader9});
            this.LoadsListview.ContextMenuStrip = this.LoadsContextMenuStrip;
            this.LoadsListview.FullRowSelect = true;
            this.LoadsListview.GridLines = true;
            this.LoadsListview.Location = new System.Drawing.Point(6, 42);
            this.LoadsListview.Name = "LoadsListview";
            this.LoadsListview.Size = new System.Drawing.Size(679, 355);
            this.LoadsListview.Sorting = System.Windows.Forms.SortOrder.Ascending;
            this.LoadsListview.TabIndex = 4;
            this.LoadsListview.UseCompatibleStateImageBehavior = false;
            this.LoadsListview.View = System.Windows.Forms.View.Details;
            this.LoadsListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.LoadsListview_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Driver";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Load";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Load Date";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "BOL";
            this.columnHeader4.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "PUR";
            this.columnHeader5.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader6
            // 
            this.columnHeader6.Text = "Origin";
            this.columnHeader6.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader7
            // 
            this.columnHeader7.Text = "Destination";
            this.columnHeader7.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader8
            // 
            this.columnHeader8.Text = "RFS";
            this.columnHeader8.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader9
            // 
            this.columnHeader9.Text = "Revenue";
            this.columnHeader9.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // LoadsContextMenuStrip
            // 
            this.LoadsContextMenuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.AssignRfsToolStripMenuItem});
            this.LoadsContextMenuStrip.Name = "LoadsContextMenuStrip";
            this.LoadsContextMenuStrip.Size = new System.Drawing.Size(141, 26);
            this.LoadsContextMenuStrip.Opening += new System.ComponentModel.CancelEventHandler(this.LoadsContextMenuStrip_Opening);
            // 
            // AssignRfsToolStripMenuItem
            // 
            this.AssignRfsToolStripMenuItem.Name = "AssignRfsToolStripMenuItem";
            this.AssignRfsToolStripMenuItem.Size = new System.Drawing.Size(140, 22);
            this.AssignRfsToolStripMenuItem.Text = "Assign RFS...";
            this.AssignRfsToolStripMenuItem.Click += new System.EventHandler(this.AssignRfsToolStripMenuItem_Click);
            // 
            // CalculateSelectedLoads
            // 
            this.CalculateSelectedLoads.Location = new System.Drawing.Point(175, 6);
            this.CalculateSelectedLoads.Name = "CalculateSelectedLoads";
            this.CalculateSelectedLoads.Size = new System.Drawing.Size(165, 23);
            this.CalculateSelectedLoads.TabIndex = 1;
            this.CalculateSelectedLoads.Text = "Calculate Selected Loads";
            this.CalculateSelectedLoads.UseVisualStyleBackColor = true;
            this.CalculateSelectedLoads.Click += new System.EventHandler(this.CalculateSelectedLoads_Click);
            // 
            // BeginDate
            // 
            this.BeginDate.Location = new System.Drawing.Point(84, 10);
            this.BeginDate.Name = "BeginDate";
            this.BeginDate.Size = new System.Drawing.Size(200, 20);
            this.BeginDate.TabIndex = 1;
            // 
            // EndDate
            // 
            this.EndDate.Location = new System.Drawing.Point(487, 10);
            this.EndDate.Name = "EndDate";
            this.EndDate.Size = new System.Drawing.Size(200, 20);
            this.EndDate.TabIndex = 5;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(15, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Begin Date:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(426, 13);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(55, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "End Date:";
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1,
            this.toolStripProgressBar1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 485);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(728, 22);
            this.statusStrip1.TabIndex = 7;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(713, 17);
            this.toolStripStatusLabel1.Spring = true;
            this.toolStripStatusLabel1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // toolStripProgressBar1
            // 
            this.toolStripProgressBar1.Name = "toolStripProgressBar1";
            this.toolStripProgressBar1.Size = new System.Drawing.Size(100, 16);
            this.toolStripProgressBar1.Visible = false;
            // 
            // SelectZeroRevenueLoads
            // 
            this.SelectZeroRevenueLoads.Location = new System.Drawing.Point(346, 6);
            this.SelectZeroRevenueLoads.Name = "SelectZeroRevenueLoads";
            this.SelectZeroRevenueLoads.Size = new System.Drawing.Size(165, 23);
            this.SelectZeroRevenueLoads.TabIndex = 2;
            this.SelectZeroRevenueLoads.Text = "Select Zero Revenue Loads";
            this.SelectZeroRevenueLoads.UseVisualStyleBackColor = true;
            this.SelectZeroRevenueLoads.Click += new System.EventHandler(this.SelectZeroRevenueLoads_Click);
            // 
            // CalculateAllLoads
            // 
            this.CalculateAllLoads.Location = new System.Drawing.Point(517, 6);
            this.CalculateAllLoads.Name = "CalculateAllLoads";
            this.CalculateAllLoads.Size = new System.Drawing.Size(165, 23);
            this.CalculateAllLoads.TabIndex = 3;
            this.CalculateAllLoads.Text = "Calculate All Loads";
            this.CalculateAllLoads.UseVisualStyleBackColor = true;
            this.CalculateAllLoads.Click += new System.EventHandler(this.CalculateAllLoads_Click);
            // 
            // SetEndDateToBeginDateButton
            // 
            this.SetEndDateToBeginDateButton.Location = new System.Drawing.Point(290, 9);
            this.SetEndDateToBeginDateButton.Name = "SetEndDateToBeginDateButton";
            this.SetEndDateToBeginDateButton.Size = new System.Drawing.Size(55, 23);
            this.SetEndDateToBeginDateButton.TabIndex = 2;
            this.SetEndDateToBeginDateButton.Text = ">>";
            this.SetEndDateToBeginDateButton.UseVisualStyleBackColor = true;
            this.SetEndDateToBeginDateButton.Click += new System.EventHandler(this.SetEndDateToBeginDateButton_Click);
            // 
            // SetBeginDateToEndDateButton
            // 
            this.SetBeginDateToEndDateButton.Location = new System.Drawing.Point(365, 9);
            this.SetBeginDateToEndDateButton.Name = "SetBeginDateToEndDateButton";
            this.SetBeginDateToEndDateButton.Size = new System.Drawing.Size(55, 23);
            this.SetBeginDateToEndDateButton.TabIndex = 3;
            this.SetBeginDateToEndDateButton.Text = "<<";
            this.SetBeginDateToEndDateButton.UseVisualStyleBackColor = true;
            this.SetBeginDateToEndDateButton.Click += new System.EventHandler(this.SetBeginDateToEndDateButton_Click);
            // 
            // CategoriesTabcontrol
            // 
            this.CategoriesTabcontrol.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.CategoriesTabcontrol.Controls.Add(this.LoadsTab);
            this.CategoriesTabcontrol.Controls.Add(this.WarehouseTab);
            this.CategoriesTabcontrol.Location = new System.Drawing.Point(12, 38);
            this.CategoriesTabcontrol.Name = "CategoriesTabcontrol";
            this.CategoriesTabcontrol.SelectedIndex = 0;
            this.CategoriesTabcontrol.Size = new System.Drawing.Size(704, 429);
            this.CategoriesTabcontrol.TabIndex = 6;
            // 
            // LoadsTab
            // 
            this.LoadsTab.Controls.Add(this.LoadsListview);
            this.LoadsTab.Controls.Add(this.FindCalculableLoads);
            this.LoadsTab.Controls.Add(this.CalculateSelectedLoads);
            this.LoadsTab.Controls.Add(this.CalculateAllLoads);
            this.LoadsTab.Controls.Add(this.SelectZeroRevenueLoads);
            this.LoadsTab.Location = new System.Drawing.Point(4, 22);
            this.LoadsTab.Name = "LoadsTab";
            this.LoadsTab.Padding = new System.Windows.Forms.Padding(3);
            this.LoadsTab.Size = new System.Drawing.Size(696, 403);
            this.LoadsTab.TabIndex = 0;
            this.LoadsTab.Text = "Loads";
            this.LoadsTab.UseVisualStyleBackColor = true;
            // 
            // WarehouseTab
            // 
            this.WarehouseTab.Controls.Add(this.WarehouseListview);
            this.WarehouseTab.Controls.Add(this.FindCalculableWarehouseButton);
            this.WarehouseTab.Controls.Add(this.CalculateSelectedWarehouseButton);
            this.WarehouseTab.Controls.Add(this.CalculateAllWarehouseButton);
            this.WarehouseTab.Controls.Add(this.SelectZeroRevenueWarehouseButton);
            this.WarehouseTab.Location = new System.Drawing.Point(4, 22);
            this.WarehouseTab.Name = "WarehouseTab";
            this.WarehouseTab.Padding = new System.Windows.Forms.Padding(3);
            this.WarehouseTab.Size = new System.Drawing.Size(696, 403);
            this.WarehouseTab.TabIndex = 1;
            this.WarehouseTab.Text = "Warehouse";
            this.WarehouseTab.UseVisualStyleBackColor = true;
            // 
            // WarehouseListview
            // 
            this.WarehouseListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.WarehouseListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader10,
            this.columnHeader11,
            this.columnHeader12,
            this.columnHeader13,
            this.columnHeader14,
            this.columnHeader15,
            this.columnHeader16});
            this.WarehouseListview.FullRowSelect = true;
            this.WarehouseListview.GridLines = true;
            this.WarehouseListview.Location = new System.Drawing.Point(6, 42);
            this.WarehouseListview.Name = "WarehouseListview";
            this.WarehouseListview.Size = new System.Drawing.Size(679, 355);
            this.WarehouseListview.Sorting = System.Windows.Forms.SortOrder.Ascending;
            this.WarehouseListview.TabIndex = 9;
            this.WarehouseListview.UseCompatibleStateImageBehavior = false;
            this.WarehouseListview.View = System.Windows.Forms.View.Details;
            this.WarehouseListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.WarehouseListview_ColumnClick);
            // 
            // columnHeader10
            // 
            this.columnHeader10.Text = "Document ID";
            this.columnHeader10.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.columnHeader10.Width = 93;
            // 
            // columnHeader11
            // 
            this.columnHeader11.Text = "Type";
            // 
            // columnHeader12
            // 
            this.columnHeader12.Text = "Date";
            this.columnHeader12.Width = 83;
            // 
            // columnHeader13
            // 
            this.columnHeader13.Text = "Shipper";
            this.columnHeader13.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader14
            // 
            this.columnHeader14.Text = "Receiver";
            this.columnHeader14.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader15
            // 
            this.columnHeader15.Text = "RFS";
            this.columnHeader15.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader16
            // 
            this.columnHeader16.Text = "Revenue";
            this.columnHeader16.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // FindCalculableWarehouseButton
            // 
            this.FindCalculableWarehouseButton.Location = new System.Drawing.Point(4, 6);
            this.FindCalculableWarehouseButton.Name = "FindCalculableWarehouseButton";
            this.FindCalculableWarehouseButton.Size = new System.Drawing.Size(165, 23);
            this.FindCalculableWarehouseButton.TabIndex = 5;
            this.FindCalculableWarehouseButton.Text = "Find Calculable Warehouse";
            this.FindCalculableWarehouseButton.UseVisualStyleBackColor = true;
            this.FindCalculableWarehouseButton.Click += new System.EventHandler(this.FindCalculableWarehouseButton_Click);
            // 
            // CalculateSelectedWarehouseButton
            // 
            this.CalculateSelectedWarehouseButton.Location = new System.Drawing.Point(175, 6);
            this.CalculateSelectedWarehouseButton.Name = "CalculateSelectedWarehouseButton";
            this.CalculateSelectedWarehouseButton.Size = new System.Drawing.Size(165, 23);
            this.CalculateSelectedWarehouseButton.TabIndex = 6;
            this.CalculateSelectedWarehouseButton.Text = "Calculate Selected Warehouse";
            this.CalculateSelectedWarehouseButton.UseVisualStyleBackColor = true;
            this.CalculateSelectedWarehouseButton.Click += new System.EventHandler(this.CalculateSelectedWarehouseButton_Click);
            // 
            // CalculateAllWarehouseButton
            // 
            this.CalculateAllWarehouseButton.Location = new System.Drawing.Point(517, 6);
            this.CalculateAllWarehouseButton.Name = "CalculateAllWarehouseButton";
            this.CalculateAllWarehouseButton.Size = new System.Drawing.Size(165, 23);
            this.CalculateAllWarehouseButton.TabIndex = 8;
            this.CalculateAllWarehouseButton.Text = "Calculate All Warehouse";
            this.CalculateAllWarehouseButton.UseVisualStyleBackColor = true;
            this.CalculateAllWarehouseButton.Click += new System.EventHandler(this.CalculateAllWarehouseButton_Click);
            // 
            // SelectZeroRevenueWarehouseButton
            // 
            this.SelectZeroRevenueWarehouseButton.Location = new System.Drawing.Point(346, 6);
            this.SelectZeroRevenueWarehouseButton.Name = "SelectZeroRevenueWarehouseButton";
            this.SelectZeroRevenueWarehouseButton.Size = new System.Drawing.Size(165, 23);
            this.SelectZeroRevenueWarehouseButton.TabIndex = 7;
            this.SelectZeroRevenueWarehouseButton.Text = "Select Zero Revenue Items";
            this.SelectZeroRevenueWarehouseButton.UseVisualStyleBackColor = true;
            this.SelectZeroRevenueWarehouseButton.Click += new System.EventHandler(this.SelectZeroRevenueWarehouseButton_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(728, 507);
            this.Controls.Add(this.CategoriesTabcontrol);
            this.Controls.Add(this.SetBeginDateToEndDateButton);
            this.Controls.Add(this.SetEndDateToBeginDateButton);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.EndDate);
            this.Controls.Add(this.BeginDate);
            this.Name = "MainForm";
            this.Text = "RFS Calculator";
            this.LoadsContextMenuStrip.ResumeLayout(false);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.CategoriesTabcontrol.ResumeLayout(false);
            this.LoadsTab.ResumeLayout(false);
            this.WarehouseTab.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button FindCalculableLoads;
        private System.Windows.Forms.ListView LoadsListview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.Button CalculateSelectedLoads;
        private System.Windows.Forms.DateTimePicker BeginDate;
        private System.Windows.Forms.DateTimePicker EndDate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.ColumnHeader columnHeader6;
        private System.Windows.Forms.ColumnHeader columnHeader7;
        private System.Windows.Forms.ColumnHeader columnHeader8;
        private System.Windows.Forms.ColumnHeader columnHeader9;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.ToolStripProgressBar toolStripProgressBar1;
        private System.Windows.Forms.Button SelectZeroRevenueLoads;
        private System.Windows.Forms.Button CalculateAllLoads;
        private System.Windows.Forms.Button SetEndDateToBeginDateButton;
        private System.Windows.Forms.Button SetBeginDateToEndDateButton;
        private System.Windows.Forms.TabControl CategoriesTabcontrol;
        private System.Windows.Forms.TabPage LoadsTab;
        private System.Windows.Forms.TabPage WarehouseTab;
        private System.Windows.Forms.ListView WarehouseListview;
        private System.Windows.Forms.ColumnHeader columnHeader10;
        private System.Windows.Forms.ColumnHeader columnHeader11;
        private System.Windows.Forms.ColumnHeader columnHeader12;
        private System.Windows.Forms.ColumnHeader columnHeader13;
        private System.Windows.Forms.ColumnHeader columnHeader14;
        private System.Windows.Forms.ColumnHeader columnHeader15;
        private System.Windows.Forms.ColumnHeader columnHeader16;
        private System.Windows.Forms.Button FindCalculableWarehouseButton;
        private System.Windows.Forms.Button CalculateSelectedWarehouseButton;
        private System.Windows.Forms.Button CalculateAllWarehouseButton;
        private System.Windows.Forms.Button SelectZeroRevenueWarehouseButton;
        private System.Windows.Forms.ContextMenuStrip LoadsContextMenuStrip;
        private System.Windows.Forms.ToolStripMenuItem AssignRfsToolStripMenuItem;
    }
}

