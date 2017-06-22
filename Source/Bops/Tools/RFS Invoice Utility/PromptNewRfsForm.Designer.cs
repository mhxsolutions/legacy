namespace RFS_Invoice_Utility
{
    partial class PromptNewRfsForm
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
            this._OkButton = new System.Windows.Forms.Button();
            this._CloseButton = new System.Windows.Forms.Button();
            this._DirectionsLabel = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this._RfsCombobox = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // _OkButton
            // 
            this._OkButton.Location = new System.Drawing.Point(270, 8);
            this._OkButton.Name = "_OkButton";
            this._OkButton.Size = new System.Drawing.Size(75, 23);
            this._OkButton.TabIndex = 0;
            this._OkButton.Text = "OK";
            this._OkButton.UseVisualStyleBackColor = true;
            this._OkButton.Click += new System.EventHandler(this._OkButton_Click);
            // 
            // _CloseButton
            // 
            this._CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this._CloseButton.Location = new System.Drawing.Point(270, 37);
            this._CloseButton.Name = "_CloseButton";
            this._CloseButton.Size = new System.Drawing.Size(75, 23);
            this._CloseButton.TabIndex = 1;
            this._CloseButton.Text = "Cancel";
            this._CloseButton.UseVisualStyleBackColor = true;
            // 
            // _DirectionsLabel
            // 
            this._DirectionsLabel.Location = new System.Drawing.Point(12, 13);
            this._DirectionsLabel.Name = "_DirectionsLabel";
            this._DirectionsLabel.Size = new System.Drawing.Size(252, 34);
            this._DirectionsLabel.TabIndex = 2;
            this._DirectionsLabel.Text = "label1";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 59);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(56, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "New RFS:";
            // 
            // _RfsCombobox
            // 
            this._RfsCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._RfsCombobox.FormattingEnabled = true;
            this._RfsCombobox.Location = new System.Drawing.Point(74, 56);
            this._RfsCombobox.Name = "_RfsCombobox";
            this._RfsCombobox.Size = new System.Drawing.Size(121, 21);
            this._RfsCombobox.TabIndex = 5;
            // 
            // PromptNewRfsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this._CloseButton;
            this.ClientSize = new System.Drawing.Size(357, 87);
            this.Controls.Add(this._RfsCombobox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this._DirectionsLabel);
            this.Controls.Add(this._CloseButton);
            this.Controls.Add(this._OkButton);
            this.Name = "PromptNewRfsForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Enter New RFS";
            this.Load += new System.EventHandler(this.PromptNewRfsForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button _OkButton;
        private System.Windows.Forms.Button _CloseButton;
        private System.Windows.Forms.Label _DirectionsLabel;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox _RfsCombobox;
    }
}