namespace RFS_Invoice_Utility
{
    partial class CreateInvoicesFromStorageBillingForm
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
            this._LocationCombobox = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this._ServiceCombobox = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this._InvoiceDatepicker = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this._OkButton = new System.Windows.Forms.Button();
            this._CloseButton = new System.Windows.Forms.Button();
            this._InvoiceTypeCombobox = new System.Windows.Forms.ComboBox();
            this.label13 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // _LocationCombobox
            // 
            this._LocationCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._LocationCombobox.FormattingEnabled = true;
            this._LocationCombobox.Location = new System.Drawing.Point(90, 106);
            this._LocationCombobox.Name = "_LocationCombobox";
            this._LocationCombobox.Size = new System.Drawing.Size(200, 21);
            this._LocationCombobox.TabIndex = 6;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(13, 109);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(51, 13);
            this.label6.TabIndex = 5;
            this.label6.Text = "Location:";
            // 
            // _ServiceCombobox
            // 
            this._ServiceCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._ServiceCombobox.FormattingEnabled = true;
            this._ServiceCombobox.Location = new System.Drawing.Point(90, 133);
            this._ServiceCombobox.Name = "_ServiceCombobox";
            this._ServiceCombobox.Size = new System.Drawing.Size(200, 21);
            this._ServiceCombobox.TabIndex = 8;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 132);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(46, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Service:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(13, 86);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(71, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "Invoice Date:";
            // 
            // _InvoiceDatepicker
            // 
            this._InvoiceDatepicker.Location = new System.Drawing.Point(90, 80);
            this._InvoiceDatepicker.Name = "_InvoiceDatepicker";
            this._InvoiceDatepicker.Size = new System.Drawing.Size(200, 20);
            this._InvoiceDatepicker.TabIndex = 4;
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(304, 33);
            this.label1.TabIndex = 0;
            this.label1.Text = "Please provide the date to be used for the invoice(s) along with the location/ser" +
                "vice for accounting purposes.";
            // 
            // _OkButton
            // 
            this._OkButton.Location = new System.Drawing.Point(323, 13);
            this._OkButton.Name = "_OkButton";
            this._OkButton.Size = new System.Drawing.Size(75, 23);
            this._OkButton.TabIndex = 9;
            this._OkButton.Text = "OK";
            this._OkButton.UseVisualStyleBackColor = true;
            this._OkButton.Click += new System.EventHandler(this._OkButton_Click);
            // 
            // _CloseButton
            // 
            this._CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this._CloseButton.Location = new System.Drawing.Point(323, 42);
            this._CloseButton.Name = "_CloseButton";
            this._CloseButton.Size = new System.Drawing.Size(75, 23);
            this._CloseButton.TabIndex = 10;
            this._CloseButton.Text = "Cancel";
            this._CloseButton.UseVisualStyleBackColor = true;
            // 
            // _InvoiceTypeCombobox
            // 
            this._InvoiceTypeCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._InvoiceTypeCombobox.FormattingEnabled = true;
            this._InvoiceTypeCombobox.Location = new System.Drawing.Point(90, 53);
            this._InvoiceTypeCombobox.Name = "_InvoiceTypeCombobox";
            this._InvoiceTypeCombobox.Size = new System.Drawing.Size(200, 21);
            this._InvoiceTypeCombobox.TabIndex = 2;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(13, 56);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(72, 13);
            this.label13.TabIndex = 1;
            this.label13.Text = "Invoice Type:";
            // 
            // CreateInvoicesFromStorageBillingForm
            // 
            this.AcceptButton = this._OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this._CloseButton;
            this.ClientSize = new System.Drawing.Size(414, 168);
            this.Controls.Add(this._InvoiceTypeCombobox);
            this.Controls.Add(this.label13);
            this.Controls.Add(this._CloseButton);
            this.Controls.Add(this._OkButton);
            this.Controls.Add(this.label1);
            this.Controls.Add(this._LocationCombobox);
            this.Controls.Add(this.label6);
            this.Controls.Add(this._ServiceCombobox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label4);
            this.Controls.Add(this._InvoiceDatepicker);
            this.Name = "CreateInvoicesFromStorageBillingForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Create Storage Billing Invoice";
            this.Load += new System.EventHandler(this.CreateInvoicesFromStorageBillingForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox _LocationCombobox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox _ServiceCombobox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DateTimePicker _InvoiceDatepicker;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button _OkButton;
        private System.Windows.Forms.Button _CloseButton;
        private System.Windows.Forms.ComboBox _InvoiceTypeCombobox;
        private System.Windows.Forms.Label label13;
    }
}