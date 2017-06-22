namespace AgilisQueryTool
{
    partial class AgilisQueryTool
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
            this.MethodName = new System.Windows.Forms.ComboBox();
            this.UserName = new System.Windows.Forms.TextBox();
            this.Password = new System.Windows.Forms.TextBox();
            this.Param1 = new System.Windows.Forms.TextBox();
            this.Param2 = new System.Windows.Forms.TextBox();
            this.Param3 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.Param1Label = new System.Windows.Forms.Label();
            this.Param2Label = new System.Windows.Forms.Label();
            this.Param3Label = new System.Windows.Forms.Label();
            this.LaunchUrl = new System.Windows.Forms.Button();
            this.CopyUrl = new System.Windows.Forms.Button();
            this.Picker1 = new System.Windows.Forms.Button();
            this.Picker2 = new System.Windows.Forms.Button();
            this.Picker3 = new System.Windows.Forms.Button();
            this.UseDemoSite = new System.Windows.Forms.RadioButton();
            this.UseProductionSite = new System.Windows.Forms.RadioButton();
            this.SiteSelectionGroup = new System.Windows.Forms.GroupBox();
            this.SiteSelectionGroup.SuspendLayout();
            this.SuspendLayout();
            // 
            // MethodName
            // 
            this.MethodName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.MethodName.FormattingEnabled = true;
            this.MethodName.Location = new System.Drawing.Point(99, 17);
            this.MethodName.Name = "MethodName";
            this.MethodName.Size = new System.Drawing.Size(167, 21);
            this.MethodName.TabIndex = 1;
            this.MethodName.SelectedIndexChanged += new System.EventHandler(this.MethodName_SelectedIndexChanged);
            // 
            // UserName
            // 
            this.UserName.Location = new System.Drawing.Point(99, 54);
            this.UserName.Name = "UserName";
            this.UserName.Size = new System.Drawing.Size(167, 20);
            this.UserName.TabIndex = 3;
            // 
            // Password
            // 
            this.Password.Location = new System.Drawing.Point(99, 80);
            this.Password.Name = "Password";
            this.Password.PasswordChar = '*';
            this.Password.Size = new System.Drawing.Size(167, 20);
            this.Password.TabIndex = 5;
            // 
            // Param1
            // 
            this.Param1.Location = new System.Drawing.Point(99, 116);
            this.Param1.Name = "Param1";
            this.Param1.Size = new System.Drawing.Size(167, 20);
            this.Param1.TabIndex = 7;
            // 
            // Param2
            // 
            this.Param2.Location = new System.Drawing.Point(99, 142);
            this.Param2.Name = "Param2";
            this.Param2.Size = new System.Drawing.Size(167, 20);
            this.Param2.TabIndex = 10;
            // 
            // Param3
            // 
            this.Param3.Location = new System.Drawing.Point(99, 168);
            this.Param3.Name = "Param3";
            this.Param3.Size = new System.Drawing.Size(167, 20);
            this.Param3.TabIndex = 13;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(79, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Select Method:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 57);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "User Name:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 83);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Password:";
            // 
            // Param1Label
            // 
            this.Param1Label.AutoSize = true;
            this.Param1Label.Location = new System.Drawing.Point(12, 119);
            this.Param1Label.Name = "Param1Label";
            this.Param1Label.Size = new System.Drawing.Size(43, 13);
            this.Param1Label.TabIndex = 6;
            this.Param1Label.Text = "Param1";
            // 
            // Param2Label
            // 
            this.Param2Label.AutoSize = true;
            this.Param2Label.Location = new System.Drawing.Point(12, 145);
            this.Param2Label.Name = "Param2Label";
            this.Param2Label.Size = new System.Drawing.Size(43, 13);
            this.Param2Label.TabIndex = 9;
            this.Param2Label.Text = "Param2";
            // 
            // Param3Label
            // 
            this.Param3Label.AutoSize = true;
            this.Param3Label.Location = new System.Drawing.Point(12, 171);
            this.Param3Label.Name = "Param3Label";
            this.Param3Label.Size = new System.Drawing.Size(43, 13);
            this.Param3Label.TabIndex = 12;
            this.Param3Label.Text = "Param3";
            // 
            // LaunchUrl
            // 
            this.LaunchUrl.Location = new System.Drawing.Point(317, 17);
            this.LaunchUrl.Name = "LaunchUrl";
            this.LaunchUrl.Size = new System.Drawing.Size(102, 35);
            this.LaunchUrl.TabIndex = 15;
            this.LaunchUrl.Text = "Launch URL";
            this.LaunchUrl.UseVisualStyleBackColor = true;
            this.LaunchUrl.Click += new System.EventHandler(this.LaunchUrl_Click);
            // 
            // CopyUrl
            // 
            this.CopyUrl.Location = new System.Drawing.Point(317, 65);
            this.CopyUrl.Name = "CopyUrl";
            this.CopyUrl.Size = new System.Drawing.Size(102, 35);
            this.CopyUrl.TabIndex = 16;
            this.CopyUrl.Text = "Copy URL";
            this.CopyUrl.UseVisualStyleBackColor = true;
            this.CopyUrl.Click += new System.EventHandler(this.CopyUrl_Click);
            // 
            // Picker1
            // 
            this.Picker1.Location = new System.Drawing.Point(272, 114);
            this.Picker1.Name = "Picker1";
            this.Picker1.Size = new System.Drawing.Size(26, 23);
            this.Picker1.TabIndex = 8;
            this.Picker1.Text = "...";
            this.Picker1.UseVisualStyleBackColor = true;
            this.Picker1.Click += new System.EventHandler(this.Picker1_Click);
            // 
            // Picker2
            // 
            this.Picker2.Location = new System.Drawing.Point(272, 140);
            this.Picker2.Name = "Picker2";
            this.Picker2.Size = new System.Drawing.Size(26, 23);
            this.Picker2.TabIndex = 11;
            this.Picker2.Text = "...";
            this.Picker2.UseVisualStyleBackColor = true;
            this.Picker2.Click += new System.EventHandler(this.Picker2_Click);
            // 
            // Picker3
            // 
            this.Picker3.Location = new System.Drawing.Point(272, 166);
            this.Picker3.Name = "Picker3";
            this.Picker3.Size = new System.Drawing.Size(26, 23);
            this.Picker3.TabIndex = 14;
            this.Picker3.Text = "...";
            this.Picker3.UseVisualStyleBackColor = true;
            this.Picker3.Click += new System.EventHandler(this.Picker3_Click);
            // 
            // UseDemoSite
            // 
            this.UseDemoSite.AutoSize = true;
            this.UseDemoSite.Location = new System.Drawing.Point(17, 22);
            this.UseDemoSite.Name = "UseDemoSite";
            this.UseDemoSite.Size = new System.Drawing.Size(53, 17);
            this.UseDemoSite.TabIndex = 0;
            this.UseDemoSite.Text = "Demo";
            this.UseDemoSite.UseVisualStyleBackColor = true;
            // 
            // UseProductionSite
            // 
            this.UseProductionSite.AutoSize = true;
            this.UseProductionSite.Checked = true;
            this.UseProductionSite.Location = new System.Drawing.Point(17, 45);
            this.UseProductionSite.Name = "UseProductionSite";
            this.UseProductionSite.Size = new System.Drawing.Size(76, 17);
            this.UseProductionSite.TabIndex = 1;
            this.UseProductionSite.TabStop = true;
            this.UseProductionSite.Text = "Production";
            this.UseProductionSite.UseVisualStyleBackColor = true;
            // 
            // SiteSelectionGroup
            // 
            this.SiteSelectionGroup.Controls.Add(this.UseDemoSite);
            this.SiteSelectionGroup.Controls.Add(this.UseProductionSite);
            this.SiteSelectionGroup.Location = new System.Drawing.Point(317, 115);
            this.SiteSelectionGroup.Name = "SiteSelectionGroup";
            this.SiteSelectionGroup.Size = new System.Drawing.Size(116, 74);
            this.SiteSelectionGroup.TabIndex = 17;
            this.SiteSelectionGroup.TabStop = false;
            this.SiteSelectionGroup.Text = "Site Selection:";
            // 
            // AgilisQueryTool
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(447, 209);
            this.Controls.Add(this.SiteSelectionGroup);
            this.Controls.Add(this.Picker3);
            this.Controls.Add(this.Picker2);
            this.Controls.Add(this.Picker1);
            this.Controls.Add(this.CopyUrl);
            this.Controls.Add(this.LaunchUrl);
            this.Controls.Add(this.Param3Label);
            this.Controls.Add(this.Param2Label);
            this.Controls.Add(this.Param1Label);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.Param3);
            this.Controls.Add(this.Param2);
            this.Controls.Add(this.Param1);
            this.Controls.Add(this.Password);
            this.Controls.Add(this.UserName);
            this.Controls.Add(this.MethodName);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "AgilisQueryTool";
            this.Text = "Agilis Query Tool";
            this.Load += new System.EventHandler(this.AgilisApiTesterForm_Load);
            this.SiteSelectionGroup.ResumeLayout(false);
            this.SiteSelectionGroup.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox MethodName;
        private System.Windows.Forms.TextBox UserName;
        private System.Windows.Forms.TextBox Password;
        private System.Windows.Forms.TextBox Param1;
        private System.Windows.Forms.TextBox Param2;
        private System.Windows.Forms.TextBox Param3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label Param1Label;
        private System.Windows.Forms.Label Param2Label;
        private System.Windows.Forms.Label Param3Label;
        private System.Windows.Forms.Button LaunchUrl;
        private System.Windows.Forms.Button CopyUrl;
        private System.Windows.Forms.Button Picker1;
        private System.Windows.Forms.Button Picker2;
        private System.Windows.Forms.Button Picker3;
        private System.Windows.Forms.RadioButton UseDemoSite;
        private System.Windows.Forms.RadioButton UseProductionSite;
        private System.Windows.Forms.GroupBox SiteSelectionGroup;
    }
}
