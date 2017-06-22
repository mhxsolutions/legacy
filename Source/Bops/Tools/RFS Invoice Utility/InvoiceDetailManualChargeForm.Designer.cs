namespace RFS_Invoice_Utility
{
    partial class InvoiceDetailManualChargeForm
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
            this.DescriptionTextbox = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.CloseButton = new System.Windows.Forms.Button();
            this.OkButton = new System.Windows.Forms.Button();
            this.DatePicker = new System.Windows.Forms.DateTimePicker();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.AmountTextbox = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.ServiceOfferedCombobox = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.LocationCombobox = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // DescriptionTextbox
            // 
            this.DescriptionTextbox.AcceptsReturn = true;
            this.DescriptionTextbox.Location = new System.Drawing.Point(89, 141);
            this.DescriptionTextbox.Multiline = true;
            this.DescriptionTextbox.Name = "DescriptionTextbox";
            this.DescriptionTextbox.Size = new System.Drawing.Size(381, 139);
            this.DescriptionTextbox.TabIndex = 10;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(16, 144);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(63, 13);
            this.label3.TabIndex = 9;
            this.label3.Text = "Description:";
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(472, 23);
            this.label1.TabIndex = 0;
            this.label1.Text = "Edit the invoice line details below and press OK to accept your changes or cancel" +
                " to abort.";
            // 
            // CloseButton
            // 
            this.CloseButton.CausesValidation = false;
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(490, 41);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 12;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // OkButton
            // 
            this.OkButton.Location = new System.Drawing.Point(490, 12);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 11;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // DatePicker
            // 
            this.DatePicker.Location = new System.Drawing.Point(89, 35);
            this.DatePicker.Name = "DatePicker";
            this.DatePicker.Size = new System.Drawing.Size(200, 20);
            this.DatePicker.TabIndex = 2;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(16, 41);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(33, 13);
            this.label4.TabIndex = 1;
            this.label4.Text = "Date:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(16, 64);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(46, 13);
            this.label5.TabIndex = 3;
            this.label5.Text = "Amount:";
            // 
            // AmountTextbox
            // 
            this.AmountTextbox.Location = new System.Drawing.Point(89, 61);
            this.AmountTextbox.Name = "AmountTextbox";
            this.AmountTextbox.Size = new System.Drawing.Size(200, 20);
            this.AmountTextbox.TabIndex = 4;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(16, 117);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(46, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Service:";
            // 
            // ServiceOfferedCombobox
            // 
            this.ServiceOfferedCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ServiceOfferedCombobox.FormattingEnabled = true;
            this.ServiceOfferedCombobox.Location = new System.Drawing.Point(89, 114);
            this.ServiceOfferedCombobox.Name = "ServiceOfferedCombobox";
            this.ServiceOfferedCombobox.Size = new System.Drawing.Size(381, 21);
            this.ServiceOfferedCombobox.Sorted = true;
            this.ServiceOfferedCombobox.TabIndex = 8;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(16, 90);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(51, 13);
            this.label6.TabIndex = 5;
            this.label6.Text = "Location:";
            // 
            // LocationCombobox
            // 
            this.LocationCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.LocationCombobox.FormattingEnabled = true;
            this.LocationCombobox.Location = new System.Drawing.Point(89, 87);
            this.LocationCombobox.Name = "LocationCombobox";
            this.LocationCombobox.Size = new System.Drawing.Size(200, 21);
            this.LocationCombobox.TabIndex = 6;
            // 
            // InvoiceDetailManualChargeForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(577, 295);
            this.Controls.Add(this.LocationCombobox);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.ServiceOfferedCombobox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.AmountTextbox);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.DatePicker);
            this.Controls.Add(this.DescriptionTextbox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.OkButton);
            this.Name = "InvoiceDetailManualChargeForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Manual Bill Details";
            this.Load += new System.EventHandler(this.InvoiceDetailManualChargeForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox DescriptionTextbox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.DateTimePicker DatePicker;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox AmountTextbox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox ServiceOfferedCombobox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox LocationCombobox;
    }
}