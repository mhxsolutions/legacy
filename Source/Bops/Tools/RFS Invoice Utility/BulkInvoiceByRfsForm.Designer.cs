namespace RFS_Invoice_Utility
{
    partial class BulkInvoiceByRfsForm
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
            this.label2 = new System.Windows.Forms.Label();
            this.RfsNumberTextbox = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.OkButton = new System.Windows.Forms.Button();
            this.CloseButton = new System.Windows.Forms.Button();
            this.BillsOfLadingCheckbox = new System.Windows.Forms.CheckBox();
            this.LoadsCheckbox = new System.Windows.Forms.CheckBox();
            this.ReceiversCheckbox = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(269, 33);
            this.label1.TabIndex = 0;
            this.label1.Text = "Provide the RFS number and specify the types of bills to include in the bulk invo" +
                "icing process.";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 54);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(71, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "RFS &Number:";
            // 
            // RfsNumberTextbox
            // 
            this.RfsNumberTextbox.Location = new System.Drawing.Point(89, 51);
            this.RfsNumberTextbox.Name = "RfsNumberTextbox";
            this.RfsNumberTextbox.Size = new System.Drawing.Size(120, 20);
            this.RfsNumberTextbox.TabIndex = 2;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 81);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(45, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "Include:";
            // 
            // OkButton
            // 
            this.OkButton.Location = new System.Drawing.Point(287, 12);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 7;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(287, 42);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 8;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // BillsOfLadingCheckbox
            // 
            this.BillsOfLadingCheckbox.AutoSize = true;
            this.BillsOfLadingCheckbox.Location = new System.Drawing.Point(89, 81);
            this.BillsOfLadingCheckbox.Name = "BillsOfLadingCheckbox";
            this.BillsOfLadingCheckbox.Size = new System.Drawing.Size(91, 17);
            this.BillsOfLadingCheckbox.TabIndex = 4;
            this.BillsOfLadingCheckbox.Text = "&Bills of Lading";
            this.BillsOfLadingCheckbox.UseVisualStyleBackColor = true;
            // 
            // LoadsCheckbox
            // 
            this.LoadsCheckbox.AutoSize = true;
            this.LoadsCheckbox.Location = new System.Drawing.Point(89, 105);
            this.LoadsCheckbox.Name = "LoadsCheckbox";
            this.LoadsCheckbox.Size = new System.Drawing.Size(55, 17);
            this.LoadsCheckbox.TabIndex = 5;
            this.LoadsCheckbox.Text = "&Loads";
            this.LoadsCheckbox.UseVisualStyleBackColor = true;
            // 
            // ReceiversCheckbox
            // 
            this.ReceiversCheckbox.AutoSize = true;
            this.ReceiversCheckbox.Location = new System.Drawing.Point(89, 128);
            this.ReceiversCheckbox.Name = "ReceiversCheckbox";
            this.ReceiversCheckbox.Size = new System.Drawing.Size(74, 17);
            this.ReceiversCheckbox.TabIndex = 6;
            this.ReceiversCheckbox.Text = "&Receivers";
            this.ReceiversCheckbox.UseVisualStyleBackColor = true;
            // 
            // BulkInvoiceByRfsForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(373, 157);
            this.Controls.Add(this.ReceiversCheckbox);
            this.Controls.Add(this.LoadsCheckbox);
            this.Controls.Add(this.BillsOfLadingCheckbox);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.OkButton);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.RfsNumberTextbox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "BulkInvoiceByRfsForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Bulk Invoice By RFS Form";
            this.Load += new System.EventHandler(this.BulkInvoiceByRfsForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox RfsNumberTextbox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Button CloseButton;
        private System.Windows.Forms.CheckBox BillsOfLadingCheckbox;
        private System.Windows.Forms.CheckBox LoadsCheckbox;
        private System.Windows.Forms.CheckBox ReceiversCheckbox;
    }
}