namespace BopsUtilities
{
    partial class ListViewSelectByColumnForm
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
            this._SelectCombobox = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this._CloseButton = new System.Windows.Forms.Button();
            this._OkButton = new System.Windows.Forms.Button();
            this.SelectModeGroupbox = new System.Windows.Forms.GroupBox();
            this._ReplaceSelectionRadiobutton = new System.Windows.Forms.RadioButton();
            this._AddSelectionRadiobutton = new System.Windows.Forms.RadioButton();
            this.SelectModeGroupbox.SuspendLayout();
            this.SuspendLayout();
            // 
            // _SelectCombobox
            // 
            this._SelectCombobox.FormattingEnabled = true;
            this._SelectCombobox.Location = new System.Drawing.Point(102, 49);
            this._SelectCombobox.Name = "_SelectCombobox";
            this._SelectCombobox.Size = new System.Drawing.Size(107, 21);
            this._SelectCombobox.TabIndex = 14;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 52);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(82, 13);
            this.label2.TabIndex = 13;
            this.label2.Text = "Value to Select:";
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(203, 38);
            this.label1.TabIndex = 12;
            this.label1.Text = "To select, provide the value and selection mode and click OK.";
            // 
            // _CloseButton
            // 
            this._CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this._CloseButton.Location = new System.Drawing.Point(224, 38);
            this._CloseButton.Name = "_CloseButton";
            this._CloseButton.Size = new System.Drawing.Size(75, 23);
            this._CloseButton.TabIndex = 17;
            this._CloseButton.Text = "Cancel";
            this._CloseButton.UseVisualStyleBackColor = true;
            // 
            // _OkButton
            // 
            this._OkButton.Location = new System.Drawing.Point(224, 9);
            this._OkButton.Name = "_OkButton";
            this._OkButton.Size = new System.Drawing.Size(75, 23);
            this._OkButton.TabIndex = 16;
            this._OkButton.Text = "OK";
            this._OkButton.UseVisualStyleBackColor = true;
            this._OkButton.Click += new System.EventHandler(this._OkButton_Click);
            // 
            // SelectModeGroupbox
            // 
            this.SelectModeGroupbox.Controls.Add(this._ReplaceSelectionRadiobutton);
            this.SelectModeGroupbox.Controls.Add(this._AddSelectionRadiobutton);
            this.SelectModeGroupbox.Location = new System.Drawing.Point(15, 84);
            this.SelectModeGroupbox.Name = "SelectModeGroupbox";
            this.SelectModeGroupbox.Size = new System.Drawing.Size(186, 70);
            this.SelectModeGroupbox.TabIndex = 15;
            this.SelectModeGroupbox.TabStop = false;
            this.SelectModeGroupbox.Text = "Selection Mode";
            // 
            // _ReplaceSelectionRadiobutton
            // 
            this._ReplaceSelectionRadiobutton.AutoSize = true;
            this._ReplaceSelectionRadiobutton.Checked = true;
            this._ReplaceSelectionRadiobutton.Location = new System.Drawing.Point(10, 19);
            this._ReplaceSelectionRadiobutton.Name = "_ReplaceSelectionRadiobutton";
            this._ReplaceSelectionRadiobutton.Size = new System.Drawing.Size(164, 17);
            this._ReplaceSelectionRadiobutton.TabIndex = 0;
            this._ReplaceSelectionRadiobutton.TabStop = true;
            this._ReplaceSelectionRadiobutton.Text = "Replace the current selection";
            this._ReplaceSelectionRadiobutton.UseVisualStyleBackColor = true;
            // 
            // _AddSelectionRadiobutton
            // 
            this._AddSelectionRadiobutton.AutoSize = true;
            this._AddSelectionRadiobutton.Location = new System.Drawing.Point(10, 42);
            this._AddSelectionRadiobutton.Name = "_AddSelectionRadiobutton";
            this._AddSelectionRadiobutton.Size = new System.Drawing.Size(155, 17);
            this._AddSelectionRadiobutton.TabIndex = 1;
            this._AddSelectionRadiobutton.TabStop = true;
            this._AddSelectionRadiobutton.Text = "Add to the current selection";
            this._AddSelectionRadiobutton.UseVisualStyleBackColor = true;
            // 
            // ListViewSelectByColumnForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(312, 168);
            this.Controls.Add(this._SelectCombobox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this._CloseButton);
            this.Controls.Add(this._OkButton);
            this.Controls.Add(this.SelectModeGroupbox);
            this.Name = "ListViewSelectByColumnForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Select";
            this.Load += new System.EventHandler(this.ListViewSelectByColumn_Load);
            this.SelectModeGroupbox.ResumeLayout(false);
            this.SelectModeGroupbox.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox _SelectCombobox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button _CloseButton;
        private System.Windows.Forms.Button _OkButton;
        private System.Windows.Forms.GroupBox SelectModeGroupbox;
        private System.Windows.Forms.RadioButton _ReplaceSelectionRadiobutton;
        private System.Windows.Forms.RadioButton _AddSelectionRadiobutton;
    }
}