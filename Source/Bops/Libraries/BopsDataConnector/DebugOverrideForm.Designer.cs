namespace BopsDataConnector
{
    partial class DebugOverrideForm
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
            this.OkButton = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.SqlServerNameTextbox = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.DatabaseNameTextbox = new System.Windows.Forms.TextBox();
            this.UseForAllDatabasesCheckbox = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(369, 38);
            this.label1.TabIndex = 4;
            this.label1.Text = "An NHibernate session factory is about to be created for the specified database. " +
                "You may re-route to a different SQL Server instance if desired.";
            // 
            // OkButton
            // 
            this.OkButton.Location = new System.Drawing.Point(383, 8);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(75, 23);
            this.OkButton.TabIndex = 3;
            this.OkButton.Text = "OK";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 84);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(96, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "SQL Server Name:";
            // 
            // SqlServerNameTextbox
            // 
            this.SqlServerNameTextbox.Location = new System.Drawing.Point(122, 81);
            this.SqlServerNameTextbox.Name = "SqlServerNameTextbox";
            this.SqlServerNameTextbox.Size = new System.Drawing.Size(226, 20);
            this.SqlServerNameTextbox.TabIndex = 1;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(16, 55);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(87, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Database Name:";
            // 
            // DatabaseNameTextbox
            // 
            this.DatabaseNameTextbox.Location = new System.Drawing.Point(122, 55);
            this.DatabaseNameTextbox.Name = "DatabaseNameTextbox";
            this.DatabaseNameTextbox.ReadOnly = true;
            this.DatabaseNameTextbox.Size = new System.Drawing.Size(226, 20);
            this.DatabaseNameTextbox.TabIndex = 6;
            // 
            // UseForAllDatabasesCheckbox
            // 
            this.UseForAllDatabasesCheckbox.AutoSize = true;
            this.UseForAllDatabasesCheckbox.Location = new System.Drawing.Point(122, 108);
            this.UseForAllDatabasesCheckbox.Name = "UseForAllDatabasesCheckbox";
            this.UseForAllDatabasesCheckbox.Size = new System.Drawing.Size(202, 17);
            this.UseForAllDatabasesCheckbox.TabIndex = 2;
            this.UseForAllDatabasesCheckbox.Text = "Use this SQL Server for all databases";
            this.UseForAllDatabasesCheckbox.UseVisualStyleBackColor = true;
            // 
            // DebugOverrideForm
            // 
            this.AcceptButton = this.OkButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(470, 138);
            this.Controls.Add(this.UseForAllDatabasesCheckbox);
            this.Controls.Add(this.DatabaseNameTextbox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.SqlServerNameTextbox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.OkButton);
            this.Controls.Add(this.label1);
            this.Name = "DebugOverrideForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "BopsDataConnector Debug Override";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox SqlServerNameTextbox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox DatabaseNameTextbox;
        private System.Windows.Forms.CheckBox UseForAllDatabasesCheckbox;
    }
}