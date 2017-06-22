namespace Driver_Event_Scrubber
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
            this._PlanDatePicker = new System.Windows.Forms.DateTimePicker();
            this.label2 = new System.Windows.Forms.Label();
            this._LookupButton = new System.Windows.Forms.Button();
            this._PlanListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader5 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader6 = new System.Windows.Forms.ColumnHeader();
            this._DriverContextMenu = new System.Windows.Forms.ContextMenuStrip(this.components);
            this._AnalyzeToClipboardMenuitem = new System.Windows.Forms.ToolStripMenuItem();
            this._DriverContextMenu.SuspendLayout();
            this.SuspendLayout();
            // 
            // _PlanDatePicker
            // 
            this._PlanDatePicker.Location = new System.Drawing.Point(75, 12);
            this._PlanDatePicker.Name = "_PlanDatePicker";
            this._PlanDatePicker.Size = new System.Drawing.Size(212, 20);
            this._PlanDatePicker.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 18);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(57, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Plan Date:";
            // 
            // _LookupButton
            // 
            this._LookupButton.Location = new System.Drawing.Point(293, 9);
            this._LookupButton.Name = "_LookupButton";
            this._LookupButton.Size = new System.Drawing.Size(75, 23);
            this._LookupButton.TabIndex = 4;
            this._LookupButton.Text = "Lookup Plan";
            this._LookupButton.UseVisualStyleBackColor = true;
            this._LookupButton.Click += new System.EventHandler(this._LookupButton_Click);
            // 
            // _PlanListview
            // 
            this._PlanListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._PlanListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5,
            this.columnHeader6});
            this._PlanListview.ContextMenuStrip = this._DriverContextMenu;
            this._PlanListview.FullRowSelect = true;
            this._PlanListview.Location = new System.Drawing.Point(12, 38);
            this._PlanListview.Name = "_PlanListview";
            this._PlanListview.Size = new System.Drawing.Size(657, 323);
            this._PlanListview.TabIndex = 5;
            this._PlanListview.UseCompatibleStateImageBehavior = false;
            this._PlanListview.View = System.Windows.Forms.View.Details;
            this._PlanListview.DoubleClick += new System.EventHandler(this._PlanListview_DoubleClick);
            this._PlanListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this._PlanListview_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Last Name";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "First Name";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Fleet";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Origins";
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "Destinations";
            // 
            // columnHeader6
            // 
            this.columnHeader6.Text = "Location Datapoints";
            // 
            // _DriverContextMenu
            // 
            this._DriverContextMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._AnalyzeToClipboardMenuitem});
            this._DriverContextMenu.Name = "_DriverContextMenu";
            this._DriverContextMenu.Size = new System.Drawing.Size(185, 26);
            // 
            // _AnalyzeToClipboardMenuitem
            // 
            this._AnalyzeToClipboardMenuitem.Name = "_AnalyzeToClipboardMenuitem";
            this._AnalyzeToClipboardMenuitem.Size = new System.Drawing.Size(184, 22);
            this._AnalyzeToClipboardMenuitem.Text = "Analyze to Clipboard";
            this._AnalyzeToClipboardMenuitem.Click += new System.EventHandler(this._AnalyzeToClipboardMenuitem_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(684, 374);
            this.Controls.Add(this._PlanListview);
            this.Controls.Add(this._LookupButton);
            this.Controls.Add(this.label2);
            this.Controls.Add(this._PlanDatePicker);
            this.Name = "MainForm";
            this.Text = "Driver Event Scrubber";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this._DriverContextMenu.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DateTimePicker _PlanDatePicker;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button _LookupButton;
        private System.Windows.Forms.ListView _PlanListview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.ColumnHeader columnHeader6;
        private System.Windows.Forms.ContextMenuStrip _DriverContextMenu;
        private System.Windows.Forms.ToolStripMenuItem _AnalyzeToClipboardMenuitem;
    }
}

