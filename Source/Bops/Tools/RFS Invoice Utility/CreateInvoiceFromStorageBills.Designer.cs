namespace RFS_Invoice_Utility
{
    partial class CreateInvoiceFromStorageBills
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
            this._StorageSummaryListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader4 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader5 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this._StorageDetailsListview = new System.Windows.Forms.ListView();
            this.columnHeader6 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader7 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader8 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader9 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader10 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader11 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader12 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.label22 = new System.Windows.Forms.Label();
            this.label21 = new System.Windows.Forms.Label();
            this._InvoiceAllButton = new System.Windows.Forms.Button();
            this._InvoiceSelectedButton = new System.Windows.Forms.Button();
            this._Status = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this._RollbackSelectedButton = new System.Windows.Forms.Button();
            this._Status.SuspendLayout();
            this.SuspendLayout();
            // 
            // _StorageSummaryListview
            // 
            this._StorageSummaryListview.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this._StorageSummaryListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader4,
            this.columnHeader5});
            this._StorageSummaryListview.FullRowSelect = true;
            this._StorageSummaryListview.Location = new System.Drawing.Point(12, 25);
            this._StorageSummaryListview.MultiSelect = false;
            this._StorageSummaryListview.Name = "_StorageSummaryListview";
            this._StorageSummaryListview.Size = new System.Drawing.Size(881, 171);
            this._StorageSummaryListview.TabIndex = 1;
            this._StorageSummaryListview.UseCompatibleStateImageBehavior = false;
            this._StorageSummaryListview.View = System.Windows.Forms.View.Details;
            this._StorageSummaryListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this._StorageSummaryListview_ColumnClick);
            this._StorageSummaryListview.SelectedIndexChanged += new System.EventHandler(this._StorageSummaryListview_SelectedIndexChanged);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Bill-To";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Items";
            this.columnHeader4.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "Revenue";
            this.columnHeader5.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // _StorageDetailsListview
            // 
            this._StorageDetailsListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this._StorageDetailsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader6,
            this.columnHeader2,
            this.columnHeader7,
            this.columnHeader8,
            this.columnHeader9,
            this.columnHeader10,
            this.columnHeader11,
            this.columnHeader12});
            this._StorageDetailsListview.FullRowSelect = true;
            this._StorageDetailsListview.Location = new System.Drawing.Point(12, 215);
            this._StorageDetailsListview.Name = "_StorageDetailsListview";
            this._StorageDetailsListview.Size = new System.Drawing.Size(881, 270);
            this._StorageDetailsListview.TabIndex = 3;
            this._StorageDetailsListview.UseCompatibleStateImageBehavior = false;
            this._StorageDetailsListview.View = System.Windows.Forms.View.Details;
            this._StorageDetailsListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this._StorageDetailsListview_ColumnClick);
            this._StorageDetailsListview.SelectedIndexChanged += new System.EventHandler(this._StorageDetailsListview_SelectedIndexChanged);
            // 
            // columnHeader6
            // 
            this.columnHeader6.Text = "Inventory";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Bill Through Date";
            // 
            // columnHeader7
            // 
            this.columnHeader7.Text = "Receiver";
            this.columnHeader7.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader8
            // 
            this.columnHeader8.Text = "Profile";
            this.columnHeader8.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader9
            // 
            this.columnHeader9.Text = "Quantity";
            this.columnHeader9.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader10
            // 
            this.columnHeader10.Text = "Cycles";
            this.columnHeader10.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader11
            // 
            this.columnHeader11.Text = "Revenue";
            this.columnHeader11.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader12
            // 
            this.columnHeader12.Text = "Details";
            // 
            // label22
            // 
            this.label22.AutoSize = true;
            this.label22.Location = new System.Drawing.Point(12, 199);
            this.label22.Name = "label22";
            this.label22.Size = new System.Drawing.Size(109, 13);
            this.label22.TabIndex = 2;
            this.label22.Text = "Storage Billing Details";
            // 
            // label21
            // 
            this.label21.AutoSize = true;
            this.label21.Location = new System.Drawing.Point(12, 9);
            this.label21.Name = "label21";
            this.label21.Size = new System.Drawing.Size(120, 13);
            this.label21.TabIndex = 0;
            this.label21.Text = "Storage Billing Summary";
            // 
            // _InvoiceAllButton
            // 
            this._InvoiceAllButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this._InvoiceAllButton.Location = new System.Drawing.Point(12, 491);
            this._InvoiceAllButton.Name = "_InvoiceAllButton";
            this._InvoiceAllButton.Size = new System.Drawing.Size(190, 23);
            this._InvoiceAllButton.TabIndex = 4;
            this._InvoiceAllButton.Text = "Invoice All Details...";
            this._InvoiceAllButton.UseVisualStyleBackColor = true;
            this._InvoiceAllButton.Click += new System.EventHandler(this._InvoiceAllButton_Click);
            // 
            // _InvoiceSelectedButton
            // 
            this._InvoiceSelectedButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this._InvoiceSelectedButton.Location = new System.Drawing.Point(208, 491);
            this._InvoiceSelectedButton.Name = "_InvoiceSelectedButton";
            this._InvoiceSelectedButton.Size = new System.Drawing.Size(190, 23);
            this._InvoiceSelectedButton.TabIndex = 5;
            this._InvoiceSelectedButton.Text = "Invoice Selected Details...";
            this._InvoiceSelectedButton.UseVisualStyleBackColor = true;
            this._InvoiceSelectedButton.Click += new System.EventHandler(this._InvoiceSelectedButton_Click);
            // 
            // _Status
            // 
            this._Status.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this._Status.Location = new System.Drawing.Point(0, 522);
            this._Status.Name = "_Status";
            this._Status.Size = new System.Drawing.Size(905, 22);
            this._Status.TabIndex = 7;
            this._Status.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(179, 17);
            this.toolStripStatusLabel1.Text = "No storage bills found to invoice";
            // 
            // _RollbackSelectedButton
            // 
            this._RollbackSelectedButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this._RollbackSelectedButton.Location = new System.Drawing.Point(404, 491);
            this._RollbackSelectedButton.Name = "_RollbackSelectedButton";
            this._RollbackSelectedButton.Size = new System.Drawing.Size(190, 23);
            this._RollbackSelectedButton.TabIndex = 6;
            this._RollbackSelectedButton.Text = "Rollback Selected Details";
            this._RollbackSelectedButton.UseVisualStyleBackColor = true;
            this._RollbackSelectedButton.Visible = false;
            this._RollbackSelectedButton.Click += new System.EventHandler(this._RollbackSelectedButton_Click);
            // 
            // CreateInvoiceFromStorageBills
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(905, 544);
            this.Controls.Add(this._RollbackSelectedButton);
            this.Controls.Add(this._Status);
            this.Controls.Add(this._InvoiceSelectedButton);
            this.Controls.Add(this._InvoiceAllButton);
            this.Controls.Add(this.label22);
            this.Controls.Add(this.label21);
            this.Controls.Add(this._StorageDetailsListview);
            this.Controls.Add(this._StorageSummaryListview);
            this.Name = "CreateInvoiceFromStorageBills";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Create Invoice From Storage Bills";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.CreateInvoiceFromStorageBills_FormClosing);
            this.Load += new System.EventHandler(this.CreateInvoiceFromStorageBills_Load);
            this._Status.ResumeLayout(false);
            this._Status.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListView _StorageSummaryListview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.ListView _StorageDetailsListview;
        private System.Windows.Forms.ColumnHeader columnHeader6;
        private System.Windows.Forms.ColumnHeader columnHeader7;
        private System.Windows.Forms.ColumnHeader columnHeader8;
        private System.Windows.Forms.ColumnHeader columnHeader9;
        private System.Windows.Forms.ColumnHeader columnHeader10;
        private System.Windows.Forms.ColumnHeader columnHeader11;
        private System.Windows.Forms.ColumnHeader columnHeader12;
        private System.Windows.Forms.Label label22;
        private System.Windows.Forms.Label label21;
        private System.Windows.Forms.Button _InvoiceAllButton;
        private System.Windows.Forms.Button _InvoiceSelectedButton;
        private System.Windows.Forms.StatusStrip _Status;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.Button _RollbackSelectedButton;
        private System.Windows.Forms.ColumnHeader columnHeader2;
    }
}