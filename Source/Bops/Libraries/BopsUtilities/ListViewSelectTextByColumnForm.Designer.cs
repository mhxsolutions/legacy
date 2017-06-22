namespace BopsUtilities
{
    partial class ListViewSelectTextByColumnForm
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
            this._ColumnCombobox = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this._FindTextbox = new System.Windows.Forms.TextBox();
            this._MatchCaseCheckbox = new System.Windows.Forms.CheckBox();
            this._OkButton = new System.Windows.Forms.Button();
            this._CloseButton = new System.Windows.Forms.Button();
            this.SelectModeGroupbox = new System.Windows.Forms.GroupBox();
            this._ReplaceSelectionRadiobutton = new System.Windows.Forms.RadioButton();
            this._AddSelectionRadiobutton = new System.Windows.Forms.RadioButton();
            this.SelectModeGroupbox.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(94, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "Column to &Search:";
            // 
            // _ColumnCombobox
            // 
            this._ColumnCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._ColumnCombobox.FormattingEnabled = true;
            this._ColumnCombobox.Location = new System.Drawing.Point(113, 10);
            this._ColumnCombobox.Name = "_ColumnCombobox";
            this._ColumnCombobox.Size = new System.Drawing.Size(245, 21);
            this._ColumnCombobox.TabIndex = 7;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 40);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(66, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "Text to &Find:";
            // 
            // _FindTextbox
            // 
            this._FindTextbox.Location = new System.Drawing.Point(113, 37);
            this._FindTextbox.Name = "_FindTextbox";
            this._FindTextbox.Size = new System.Drawing.Size(245, 20);
            this._FindTextbox.TabIndex = 1;
            // 
            // _MatchCaseCheckbox
            // 
            this._MatchCaseCheckbox.AutoSize = true;
            this._MatchCaseCheckbox.Location = new System.Drawing.Point(113, 63);
            this._MatchCaseCheckbox.Name = "_MatchCaseCheckbox";
            this._MatchCaseCheckbox.Size = new System.Drawing.Size(82, 17);
            this._MatchCaseCheckbox.TabIndex = 2;
            this._MatchCaseCheckbox.Text = "Match &case";
            this._MatchCaseCheckbox.UseVisualStyleBackColor = true;
            // 
            // _OkButton
            // 
            this._OkButton.Location = new System.Drawing.Point(372, 8);
            this._OkButton.Name = "_OkButton";
            this._OkButton.Size = new System.Drawing.Size(75, 23);
            this._OkButton.TabIndex = 4;
            this._OkButton.Text = "OK";
            this._OkButton.UseVisualStyleBackColor = true;
            this._OkButton.Click += new System.EventHandler(this._OkButton_Click);
            // 
            // _CloseButton
            // 
            this._CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this._CloseButton.Location = new System.Drawing.Point(373, 37);
            this._CloseButton.Name = "_CloseButton";
            this._CloseButton.Size = new System.Drawing.Size(75, 23);
            this._CloseButton.TabIndex = 5;
            this._CloseButton.Text = "Cancel";
            this._CloseButton.UseVisualStyleBackColor = true;
            // 
            // SelectModeGroupbox
            // 
            this.SelectModeGroupbox.Controls.Add(this._ReplaceSelectionRadiobutton);
            this.SelectModeGroupbox.Controls.Add(this._AddSelectionRadiobutton);
            this.SelectModeGroupbox.Location = new System.Drawing.Point(113, 86);
            this.SelectModeGroupbox.Name = "SelectModeGroupbox";
            this.SelectModeGroupbox.Size = new System.Drawing.Size(186, 70);
            this.SelectModeGroupbox.TabIndex = 3;
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
            this._ReplaceSelectionRadiobutton.Text = "&Replace the current selection";
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
            this._AddSelectionRadiobutton.Text = "&Add to the current selection";
            this._AddSelectionRadiobutton.UseVisualStyleBackColor = true;
            // 
            // ListViewSelectTextByColumnForm
            // 
            this.AcceptButton = this._OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this._CloseButton;
            this.ClientSize = new System.Drawing.Size(456, 169);
            this.Controls.Add(this.SelectModeGroupbox);
            this.Controls.Add(this._CloseButton);
            this.Controls.Add(this._OkButton);
            this.Controls.Add(this._MatchCaseCheckbox);
            this.Controls.Add(this._FindTextbox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this._ColumnCombobox);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "ListViewSelectTextByColumnForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Select";
            this.SelectModeGroupbox.ResumeLayout(false);
            this.SelectModeGroupbox.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox _ColumnCombobox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox _FindTextbox;
        private System.Windows.Forms.CheckBox _MatchCaseCheckbox;
        private System.Windows.Forms.Button _OkButton;
        private System.Windows.Forms.Button _CloseButton;
        private System.Windows.Forms.GroupBox SelectModeGroupbox;
        private System.Windows.Forms.RadioButton _ReplaceSelectionRadiobutton;
        private System.Windows.Forms.RadioButton _AddSelectionRadiobutton;
    }
}