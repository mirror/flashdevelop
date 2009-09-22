using System;
using System.Windows.Forms;
using System.ComponentModel;
using PluginCore.Localization;
using FlashDevelop;

namespace CodeRefactor.Controls
{
    public class ProgressDialog : Form
    {
        private Boolean m_IsRunning = false;
        private System.Windows.Forms.Label labelStatus;
        private System.Windows.Forms.Button closeButton;
        private System.Windows.Forms.ProgressBar progressBar;

        public ProgressDialog()
        {
            this.Owner = Globals.MainForm;
            this.Font = Globals.Settings.DefaultFont;
            this.InitializeComponent();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.closeButton = new System.Windows.Forms.Button();
            this.labelStatus = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // progressBar
            // 
            this.progressBar.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.progressBar.Location = new System.Drawing.Point(12, 23);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new System.Drawing.Size(491, 14);
            this.progressBar.TabIndex = 0;
            this.progressBar.UseWaitCursor = true;
            // 
            // closeButton
            // 
            this.closeButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.closeButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.closeButton.Location = new System.Drawing.Point(0, 0);
            this.closeButton.Name = "closeButton";
            this.closeButton.Size = new System.Drawing.Size(0, 0);
            this.closeButton.TabIndex = 29;
            this.closeButton.TabStop = false;
            this.closeButton.UseWaitCursor = true;
            this.closeButton.Click += new System.EventHandler(this.CloseButtonClick);
            this.closeButton.Enabled = false;
            // 
            // labelStatus
            // 
            this.labelStatus.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.labelStatus.AutoEllipsis = true;
            this.labelStatus.AutoSize = true;
            this.labelStatus.BackColor = System.Drawing.SystemColors.Control;
            this.labelStatus.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.labelStatus.ForeColor = System.Drawing.SystemColors.ControlText;
            this.labelStatus.Location = new System.Drawing.Point(12, 7);
            this.labelStatus.Name = "labelStatus";
            this.labelStatus.Size = new System.Drawing.Size(43, 13);
            this.labelStatus.TabIndex = 0;
            this.labelStatus.Text = "Status: ";
            this.labelStatus.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.labelStatus.UseWaitCursor = true;
            // 
            // FindingReferencesDialogue
            //
            this.CancelButton = this.closeButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(515, 49);
            this.Controls.Add(this.labelStatus);
            this.Controls.Add(this.progressBar);
            this.Controls.Add(this.closeButton);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.Text = "Finding References...";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Load += new System.EventHandler(this.DialogLoaded);
            this.VisibleChanged += new System.EventHandler(this.VisibleChange);
            this.Closing += new System.ComponentModel.CancelEventHandler(this.DialogClosing);
            this.Name = "FindingReferencesDialog";
            this.UseWaitCursor = true;
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        #region Methods And Event Handlers

        /// <summary>
        /// Closes the dialog window
        /// </summary>
        private void CloseButtonClick(Object sender, EventArgs e)
        {
            //if (!this.m_IsRunning)
            //{
            //    this.Close();
            //}
        }

        /// <summary>
        /// 
        /// </summary>
        public void Reset()
        {
            UpdateProgress(0);
            UpdateStatusMessage(String.Empty);
        }

        /// <summary>
        /// Runner reports how much of the lookup is done
        /// </summary>
        public void UpdateProgress(Int32 percentDone)
        {
            this.progressBar.Value = percentDone;
        }

        /// <summary>
        /// 
        /// </summary>
        public void UpdateStatusMessage(String message)
        {
            this.labelStatus.Text = TextHelper.GetString("Info.Status") + " " + message;
            this.labelStatus.Update();
        }

        /// <summary>
        /// Just hides the dialog window when closing
        /// </summary>
        private void DialogClosing(Object sender, CancelEventArgs e)
        {
            e.Cancel = true;
            Globals.CurrentDocument.Activate();
            this.Hide();
        }
        
        /// <summary>
        /// Setups the dialog on load
        /// </summary>
        private void DialogLoaded(Object sender, System.EventArgs e)
        {
            //String message = TextHelper.GetString("Info.NoMatches");
            //this.txtStatus.Text = String.Empty;
        }

        /// <summary>
        /// Some event handling when showing the form
        /// </summary>
        private void VisibleChange(Object sender, System.EventArgs e)
        {
            if (this.Visible)
            {
                this.CenterToParent();
            }
        }

        /// <summary>
        /// Update the dialog args when show is called
        /// </summary>
        public new void Show()
        {
            base.Show();
            this.Reset();
        }

        /// <summary>
        /// 
        /// </summary>
        public void SetTitle(String title)
        {
            this.Text = title;
        }

        #endregion

    }

}
