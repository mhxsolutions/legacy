namespace RFS_Invoice_Utility
{
    partial class InvoiceEditLinesForm
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
            this.label17 = new System.Windows.Forms.Label();
            this.EditInvoiceDetailsListview = new System.Windows.Forms.ListView();
            this.columnHeader23 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader24 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader25 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader26 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader27 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader28 = new System.Windows.Forms.ColumnHeader();
            this.OkButton = new System.Windows.Forms.Button();
            this.CloseButton = new System.Windows.Forms.Button();
            this.GroupButton = new System.Windows.Forms.Button();
            this.UngroupButton = new System.Windows.Forms.Button();
            this.AddManualChargeButton = new System.Windows.Forms.Button();
            this.EditInvoiceLineButton = new System.Windows.Forms.Button();
            this.InvoiceTotalLabel = new System.Windows.Forms.Label();
            this.ShowGroupDetailCheckbox = new System.Windows.Forms.CheckBox();
            this.ClearAllGroupsButton = new System.Windows.Forms.Button();
            this.UnapproveBillsButton = new System.Windows.Forms.Button();
            this.MoveUpButton = new System.Windows.Forms.Button();
            this.MoveDownButton = new System.Windows.Forms.Button();
            this.DeleteManualBillButton = new System.Windows.Forms.Button();
            this.AddBillsButton = new System.Windows.Forms.Button();
            this.SelectButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Location = new System.Drawing.Point(12, 9);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(87, 13);
            this.label17.TabIndex = 0;
            this.label17.Text = "Invoice Contents";
            // 
            // EditInvoiceDetailsListview
            // 
            this.EditInvoiceDetailsListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.EditInvoiceDetailsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader23,
            this.columnHeader24,
            this.columnHeader25,
            this.columnHeader26,
            this.columnHeader27,
            this.columnHeader28});
            this.EditInvoiceDetailsListview.FullRowSelect = true;
            this.EditInvoiceDetailsListview.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
            this.EditInvoiceDetailsListview.HideSelection = false;
            this.EditInvoiceDetailsListview.Location = new System.Drawing.Point(15, 25);
            this.EditInvoiceDetailsListview.Name = "EditInvoiceDetailsListview";
            this.EditInvoiceDetailsListview.Size = new System.Drawing.Size(612, 505);
            this.EditInvoiceDetailsListview.TabIndex = 1;
            this.EditInvoiceDetailsListview.UseCompatibleStateImageBehavior = false;
            this.EditInvoiceDetailsListview.View = System.Windows.Forms.View.Details;
            this.EditInvoiceDetailsListview.DoubleClick += new System.EventHandler(this.EditInvoiceDetailsListview_DoubleClick);
            this.EditInvoiceDetailsListview.KeyDown += new System.Windows.Forms.KeyEventHandler(this.EditInvoiceDetailsListview_KeyDown);
            // 
            // columnHeader23
            // 
            this.columnHeader23.Text = "Line";
            // 
            // columnHeader24
            // 
            this.columnHeader24.Text = "Type";
            // 
            // columnHeader25
            // 
            this.columnHeader25.Text = "Group";
            // 
            // columnHeader26
            // 
            this.columnHeader26.Text = "Date";
            // 
            // columnHeader27
            // 
            this.columnHeader27.Text = "Amount";
            this.columnHeader27.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeader28
            // 
            this.columnHeader28.Text = "Description";
            this.columnHeader28.Width = 118;
            // 
            // OkButton
            // 
            this.OkButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.OkButton.Location = new System.Drawing.Point(633, 25);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(140, 23);
            this.OkButton.TabIndex = 4;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // CloseButton
            // 
            this.CloseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(633, 54);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(140, 23);
            this.CloseButton.TabIndex = 5;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // GroupButton
            // 
            this.GroupButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.GroupButton.Location = new System.Drawing.Point(634, 203);
            this.GroupButton.Name = "GroupButton";
            this.GroupButton.Size = new System.Drawing.Size(140, 23);
            this.GroupButton.TabIndex = 9;
            this.GroupButton.Text = "Group...";
            this.GroupButton.UseVisualStyleBackColor = true;
            this.GroupButton.Click += new System.EventHandler(this.GroupButton_Click);
            // 
            // UngroupButton
            // 
            this.UngroupButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.UngroupButton.Location = new System.Drawing.Point(634, 232);
            this.UngroupButton.Name = "UngroupButton";
            this.UngroupButton.Size = new System.Drawing.Size(140, 23);
            this.UngroupButton.TabIndex = 10;
            this.UngroupButton.Text = "Ungroup";
            this.UngroupButton.UseVisualStyleBackColor = true;
            this.UngroupButton.Click += new System.EventHandler(this.UngroupButton_Click);
            // 
            // AddManualChargeButton
            // 
            this.AddManualChargeButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.AddManualChargeButton.Location = new System.Drawing.Point(633, 410);
            this.AddManualChargeButton.Name = "AddManualChargeButton";
            this.AddManualChargeButton.Size = new System.Drawing.Size(140, 23);
            this.AddManualChargeButton.TabIndex = 15;
            this.AddManualChargeButton.Text = "Add Manual Bill...";
            this.AddManualChargeButton.UseVisualStyleBackColor = true;
            this.AddManualChargeButton.Click += new System.EventHandler(this.AddManualChargeButton_Click);
            // 
            // EditInvoiceLineButton
            // 
            this.EditInvoiceLineButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.EditInvoiceLineButton.Location = new System.Drawing.Point(634, 301);
            this.EditInvoiceLineButton.Name = "EditInvoiceLineButton";
            this.EditInvoiceLineButton.Size = new System.Drawing.Size(140, 23);
            this.EditInvoiceLineButton.TabIndex = 12;
            this.EditInvoiceLineButton.Text = "Edit Invoice Line...";
            this.EditInvoiceLineButton.UseVisualStyleBackColor = true;
            this.EditInvoiceLineButton.Click += new System.EventHandler(this.EditInvoiceLineButton_Click);
            // 
            // InvoiceTotalLabel
            // 
            this.InvoiceTotalLabel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.InvoiceTotalLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.InvoiceTotalLabel.Location = new System.Drawing.Point(443, 537);
            this.InvoiceTotalLabel.Name = "InvoiceTotalLabel";
            this.InvoiceTotalLabel.Size = new System.Drawing.Size(184, 18);
            this.InvoiceTotalLabel.TabIndex = 3;
            this.InvoiceTotalLabel.Text = "Invoice Total: ?";
            this.InvoiceTotalLabel.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // ShowGroupDetailCheckbox
            // 
            this.ShowGroupDetailCheckbox.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.ShowGroupDetailCheckbox.AutoSize = true;
            this.ShowGroupDetailCheckbox.Location = new System.Drawing.Point(15, 536);
            this.ShowGroupDetailCheckbox.Name = "ShowGroupDetailCheckbox";
            this.ShowGroupDetailCheckbox.Size = new System.Drawing.Size(143, 17);
            this.ShowGroupDetailCheckbox.TabIndex = 2;
            this.ShowGroupDetailCheckbox.Text = "Show Group Detail Lines";
            this.ShowGroupDetailCheckbox.UseVisualStyleBackColor = true;
            this.ShowGroupDetailCheckbox.CheckedChanged += new System.EventHandler(this.ShowGroupDetailCheckbox_CheckedChanged);
            // 
            // ClearAllGroupsButton
            // 
            this.ClearAllGroupsButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.ClearAllGroupsButton.Location = new System.Drawing.Point(634, 261);
            this.ClearAllGroupsButton.Name = "ClearAllGroupsButton";
            this.ClearAllGroupsButton.Size = new System.Drawing.Size(140, 23);
            this.ClearAllGroupsButton.TabIndex = 11;
            this.ClearAllGroupsButton.Text = "Clear All Groups";
            this.ClearAllGroupsButton.UseVisualStyleBackColor = true;
            this.ClearAllGroupsButton.Click += new System.EventHandler(this.ClearAllGroupsButton_Click);
            // 
            // UnapproveBillsButton
            // 
            this.UnapproveBillsButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.UnapproveBillsButton.Location = new System.Drawing.Point(633, 370);
            this.UnapproveBillsButton.Name = "UnapproveBillsButton";
            this.UnapproveBillsButton.Size = new System.Drawing.Size(140, 23);
            this.UnapproveBillsButton.TabIndex = 14;
            this.UnapproveBillsButton.Text = "Unapprove Bills";
            this.UnapproveBillsButton.UseVisualStyleBackColor = true;
            this.UnapproveBillsButton.Click += new System.EventHandler(this.UnapproveBillsButton_Click);
            // 
            // MoveUpButton
            // 
            this.MoveUpButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.MoveUpButton.Location = new System.Drawing.Point(634, 134);
            this.MoveUpButton.Name = "MoveUpButton";
            this.MoveUpButton.Size = new System.Drawing.Size(139, 23);
            this.MoveUpButton.TabIndex = 7;
            this.MoveUpButton.Text = "Move Up";
            this.MoveUpButton.UseVisualStyleBackColor = true;
            this.MoveUpButton.Click += new System.EventHandler(this.MoveUpButton_Click);
            // 
            // MoveDownButton
            // 
            this.MoveDownButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.MoveDownButton.Location = new System.Drawing.Point(634, 163);
            this.MoveDownButton.Name = "MoveDownButton";
            this.MoveDownButton.Size = new System.Drawing.Size(139, 23);
            this.MoveDownButton.TabIndex = 8;
            this.MoveDownButton.Text = "Move Down";
            this.MoveDownButton.UseVisualStyleBackColor = true;
            this.MoveDownButton.Click += new System.EventHandler(this.MoveDownButton_Click);
            // 
            // DeleteManualBillButton
            // 
            this.DeleteManualBillButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.DeleteManualBillButton.Location = new System.Drawing.Point(633, 439);
            this.DeleteManualBillButton.Name = "DeleteManualBillButton";
            this.DeleteManualBillButton.Size = new System.Drawing.Size(139, 23);
            this.DeleteManualBillButton.TabIndex = 16;
            this.DeleteManualBillButton.Text = "Delete Manual Bill";
            this.DeleteManualBillButton.UseVisualStyleBackColor = true;
            this.DeleteManualBillButton.Click += new System.EventHandler(this.DeleteManualBillButton_Click);
            // 
            // AddBillsButton
            // 
            this.AddBillsButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.AddBillsButton.Enabled = false;
            this.AddBillsButton.Location = new System.Drawing.Point(635, 341);
            this.AddBillsButton.Name = "AddBillsButton";
            this.AddBillsButton.Size = new System.Drawing.Size(138, 23);
            this.AddBillsButton.TabIndex = 13;
            this.AddBillsButton.Text = "Add Bills...";
            this.AddBillsButton.UseVisualStyleBackColor = true;
            this.AddBillsButton.Click += new System.EventHandler(this.AddBillsButton_Click);
            // 
            // SelectButton
            // 
            this.SelectButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.SelectButton.Location = new System.Drawing.Point(632, 94);
            this.SelectButton.Name = "SelectButton";
            this.SelectButton.Size = new System.Drawing.Size(139, 23);
            this.SelectButton.TabIndex = 6;
            this.SelectButton.Text = "Select...";
            this.SelectButton.UseVisualStyleBackColor = true;
            this.SelectButton.Click += new System.EventHandler(this.SelectButton_Click);
            // 
            // InvoiceEditLinesForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(784, 564);
            this.Controls.Add(this.SelectButton);
            this.Controls.Add(this.AddBillsButton);
            this.Controls.Add(this.DeleteManualBillButton);
            this.Controls.Add(this.label17);
            this.Controls.Add(this.EditInvoiceDetailsListview);
            this.Controls.Add(this.ShowGroupDetailCheckbox);
            this.Controls.Add(this.InvoiceTotalLabel);
            this.Controls.Add(this.OkButton);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.MoveUpButton);
            this.Controls.Add(this.MoveDownButton);
            this.Controls.Add(this.GroupButton);
            this.Controls.Add(this.UngroupButton);
            this.Controls.Add(this.ClearAllGroupsButton);
            this.Controls.Add(this.EditInvoiceLineButton);
            this.Controls.Add(this.AddManualChargeButton);
            this.Controls.Add(this.UnapproveBillsButton);
            this.MinimumSize = new System.Drawing.Size(800, 600);
            this.Name = "InvoiceEditLinesForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Edit Invoice Detail Lines";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label17;
        private System.Windows.Forms.ListView EditInvoiceDetailsListview;
        private System.Windows.Forms.ColumnHeader columnHeader23;
        private System.Windows.Forms.ColumnHeader columnHeader24;
        private System.Windows.Forms.ColumnHeader columnHeader25;
        private System.Windows.Forms.ColumnHeader columnHeader26;
        private System.Windows.Forms.ColumnHeader columnHeader27;
        private System.Windows.Forms.ColumnHeader columnHeader28;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.Button GroupButton;
        private System.Windows.Forms.Button UngroupButton;
        private System.Windows.Forms.Button AddManualChargeButton;
        private System.Windows.Forms.Button EditInvoiceLineButton;
        private System.Windows.Forms.Label InvoiceTotalLabel;
        private System.Windows.Forms.CheckBox ShowGroupDetailCheckbox;
        private System.Windows.Forms.Button ClearAllGroupsButton;
        private System.Windows.Forms.Button UnapproveBillsButton;
        private System.Windows.Forms.Button MoveUpButton;
        private System.Windows.Forms.Button MoveDownButton;
        private System.Windows.Forms.Button DeleteManualBillButton;
        private System.Windows.Forms.Button AddBillsButton;
        private System.Windows.Forms.Button SelectButton;
    }
}