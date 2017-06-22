namespace RFS_Invoice_Utility
{
    partial class ChooseLoginForm
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
            this.helpTextLabel = new System.Windows.Forms.Label();
            this.okButton = new System.Windows.Forms.Button();
            this.loginListbox = new System.Windows.Forms.ListBox();
            this.SuspendLayout();
            // 
            // helpTextLabel
            // 
            this.helpTextLabel.Location = new System.Drawing.Point(13, 13);
            this.helpTextLabel.Name = "helpTextLabel";
            this.helpTextLabel.Size = new System.Drawing.Size(331, 38);
            this.helpTextLabel.TabIndex = 0;
            this.helpTextLabel.Text = "You are authorized to work with multilpe companies. Choose the company you\'d like" +
    " to represent for this session.";
            // 
            // okButton
            // 
            this.okButton.Location = new System.Drawing.Point(350, 12);
            this.okButton.Name = "okButton";
            this.okButton.Size = new System.Drawing.Size(75, 23);
            this.okButton.TabIndex = 1;
            this.okButton.Text = "OK";
            this.okButton.UseVisualStyleBackColor = true;
            this.okButton.Click += new System.EventHandler(this.okButton_Click);
            // 
            // loginListbox
            // 
            this.loginListbox.FormattingEnabled = true;
            this.loginListbox.Location = new System.Drawing.Point(16, 55);
            this.loginListbox.Name = "loginListbox";
            this.loginListbox.Size = new System.Drawing.Size(301, 82);
            this.loginListbox.TabIndex = 2;
            this.loginListbox.DoubleClick += new System.EventHandler(this.loginListbox_DoubleClick);
            // 
            // ChooseLoginForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(436, 155);
            this.Controls.Add(this.loginListbox);
            this.Controls.Add(this.okButton);
            this.Controls.Add(this.helpTextLabel);
            this.Name = "ChooseLoginForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Choose Login";
            this.Load += new System.EventHandler(this.ChooseLoginForm_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label helpTextLabel;
        private System.Windows.Forms.Button okButton;
        private System.Windows.Forms.ListBox loginListbox;
    }
}