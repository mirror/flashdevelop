namespace System.Windows.Forms
{
	using System;
	using System.Drawing;
	using System.Windows.Forms;
	using System.Collections;
	using System.IO;
	using PluginCore;
	
	/**
	* Finds menu items from the specified XmlBuilder class
	*/
	public class ItemFinder
	{
		/**
		* Variables
		*/
		public XmlBuilder xmlBuilder;
		
		/**
		* Constructor
		*/
		public ItemFinder(XmlBuilder xmlBuilder)
		{
			this.xmlBuilder = xmlBuilder;
		}
		
		#region FindMethods
		
		/**
		* Gets a menu by name
		*/
		public CommandBarMenu GetCommandBarMenu(string name)
		{
			int count = this.xmlBuilder.Menus.Count;
			for(int i = 0; i<count; i++)
			{
				CommandBarMenu menu = (CommandBarMenu)this.xmlBuilder.Menus[i];
				if (menu.Name == name)
				{
					return menu;
				}
			}
			return null;
		}
		
		/**
		* Gets a button by name
		*/
		public CommandBarButton GetCommandBarButton(string name)
		{
			int count = this.xmlBuilder.Buttons.Count;
			for (int i = 0; i<count; i++)
			{
				CommandBarButton button = (CommandBarButton)this.xmlBuilder.Buttons[i];
				if (button.Name == name)
				{
					return button;
				}
			}
			return null;
		}
		
		/**
		* Gets a checkbox by name
		*/
		public CommandBarCheckBox GetCommandBarCheckBox(string name)
		{
			int count = this.xmlBuilder.CheckBoxes.Count;
			for (int i = 0; i<count; i++)
			{
				CommandBarCheckBox checkBox = (CommandBarCheckBox)this.xmlBuilder.CheckBoxes[i];
				if (checkBox.Name == name)
				{
					return checkBox;
				}
			}
			return null;
		}
		
		/**
		* Gets a combobox by name
		*/
		public CommandBarComboBox GetCommandBarComboBox(string name)
		{
			int count = this.xmlBuilder.ComboBoxes.Count;
			for (int i = 0; i<count; i++)
			{
				CommandBarComboBox comboBox = (CommandBarComboBox)this.xmlBuilder.ComboBoxes[i];
				if (comboBox.Name == name)
				{
					return comboBox;
				}
			}
			return null;
		}
		
		/**
		* Gets all items by name
		*/
		public ArrayList GetItemsByName(string name)
		{
			ArrayList results = new ArrayList();
			ArrayList items = this.xmlBuilder.Items;
			int count = items.Count;
			for (int i = 0; i<count; i++) 
			{
				CommandBarItem item = (CommandBarItem)items[i];
				if (item.Name == name) 
				{
					results.Add(item);
				}
			}
			return results;
		}
		
		#endregion
		
	}

}
