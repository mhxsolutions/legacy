namespace RFS_Invoice_Utility
{
    partial class StorageBillingSummaryForm
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
            this._StorageDetailsListview = new System.Windows.Forms.ListView();
            this.columnHeader38 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader39 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader40 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader41 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader42 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader43 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader44 = new System.Windows.Forms.ColumnHeader();
            this.label22 = new System.Windows.Forms.Label();
            this._StorageSummaryListview = new System.Windows.Forms.ListView();
            this.columnHeader33 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader34 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader35 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader36 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader37 = new System.Windows.Forms.ColumnHeader();
            this.label21 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // _StorageDetailsListview
            // 
            this._StorageDetailsListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._StorageDetailsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader38,
            this.columnHeader39,
            this.columnHeader40,
            this.columnHeader41,
            this.columnHeader42,
            this.columnHeader43,
            this.columnHeader44});
            this._StorageDetailsListview.FullRowSelect = true;
            this._StorageDetailsListview.Location = new System.Drawing.Point(12, 213);
            this._StorageDetailsListview.Name = "_StorageDetailsListview";
            this._StorageDetailsListview.Size = new System.Drawing.Size(636, 236);
            this._StorageDetailsListview.TabIndex = 10;
            this._StorageDetailsListview.UseCompatibleStateImageBehavior = false;
            this._StorageDetailsListview.View = System.Windows.Forms.View.Details;
            this._StorageDetailsListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this._StorageDetailsListview_ColumnClick);
            // 
            // columnHeader38
            // 
            this.columnHeader38.Text = "Inventory";
            // 
            // columnHeader39
            // 
            this.columnHeader39.Text = "Receiver";
            this.columnHeader39.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader40
            // 
            this.columnHeader40.Text = "Profile";
            this.columnHeader40.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader41
            // 
            this.columnHeader41.Text = "Quantity";
            this.columnHeader41.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader42
            // 
            this.columnHeader42.Text = "Cycles";
            this.columnHeader42.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader43
            // 
            this.columnHeader43.Text = "Revenue";
            this.columnHeader43.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader44
            // 
            this.columnHeader44.Text = "Details";
            // 
            // label22
            // 
            this.label22.AutoSize = true;
            this.label22.Location = new System.Drawing.Point(12, 197);
            this.label22.Name = "label22";
            this.label22.Size = new System.Drawing.Size(109, 13);
            this.label22.TabIndex = 9;
            this.label22.Text = "Storage Billing Details";
            // 
            // _StorageSummaryListview
            // 
            this._StorageSummaryListview.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._StorageSummaryListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader33,
            this.columnHeader34,
            this.columnHeader35,
            this.columnHeader36,
            this.columnHeader37});
            this._StorageSummaryListview.FullRowSelect = true;
            this._StorageSummaryListview.Location = new System.Drawing.Point(12, 22);
            this._StorageSummaryListview.MultiSelect = false;
            this._StorageSummaryListview.Name = "_StorageSummaryListview";
            this._StorageSummaryListview.Size = new System.Drawing.Size(636, 168);
            this._StorageSummaryListview.TabIndex = 8;
            this._StorageSummaryListview.UseCompatibleStateImageBehavior = false;
            this._StorageSummaryListview.View = System.Windows.Forms.View.Details;
            this._StorageSummaryListview.SelectedIndexChanged += new System.EventHandler(this._StorageSummaryListview_SelectedIndexChanged);
            this._StorageSummaryListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this._StorageSummaryListview_ColumnClick);
            // 
            // columnHeader33
            // 
            this.columnHeader33.Text = "Profile";
            // 
            // columnHeader34
            // 
            this.columnHeader34.Text = "Bill-To";
            // 
            // columnHeader35
            // 
            this.columnHeader35.Text = "Description";
            // 
            // columnHeader36
            // 
            this.columnHeader36.Text = "Items";
            this.columnHeader36.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader37
            // 
            this.columnHeader37.Text = "Revenue";
            this.columnHeader37.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // label21
            // 
            this.label21.AutoSize = true;
            this.label21.Location = new System.Drawing.Point(9, 5);
            this.label21.Name = "label21";
            this.label21.Size = new System.Drawing.Size(120, 13);
            this.label21.TabIndex = 7;
            this.label21.Text = "Storage Billing Summary";
            // 
            // StorageBillingSummaryForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(660, 461);
            this.Controls.Add(this._StorageDetailsListview);
            this.Controls.Add(this.label22);
            this.Controls.Add(this._StorageSummaryListview);
            this.Controls.Add(this.label21);
            this.MinimumSize = new System.Drawing.Size(676, 497);
            this.Name = "StorageBillingSummaryForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Storage Billing Summary";
            this.Load += new System.EventHandler(this.StorageBillingSummaryForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListView _StorageDetailsListview;
        private System.Windows.Forms.ColumnHeader columnHeader38;
        private System.Windows.Forms.ColumnHeader columnHeader39;
        private System.Windows.Forms.ColumnHeader columnHeader40;
        private System.Windows.Forms.ColumnHeader columnHeader41;
        private System.Windows.Forms.ColumnHeader columnHeader42;
        private System.Windows.Forms.ColumnHeader columnHeader43;
        private System.Windows.Forms.ColumnHeader columnHeader44;
        private System.Windows.Forms.Label label22;
        private System.Windows.Forms.ListView _StorageSummaryListview;
        private System.Windows.Forms.ColumnHeader columnHeader33;
        private System.Windows.Forms.ColumnHeader columnHeader34;
        private System.Windows.Forms.ColumnHeader columnHeader35;
        private System.Windows.Forms.ColumnHeader columnHeader36;
        private System.Windows.Forms.ColumnHeader columnHeader37;
        private System.Windows.Forms.Label label21;

    }
}