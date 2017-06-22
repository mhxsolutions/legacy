namespace Agilis_Plan_Utility
{
    partial class AgilisPlanForm
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
            this.components = new System.ComponentModel.Container();
            this.listView1 = new System.Windows.Forms.ListView();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.copyWorkOrderNumberToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.queryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.yesterdaysPlanToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.todaysPlanToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tomorrowToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.fromFileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.clearToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.edotToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.findToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.actionsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cancelToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.querySignaturesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.checkDriversForTomorrowsPlanToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.checkIfTomorrowsPlanIsReadyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.contextMenuStrip1.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // listView1
            // 
            this.listView1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.listView1.ContextMenuStrip = this.contextMenuStrip1;
            this.listView1.FullRowSelect = true;
            this.listView1.GridLines = true;
            this.listView1.Location = new System.Drawing.Point(12, 36);
            this.listView1.Name = "listView1";
            this.listView1.Size = new System.Drawing.Size(744, 399);
            this.listView1.TabIndex = 0;
            this.listView1.UseCompatibleStateImageBehavior = false;
            this.listView1.View = System.Windows.Forms.View.Details;
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.copyWorkOrderNumberToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(210, 26);
            // 
            // copyWorkOrderNumberToolStripMenuItem
            // 
            this.copyWorkOrderNumberToolStripMenuItem.Name = "copyWorkOrderNumberToolStripMenuItem";
            this.copyWorkOrderNumberToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
            this.copyWorkOrderNumberToolStripMenuItem.Text = "Copy Work Order Number";
            this.copyWorkOrderNumberToolStripMenuItem.Click += new System.EventHandler(this.copyWorkOrderNumberToolStripMenuItem_Click);
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 448);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(768, 22);
            this.statusStrip1.TabIndex = 1;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(109, 17);
            this.toolStripStatusLabel1.Text = "toolStripStatusLabel1";
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.queryToolStripMenuItem,
            this.edotToolStripMenuItem,
            this.actionsToolStripMenuItem,
            this.toolsToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(768, 24);
            this.menuStrip1.TabIndex = 2;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // queryToolStripMenuItem
            // 
            this.queryToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.yesterdaysPlanToolStripMenuItem,
            this.todaysPlanToolStripMenuItem,
            this.tomorrowToolStripMenuItem,
            this.fromFileToolStripMenuItem,
            this.clearToolStripMenuItem,
            this.toolStripSeparator1,
            this.exitToolStripMenuItem});
            this.queryToolStripMenuItem.Name = "queryToolStripMenuItem";
            this.queryToolStripMenuItem.Size = new System.Drawing.Size(49, 20);
            this.queryToolStripMenuItem.Text = "Query";
            // 
            // yesterdaysPlanToolStripMenuItem
            // 
            this.yesterdaysPlanToolStripMenuItem.Name = "yesterdaysPlanToolStripMenuItem";
            this.yesterdaysPlanToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.yesterdaysPlanToolStripMenuItem.Text = "Yesterday";
            this.yesterdaysPlanToolStripMenuItem.Click += new System.EventHandler(this.yesterdaysPlanToolStripMenuItem_Click);
            // 
            // todaysPlanToolStripMenuItem
            // 
            this.todaysPlanToolStripMenuItem.Name = "todaysPlanToolStripMenuItem";
            this.todaysPlanToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.todaysPlanToolStripMenuItem.Text = "Today";
            this.todaysPlanToolStripMenuItem.Click += new System.EventHandler(this.todaysPlanToolStripMenuItem_Click);
            // 
            // tomorrowToolStripMenuItem
            // 
            this.tomorrowToolStripMenuItem.Name = "tomorrowToolStripMenuItem";
            this.tomorrowToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.tomorrowToolStripMenuItem.Text = "Tomorrow";
            this.tomorrowToolStripMenuItem.Click += new System.EventHandler(this.tomorrowToolStripMenuItem_Click);
            // 
            // fromFileToolStripMenuItem
            // 
            this.fromFileToolStripMenuItem.Name = "fromFileToolStripMenuItem";
            this.fromFileToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.fromFileToolStripMenuItem.Text = "From File...";
            this.fromFileToolStripMenuItem.Click += new System.EventHandler(this.fromFileToolStripMenuItem_Click);
            // 
            // clearToolStripMenuItem
            // 
            this.clearToolStripMenuItem.Name = "clearToolStripMenuItem";
            this.clearToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.clearToolStripMenuItem.Text = "Clear";
            this.clearToolStripMenuItem.Click += new System.EventHandler(this.clearToolStripMenuItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(149, 6);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.exitToolStripMenuItem.Text = "Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // edotToolStripMenuItem
            // 
            this.edotToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.findToolStripMenuItem});
            this.edotToolStripMenuItem.Name = "edotToolStripMenuItem";
            this.edotToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
            this.edotToolStripMenuItem.Text = "Edit";
            // 
            // findToolStripMenuItem
            // 
            this.findToolStripMenuItem.Name = "findToolStripMenuItem";
            this.findToolStripMenuItem.ShortcutKeyDisplayString = "Ctrl+F";
            this.findToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.F)));
            this.findToolStripMenuItem.Size = new System.Drawing.Size(155, 22);
            this.findToolStripMenuItem.Text = "Find...";
            this.findToolStripMenuItem.Click += new System.EventHandler(this.findToolStripMenuItem_Click);
            // 
            // actionsToolStripMenuItem
            // 
            this.actionsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cancelToolStripMenuItem,
            this.querySignaturesToolStripMenuItem});
            this.actionsToolStripMenuItem.Name = "actionsToolStripMenuItem";
            this.actionsToolStripMenuItem.Size = new System.Drawing.Size(54, 20);
            this.actionsToolStripMenuItem.Text = "Actions";
            // 
            // cancelToolStripMenuItem
            // 
            this.cancelToolStripMenuItem.Name = "cancelToolStripMenuItem";
            this.cancelToolStripMenuItem.Size = new System.Drawing.Size(181, 22);
            this.cancelToolStripMenuItem.Text = "Cancel";
            this.cancelToolStripMenuItem.Click += new System.EventHandler(this.cancelToolStripMenuItem_Click);
            // 
            // querySignaturesToolStripMenuItem
            // 
            this.querySignaturesToolStripMenuItem.Name = "querySignaturesToolStripMenuItem";
            this.querySignaturesToolStripMenuItem.Size = new System.Drawing.Size(181, 22);
            this.querySignaturesToolStripMenuItem.Text = "Query Signatures...";
            this.querySignaturesToolStripMenuItem.Click += new System.EventHandler(this.querySignaturesToolStripMenuItem_Click);
            // 
            // toolsToolStripMenuItem
            // 
            this.toolsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.checkDriversForTomorrowsPlanToolStripMenuItem,
            this.checkIfTomorrowsPlanIsReadyToolStripMenuItem});
            this.toolsToolStripMenuItem.Name = "toolsToolStripMenuItem";
            this.toolsToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
            this.toolsToolStripMenuItem.Text = "Tools";
            // 
            // checkDriversForTomorrowsPlanToolStripMenuItem
            // 
            this.checkDriversForTomorrowsPlanToolStripMenuItem.Name = "checkDriversForTomorrowsPlanToolStripMenuItem";
            this.checkDriversForTomorrowsPlanToolStripMenuItem.Size = new System.Drawing.Size(249, 22);
            this.checkDriversForTomorrowsPlanToolStripMenuItem.Text = "Check Drivers for Tomorrow\'s Plan";
            this.checkDriversForTomorrowsPlanToolStripMenuItem.Click += new System.EventHandler(this.checkDriversForTomorrowsPlanToolStripMenuItem_Click);
            // 
            // checkIfTomorrowsPlanIsReadyToolStripMenuItem
            // 
            this.checkIfTomorrowsPlanIsReadyToolStripMenuItem.Name = "checkIfTomorrowsPlanIsReadyToolStripMenuItem";
            this.checkIfTomorrowsPlanIsReadyToolStripMenuItem.Size = new System.Drawing.Size(249, 22);
            this.checkIfTomorrowsPlanIsReadyToolStripMenuItem.Text = "Check if Tomorrow\'s Plan is Ready";
            this.checkIfTomorrowsPlanIsReadyToolStripMenuItem.Click += new System.EventHandler(this.checkIfTomorrowsPlanIsReadyToolStripMenuItem_Click);
            // 
            // AgilisPlanForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(768, 470);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.menuStrip1);
            this.Controls.Add(this.listView1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "AgilisPlanForm";
            this.Text = "Agilis Plan Utility";
            this.contextMenuStrip1.ResumeLayout(false);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListView listView1;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem queryToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem yesterdaysPlanToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem todaysPlanToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem tomorrowToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem fromFileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem toolsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem checkDriversForTomorrowsPlanToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem actionsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cancelToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem querySignaturesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem edotToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem findToolStripMenuItem;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.ToolStripMenuItem copyWorkOrderNumberToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem checkIfTomorrowsPlanIsReadyToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem clearToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
    }
}

