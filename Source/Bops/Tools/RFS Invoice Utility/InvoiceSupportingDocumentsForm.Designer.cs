namespace RFS_Invoice_Utility
{
    partial class InvoiceSupportingDocumentsForm
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
            this.SupportingDocumentsListview = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.CloseButton = new System.Windows.Forms.Button();
            this.OpenMergedButton = new System.Windows.Forms.Button();
            this.OpenSelectedButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(472, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Supporting Documents (yellow means no document, red has a document but the file d" +
                "oes not exist)";
            // 
            // SupportingDocumentsListview
            // 
            this.SupportingDocumentsListview.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.SupportingDocumentsListview.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4});
            this.SupportingDocumentsListview.FullRowSelect = true;
            this.SupportingDocumentsListview.Location = new System.Drawing.Point(16, 30);
            this.SupportingDocumentsListview.Name = "SupportingDocumentsListview";
            this.SupportingDocumentsListview.Size = new System.Drawing.Size(650, 405);
            this.SupportingDocumentsListview.TabIndex = 1;
            this.SupportingDocumentsListview.UseCompatibleStateImageBehavior = false;
            this.SupportingDocumentsListview.View = System.Windows.Forms.View.Details;
            this.SupportingDocumentsListview.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.SupportingDocumentsListview_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Bill Type";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Bill ID";
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Document";
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "File Name";
            // 
            // CloseButton
            // 
            this.CloseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(672, 30);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(100, 23);
            this.CloseButton.TabIndex = 2;
            this.CloseButton.Text = "Close";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // OpenMergedButton
            // 
            this.OpenMergedButton.Location = new System.Drawing.Point(673, 99);
            this.OpenMergedButton.Name = "OpenMergedButton";
            this.OpenMergedButton.Size = new System.Drawing.Size(100, 23);
            this.OpenMergedButton.TabIndex = 4;
            this.OpenMergedButton.Text = "Open All Merged";
            this.OpenMergedButton.UseVisualStyleBackColor = true;
            this.OpenMergedButton.Click += new System.EventHandler(this.OpenMergedButton_Click);
            // 
            // OpenSelectedButton
            // 
            this.OpenSelectedButton.Location = new System.Drawing.Point(673, 70);
            this.OpenSelectedButton.Name = "OpenSelectedButton";
            this.OpenSelectedButton.Size = new System.Drawing.Size(100, 23);
            this.OpenSelectedButton.TabIndex = 3;
            this.OpenSelectedButton.Text = "Open Selected";
            this.OpenSelectedButton.UseVisualStyleBackColor = true;
            this.OpenSelectedButton.Click += new System.EventHandler(this.OpenSelectedButton_Click);
            // 
            // InvoiceSupportingDocumentsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(784, 447);
            this.Controls.Add(this.OpenSelectedButton);
            this.Controls.Add(this.OpenMergedButton);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.SupportingDocumentsListview);
            this.Controls.Add(this.label1);
            this.MinimumSize = new System.Drawing.Size(776, 483);
            this.Name = "InvoiceSupportingDocumentsForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Invoice Supporting Documents";
            this.Load += new System.EventHandler(this.InvoiceSupportingDocumentsForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ListView SupportingDocumentsListview;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private System.Windows.Forms.ColumnHeader columnHeader4;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.Button OpenMergedButton;
        private System.Windows.Forms.Button OpenSelectedButton;
    }
}