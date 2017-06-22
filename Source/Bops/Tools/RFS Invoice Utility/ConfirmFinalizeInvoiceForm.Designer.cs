namespace RFS_Invoice_Utility
{
    partial class ConfirmFinalizeInvoiceForm
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
            this.YesButton = new System.Windows.Forms.Button();
            this.NoButton = new System.Windows.Forms.Button();
            this.ShowInvoiceCheckbox = new System.Windows.Forms.CheckBox();
            this.QuestionIconPicturebox = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.QuestionIconPicturebox)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(50, 18);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(220, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Are you sure you want to finalize the invoice?";
            // 
            // YesButton
            // 
            this.YesButton.Location = new System.Drawing.Point(305, 12);
            this.YesButton.Name = "YesButton";
            this.YesButton.Size = new System.Drawing.Size(75, 23);
            this.YesButton.TabIndex = 2;
            this.YesButton.Text = "Yes";
            this.YesButton.UseVisualStyleBackColor = true;
            this.YesButton.Click += new System.EventHandler(this.YesButton_Click);
            // 
            // NoButton
            // 
            this.NoButton.Location = new System.Drawing.Point(305, 41);
            this.NoButton.Name = "NoButton";
            this.NoButton.Size = new System.Drawing.Size(75, 23);
            this.NoButton.TabIndex = 3;
            this.NoButton.Text = "No";
            this.NoButton.UseVisualStyleBackColor = true;
            this.NoButton.Click += new System.EventHandler(this.NoButton_Click);
            // 
            // ShowInvoiceCheckbox
            // 
            this.ShowInvoiceCheckbox.AutoSize = true;
            this.ShowInvoiceCheckbox.Location = new System.Drawing.Point(53, 41);
            this.ShowInvoiceCheckbox.Name = "ShowInvoiceCheckbox";
            this.ShowInvoiceCheckbox.Size = new System.Drawing.Size(243, 17);
            this.ShowInvoiceCheckbox.TabIndex = 1;
            this.ShowInvoiceCheckbox.Text = "Show me the invoice document when finished";
            this.ShowInvoiceCheckbox.UseVisualStyleBackColor = true;
            // 
            // QuestionIconPicturebox
            // 
            this.QuestionIconPicturebox.Location = new System.Drawing.Point(12, 12);
            this.QuestionIconPicturebox.Name = "QuestionIconPicturebox";
            this.QuestionIconPicturebox.Size = new System.Drawing.Size(32, 32);
            this.QuestionIconPicturebox.TabIndex = 4;
            this.QuestionIconPicturebox.TabStop = false;
            // 
            // ConfirmFinalizeInvoiceForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(392, 78);
            this.Controls.Add(this.QuestionIconPicturebox);
            this.Controls.Add(this.ShowInvoiceCheckbox);
            this.Controls.Add(this.NoButton);
            this.Controls.Add(this.YesButton);
            this.Controls.Add(this.label1);
            this.Name = "ConfirmFinalizeInvoiceForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Confirm";
            ((System.ComponentModel.ISupportInitialize)(this.QuestionIconPicturebox)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button YesButton;
        private System.Windows.Forms.Button NoButton;
        private System.Windows.Forms.CheckBox ShowInvoiceCheckbox;
        private System.Windows.Forms.PictureBox QuestionIconPicturebox;
    }
}