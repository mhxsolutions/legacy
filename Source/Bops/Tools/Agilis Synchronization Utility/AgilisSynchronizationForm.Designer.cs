namespace Agilis_Synchronization_Utility
{
    partial class AgilisSynchronizationForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(AgilisSynchronizationForm));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.UserId = new System.Windows.Forms.TextBox();
            this.Password = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.RawFile = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.ImportButton = new System.Windows.Forms.Button();
            this.StartDate = new System.Windows.Forms.DateTimePicker();
            this.EndDate = new System.Windows.Forms.DateTimePicker();
            this.PickRawFile = new System.Windows.Forms.Button();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.ProgressText = new System.Windows.Forms.ToolStripStatusLabel();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.UseMultipleTransactions = new System.Windows.Forms.RadioButton();
            this.UseOneTransaction = new System.Windows.Forms.RadioButton();
            this.ExportButton = new System.Windows.Forms.Button();
            this.NowButton = new System.Windows.Forms.Button();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.UseDemoSystem = new System.Windows.Forms.RadioButton();
            this.UseProductionSystem = new System.Windows.Forms.RadioButton();
            this.DataTypes = new System.Windows.Forms.CheckedListBox();
            this.label7 = new System.Windows.Forms.Label();
            this.SynchronizeButton = new System.Windows.Forms.Button();
            this.FinalizeButton = new System.Windows.Forms.Button();
            this.UseImportFilters = new System.Windows.Forms.CheckBox();
            this.UsePlanDateImport = new System.Windows.Forms.CheckBox();
            this.UseDriverPlanControls = new System.Windows.Forms.CheckBox();
            this.AisSyncButton = new System.Windows.Forms.Button();
            this.SimulationMode = new System.Windows.Forms.CheckBox();
            this.statusStrip1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 71);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(46, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "User ID:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 97);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(56, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Password:";
            // 
            // UserId
            // 
            this.UserId.Location = new System.Drawing.Point(78, 68);
            this.UserId.Name = "UserId";
            this.UserId.Size = new System.Drawing.Size(120, 20);
            this.UserId.TabIndex = 2;
            // 
            // Password
            // 
            this.Password.Location = new System.Drawing.Point(78, 94);
            this.Password.Name = "Password";
            this.Password.PasswordChar = '*';
            this.Password.Size = new System.Drawing.Size(120, 20);
            this.Password.TabIndex = 4;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(13, 125);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(58, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Start Date:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(13, 152);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(55, 13);
            this.label4.TabIndex = 7;
            this.label4.Text = "End Date:";
            // 
            // RawFile
            // 
            this.RawFile.Location = new System.Drawing.Point(77, 185);
            this.RawFile.Name = "RawFile";
            this.RawFile.Size = new System.Drawing.Size(251, 20);
            this.RawFile.TabIndex = 12;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(12, 188);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(51, 13);
            this.label5.TabIndex = 11;
            this.label5.Text = "Raw File:";
            // 
            // label6
            // 
            this.label6.Location = new System.Drawing.Point(12, 14);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(381, 47);
            this.label6.TabIndex = 0;
            this.label6.Text = resources.GetString("label6.Text");
            // 
            // ImportButton
            // 
            this.ImportButton.Location = new System.Drawing.Point(419, 9);
            this.ImportButton.Name = "ImportButton";
            this.ImportButton.Size = new System.Drawing.Size(85, 23);
            this.ImportButton.TabIndex = 21;
            this.ImportButton.Text = "Import";
            this.ImportButton.UseVisualStyleBackColor = true;
            this.ImportButton.Click += new System.EventHandler(this.ImportButton_Click);
            // 
            // StartDate
            // 
            this.StartDate.CustomFormat = "ddd dd MMM yyyy, HH:mm:ss";
            this.StartDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.StartDate.Location = new System.Drawing.Point(77, 122);
            this.StartDate.Name = "StartDate";
            this.StartDate.Size = new System.Drawing.Size(188, 20);
            this.StartDate.TabIndex = 6;
            // 
            // EndDate
            // 
            this.EndDate.CustomFormat = "ddd dd MMM yyyy, HH:mm:ss";
            this.EndDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.EndDate.Location = new System.Drawing.Point(77, 148);
            this.EndDate.Name = "EndDate";
            this.EndDate.Size = new System.Drawing.Size(188, 20);
            this.EndDate.TabIndex = 8;
            // 
            // PickRawFile
            // 
            this.PickRawFile.Location = new System.Drawing.Point(380, 184);
            this.PickRawFile.Name = "PickRawFile";
            this.PickRawFile.Size = new System.Drawing.Size(27, 20);
            this.PickRawFile.TabIndex = 14;
            this.PickRawFile.Text = "...";
            this.PickRawFile.UseVisualStyleBackColor = true;
            this.PickRawFile.Click += new System.EventHandler(this.PickRawFile_Click);
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ProgressText});
            this.statusStrip1.Location = new System.Drawing.Point(0, 405);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(516, 22);
            this.statusStrip1.SizingGrip = false;
            this.statusStrip1.TabIndex = 26;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // ProgressText
            // 
            this.ProgressText.Name = "ProgressText";
            this.ProgressText.Size = new System.Drawing.Size(118, 17);
            this.ProgressText.Text = "toolStripStatusLabel1";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.UseMultipleTransactions);
            this.groupBox1.Controls.Add(this.UseOneTransaction);
            this.groupBox1.Location = new System.Drawing.Point(16, 319);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(256, 74);
            this.groupBox1.TabIndex = 19;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Transaction Mode";
            // 
            // UseMultipleTransactions
            // 
            this.UseMultipleTransactions.AutoSize = true;
            this.UseMultipleTransactions.Location = new System.Drawing.Point(15, 42);
            this.UseMultipleTransactions.Name = "UseMultipleTransactions";
            this.UseMultipleTransactions.Size = new System.Drawing.Size(215, 17);
            this.UseMultipleTransactions.TabIndex = 1;
            this.UseMultipleTransactions.TabStop = true;
            this.UseMultipleTransactions.Text = "Use one transaction for each work order";
            this.UseMultipleTransactions.UseVisualStyleBackColor = true;
            // 
            // UseOneTransaction
            // 
            this.UseOneTransaction.AutoSize = true;
            this.UseOneTransaction.Checked = true;
            this.UseOneTransaction.Location = new System.Drawing.Point(15, 19);
            this.UseOneTransaction.Name = "UseOneTransaction";
            this.UseOneTransaction.Size = new System.Drawing.Size(138, 17);
            this.UseOneTransaction.TabIndex = 0;
            this.UseOneTransaction.TabStop = true;
            this.UseOneTransaction.Text = "Use a single transaction";
            this.UseOneTransaction.UseVisualStyleBackColor = true;
            // 
            // ExportButton
            // 
            this.ExportButton.Location = new System.Drawing.Point(419, 38);
            this.ExportButton.Name = "ExportButton";
            this.ExportButton.Size = new System.Drawing.Size(85, 23);
            this.ExportButton.TabIndex = 22;
            this.ExportButton.Text = "Export (Full)";
            this.ExportButton.UseVisualStyleBackColor = true;
            this.ExportButton.Click += new System.EventHandler(this.ExportButton_Click);
            // 
            // NowButton
            // 
            this.NowButton.Location = new System.Drawing.Point(334, 184);
            this.NowButton.Name = "NowButton";
            this.NowButton.Size = new System.Drawing.Size(40, 20);
            this.NowButton.TabIndex = 13;
            this.NowButton.Text = "Now";
            this.NowButton.UseVisualStyleBackColor = true;
            this.NowButton.Click += new System.EventHandler(this.NowButton_Click);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.UseDemoSystem);
            this.groupBox3.Controls.Add(this.UseProductionSystem);
            this.groupBox3.Location = new System.Drawing.Point(278, 319);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(116, 74);
            this.groupBox3.TabIndex = 20;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Target System";
            // 
            // UseDemoSystem
            // 
            this.UseDemoSystem.AutoSize = true;
            this.UseDemoSystem.Location = new System.Drawing.Point(17, 42);
            this.UseDemoSystem.Name = "UseDemoSystem";
            this.UseDemoSystem.Size = new System.Drawing.Size(53, 17);
            this.UseDemoSystem.TabIndex = 1;
            this.UseDemoSystem.Text = "Demo";
            this.UseDemoSystem.UseVisualStyleBackColor = true;
            this.UseDemoSystem.CheckedChanged += new System.EventHandler(this.UseDemoSystem_CheckedChanged);
            // 
            // UseProductionSystem
            // 
            this.UseProductionSystem.AutoSize = true;
            this.UseProductionSystem.Checked = true;
            this.UseProductionSystem.Location = new System.Drawing.Point(17, 19);
            this.UseProductionSystem.Name = "UseProductionSystem";
            this.UseProductionSystem.Size = new System.Drawing.Size(76, 17);
            this.UseProductionSystem.TabIndex = 0;
            this.UseProductionSystem.TabStop = true;
            this.UseProductionSystem.Text = "Production";
            this.UseProductionSystem.UseVisualStyleBackColor = true;
            this.UseProductionSystem.CheckedChanged += new System.EventHandler(this.UseProductionSystem_CheckedChanged);
            // 
            // DataTypes
            // 
            this.DataTypes.FormattingEnabled = true;
            this.DataTypes.Items.AddRange(new object[] {
            "Drivers",
            "Driver Events",
            "Driver Positions",
            "Work Orders",
            "Work Order Signatures"});
            this.DataTypes.Location = new System.Drawing.Point(271, 89);
            this.DataTypes.Name = "DataTypes";
            this.DataTypes.Size = new System.Drawing.Size(136, 79);
            this.DataTypes.TabIndex = 10;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(291, 75);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(65, 13);
            this.label7.TabIndex = 9;
            this.label7.Text = "Data Types:";
            // 
            // SynchronizeButton
            // 
            this.SynchronizeButton.Location = new System.Drawing.Point(419, 67);
            this.SynchronizeButton.Name = "SynchronizeButton";
            this.SynchronizeButton.Size = new System.Drawing.Size(85, 23);
            this.SynchronizeButton.TabIndex = 23;
            this.SynchronizeButton.Text = "Export (Sync)";
            this.SynchronizeButton.UseVisualStyleBackColor = true;
            this.SynchronizeButton.Click += new System.EventHandler(this.SynchronizeButton_Click);
            // 
            // FinalizeButton
            // 
            this.FinalizeButton.Location = new System.Drawing.Point(419, 97);
            this.FinalizeButton.Name = "FinalizeButton";
            this.FinalizeButton.Size = new System.Drawing.Size(85, 23);
            this.FinalizeButton.TabIndex = 24;
            this.FinalizeButton.Text = "Finalize (Cancel)";
            this.FinalizeButton.UseVisualStyleBackColor = true;
            this.FinalizeButton.Click += new System.EventHandler(this.FinalizeButton_Click);
            // 
            // UseImportFilters
            // 
            this.UseImportFilters.AutoSize = true;
            this.UseImportFilters.Checked = true;
            this.UseImportFilters.CheckState = System.Windows.Forms.CheckState.Checked;
            this.UseImportFilters.Location = new System.Drawing.Point(77, 218);
            this.UseImportFilters.Name = "UseImportFilters";
            this.UseImportFilters.Size = new System.Drawing.Size(217, 17);
            this.UseImportFilters.TabIndex = 15;
            this.UseImportFilters.Text = "Use import filters defined in the database";
            this.UseImportFilters.UseVisualStyleBackColor = true;
            // 
            // UsePlanDateImport
            // 
            this.UsePlanDateImport.AutoSize = true;
            this.UsePlanDateImport.Location = new System.Drawing.Point(77, 287);
            this.UsePlanDateImport.Name = "UsePlanDateImport";
            this.UsePlanDateImport.Size = new System.Drawing.Size(138, 17);
            this.UsePlanDateImport.TabIndex = 18;
            this.UsePlanDateImport.Text = "Use plan date for import";
            this.UsePlanDateImport.UseVisualStyleBackColor = true;
            // 
            // UseDriverPlanControls
            // 
            this.UseDriverPlanControls.AutoSize = true;
            this.UseDriverPlanControls.Checked = true;
            this.UseDriverPlanControls.CheckState = System.Windows.Forms.CheckState.Checked;
            this.UseDriverPlanControls.Location = new System.Drawing.Point(77, 241);
            this.UseDriverPlanControls.Name = "UseDriverPlanControls";
            this.UseDriverPlanControls.Size = new System.Drawing.Size(251, 17);
            this.UseDriverPlanControls.TabIndex = 16;
            this.UseDriverPlanControls.Text = "Use driver plan controls defined in the database";
            this.UseDriverPlanControls.UseVisualStyleBackColor = true;
            // 
            // AisSyncButton
            // 
            this.AisSyncButton.Location = new System.Drawing.Point(419, 126);
            this.AisSyncButton.Name = "AisSyncButton";
            this.AisSyncButton.Size = new System.Drawing.Size(85, 23);
            this.AisSyncButton.TabIndex = 25;
            this.AisSyncButton.Text = "Run AIS Sync";
            this.AisSyncButton.UseVisualStyleBackColor = true;
            this.AisSyncButton.Click += new System.EventHandler(this.AisSyncButton_Click);
            // 
            // SimulationMode
            // 
            this.SimulationMode.AutoSize = true;
            this.SimulationMode.Checked = true;
            this.SimulationMode.CheckState = System.Windows.Forms.CheckState.Checked;
            this.SimulationMode.Location = new System.Drawing.Point(77, 264);
            this.SimulationMode.Name = "SimulationMode";
            this.SimulationMode.Size = new System.Drawing.Size(134, 17);
            this.SimulationMode.TabIndex = 17;
            this.SimulationMode.Text = "Simulate outgoing calls";
            this.SimulationMode.UseVisualStyleBackColor = true;
            // 
            // AgilisSynchronizationForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(516, 427);
            this.Controls.Add(this.SimulationMode);
            this.Controls.Add(this.AisSyncButton);
            this.Controls.Add(this.UseDriverPlanControls);
            this.Controls.Add(this.UsePlanDateImport);
            this.Controls.Add(this.UseImportFilters);
            this.Controls.Add(this.FinalizeButton);
            this.Controls.Add(this.SynchronizeButton);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.DataTypes);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.NowButton);
            this.Controls.Add(this.ExportButton);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.PickRawFile);
            this.Controls.Add(this.EndDate);
            this.Controls.Add(this.StartDate);
            this.Controls.Add(this.ImportButton);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.RawFile);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.Password);
            this.Controls.Add(this.UserId);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "AgilisSynchronizationForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Agilis Synchronization Utility";
            this.Load += new System.EventHandler(this.AgilisSynchronizationForm_Load);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox UserId;
        private System.Windows.Forms.TextBox Password;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox RawFile;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button ImportButton;
        private System.Windows.Forms.DateTimePicker StartDate;
        private System.Windows.Forms.DateTimePicker EndDate;
        private System.Windows.Forms.Button PickRawFile;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel ProgressText;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton UseMultipleTransactions;
        private System.Windows.Forms.RadioButton UseOneTransaction;
        private System.Windows.Forms.Button ExportButton;
        private System.Windows.Forms.Button NowButton;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.RadioButton UseDemoSystem;
        private System.Windows.Forms.RadioButton UseProductionSystem;
        private System.Windows.Forms.CheckedListBox DataTypes;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Button SynchronizeButton;
        private System.Windows.Forms.Button FinalizeButton;
        private System.Windows.Forms.CheckBox UseImportFilters;
        private System.Windows.Forms.CheckBox UsePlanDateImport;
        private System.Windows.Forms.CheckBox UseDriverPlanControls;
        private System.Windows.Forms.Button AisSyncButton;
        private System.Windows.Forms.CheckBox SimulationMode;
    }
}