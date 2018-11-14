namespace RFS_Invoice_Utility
{
    partial class CreateInvoiceFromManualBillForm
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
            this.ManualBillServiceOfferedCombobox = new System.Windows.Forms.ComboBox();
            this.ManualBillAmountTextbox = new System.Windows.Forms.TextBox();
            this.ManualBillDatePicker = new System.Windows.Forms.DateTimePicker();
            this.ManualBillDescriptionTextbox = new System.Windows.Forms.TextBox();
            this.CloseButton = new System.Windows.Forms.Button();
            this.OkButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.PrivateNotesTextbox = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.PublicNotesTextbox = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.InvoiceDatePicker = new System.Windows.Forms.DateTimePicker();
            this.label9 = new System.Windows.Forms.Label();
            this.InvoiceShipperCombobox = new System.Windows.Forms.ComboBox();
            this.InvoiceBillToCombobox = new System.Windows.Forms.ComboBox();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.LocationCombobox = new System.Windows.Forms.ComboBox();
            this.label12 = new System.Windows.Forms.Label();
            this._InvoiceTypeCombobox = new System.Windows.Forms.ComboBox();
            this.label13 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // ManualBillServiceOfferedCombobox
            // 
            this.ManualBillServiceOfferedCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ManualBillServiceOfferedCombobox.FormattingEnabled = true;
            this.ManualBillServiceOfferedCombobox.Location = new System.Drawing.Point(139, 521);
            this.ManualBillServiceOfferedCombobox.Name = "ManualBillServiceOfferedCombobox";
            this.ManualBillServiceOfferedCombobox.Size = new System.Drawing.Size(354, 21);
            this.ManualBillServiceOfferedCombobox.Sorted = true;
            this.ManualBillServiceOfferedCombobox.TabIndex = 21;
            // 
            // ManualBillAmountTextbox
            // 
            this.ManualBillAmountTextbox.Location = new System.Drawing.Point(139, 468);
            this.ManualBillAmountTextbox.Name = "ManualBillAmountTextbox";
            this.ManualBillAmountTextbox.Size = new System.Drawing.Size(200, 20);
            this.ManualBillAmountTextbox.TabIndex = 17;
            // 
            // ManualBillDatePicker
            // 
            this.ManualBillDatePicker.Location = new System.Drawing.Point(137, 442);
            this.ManualBillDatePicker.Name = "ManualBillDatePicker";
            this.ManualBillDatePicker.Size = new System.Drawing.Size(200, 20);
            this.ManualBillDatePicker.TabIndex = 15;
            // 
            // ManualBillDescriptionTextbox
            // 
            this.ManualBillDescriptionTextbox.Location = new System.Drawing.Point(12, 572);
            this.ManualBillDescriptionTextbox.Multiline = true;
            this.ManualBillDescriptionTextbox.Name = "ManualBillDescriptionTextbox";
            this.ManualBillDescriptionTextbox.Size = new System.Drawing.Size(481, 100);
            this.ManualBillDescriptionTextbox.TabIndex = 23;
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(512, 41);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 25;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // OkButton
            // 
            this.OkButton.Location = new System.Drawing.Point(512, 12);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 24;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 448);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(87, 13);
            this.label1.TabIndex = 14;
            this.label1.Text = "Manual Bill Date:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 471);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(100, 13);
            this.label2.TabIndex = 16;
            this.label2.Text = "Manual Bill Amount:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 524);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(100, 13);
            this.label3.TabIndex = 20;
            this.label3.Text = "Manual Bill Service:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(9, 556);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(117, 13);
            this.label4.TabIndex = 22;
            this.label4.Text = "Manual Bill Description:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(12, 89);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(84, 13);
            this.label5.TabIndex = 5;
            this.label5.Text = "Invoice Shipper:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(12, 116);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(77, 13);
            this.label6.TabIndex = 7;
            this.label6.Text = "Invoice Bill-To:";
            // 
            // PrivateNotesTextbox
            // 
            this.PrivateNotesTextbox.Location = new System.Drawing.Point(12, 297);
            this.PrivateNotesTextbox.MaxLength = 500;
            this.PrivateNotesTextbox.Multiline = true;
            this.PrivateNotesTextbox.Name = "PrivateNotesTextbox";
            this.PrivateNotesTextbox.Size = new System.Drawing.Size(481, 100);
            this.PrivateNotesTextbox.TabIndex = 12;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(12, 281);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(171, 13);
            this.label7.TabIndex = 11;
            this.label7.Text = "Private Notes (for internal use only)";
            // 
            // PublicNotesTextbox
            // 
            this.PublicNotesTextbox.Location = new System.Drawing.Point(12, 168);
            this.PublicNotesTextbox.MaxLength = 500;
            this.PublicNotesTextbox.Multiline = true;
            this.PublicNotesTextbox.Name = "PublicNotesTextbox";
            this.PublicNotesTextbox.Size = new System.Drawing.Size(481, 100);
            this.PublicNotesTextbox.TabIndex = 10;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(12, 152);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(192, 13);
            this.label8.TabIndex = 9;
            this.label8.Text = "Public Notes (will be printed on invoice)";
            // 
            // InvoiceDatePicker
            // 
            this.InvoiceDatePicker.Location = new System.Drawing.Point(137, 60);
            this.InvoiceDatePicker.Name = "InvoiceDatePicker";
            this.InvoiceDatePicker.Size = new System.Drawing.Size(200, 20);
            this.InvoiceDatePicker.TabIndex = 4;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(12, 66);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(71, 13);
            this.label9.TabIndex = 3;
            this.label9.Text = "Invoice Date:";
            // 
            // InvoiceShipperCombobox
            // 
            this.InvoiceShipperCombobox.FormattingEnabled = true;
            this.InvoiceShipperCombobox.Location = new System.Drawing.Point(137, 86);
            this.InvoiceShipperCombobox.Name = "InvoiceShipperCombobox";
            this.InvoiceShipperCombobox.Size = new System.Drawing.Size(356, 21);
            this.InvoiceShipperCombobox.Sorted = true;
            this.InvoiceShipperCombobox.TabIndex = 6;
            // 
            // InvoiceBillToCombobox
            // 
            this.InvoiceBillToCombobox.FormattingEnabled = true;
            this.InvoiceBillToCombobox.Location = new System.Drawing.Point(137, 113);
            this.InvoiceBillToCombobox.Name = "InvoiceBillToCombobox";
            this.InvoiceBillToCombobox.Size = new System.Drawing.Size(356, 21);
            this.InvoiceBillToCombobox.Sorted = true;
            this.InvoiceBillToCombobox.TabIndex = 8;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(12, 12);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(155, 13);
            this.label10.TabIndex = 0;
            this.label10.Text = "Enter the Invoice details below.";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(12, 414);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(169, 13);
            this.label11.TabIndex = 13;
            this.label11.Text = "Enter the manual bill details below.";
            // 
            // LocationCombobox
            // 
            this.LocationCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.LocationCombobox.FormattingEnabled = true;
            this.LocationCombobox.Location = new System.Drawing.Point(139, 494);
            this.LocationCombobox.Name = "LocationCombobox";
            this.LocationCombobox.Size = new System.Drawing.Size(200, 21);
            this.LocationCombobox.Sorted = true;
            this.LocationCombobox.TabIndex = 19;
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(12, 497);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(51, 13);
            this.label12.TabIndex = 18;
            this.label12.Text = "Location:";
            // 
            // _InvoiceTypeCombobox
            // 
            this._InvoiceTypeCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._InvoiceTypeCombobox.FormattingEnabled = true;
            this._InvoiceTypeCombobox.Location = new System.Drawing.Point(137, 33);
            this._InvoiceTypeCombobox.Name = "_InvoiceTypeCombobox";
            this._InvoiceTypeCombobox.Size = new System.Drawing.Size(200, 21);
            this._InvoiceTypeCombobox.TabIndex = 2;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(12, 36);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(72, 13);
            this.label13.TabIndex = 1;
            this.label13.Text = "Invoice Type:";
            // 
            // CreateInvoiceFromManualBillForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(599, 684);
            this.Controls.Add(this._InvoiceTypeCombobox);
            this.Controls.Add(this.label13);
            this.Controls.Add(this.LocationCombobox);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.InvoiceBillToCombobox);
            this.Controls.Add(this.InvoiceShipperCombobox);
            this.Controls.Add(this.PrivateNotesTextbox);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.PublicNotesTextbox);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.InvoiceDatePicker);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.ManualBillServiceOfferedCombobox);
            this.Controls.Add(this.ManualBillAmountTextbox);
            this.Controls.Add(this.ManualBillDatePicker);
            this.Controls.Add(this.ManualBillDescriptionTextbox);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.OkButton);
            this.Name = "CreateInvoiceFromManualBillForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Invoice Details";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox ManualBillServiceOfferedCombobox;
        private System.Windows.Forms.TextBox ManualBillAmountTextbox;
        private System.Windows.Forms.DateTimePicker ManualBillDatePicker;
        private System.Windows.Forms.TextBox ManualBillDescriptionTextbox;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox PrivateNotesTextbox;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox PublicNotesTextbox;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.DateTimePicker InvoiceDatePicker;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.ComboBox InvoiceShipperCombobox;
        private System.Windows.Forms.ComboBox InvoiceBillToCombobox;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.ComboBox LocationCombobox;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.ComboBox _InvoiceTypeCombobox;
        private System.Windows.Forms.Label label13;
    }
}