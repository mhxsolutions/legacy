namespace RFS_Invoice_Utility
{
    partial class CreateInvoiceDetailsForm
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
            this.label2 = new System.Windows.Forms.Label();
            this.InvoiceDatePicker = new System.Windows.Forms.DateTimePicker();
            this.label3 = new System.Windows.Forms.Label();
            this.PublicNotesTextbox = new System.Windows.Forms.TextBox();
            this.PrivateNotesTextbox = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this._InvoiceTypeCombobox = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(380, 39);
            this.label1.TabIndex = 0;
            this.label1.Text = "Specify the invoice type, invoice date, and record private and/or public notes fo" +
    "r the invoice. Press OK to continue or Cancel to abort.";
            // 
            // OkButton
            // 
            this.OkButton.Location = new System.Drawing.Point(398, 9);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 9;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(398, 38);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 10;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 82);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(71, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Invoice Date:";
            // 
            // InvoiceDatePicker
            // 
            this.InvoiceDatePicker.Location = new System.Drawing.Point(89, 76);
            this.InvoiceDatePicker.Name = "InvoiceDatePicker";
            this.InvoiceDatePicker.Size = new System.Drawing.Size(200, 20);
            this.InvoiceDatePicker.TabIndex = 4;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 117);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(192, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Public Notes (will be printed on invoice)";
            // 
            // PublicNotesTextbox
            // 
            this.PublicNotesTextbox.Location = new System.Drawing.Point(15, 134);
            this.PublicNotesTextbox.MaxLength = 500;
            this.PublicNotesTextbox.Multiline = true;
            this.PublicNotesTextbox.Name = "PublicNotesTextbox";
            this.PublicNotesTextbox.Size = new System.Drawing.Size(458, 128);
            this.PublicNotesTextbox.TabIndex = 6;
            // 
            // PrivateNotesTextbox
            // 
            this.PrivateNotesTextbox.Location = new System.Drawing.Point(15, 291);
            this.PrivateNotesTextbox.MaxLength = 500;
            this.PrivateNotesTextbox.Multiline = true;
            this.PrivateNotesTextbox.Name = "PrivateNotesTextbox";
            this.PrivateNotesTextbox.Size = new System.Drawing.Size(458, 128);
            this.PrivateNotesTextbox.TabIndex = 8;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 274);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(171, 13);
            this.label4.TabIndex = 7;
            this.label4.Text = "Private Notes (for internal use only)";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(11, 52);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(72, 13);
            this.label5.TabIndex = 1;
            this.label5.Text = "Invoice Type:";
            // 
            // _InvoiceTypeCombobox
            // 
            this._InvoiceTypeCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._InvoiceTypeCombobox.FormattingEnabled = true;
            this._InvoiceTypeCombobox.Location = new System.Drawing.Point(89, 49);
            this._InvoiceTypeCombobox.Name = "_InvoiceTypeCombobox";
            this._InvoiceTypeCombobox.Size = new System.Drawing.Size(200, 21);
            this._InvoiceTypeCombobox.Sorted = true;
            this._InvoiceTypeCombobox.TabIndex = 2;
            // 
            // CreateInvoiceDetailsForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(487, 434);
            this.Controls.Add(this._InvoiceTypeCombobox);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.PrivateNotesTextbox);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.PublicNotesTextbox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.InvoiceDatePicker);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.OkButton);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "CreateInvoiceDetailsForm";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Invoice Details";
            this.Load += new System.EventHandler(this.CreateInvoiceDetailsForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DateTimePicker InvoiceDatePicker;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox PublicNotesTextbox;
        private System.Windows.Forms.TextBox PrivateNotesTextbox;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox _InvoiceTypeCombobox;
    }
}