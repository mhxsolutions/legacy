namespace RFS_Invoice_Utility
{
    partial class InvoiceExportResultsForm
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.ExportIdTextbox = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.InvoiceCountTextbox = new System.Windows.Forms.TextBox();
            this.TotalAmountTextbox = new System.Windows.Forms.TextBox();
            this.AccountBreakdownListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.CloseButton = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.OpenFileLink = new System.Windows.Forms.LinkLabel();
            this.FileContentsTextbox = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.CsvFileNameTextbox = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(228, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Invoice(s) exported successfully to CSV format.";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 41);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(54, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Export ID:";
            // 
            // ExportIdTextbox
            // 
            this.ExportIdTextbox.Location = new System.Drawing.Point(72, 38);
            this.ExportIdTextbox.Name = "ExportIdTextbox";
            this.ExportIdTextbox.ReadOnly = true;
            this.ExportIdTextbox.Size = new System.Drawing.Size(127, 20);
            this.ExportIdTextbox.TabIndex = 2;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(216, 41);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(76, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "Invoice Count:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(221, 198);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(73, 13);
            this.label4.TabIndex = 7;
            this.label4.Text = "Total Amount:";
            // 
            // InvoiceCountTextbox
            // 
            this.InvoiceCountTextbox.Location = new System.Drawing.Point(298, 38);
            this.InvoiceCountTextbox.Name = "InvoiceCountTextbox";
            this.InvoiceCountTextbox.ReadOnly = true;
            this.InvoiceCountTextbox.Size = new System.Drawing.Size(127, 20);
            this.InvoiceCountTextbox.TabIndex = 4;
            // 
            // TotalAmountTextbox
            // 
            this.TotalAmountTextbox.Location = new System.Drawing.Point(300, 195);
            this.TotalAmountTextbox.Name = "TotalAmountTextbox";
            this.TotalAmountTextbox.ReadOnly = true;
            this.TotalAmountTextbox.Size = new System.Drawing.Size(125, 20);
            this.TotalAmountTextbox.TabIndex = 8;
            this.TotalAmountTextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // AccountBreakdownListview
            // 
            this.AccountBreakdownListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2});
            this.AccountBreakdownListview.FullRowSelect = true;
            this.AccountBreakdownListview.GridLines = true;
            this.AccountBreakdownListview.Location = new System.Drawing.Point(15, 91);
            this.AccountBreakdownListview.Name = "AccountBreakdownListview";
            this.AccountBreakdownListview.Size = new System.Drawing.Size(410, 98);
            this.AccountBreakdownListview.TabIndex = 6;
            this.AccountBreakdownListview.UseCompatibleStateImageBehavior = false;
            this.AccountBreakdownListview.View = System.Windows.Forms.View.Details;
            this.AccountBreakdownListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.AccountBreakdownListview_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "General Ledger Code";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Total";
            this.columnHeader2.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(454, 12);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 14;
            this.CloseButton.Text = "Close";
            this.CloseButton.UseVisualStyleBackColor = true;
            this.CloseButton.Click += new System.EventHandler(this.CloseButton_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(12, 227);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(95, 13);
            this.label5.TabIndex = 9;
            this.label5.Text = "CSV File Contents:";
            // 
            // OpenFileLink
            // 
            this.OpenFileLink.AutoSize = true;
            this.OpenFileLink.Location = new System.Drawing.Point(289, 227);
            this.OpenFileLink.Name = "OpenFileLink";
            this.OpenFileLink.Size = new System.Drawing.Size(136, 13);
            this.OpenFileLink.TabIndex = 10;
            this.OpenFileLink.TabStop = true;
            this.OpenFileLink.Text = "Click to open the output file";
            this.OpenFileLink.TextAlign = System.Drawing.ContentAlignment.TopRight;
            this.OpenFileLink.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.OpenFileLink_LinkClicked);
            // 
            // FileContentsTextbox
            // 
            this.FileContentsTextbox.Location = new System.Drawing.Point(15, 243);
            this.FileContentsTextbox.Multiline = true;
            this.FileContentsTextbox.Name = "FileContentsTextbox";
            this.FileContentsTextbox.ReadOnly = true;
            this.FileContentsTextbox.Size = new System.Drawing.Size(410, 159);
            this.FileContentsTextbox.TabIndex = 11;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(12, 75);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(180, 13);
            this.label6.TabIndex = 5;
            this.label6.Text = "General Ledger Account Breakdown";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(12, 411);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(50, 13);
            this.label7.TabIndex = 12;
            this.label7.Text = "CSV File:";
            // 
            // CsvFileNameTextbox
            // 
            this.CsvFileNameTextbox.Location = new System.Drawing.Point(68, 408);
            this.CsvFileNameTextbox.Name = "CsvFileNameTextbox";
            this.CsvFileNameTextbox.ReadOnly = true;
            this.CsvFileNameTextbox.Size = new System.Drawing.Size(357, 20);
            this.CsvFileNameTextbox.TabIndex = 13;
            // 
            // InvoiceExportResultsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(541, 445);
            this.Controls.Add(this.CsvFileNameTextbox);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.FileContentsTextbox);
            this.Controls.Add(this.OpenFileLink);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.AccountBreakdownListview);
            this.Controls.Add(this.TotalAmountTextbox);
            this.Controls.Add(this.InvoiceCountTextbox);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.ExportIdTextbox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "InvoiceExportResultsForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Invoice Export Results";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox ExportIdTextbox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox InvoiceCountTextbox;
        private System.Windows.Forms.TextBox TotalAmountTextbox;
        private System.Windows.Forms.ListView AccountBreakdownListview;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.LinkLabel OpenFileLink;
        private System.Windows.Forms.TextBox FileContentsTextbox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox CsvFileNameTextbox;
    }
}