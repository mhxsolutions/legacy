namespace RFS_Invoice_Utility
{
    partial class InvoicePackageForm
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
            this._InvoicesListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.label1 = new System.Windows.Forms.Label();
            this._CopyButton = new System.Windows.Forms.Button();
            this._SaveButton = new System.Windows.Forms.Button();
            this._CloseButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // _InvoicesListview
            // 
            this._InvoicesListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._InvoicesListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4});
            this._InvoicesListview.FullRowSelect = true;
            this._InvoicesListview.Location = new System.Drawing.Point(12, 29);
            this._InvoicesListview.Name = "_InvoicesListview";
            this._InvoicesListview.Size = new System.Drawing.Size(577, 347);
            this._InvoicesListview.TabIndex = 1;
            this._InvoicesListview.UseCompatibleStateImageBehavior = false;
            this._InvoicesListview.View = System.Windows.Forms.View.Details;
            this._InvoicesListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this._InvoicesListview_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Id";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Date";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Bill-To";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Revenue";
            this.columnHeader4.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(47, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Invoices";
            // 
            // _CopyButton
            // 
            this._CopyButton.Location = new System.Drawing.Point(595, 12);
            this._CopyButton.Name = "_CopyButton";
            this._CopyButton.Size = new System.Drawing.Size(115, 23);
            this._CopyButton.TabIndex = 2;
            this._CopyButton.Text = "Copy to Clipboard";
            this._CopyButton.UseVisualStyleBackColor = true;
            this._CopyButton.Click += new System.EventHandler(this._CopyButton_Click);
            // 
            // _SaveButton
            // 
            this._SaveButton.Location = new System.Drawing.Point(595, 41);
            this._SaveButton.Name = "_SaveButton";
            this._SaveButton.Size = new System.Drawing.Size(115, 23);
            this._SaveButton.TabIndex = 3;
            this._SaveButton.Text = "Export to File...";
            this._SaveButton.UseVisualStyleBackColor = true;
            this._SaveButton.Click += new System.EventHandler(this._SaveButton_Click);
            // 
            // _CloseButton
            // 
            this._CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this._CloseButton.Location = new System.Drawing.Point(595, 87);
            this._CloseButton.Name = "_CloseButton";
            this._CloseButton.Size = new System.Drawing.Size(115, 23);
            this._CloseButton.TabIndex = 4;
            this._CloseButton.Text = "Close";
            this._CloseButton.UseVisualStyleBackColor = true;
            // 
            // InvoicePackageForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this._CloseButton;
            this.ClientSize = new System.Drawing.Size(722, 387);
            this.Controls.Add(this._CloseButton);
            this.Controls.Add(this._SaveButton);
            this.Controls.Add(this._CopyButton);
            this.Controls.Add(this.label1);
            this.Controls.Add(this._InvoicesListview);
            this.Name = "InvoicePackageForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Invoice Package";
            this.Load += new System.EventHandler(this.InvoicePackageForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListView _InvoicesListview;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.Button _CopyButton;
        private System.Windows.Forms.Button _SaveButton;
        private System.Windows.Forms.Button _CloseButton;
    }
}