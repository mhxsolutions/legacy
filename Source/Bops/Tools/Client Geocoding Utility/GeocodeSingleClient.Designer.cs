namespace Client_Geocoding_Utility
{
    partial class GeocodeSingleClient
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
            this.ClientCombobox = new System.Windows.Forms.ComboBox();
            this.LookupButton = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.LatitudeTextbox = new System.Windows.Forms.TextBox();
            this.LongitudeTextbox = new System.Windows.Forms.TextBox();
            this.UpdateDatabaseButton = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.CloseButton = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(36, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Client:";
            // 
            // ClientCombobox
            // 
            this.ClientCombobox.FormattingEnabled = true;
            this.ClientCombobox.Location = new System.Drawing.Point(54, 12);
            this.ClientCombobox.Name = "ClientCombobox";
            this.ClientCombobox.Size = new System.Drawing.Size(327, 21);
            this.ClientCombobox.TabIndex = 1;
            // 
            // LookupButton
            // 
            this.LookupButton.Location = new System.Drawing.Point(398, 10);
            this.LookupButton.Name = "LookupButton";
            this.LookupButton.Size = new System.Drawing.Size(75, 23);
            this.LookupButton.TabIndex = 2;
            this.LookupButton.Text = "Lookup";
            this.LookupButton.UseVisualStyleBackColor = true;
            this.LookupButton.Click += new System.EventHandler(this.LookupButton_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 28);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(48, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "Latitude:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(13, 54);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(57, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Longitude:";
            // 
            // LatitudeTextbox
            // 
            this.LatitudeTextbox.Location = new System.Drawing.Point(76, 25);
            this.LatitudeTextbox.Name = "LatitudeTextbox";
            this.LatitudeTextbox.Size = new System.Drawing.Size(86, 20);
            this.LatitudeTextbox.TabIndex = 1;
            // 
            // LongitudeTextbox
            // 
            this.LongitudeTextbox.Location = new System.Drawing.Point(76, 51);
            this.LongitudeTextbox.Name = "LongitudeTextbox";
            this.LongitudeTextbox.Size = new System.Drawing.Size(86, 20);
            this.LongitudeTextbox.TabIndex = 3;
            // 
            // UpdateDatabaseButton
            // 
            this.UpdateDatabaseButton.Enabled = false;
            this.UpdateDatabaseButton.Location = new System.Drawing.Point(182, 25);
            this.UpdateDatabaseButton.Name = "UpdateDatabaseButton";
            this.UpdateDatabaseButton.Size = new System.Drawing.Size(123, 23);
            this.UpdateDatabaseButton.TabIndex = 4;
            this.UpdateDatabaseButton.Text = "Update Database";
            this.UpdateDatabaseButton.UseVisualStyleBackColor = true;
            this.UpdateDatabaseButton.Click += new System.EventHandler(this.UpdateDatabaseButton_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.UpdateDatabaseButton);
            this.groupBox1.Controls.Add(this.LongitudeTextbox);
            this.groupBox1.Controls.Add(this.LatitudeTextbox);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Location = new System.Drawing.Point(58, 46);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(323, 97);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Geocoding Results:";
            // 
            // CloseButton
            // 
            this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CloseButton.Location = new System.Drawing.Point(398, 39);
            this.CloseButton.Name = "CloseButton";
            this.CloseButton.Size = new System.Drawing.Size(75, 23);
            this.CloseButton.TabIndex = 4;
            this.CloseButton.Text = "Close";
            this.CloseButton.UseVisualStyleBackColor = true;
            // 
            // GeocodeSingleClient
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.CloseButton;
            this.CausesValidation = false;
            this.ClientSize = new System.Drawing.Size(486, 163);
            this.Controls.Add(this.CloseButton);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.LookupButton);
            this.Controls.Add(this.ClientCombobox);
            this.Controls.Add(this.label1);
            this.Name = "GeocodeSingleClient";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Geocode Single Client";
            this.Load += new System.EventHandler(this.GeocodeSingleClient_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox ClientCombobox;
        private System.Windows.Forms.Button LookupButton;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox LatitudeTextbox;
        private System.Windows.Forms.TextBox LongitudeTextbox;
        private System.Windows.Forms.Button UpdateDatabaseButton;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button CloseButton;
    }
}