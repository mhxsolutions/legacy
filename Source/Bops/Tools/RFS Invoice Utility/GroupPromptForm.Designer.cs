namespace RFS_Invoice_Utility
{
    partial class GroupPromptForm
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
            this.GroupNameCombobox = new System.Windows.Forms.ComboBox();
            this.OkButton = new System.Windows.Forms.Button();
            this.CloseButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 14);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(189, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Select or type the desired group name.";
            // 
            // GroupNameCombobox
            // 
            this.GroupNameCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple;
            this.GroupNameCombobox.FormattingEnabled = true;
            this.GroupNameCombobox.Location = new System.Drawing.Point(15, 34);
            this.GroupNameCombobox.Name = "GroupNameCombobox";
            this.GroupNameCombobox.Size = new System.Drawing.Size(236, 150);
            this.GroupNameCombobox.TabIndex = 1;
            this.GroupNameCombobox.KeyUp += new System.Windows.Forms.KeyEventHandler(this.GroupNameCombobox_KeyUp);
            // 
            // OkButton
            // 
            this.OkButton.Location = new System.Drawing.Point(261, 9);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 2;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(261, 38);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 3;
            this.CloseButton.Text = "Cancel";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // GroupPromptForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.ClientSize = new System.Drawing.Size(348, 191);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.GroupNameCombobox);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.OkButton);
            this.Name = "GroupPromptForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Select Group";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox GroupNameCombobox;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Button CloseButton;
    }
}