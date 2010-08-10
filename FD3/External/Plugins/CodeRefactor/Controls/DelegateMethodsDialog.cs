using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Windows.Forms;
using ASCompletion.Model;
using PluginCore;
using PluginCore.Localization;

namespace CodeRefactor.Controls
{
    public partial class DelegateMethodsDialog : Form
    {
        private System.Windows.Forms.Button btnOK;
        private DividedCheckedListBox checkedListBox;
        private System.Windows.Forms.Button btnCancel;
        private Dictionary<MemberModel, ClassModel> members;
        private Dictionary<string, MemberModel> members2;

        public Dictionary<MemberModel, ClassModel> checkedMembers;

        public DelegateMethodsDialog()
        {
            this.Owner = (Form)PluginBase.MainForm;
            this.Font = PluginBase.Settings.DefaultFont;

            InitializeComponent();

            this.Text = TextHelper.GetString("Title.DelegateMethods");

            btnOK.Focus();
        }

        public void Reset()
        {

        }

        public void FillData(Dictionary<MemberModel, ClassModel> members, ClassModel cm)
        {
            this.members = members;

            members2 = new Dictionary<string, MemberModel>();
            CheckedListBox.ObjectCollection items = checkedListBox.Items;
            items.Clear();
            Dictionary<MemberModel, ClassModel>.KeyCollection keys = members.Keys;
            string separatorInserted = null;
            string label;
            foreach (MemberModel member in keys)
	        {
                string qname = members[member].QualifiedName;
                if (separatorInserted != qname)
                {
                    separatorInserted = qname;
                    items.Add("--- " + qname);
                }
                label = member.ToDeclarationString();
                items.Add(label, false);
                members2.Add(label, member);
	        }
        }

        /// <summary>
        /// Just hides the dialog window when closing
        /// </summary>
        private void DialogClosing(Object sender, CancelEventArgs e)
        {
            e.Cancel = true;
            PluginBase.MainForm.CurrentDocument.Activate();
            members = null;
            this.Hide();
        }

        /// <summary>
        /// Update the dialog args when show is called
        /// </summary>
        public new void Show()
        {
            base.Show();
            this.Reset();
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            this.checkedMembers = new Dictionary<MemberModel, ClassModel>();
            foreach (string item in checkedListBox.CheckedItems)
            {
                if (item.StartsWith("---")) continue;
                checkedMembers[members2[item]] = members[members2[item]];
            }

            CancelEventArgs cancelArgs = new CancelEventArgs(false);
            OnValidating(cancelArgs);
            if (!cancelArgs.Cancel)
            {
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnOK = new System.Windows.Forms.Button();
            this.checkedListBox = new DividedCheckedListBox();
            this.btnCancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnOK
            // 
            this.btnOK.Location = new System.Drawing.Point(164, 225);
            this.btnOK.Name = "btnOK";
            this.btnOK.Size = new System.Drawing.Size(75, 23);
            this.btnOK.TabIndex = 0;
            this.btnOK.Text = "OK";
            this.btnOK.UseVisualStyleBackColor = true;
            this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
            // 
            // checkedListBox
            // 
            this.checkedListBox.CheckOnClick = true;
            this.checkedListBox.FormattingEnabled = true;
            this.checkedListBox.Location = new System.Drawing.Point(4, 5);
            this.checkedListBox.Name = "checkedListBox";
            this.checkedListBox.Size = new System.Drawing.Size(472, 214);
            this.checkedListBox.TabIndex = 2;
            // 
            // btnCancel
            // 
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Location = new System.Drawing.Point(245, 225);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 1;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // DelegateMethodsDiaog
            // 
            this.AcceptButton = this.btnOK;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(480, 253);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.checkedListBox);
            this.Controls.Add(this.btnOK);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "DelegateMethodsDiaog";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.ResumeLayout(false);

        }

        #endregion

        
    }
}
