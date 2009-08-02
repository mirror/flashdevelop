﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Reflection;

using PluginCore;
using PluginCore.Localization;

using ASCompletion.Model;

using ASClassWizard.Wizards;
using ASClassWizard.Resources;


namespace ASClassWizard.Wizards
{
    public partial class ClassBrowser : Form
    {

        private MemberList all;
        private List<GListBox.GListBoxItem> dataProvider;
        private FlagType invalidFlag;
        private FlagType validFlag;

        public MemberList ClassList
        {
            get { return this.all; }
            set { this.all = value; }
        }

        public List<GListBox.GListBoxItem> DataProvider
        {
            get { return this.dataProvider; }
            set { this.dataProvider = value; }
        }

        public FlagType ExcludeFlag
        {
            get { return this.invalidFlag; }
            set { this.invalidFlag = value; }
        }

        public FlagType IncludeFlag
        {
            get { return this.validFlag; }
            set { this.validFlag = value; }
        }

        public string SelectedClass
        {
            get { return this.itemList.SelectedItem != null ? this.itemList.SelectedItem.ToString() : null; }
        }

        public ClassBrowser()
        {
            this.DataProvider = new List<GListBox.GListBoxItem>();
            InitializeComponent();
            InitializeLocalization();
            this.Font = PluginBase.Settings.DefaultFont;
            this.itemList.ImageList =  ASCompletion.Context.ASContext.Panel.TreeIcons;
            CenterToParent();
        }

        private void InitializeLocalization()
        {
            this.cancelButton.Text = TextHelper.GetString("Wizard.Button.SelectNone");
            this.okButton.Text = TextHelper.GetString("Wizard.Button.Ok");
            this.Text = TextHelper.GetString("Wizard.Label.OpenType");
        }

        private void ClassBrowser_Load(object sender, EventArgs e)
        {
            ASClassWizard.Wizards.GListBox.GListBoxItem node;

            this.itemList.BeginUpdate();
            this.itemList.Items.Clear();
            if (this.ClassList != null)
            {
                foreach (MemberModel item in this.ClassList)
                {
                    if (ExcludeFlag > 0) if ((item.Flags & ExcludeFlag) > 0) continue;
                    if (IncludeFlag > 0)
                    {
                        if (!((item.Flags & IncludeFlag) > 0))
                        {
                            continue;
                        }
                    }

                    if (this.itemList.Items.Count > 0 && item.Name == this.itemList.Items[this.itemList.Items.Count - 1].ToString()) continue;

                    node = new ASClassWizard.Wizards.GListBox.GListBoxItem(item.Name, (item.Flags & FlagType.Interface) > 0 ? 6 : 8);
                    this.itemList.Items.Add(node);
                    this.DataProvider.Add(node);
                }
            }
            if (this.itemList.Items.Count > 0)
            {
                this.itemList.SelectedIndex = 0;
            }
            this.itemList.EndUpdate();

            this.filterBox.Focus();
            this.filterBox.SelectAll();
        }

        /// <summary>
        /// Filder the list
        /// </summary>
        private void filterBox_TextChanged( Object sender, EventArgs e)
        {
            string text = this.filterBox.Text;

            this.itemList.BeginUpdate();
            this.itemList.Items.Clear();

            List<GListBox.GListBoxItem> result = this.DataProvider.FindAll( FindAllItems );
            this.itemList.Items.AddRange(result.ToArray());

            this.itemList.EndUpdate();
            if (this.itemList.Items.Count > 0)
                this.itemList.SelectedIndex = 0;
        }


        /// <summary>
        /// Filder the results
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        private bool FindAllItems( GListBox.GListBoxItem item )
        {
            return item.Text.ToLower().IndexOf(this.filterBox.Text.ToLower()) > -1;
        }


        /// <summary>
        /// Select None button click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cancelButton_Click(object sender, EventArgs e)
        {
            this.itemList.SelectedItem = null;
            this.DialogResult = DialogResult.OK;
            this.Close();
        }


        /// <summary>
        /// Ok button click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void okButton_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void itemList_DoubleClick( object sender, EventArgs e )
        {
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void filterBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Up)
            {
                e.SuppressKeyPress = true;
                if (this.itemList.Items.Count > 0 && this.itemList.SelectedIndex > 0)
                    --this.itemList.SelectedIndex;
            }
            else if (e.KeyCode == Keys.Down)
            {
                e.SuppressKeyPress = true;
                if (this.itemList.Items.Count > 0 && this.itemList.SelectedIndex < this.itemList.Items.Count - 1)
                    ++this.itemList.SelectedIndex;
            }
        }
    }
}
