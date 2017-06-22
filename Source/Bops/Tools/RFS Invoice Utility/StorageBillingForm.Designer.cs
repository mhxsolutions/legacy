namespace RFS_Invoice_Utility
{
    partial class StorageBillingForm
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
            this.GenerateBillingButton = new System.Windows.Forms.Button();
            this.ResultsListview = new System.Windows.Forms.ListView();
            this.columnHeader15 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader7 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader4 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader5 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader6 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader9 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader12 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader11 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader13 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader14 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this._StorageBillingContextMenustrip = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.copyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.disableItemStorageBillingToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.disableProfileStorageBillingToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.selectByProfileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.selectByReceiverToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label1 = new System.Windows.Forms.Label();
            this.BillThroughDatepicker = new System.Windows.Forms.DateTimePicker();
            this.SaveBillingButton = new System.Windows.Forms.Button();
            this._Status = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this._CopyButton = new System.Windows.Forms.Button();
            this._ExportButton = new System.Windows.Forms.Button();
            this._ShowSummaryButton = new System.Windows.Forms.Button();
            this.columnHeader3 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this._StorageBillingContextMenustrip.SuspendLayout();
            this._Status.SuspendLayout();
            this.SuspendLayout();
            // 
            // GenerateBillingButton
            // 
            this.GenerateBillingButton.Location = new System.Drawing.Point(313, 3);
            this.GenerateBillingButton.Name = "GenerateBillingButton";
            this.GenerateBillingButton.Size = new System.Drawing.Size(115, 23);
            this.GenerateBillingButton.TabIndex = 2;
            this.GenerateBillingButton.Text = "Generate Billing";
            this.GenerateBillingButton.UseVisualStyleBackColor = true;
            this.GenerateBillingButton.Click += new System.EventHandler(this.GenerateBillingButton_Click);
            // 
            // ResultsListview
            // 
            this.ResultsListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.ResultsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader15,
            this.columnHeader7,
            this.columnHeader1,
            this.columnHeader4,
            this.columnHeader5,
            this.columnHeader6,
            this.columnHeader9,
            this.columnHeader12,
            this.columnHeader2,
            this.columnHeader11,
            this.columnHeader13,
            this.columnHeader14,
            this.columnHeader3});
            this.ResultsListview.ContextMenuStrip = this._StorageBillingContextMenustrip;
            this.ResultsListview.FullRowSelect = true;
            this.ResultsListview.Location = new System.Drawing.Point(0, 32);
            this.ResultsListview.Name = "ResultsListview";
            this.ResultsListview.ShowItemToolTips = true;
            this.ResultsListview.Size = new System.Drawing.Size(984, 524);
            this.ResultsListview.TabIndex = 7;
            this.ResultsListview.UseCompatibleStateImageBehavior = false;
            this.ResultsListview.View = System.Windows.Forms.View.Details;
            this.ResultsListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.ResultsListview_ColumnClick);
            this.ResultsListview.SelectedIndexChanged += new System.EventHandler(this.ResultsListview_SelectedIndexChanged);
            // 
            // columnHeader15
            // 
            this.columnHeader15.Text = "Client";
            // 
            // columnHeader7
            // 
            this.columnHeader7.Text = "Profile ID";
            this.columnHeader7.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Inventory ID";
            this.columnHeader1.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Billed Through";
            this.columnHeader4.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "Receiver ID";
            this.columnHeader5.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.columnHeader5.Width = 103;
            // 
            // columnHeader6
            // 
            this.columnHeader6.Text = "Received";
            this.columnHeader6.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.columnHeader6.Width = 85;
            // 
            // columnHeader9
            // 
            this.columnHeader9.Text = "Billing Type";
            // 
            // columnHeader12
            // 
            this.columnHeader12.Text = "RFS";
            this.columnHeader12.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Quantity";
            this.columnHeader2.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader11
            // 
            this.columnHeader11.Text = "Avg Rate";
            this.columnHeader11.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader13
            // 
            this.columnHeader13.Text = "Cycles";
            this.columnHeader13.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader14
            // 
            this.columnHeader14.Text = "Revenue";
            this.columnHeader14.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // _StorageBillingContextMenustrip
            // 
            this._StorageBillingContextMenustrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.copyToolStripMenuItem,
            this.toolStripSeparator1,
            this.disableItemStorageBillingToolStripMenuItem,
            this.disableProfileStorageBillingToolStripMenuItem,
            this.toolStripSeparator2,
            this.selectByProfileToolStripMenuItem,
            this.selectByReceiverToolStripMenuItem});
            this._StorageBillingContextMenustrip.Name = "_StorageBillingContextMenustrip";
            this._StorageBillingContextMenustrip.Size = new System.Drawing.Size(238, 126);
            // 
            // copyToolStripMenuItem
            // 
            this.copyToolStripMenuItem.Name = "copyToolStripMenuItem";
            this.copyToolStripMenuItem.Size = new System.Drawing.Size(237, 22);
            this.copyToolStripMenuItem.Text = "Copy";
            this.copyToolStripMenuItem.Click += new System.EventHandler(this.copyToolStripMenuItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(234, 6);
            // 
            // disableItemStorageBillingToolStripMenuItem
            // 
            this.disableItemStorageBillingToolStripMenuItem.Name = "disableItemStorageBillingToolStripMenuItem";
            this.disableItemStorageBillingToolStripMenuItem.Size = new System.Drawing.Size(237, 22);
            this.disableItemStorageBillingToolStripMenuItem.Text = "Disable Item Storage Billing...";
            this.disableItemStorageBillingToolStripMenuItem.Click += new System.EventHandler(this.disableItemStorageBillingToolStripMenuItem_Click);
            // 
            // disableProfileStorageBillingToolStripMenuItem
            // 
            this.disableProfileStorageBillingToolStripMenuItem.Name = "disableProfileStorageBillingToolStripMenuItem";
            this.disableProfileStorageBillingToolStripMenuItem.Size = new System.Drawing.Size(237, 22);
            this.disableProfileStorageBillingToolStripMenuItem.Text = "Disable Profile Storage Billing...";
            this.disableProfileStorageBillingToolStripMenuItem.Click += new System.EventHandler(this.disableProfileStorageBillingToolStripMenuItem_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(234, 6);
            // 
            // selectByProfileToolStripMenuItem
            // 
            this.selectByProfileToolStripMenuItem.Name = "selectByProfileToolStripMenuItem";
            this.selectByProfileToolStripMenuItem.Size = new System.Drawing.Size(237, 22);
            this.selectByProfileToolStripMenuItem.Text = "Select By Profile...";
            this.selectByProfileToolStripMenuItem.Click += new System.EventHandler(this.selectByProfileToolStripMenuItem_Click);
            // 
            // selectByReceiverToolStripMenuItem
            // 
            this.selectByReceiverToolStripMenuItem.Name = "selectByReceiverToolStripMenuItem";
            this.selectByReceiverToolStripMenuItem.Size = new System.Drawing.Size(237, 22);
            this.selectByReceiverToolStripMenuItem.Text = "Select By Receiver...";
            this.selectByReceiverToolStripMenuItem.Click += new System.EventHandler(this.selectByReceiverToolStripMenuItem_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 10);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(92, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Bill Through Date:";
            // 
            // BillThroughDatepicker
            // 
            this.BillThroughDatepicker.Location = new System.Drawing.Point(107, 6);
            this.BillThroughDatepicker.Name = "BillThroughDatepicker";
            this.BillThroughDatepicker.Size = new System.Drawing.Size(200, 20);
            this.BillThroughDatepicker.TabIndex = 1;
            // 
            // SaveBillingButton
            // 
            this.SaveBillingButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.SaveBillingButton.Enabled = false;
            this.SaveBillingButton.Location = new System.Drawing.Point(857, 3);
            this.SaveBillingButton.Name = "SaveBillingButton";
            this.SaveBillingButton.Size = new System.Drawing.Size(115, 23);
            this.SaveBillingButton.TabIndex = 6;
            this.SaveBillingButton.Text = "Save Billing";
            this.SaveBillingButton.UseVisualStyleBackColor = true;
            this.SaveBillingButton.Click += new System.EventHandler(this.SaveBillingButton_Click);
            // 
            // _Status
            // 
            this._Status.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this._Status.Location = new System.Drawing.Point(0, 559);
            this._Status.Name = "_Status";
            this._Status.Size = new System.Drawing.Size(984, 22);
            this._Status.TabIndex = 8;
            this._Status.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(122, 17);
            this.toolStripStatusLabel1.Text = "(no results generated)";
            // 
            // _CopyButton
            // 
            this._CopyButton.Location = new System.Drawing.Point(434, 3);
            this._CopyButton.Name = "_CopyButton";
            this._CopyButton.Size = new System.Drawing.Size(115, 23);
            this._CopyButton.TabIndex = 3;
            this._CopyButton.Text = "Copy to Clipboard";
            this._CopyButton.UseVisualStyleBackColor = true;
            this._CopyButton.Click += new System.EventHandler(this._CopyButton_Click);
            // 
            // _ExportButton
            // 
            this._ExportButton.Location = new System.Drawing.Point(555, 3);
            this._ExportButton.Name = "_ExportButton";
            this._ExportButton.Size = new System.Drawing.Size(115, 23);
            this._ExportButton.TabIndex = 4;
            this._ExportButton.Text = "Export to File...";
            this._ExportButton.UseVisualStyleBackColor = true;
            this._ExportButton.Click += new System.EventHandler(this._ExportButton_Click);
            // 
            // _ShowSummaryButton
            // 
            this._ShowSummaryButton.Location = new System.Drawing.Point(677, 3);
            this._ShowSummaryButton.Name = "_ShowSummaryButton";
            this._ShowSummaryButton.Size = new System.Drawing.Size(115, 23);
            this._ShowSummaryButton.TabIndex = 5;
            this._ShowSummaryButton.Text = "Show Summary...";
            this._ShowSummaryButton.UseVisualStyleBackColor = true;
            this._ShowSummaryButton.Click += new System.EventHandler(this._ShowSummaryButton_Click);
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Company ID";
            // 
            // StorageBillingForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(984, 581);
            this.Controls.Add(this._ShowSummaryButton);
            this.Controls.Add(this._ExportButton);
            this.Controls.Add(this._CopyButton);
            this.Controls.Add(this._Status);
            this.Controls.Add(this.GenerateBillingButton);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.SaveBillingButton);
            this.Controls.Add(this.BillThroughDatepicker);
            this.Controls.Add(this.ResultsListview);
            this.KeyPreview = true;
            this.Name = "StorageBillingForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Generate Storage Billing";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.StorageBillingForm_FormClosing);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.StorageBillingForm_KeyDown);
            this._StorageBillingContextMenustrip.ResumeLayout(false);
            this._Status.ResumeLayout(false);
            this._Status.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button GenerateBillingButton;
        private System.Windows.Forms.ListView ResultsListview;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker BillThroughDatepicker;
        private System.Windows.Forms.Button SaveBillingButton;
        private System.Windows.Forms.StatusStrip _Status;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.ColumnHeader columnHeader6;
        private System.Windows.Forms.ColumnHeader columnHeader7;
        private System.Windows.Forms.ColumnHeader columnHeader9;
        private System.Windows.Forms.ColumnHeader columnHeader11;
        private System.Windows.Forms.ColumnHeader columnHeader12;
        private System.Windows.Forms.ColumnHeader columnHeader13;
        private System.Windows.Forms.ColumnHeader columnHeader14;
        private System.Windows.Forms.ContextMenuStrip _StorageBillingContextMenustrip;
        private System.Windows.Forms.ToolStripMenuItem copyToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem disableItemStorageBillingToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem disableProfileStorageBillingToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem selectByProfileToolStripMenuItem;
        private System.Windows.Forms.Button _CopyButton;
        private System.Windows.Forms.Button _ExportButton;
        private System.Windows.Forms.ColumnHeader columnHeader15;
        private System.Windows.Forms.Button _ShowSummaryButton;
        private System.Windows.Forms.ToolStripMenuItem selectByReceiverToolStripMenuItem;
        private System.Windows.Forms.ColumnHeader columnHeader3;
    }
}