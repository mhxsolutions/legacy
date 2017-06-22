namespace RFS_Invoice_Utility
{
    partial class SelectExportForm
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
            this.OkButton = new System.Windows.Forms.Button();
            this.CloseButton = new System.Windows.Forms.Button();
            this.InvoiceExportsListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader5 = new System.Windows.Forms.ColumnHeader();
            this.label2 = new System.Windows.Forms.Label();
            this.ExportFormatCombobox = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 46);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(227, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Select the invoice export from the following list.";
            // 
            // OkButton
            // 
            this.OkButton.Location = new System.Drawing.Point(550, 13);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 4;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(550, 42);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 5;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // InvoiceExportsListview
            // 
            this.InvoiceExportsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5});
            this.InvoiceExportsListview.FullRowSelect = true;
            this.InvoiceExportsListview.Location = new System.Drawing.Point(15, 70);
            this.InvoiceExportsListview.Name = "InvoiceExportsListview";
            this.InvoiceExportsListview.Size = new System.Drawing.Size(519, 289);
            this.InvoiceExportsListview.TabIndex = 3;
            this.InvoiceExportsListview.UseCompatibleStateImageBehavior = false;
            this.InvoiceExportsListview.View = System.Windows.Forms.View.Details;
            this.InvoiceExportsListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.InvoiceExportsListview_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "ID";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Date";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "User ID";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Invoice Count";
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "Total Revenue";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 18);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(104, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "Select export format:";
            // 
            // ExportFormatCombobox
            // 
            this.ExportFormatCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ExportFormatCombobox.FormattingEnabled = true;
            this.ExportFormatCombobox.Items.AddRange(new object[] {
            "MAS90 CSV Format",
            "Solomon CSV Format"});
            this.ExportFormatCombobox.Location = new System.Drawing.Point(122, 15);
            this.ExportFormatCombobox.Name = "ExportFormatCombobox";
            this.ExportFormatCombobox.Size = new System.Drawing.Size(408, 21);
            this.ExportFormatCombobox.TabIndex = 1;
            // 
            // SelectExportForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(637, 373);
            this.Controls.Add(this.ExportFormatCombobox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.InvoiceExportsListview);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.OkButton);
            this.Controls.Add(this.label1);
            this.Name = "SelectExportForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Select Invoice Export";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.ListView InvoiceExportsListview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox ExportFormatCombobox;
    }
}