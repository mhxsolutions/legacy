namespace RFS_Invoice_Utility
{
    partial class InvoiceUserDetailsForm
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
            this.invoiceIdTextbox = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.userCreatedTextbox = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.userFinalizedTextbox = new System.Windows.Forms.TextBox();
            this.CloseButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(278, 38);
            this.label1.TabIndex = 0;
            this.label1.Text = "The following are the user details for the selected invoice. Note well: the names" +
    " given are the Windows user ID values.";
            // 
            // invoiceIdTextbox
            // 
            this.invoiceIdTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.invoiceIdTextbox.Location = new System.Drawing.Point(131, 63);
            this.invoiceIdTextbox.Name = "invoiceIdTextbox";
            this.invoiceIdTextbox.ReadOnly = true;
            this.invoiceIdTextbox.Size = new System.Drawing.Size(159, 20);
            this.invoiceIdTextbox.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(16, 66);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(59, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Invoice &ID:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(16, 105);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(102, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "User who &created it:";
            // 
            // userCreatedTextbox
            // 
            this.userCreatedTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.userCreatedTextbox.Location = new System.Drawing.Point(131, 102);
            this.userCreatedTextbox.Name = "userCreatedTextbox";
            this.userCreatedTextbox.ReadOnly = true;
            this.userCreatedTextbox.Size = new System.Drawing.Size(159, 20);
            this.userCreatedTextbox.TabIndex = 4;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(16, 134);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(104, 13);
            this.label4.TabIndex = 5;
            this.label4.Text = "User who &finalized it:";
            // 
            // userFinalizedTextbox
            // 
            this.userFinalizedTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.userFinalizedTextbox.Location = new System.Drawing.Point(131, 131);
            this.userFinalizedTextbox.Name = "userFinalizedTextbox";
            this.userFinalizedTextbox.ReadOnly = true;
            this.userFinalizedTextbox.Size = new System.Drawing.Size(159, 20);
            this.userFinalizedTextbox.TabIndex = 6;
            // 
            // CloseButton
            // 
            this.CloseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(316, 12);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 9;
            this.CloseButton.Text = "Close";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // InvoiceUserDetailsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(403, 173);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.userFinalizedTextbox);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.userCreatedTextbox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.invoiceIdTextbox);
            this.Controls.Add(this.label1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(1024, 212);
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(419, 212);
            this.Name = "InvoiceUserDetailsForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Invoice User Details";
            this.Load += new System.EventHandler(this.InvoiceUserDetailsForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox invoiceIdTextbox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox userCreatedTextbox;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox userFinalizedTextbox;
        private System.Windows.Forms.Button CloseButton;
    }
}