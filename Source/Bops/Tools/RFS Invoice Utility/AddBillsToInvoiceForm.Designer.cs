namespace RFS_Invoice_Utility
{
    partial class AddBillsToInvoiceForm
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
            this.BeginDatePicker = new System.Windows.Forms.DateTimePicker();
            this.EndDatePicker = new System.Windows.Forms.DateTimePicker();
            this.ShowBillsButton = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.BillsAvailableListview = new System.Windows.Forms.ListView();
            this.DocType = new System.Windows.Forms.ColumnHeader();
            this.BillId = new System.Windows.Forms.ColumnHeader();
            this.RFS = new System.Windows.Forms.ColumnHeader();
            this.Date = new System.Windows.Forms.ColumnHeader();
            this.Revenue = new System.Windows.Forms.ColumnHeader();
            this.FSC = new System.Windows.Forms.ColumnHeader();
            this.Shipper = new System.Windows.Forms.ColumnHeader();
            this.BillTo = new System.Windows.Forms.ColumnHeader();
            this.columnHeader30 = new System.Windows.Forms.ColumnHeader();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(416, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Use the date controls to select bills to be added to the invoice and click the OK" +
                " button.";
            // 
            // OkButton
            // 
            this.OkButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.OkButton.Location = new System.Drawing.Point(657, 13);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 7;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // CloseButton
            // 
            this.CloseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(657, 42);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 8;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // BeginDatePicker
            // 
            this.BeginDatePicker.Location = new System.Drawing.Point(82, 46);
            this.BeginDatePicker.Name = "BeginDatePicker";
            this.BeginDatePicker.Size = new System.Drawing.Size(200, 20);
            this.BeginDatePicker.TabIndex = 2;
            // 
            // EndDatePicker
            // 
            this.EndDatePicker.Location = new System.Drawing.Point(349, 46);
            this.EndDatePicker.Name = "EndDatePicker";
            this.EndDatePicker.Size = new System.Drawing.Size(200, 20);
            this.EndDatePicker.TabIndex = 4;
            // 
            // ShowBillsButton
            // 
            this.ShowBillsButton.Location = new System.Drawing.Point(555, 42);
            this.ShowBillsButton.Name = "ShowBillsButton";
            this.ShowBillsButton.Size = new System.Drawing.Size(75, 23);
            this.ShowBillsButton.TabIndex = 5;
            this.ShowBillsButton.Text = "Show Bills";
            this.ShowBillsButton.UseVisualStyleBackColor = true;
            this.ShowBillsButton.Click += new System.EventHandler(this.ShowBillsButton_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 52);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Begin Date:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(288, 52);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(55, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "End Date:";
            // 
            // BillsAvailableListview
            // 
            this.BillsAvailableListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.BillsAvailableListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.DocType,
            this.BillId,
            this.RFS,
            this.Date,
            this.Revenue,
            this.FSC,
            this.Shipper,
            this.BillTo,
            this.columnHeader30});
            this.BillsAvailableListview.FullRowSelect = true;
            this.BillsAvailableListview.HideSelection = false;
            this.BillsAvailableListview.Location = new System.Drawing.Point(16, 72);
            this.BillsAvailableListview.Name = "BillsAvailableListview";
            this.BillsAvailableListview.Size = new System.Drawing.Size(716, 406);
            this.BillsAvailableListview.TabIndex = 6;
            this.BillsAvailableListview.UseCompatibleStateImageBehavior = false;
            this.BillsAvailableListview.View = System.Windows.Forms.View.Details;
            this.BillsAvailableListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.BillsAvailableListview_ColumnClick);
            // 
            // DocType
            // 
            this.DocType.Text = "Type";
            // 
            // BillId
            // 
            this.BillId.Text = "ID";
            // 
            // RFS
            // 
            this.RFS.Text = "RFS";
            this.RFS.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // Date
            // 
            this.Date.Text = "Date";
            // 
            // Revenue
            // 
            this.Revenue.Text = "Revenue";
            this.Revenue.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // FSC
            // 
            this.FSC.Text = "FSC";
            this.FSC.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // Shipper
            // 
            this.Shipper.Text = "Shipper";
            // 
            // BillTo
            // 
            this.BillTo.Text = "Bill-To";
            // 
            // columnHeader30
            // 
            this.columnHeader30.Text = "Destination";
            this.columnHeader30.Width = 86;
            // 
            // AddBillsToInvoiceForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(744, 490);
            this.Controls.Add(this.BillsAvailableListview);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.ShowBillsButton);
            this.Controls.Add(this.EndDatePicker);
            this.Controls.Add(this.BeginDatePicker);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.OkButton);
            this.Controls.Add(this.label1);
            this.MinimumSize = new System.Drawing.Size(760, 526);
            this.Name = "AddBillsToInvoiceForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Add Bills to Invoice";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.DateTimePicker BeginDatePicker;
        private System.Windows.Forms.DateTimePicker EndDatePicker;
        private System.Windows.Forms.Button ShowBillsButton;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ListView BillsAvailableListview;
        private System.Windows.Forms.ColumnHeader DocType;
        private System.Windows.Forms.ColumnHeader BillId;
        private System.Windows.Forms.ColumnHeader RFS;
        private System.Windows.Forms.ColumnHeader Date;
        private System.Windows.Forms.ColumnHeader Revenue;
        private System.Windows.Forms.ColumnHeader FSC;
        private System.Windows.Forms.ColumnHeader Shipper;
        private System.Windows.Forms.ColumnHeader BillTo;
        private System.Windows.Forms.ColumnHeader columnHeader30;
    }
}