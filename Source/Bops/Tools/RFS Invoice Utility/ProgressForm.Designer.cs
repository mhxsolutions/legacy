namespace BopsUtilities
{
    partial class ProgressForm
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
            this.TopLevelDescription = new System.Windows.Forms.Label();
            this.ItemDescription = new System.Windows.Forms.Label();
            this.WorkProgressbar = new System.Windows.Forms.ProgressBar();
            this.AbortButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // TopLevelDescription
            // 
            this.TopLevelDescription.Location = new System.Drawing.Point(12, 9);
            this.TopLevelDescription.Name = "TopLevelDescription";
            this.TopLevelDescription.Size = new System.Drawing.Size(460, 39);
            this.TopLevelDescription.TabIndex = 0;
            this.TopLevelDescription.Text = "Top level description goes here.";
            // 
            // ItemDescription
            // 
            this.ItemDescription.Location = new System.Drawing.Point(12, 61);
            this.ItemDescription.Name = "ItemDescription";
            this.ItemDescription.Size = new System.Drawing.Size(460, 39);
            this.ItemDescription.TabIndex = 0;
            this.ItemDescription.Text = "Item level description goes here.";
            // 
            // WorkProgressbar
            // 
            this.WorkProgressbar.Location = new System.Drawing.Point(15, 121);
            this.WorkProgressbar.Name = "WorkProgressbar";
            this.WorkProgressbar.Size = new System.Drawing.Size(457, 23);
            this.WorkProgressbar.TabIndex = 1;
            // 
            // AbortButton
            // 
            this.AbortButton.Location = new System.Drawing.Point(212, 150);
            this.AbortButton.Name = "AbortButton";
            this.AbortButton.Size = new System.Drawing.Size(75, 23);
            this.AbortButton.TabIndex = 2;
            this.AbortButton.Text = "Abort";
            this.AbortButton.UseVisualStyleBackColor = true;
            this.AbortButton.Click += new System.EventHandler(this.AbortButton_Click);
            // 
            // ProgressForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(484, 186);
            this.Controls.Add(this.AbortButton);
            this.Controls.Add(this.WorkProgressbar);
            this.Controls.Add(this.ItemDescription);
            this.Controls.Add(this.TopLevelDescription);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "ProgressForm";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Progress Form";
            this.TopMost = true;
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label TopLevelDescription;
        private System.Windows.Forms.Label ItemDescription;
        private System.Windows.Forms.ProgressBar WorkProgressbar;
        private System.Windows.Forms.Button AbortButton;
    }
}