namespace Driver_Break_Detector
{
    partial class MainForm
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
            this._BeginDatepicker = new System.Windows.Forms.DateTimePicker();
            this.label2 = new System.Windows.Forms.Label();
            this._EndDatepicker = new System.Windows.Forms.DateTimePicker();
            this._DetectButton = new System.Windows.Forms.Button();
            this._DriversCheckedlistbox = new System.Windows.Forms.CheckedListBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this._OutputFileTextbox = new System.Windows.Forms.TextBox();
            this._OutputFileButton = new System.Windows.Forms.Button();
            this._AllButton = new System.Windows.Forms.Button();
            this._NoneButton = new System.Windows.Forms.Button();
            this._StatusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this._MatchLocationsCheckbox = new System.Windows.Forms.CheckBox();
            this._LocationFileTextbox = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this._LocationFileButton = new System.Windows.Forms.Button();
            this._OutputModeCombobox = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this._StatusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Begin Date:";
            // 
            // _BeginDatepicker
            // 
            this._BeginDatepicker.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._BeginDatepicker.Location = new System.Drawing.Point(95, 12);
            this._BeginDatepicker.Name = "_BeginDatepicker";
            this._BeginDatepicker.Size = new System.Drawing.Size(329, 20);
            this._BeginDatepicker.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(14, 46);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(55, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "End Date:";
            // 
            // _EndDatepicker
            // 
            this._EndDatepicker.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._EndDatepicker.Location = new System.Drawing.Point(95, 39);
            this._EndDatepicker.Name = "_EndDatepicker";
            this._EndDatepicker.Size = new System.Drawing.Size(329, 20);
            this._EndDatepicker.TabIndex = 3;
            // 
            // _DetectButton
            // 
            this._DetectButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this._DetectButton.Location = new System.Drawing.Point(430, 13);
            this._DetectButton.Name = "_DetectButton";
            this._DetectButton.Size = new System.Drawing.Size(75, 23);
            this._DetectButton.TabIndex = 17;
            this._DetectButton.Text = "Detect";
            this._DetectButton.UseVisualStyleBackColor = true;
            this._DetectButton.Click += new System.EventHandler(this._DetectButton_Click);
            // 
            // _DriversCheckedlistbox
            // 
            this._DriversCheckedlistbox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._DriversCheckedlistbox.FormattingEnabled = true;
            this._DriversCheckedlistbox.Location = new System.Drawing.Point(95, 72);
            this._DriversCheckedlistbox.Name = "_DriversCheckedlistbox";
            this._DriversCheckedlistbox.Size = new System.Drawing.Size(273, 154);
            this._DriversCheckedlistbox.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(14, 72);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(43, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Drivers:";
            // 
            // label4
            // 
            this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(3, 337);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(74, 13);
            this.label4.TabIndex = 14;
            this.label4.Text = "Output Folder:";
            // 
            // _OutputFileTextbox
            // 
            this._OutputFileTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._OutputFileTextbox.Location = new System.Drawing.Point(95, 334);
            this._OutputFileTextbox.Name = "_OutputFileTextbox";
            this._OutputFileTextbox.Size = new System.Drawing.Size(274, 20);
            this._OutputFileTextbox.TabIndex = 15;
            this._OutputFileTextbox.Text = "output";
            // 
            // _OutputFileButton
            // 
            this._OutputFileButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this._OutputFileButton.Location = new System.Drawing.Point(376, 332);
            this._OutputFileButton.Name = "_OutputFileButton";
            this._OutputFileButton.Size = new System.Drawing.Size(28, 23);
            this._OutputFileButton.TabIndex = 16;
            this._OutputFileButton.Text = "...";
            this._OutputFileButton.UseVisualStyleBackColor = true;
            this._OutputFileButton.Click += new System.EventHandler(this._OutputFileButton_Click);
            // 
            // _AllButton
            // 
            this._AllButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this._AllButton.Location = new System.Drawing.Point(375, 72);
            this._AllButton.Name = "_AllButton";
            this._AllButton.Size = new System.Drawing.Size(55, 23);
            this._AllButton.TabIndex = 6;
            this._AllButton.Text = "All";
            this._AllButton.UseVisualStyleBackColor = true;
            this._AllButton.Click += new System.EventHandler(this._AllButton_Click);
            // 
            // _NoneButton
            // 
            this._NoneButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this._NoneButton.Location = new System.Drawing.Point(374, 101);
            this._NoneButton.Name = "_NoneButton";
            this._NoneButton.Size = new System.Drawing.Size(56, 23);
            this._NoneButton.TabIndex = 7;
            this._NoneButton.Text = "None";
            this._NoneButton.UseVisualStyleBackColor = true;
            this._NoneButton.Click += new System.EventHandler(this._NoneButton_Click);
            // 
            // _StatusStrip1
            // 
            this._StatusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this._StatusStrip1.Location = new System.Drawing.Point(0, 368);
            this._StatusStrip1.Name = "_StatusStrip1";
            this._StatusStrip1.Size = new System.Drawing.Size(519, 22);
            this._StatusStrip1.TabIndex = 18;
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(118, 17);
            this.toolStripStatusLabel1.Text = "toolStripStatusLabel1";
            // 
            // _MatchLocationsCheckbox
            // 
            this._MatchLocationsCheckbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._MatchLocationsCheckbox.AutoSize = true;
            this._MatchLocationsCheckbox.Location = new System.Drawing.Point(95, 244);
            this._MatchLocationsCheckbox.Name = "_MatchLocationsCheckbox";
            this._MatchLocationsCheckbox.Size = new System.Drawing.Size(173, 17);
            this._MatchLocationsCheckbox.TabIndex = 8;
            this._MatchLocationsCheckbox.Text = "Match breaks against locations";
            this._MatchLocationsCheckbox.UseVisualStyleBackColor = true;
            this._MatchLocationsCheckbox.CheckedChanged += new System.EventHandler(this._MatchLocationsCheckbox_CheckedChanged);
            // 
            // _LocationFileTextbox
            // 
            this._LocationFileTextbox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._LocationFileTextbox.Enabled = false;
            this._LocationFileTextbox.Location = new System.Drawing.Point(95, 267);
            this._LocationFileTextbox.Name = "_LocationFileTextbox";
            this._LocationFileTextbox.Size = new System.Drawing.Size(273, 20);
            this._LocationFileTextbox.TabIndex = 10;
            this._LocationFileTextbox.Text = "Locations.xml";
            // 
            // label5
            // 
            this.label5.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.label5.AutoSize = true;
            this.label5.Enabled = false;
            this.label5.Location = new System.Drawing.Point(7, 270);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(70, 13);
            this.label5.TabIndex = 9;
            this.label5.Text = "Location File:";
            // 
            // _LocationFileButton
            // 
            this._LocationFileButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this._LocationFileButton.Enabled = false;
            this._LocationFileButton.Location = new System.Drawing.Point(374, 265);
            this._LocationFileButton.Name = "_LocationFileButton";
            this._LocationFileButton.Size = new System.Drawing.Size(28, 23);
            this._LocationFileButton.TabIndex = 11;
            this._LocationFileButton.Text = "...";
            this._LocationFileButton.UseVisualStyleBackColor = true;
            this._LocationFileButton.Click += new System.EventHandler(this._LocationFileButton_Click);
            // 
            // _OutputModeCombobox
            // 
            this._OutputModeCombobox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this._OutputModeCombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this._OutputModeCombobox.FormattingEnabled = true;
            this._OutputModeCombobox.Items.AddRange(new object[] {
            "CSV",
            "HTML"});
            this._OutputModeCombobox.Location = new System.Drawing.Point(95, 307);
            this._OutputModeCombobox.Name = "_OutputModeCombobox";
            this._OutputModeCombobox.Size = new System.Drawing.Size(273, 21);
            this._OutputModeCombobox.TabIndex = 13;
            // 
            // label6
            // 
            this.label6.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(5, 310);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(72, 13);
            this.label6.TabIndex = 12;
            this.label6.Text = "Output Mode:";
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(519, 390);
            this.Controls.Add(this.label6);
            this.Controls.Add(this._OutputModeCombobox);
            this.Controls.Add(this._LocationFileButton);
            this.Controls.Add(this.label5);
            this.Controls.Add(this._LocationFileTextbox);
            this.Controls.Add(this._MatchLocationsCheckbox);
            this.Controls.Add(this._StatusStrip1);
            this.Controls.Add(this._NoneButton);
            this.Controls.Add(this._AllButton);
            this.Controls.Add(this._OutputFileButton);
            this.Controls.Add(this._OutputFileTextbox);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this._DriversCheckedlistbox);
            this.Controls.Add(this._DetectButton);
            this.Controls.Add(this._EndDatepicker);
            this.Controls.Add(this.label2);
            this.Controls.Add(this._BeginDatepicker);
            this.Controls.Add(this.label1);
            this.MinimumSize = new System.Drawing.Size(497, 313);
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Driver Break Detector";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this._StatusStrip1.ResumeLayout(false);
            this._StatusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker _BeginDatepicker;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DateTimePicker _EndDatepicker;
        private System.Windows.Forms.Button _DetectButton;
        private System.Windows.Forms.CheckedListBox _DriversCheckedlistbox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox _OutputFileTextbox;
        private System.Windows.Forms.Button _OutputFileButton;
        private System.Windows.Forms.Button _AllButton;
        private System.Windows.Forms.Button _NoneButton;
        private System.Windows.Forms.StatusStrip _StatusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.CheckBox _MatchLocationsCheckbox;
        private System.Windows.Forms.TextBox _LocationFileTextbox;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button _LocationFileButton;
        private System.Windows.Forms.ComboBox _OutputModeCombobox;
        private System.Windows.Forms.Label label6;
    }
}

