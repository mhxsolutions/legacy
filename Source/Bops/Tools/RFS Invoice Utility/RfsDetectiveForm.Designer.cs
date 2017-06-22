namespace RFS_Invoice_Utility
{
    partial class RfsDetectiveForm
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
            this.DocumentTypeCombobox = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.DocumentIdTextbox = new System.Windows.Forms.TextBox();
            this.InvestigateButton = new System.Windows.Forms.Button();
            this.BillingDocumentPicturebox = new System.Windows.Forms.PictureBox();
            this.label3 = new System.Windows.Forms.Label();
            this.BillingDocumentTextbox = new System.Windows.Forms.TextBox();
            this.RfsPicturebox = new System.Windows.Forms.PictureBox();
            this.label4 = new System.Windows.Forms.Label();
            this.RfsTextbox = new System.Windows.Forms.TextBox();
            this.CalculationResultTextbox = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.CalculationResultPicturebox = new System.Windows.Forms.PictureBox();
            this.ServiceCalculationResultTextbox = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.ServiceCalculationResultPicturebox = new System.Windows.Forms.PictureBox();
            this.ServiceCalculationResultsListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader7 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader5 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader6 = new System.Windows.Forms.ColumnHeader();
            this.InvoiceProgressTextbox = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.InvoiceProgressPicturebox = new System.Windows.Forms.PictureBox();
            this.InvoiceProgressListview = new System.Windows.Forms.ListView();
            this.columnHeader8 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader9 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader10 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader11 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader12 = new System.Windows.Forms.ColumnHeader();
            this.CloseButton = new System.Windows.Forms.Button();
            this.RecalculateButton = new System.Windows.Forms.Button();
            this.RfsDetailsButton = new System.Windows.Forms.Button();
            this.ReassignButton = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.BillingDocumentPicturebox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.RfsPicturebox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.CalculationResultPicturebox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ServiceCalculationResultPicturebox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.InvoiceProgressPicturebox)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(86, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Document Type:";
            // 
            // DocumentTypeCombobox
            // 
            this.DocumentTypeCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.DocumentTypeCombobox.FormattingEnabled = true;
            this.DocumentTypeCombobox.Items.AddRange(new object[] {
            "Load",
            "Receiver",
            "BOL"});
            this.DocumentTypeCombobox.Location = new System.Drawing.Point(104, 12);
            this.DocumentTypeCombobox.Name = "DocumentTypeCombobox";
            this.DocumentTypeCombobox.Size = new System.Drawing.Size(70, 21);
            this.DocumentTypeCombobox.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(180, 16);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(71, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Document Id:";
            // 
            // DocumentIdTextbox
            // 
            this.DocumentIdTextbox.Location = new System.Drawing.Point(257, 13);
            this.DocumentIdTextbox.Name = "DocumentIdTextbox";
            this.DocumentIdTextbox.Size = new System.Drawing.Size(125, 20);
            this.DocumentIdTextbox.TabIndex = 3;
            // 
            // InvestigateButton
            // 
            this.InvestigateButton.Location = new System.Drawing.Point(388, 10);
            this.InvestigateButton.Name = "InvestigateButton";
            this.InvestigateButton.Size = new System.Drawing.Size(75, 23);
            this.InvestigateButton.TabIndex = 4;
            this.InvestigateButton.Text = "Investigate";
            this.InvestigateButton.UseVisualStyleBackColor = true;
            this.InvestigateButton.Click += new System.EventHandler(this.InvestigateButton_Click);
            // 
            // BillingDocumentPicturebox
            // 
            this.BillingDocumentPicturebox.Location = new System.Drawing.Point(15, 56);
            this.BillingDocumentPicturebox.Name = "BillingDocumentPicturebox";
            this.BillingDocumentPicturebox.Size = new System.Drawing.Size(48, 48);
            this.BillingDocumentPicturebox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
            this.BillingDocumentPicturebox.TabIndex = 5;
            this.BillingDocumentPicturebox.TabStop = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(69, 56);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(93, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Primary Document";
            // 
            // BillingDocumentTextbox
            // 
            this.BillingDocumentTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.BillingDocumentTextbox.Location = new System.Drawing.Point(72, 72);
            this.BillingDocumentTextbox.Multiline = true;
            this.BillingDocumentTextbox.Name = "BillingDocumentTextbox";
            this.BillingDocumentTextbox.ReadOnly = true;
            this.BillingDocumentTextbox.Size = new System.Drawing.Size(701, 44);
            this.BillingDocumentTextbox.TabIndex = 6;
            // 
            // RfsPicturebox
            // 
            this.RfsPicturebox.Location = new System.Drawing.Point(15, 133);
            this.RfsPicturebox.Name = "RfsPicturebox";
            this.RfsPicturebox.Size = new System.Drawing.Size(48, 48);
            this.RfsPicturebox.TabIndex = 8;
            this.RfsPicturebox.TabStop = false;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(69, 133);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(28, 13);
            this.label4.TabIndex = 7;
            this.label4.Text = "RFS";
            // 
            // RfsTextbox
            // 
            this.RfsTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.RfsTextbox.Location = new System.Drawing.Point(72, 149);
            this.RfsTextbox.Name = "RfsTextbox";
            this.RfsTextbox.ReadOnly = true;
            this.RfsTextbox.Size = new System.Drawing.Size(458, 20);
            this.RfsTextbox.TabIndex = 8;
            // 
            // CalculationResultTextbox
            // 
            this.CalculationResultTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.CalculationResultTextbox.Location = new System.Drawing.Point(72, 203);
            this.CalculationResultTextbox.Name = "CalculationResultTextbox";
            this.CalculationResultTextbox.ReadOnly = true;
            this.CalculationResultTextbox.Size = new System.Drawing.Size(701, 20);
            this.CalculationResultTextbox.TabIndex = 13;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(69, 187);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(116, 13);
            this.label5.TabIndex = 12;
            this.label5.Text = "RFS Calculation Result";
            // 
            // CalculationResultPicturebox
            // 
            this.CalculationResultPicturebox.Location = new System.Drawing.Point(15, 187);
            this.CalculationResultPicturebox.Name = "CalculationResultPicturebox";
            this.CalculationResultPicturebox.Size = new System.Drawing.Size(48, 48);
            this.CalculationResultPicturebox.TabIndex = 11;
            this.CalculationResultPicturebox.TabStop = false;
            // 
            // ServiceCalculationResultTextbox
            // 
            this.ServiceCalculationResultTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.ServiceCalculationResultTextbox.Location = new System.Drawing.Point(72, 257);
            this.ServiceCalculationResultTextbox.Name = "ServiceCalculationResultTextbox";
            this.ServiceCalculationResultTextbox.ReadOnly = true;
            this.ServiceCalculationResultTextbox.Size = new System.Drawing.Size(701, 20);
            this.ServiceCalculationResultTextbox.TabIndex = 15;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(69, 241);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(187, 13);
            this.label6.TabIndex = 14;
            this.label6.Text = "RFS Service Calculation Results (Bills)";
            // 
            // ServiceCalculationResultPicturebox
            // 
            this.ServiceCalculationResultPicturebox.Location = new System.Drawing.Point(15, 241);
            this.ServiceCalculationResultPicturebox.Name = "ServiceCalculationResultPicturebox";
            this.ServiceCalculationResultPicturebox.Size = new System.Drawing.Size(48, 48);
            this.ServiceCalculationResultPicturebox.TabIndex = 14;
            this.ServiceCalculationResultPicturebox.TabStop = false;
            // 
            // ServiceCalculationResultsListview
            // 
            this.ServiceCalculationResultsListview.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.ServiceCalculationResultsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader7,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5,
            this.columnHeader6});
            this.ServiceCalculationResultsListview.Location = new System.Drawing.Point(72, 283);
            this.ServiceCalculationResultsListview.Name = "ServiceCalculationResultsListview";
            this.ServiceCalculationResultsListview.Size = new System.Drawing.Size(701, 97);
            this.ServiceCalculationResultsListview.TabIndex = 16;
            this.ServiceCalculationResultsListview.UseCompatibleStateImageBehavior = false;
            this.ServiceCalculationResultsListview.View = System.Windows.Forms.View.Details;
            this.ServiceCalculationResultsListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.ServiceCalculationResultsListview_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Result Id";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Service Id";
            // 
            // columnHeader7
            // 
            this.columnHeader7.Text = "Status";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Date";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Revenue";
            // 
            // columnHeader5
            // 
            this.columnHeader5.Text = "FSC";
            // 
            // columnHeader6
            // 
            this.columnHeader6.Text = "Details";
            // 
            // InvoiceProgressTextbox
            // 
            this.InvoiceProgressTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.InvoiceProgressTextbox.Location = new System.Drawing.Point(69, 415);
            this.InvoiceProgressTextbox.Name = "InvoiceProgressTextbox";
            this.InvoiceProgressTextbox.Size = new System.Drawing.Size(701, 20);
            this.InvoiceProgressTextbox.TabIndex = 18;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(66, 399);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(122, 13);
            this.label7.TabIndex = 17;
            this.label7.Text = "Invoice Progress for Bills";
            // 
            // InvoiceProgressPicturebox
            // 
            this.InvoiceProgressPicturebox.Location = new System.Drawing.Point(12, 399);
            this.InvoiceProgressPicturebox.Name = "InvoiceProgressPicturebox";
            this.InvoiceProgressPicturebox.Size = new System.Drawing.Size(48, 48);
            this.InvoiceProgressPicturebox.TabIndex = 18;
            this.InvoiceProgressPicturebox.TabStop = false;
            // 
            // InvoiceProgressListview
            // 
            this.InvoiceProgressListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.InvoiceProgressListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader8,
            this.columnHeader9,
            this.columnHeader10,
            this.columnHeader11,
            this.columnHeader12});
            this.InvoiceProgressListview.Location = new System.Drawing.Point(69, 441);
            this.InvoiceProgressListview.Name = "InvoiceProgressListview";
            this.InvoiceProgressListview.Size = new System.Drawing.Size(701, 97);
            this.InvoiceProgressListview.TabIndex = 19;
            this.InvoiceProgressListview.UseCompatibleStateImageBehavior = false;
            this.InvoiceProgressListview.View = System.Windows.Forms.View.Details;
            this.InvoiceProgressListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.InvoiceProgressListview_ColumnClick);
            // 
            // columnHeader8
            // 
            this.columnHeader8.Text = "Result Id";
            // 
            // columnHeader9
            // 
            this.columnHeader9.Text = "Service Id";
            // 
            // columnHeader10
            // 
            this.columnHeader10.Text = "Invoice";
            // 
            // columnHeader11
            // 
            this.columnHeader11.Text = "Line";
            // 
            // columnHeader12
            // 
            this.columnHeader12.Text = "Invoice Status";
            // 
            // CloseButton
            // 
            this.CloseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(698, 13);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 20;
            this.CloseButton.Text = "Close";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // RecalculateButton
            // 
            this.RecalculateButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.RecalculateButton.Location = new System.Drawing.Point(698, 146);
            this.RecalculateButton.Name = "RecalculateButton";
            this.RecalculateButton.Size = new System.Drawing.Size(75, 23);
            this.RecalculateButton.TabIndex = 11;
            this.RecalculateButton.Text = "Recalculate";
            this.RecalculateButton.UseVisualStyleBackColor = true;
            this.RecalculateButton.Click += new System.EventHandler(this.RecalculateButton_Click);
            // 
            // RfsDetailsButton
            // 
            this.RfsDetailsButton.Location = new System.Drawing.Point(536, 146);
            this.RfsDetailsButton.Name = "RfsDetailsButton";
            this.RfsDetailsButton.Size = new System.Drawing.Size(75, 23);
            this.RfsDetailsButton.TabIndex = 9;
            this.RfsDetailsButton.Text = "Details...";
            this.RfsDetailsButton.UseVisualStyleBackColor = true;
            this.RfsDetailsButton.Click += new System.EventHandler(this.RfsDetailsButton_Click);
            // 
            // ReassignButton
            // 
            this.ReassignButton.Location = new System.Drawing.Point(617, 146);
            this.ReassignButton.Name = "ReassignButton";
            this.ReassignButton.Size = new System.Drawing.Size(75, 23);
            this.ReassignButton.TabIndex = 10;
            this.ReassignButton.Text = "Reassign...";
            this.ReassignButton.UseVisualStyleBackColor = true;
            this.ReassignButton.Click += new System.EventHandler(this.ReassignButton_Click);
            // 
            // RfsDetectiveForm
            // 
            this.AcceptButton = this.InvestigateButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(793, 555);
            this.Controls.Add(this.ReassignButton);
            this.Controls.Add(this.RfsDetailsButton);
            this.Controls.Add(this.RecalculateButton);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.InvoiceProgressListview);
            this.Controls.Add(this.InvoiceProgressTextbox);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.InvoiceProgressPicturebox);
            this.Controls.Add(this.ServiceCalculationResultsListview);
            this.Controls.Add(this.ServiceCalculationResultTextbox);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.ServiceCalculationResultPicturebox);
            this.Controls.Add(this.CalculationResultTextbox);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.CalculationResultPicturebox);
            this.Controls.Add(this.RfsTextbox);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.RfsPicturebox);
            this.Controls.Add(this.BillingDocumentTextbox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.BillingDocumentPicturebox);
            this.Controls.Add(this.InvestigateButton);
            this.Controls.Add(this.DocumentIdTextbox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.DocumentTypeCombobox);
            this.Controls.Add(this.label1);
            this.KeyPreview = true;
            this.MinimumSize = new System.Drawing.Size(801, 568);
            this.Name = "RfsDetectiveForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "RFS Detective";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.RfsDetectiveForm_KeyDown);
            ((System.ComponentModel.ISupportInitialize)(this.BillingDocumentPicturebox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.RfsPicturebox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.CalculationResultPicturebox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ServiceCalculationResultPicturebox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.InvoiceProgressPicturebox)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox DocumentTypeCombobox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox DocumentIdTextbox;
        private System.Windows.Forms.Button InvestigateButton;
        private System.Windows.Forms.PictureBox BillingDocumentPicturebox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox BillingDocumentTextbox;
        private System.Windows.Forms.PictureBox RfsPicturebox;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox RfsTextbox;
        private System.Windows.Forms.TextBox CalculationResultTextbox;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.PictureBox CalculationResultPicturebox;
        private System.Windows.Forms.TextBox ServiceCalculationResultTextbox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.PictureBox ServiceCalculationResultPicturebox;
        private System.Windows.Forms.ListView ServiceCalculationResultsListview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.ColumnHeader columnHeader5;
        private System.Windows.Forms.ColumnHeader columnHeader6;
        private System.Windows.Forms.ColumnHeader columnHeader7;
        private System.Windows.Forms.TextBox InvoiceProgressTextbox;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.PictureBox InvoiceProgressPicturebox;
        private System.Windows.Forms.ListView InvoiceProgressListview;
        private System.Windows.Forms.ColumnHeader columnHeader8;
        private System.Windows.Forms.ColumnHeader columnHeader9;
        private System.Windows.Forms.ColumnHeader columnHeader10;
        private System.Windows.Forms.ColumnHeader columnHeader11;
        private System.Windows.Forms.ColumnHeader columnHeader12;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.Button RecalculateButton;
        private System.Windows.Forms.Button RfsDetailsButton;
        private System.Windows.Forms.Button ReassignButton;
    }
}