namespace RFS_Invoice_Utility
{
    partial class InvoiceDuplicatesForm
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
            this.InvoiceDetailsListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader5 = new System.Windows.Forms.ColumnHeader();
            this.CloseButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(597, 35);
            this.label1.TabIndex = 0;
            this.label1.Text = "The invoice cannot be generated because some of the bills are already invoiced on" +
                " the following detail lines.";
            // 
            // InvoiceDetailsListview
            // 
            this.InvoiceDetailsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5});
            this.InvoiceDetailsListview.FullRowSelect = true;
            this.InvoiceDetailsListview.Location = new System.Drawing.Point(15, 32);
            this.InvoiceDetailsListview.Name = "InvoiceDetailsListview";
            this.InvoiceDetailsListview.Size = new System.Drawing.Size(679, 305);
            this.InvoiceDetailsListview.TabIndex = 1;
            this.InvoiceDetailsListview.UseCompatibleStateImageBehavior = false;
            this.InvoiceDetailsListview.View = System.Windows.Forms.View.Details;
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Invoice";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Line";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Date";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Amount";
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "Description";
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(700, 12);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 2;
            this.CloseButton.Text = "Close";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // InvoiceDuplicatesForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(787, 349);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.InvoiceDetailsListview);
            this.Controls.Add(this.label1);
            this.Name = "InvoiceDuplicatesForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Invoice Duplicates";
            this.Load += new System.EventHandler(this.InvoiceDuplicatesForm_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ListView InvoiceDetailsListview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
    }
}