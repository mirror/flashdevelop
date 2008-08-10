namespace System.Windows.Forms
{
	using System;
	using System.Drawing;
	using System.Windows.Forms;
	using System.Collections;
	using System.ComponentModel;
	using System.IO;
	using System.Xml;
	using PluginCore;

	/**
	* Builds menu items from xml files
	*/
	public class XmlBuilder
	{
		/**
		* Variables
		*/
		public ArrayList Items;
		public ArrayList Menus;
		public ArrayList Shortcuts;
		public ArrayList CheckBoxes;
		public ArrayList ComboBoxes;
		public ArrayList Buttons;
		public CommandBarManager Manager;
		public Form OwnerForm;
		public Images Images;
		
		/**
		* Constructor
		*/
		public XmlBuilder(Form ownerForm, Images images)
		{
			this.Items = new ArrayList();
			this.Menus = new ArrayList();
			this.Buttons = new ArrayList();
			this.CheckBoxes = new ArrayList();
			this.ComboBoxes = new ArrayList();
			this.Shortcuts = new ArrayList();
			this.OwnerForm = ownerForm;
			this.Images = images;
		}
		
		#region MethodsAndEventHandlers
		
		/**
		* Loads the specified xml file
		*/
		public XmlNode LoadXMLFile(string xmlFileName)
		{
			XmlDocument xmlDoc = new XmlDocument();
			xmlDoc.PreserveWhitespace = false;
			try
			{
				xmlDoc.Load(xmlFileName);
				try
				{
					XmlNode declNode = xmlDoc.FirstChild;
					XmlNode rootNode = declNode.NextSibling;
					return rootNode;
				}
				catch (Exception ex1)
				{
					ErrorHandler.ShowError("Could not handle the specified xml file.", ex1);
					return null;
				}
			}
			catch (Exception ex2)
			{
				ErrorHandler.ShowError("Could not load the specified xml file.", ex2);
				return null;
			}
		}
		
		/**
		* Creates a main menu from the specified xml file
		*/
		public CommandBar GenerateMainMenu(string menuXmlFile)
		{
			CommandBar mainMenu = new CommandBar(CommandBarStyle.Menu);
			XmlNode rootNode = this.LoadXMLFile(menuXmlFile);
			int count = rootNode.ChildNodes.Count;
			for (int i = 0; i<count; i++)
			{
				if (rootNode.ChildNodes[i].Name == "menu")
				{
					mainMenu.Items.Add(this.GetMenu(rootNode.ChildNodes[i]));
				}
			}
			return mainMenu;
		}
		
		/**
		* Creates a toolbar from the specified xml file
		*/
		public CommandBar GenerateToolBar(string toolbarXmlFile)
		{
			CommandBar toolBar = new CommandBar(CommandBarStyle.ToolBar);
			XmlNode rootNode = this.LoadXMLFile(toolbarXmlFile);
			int count = rootNode.ChildNodes.Count;
			for (int i = 0; i<count; i++)
			{
				if (rootNode.ChildNodes[i].Name == "button")
				{
					toolBar.Items.Add(this.GetButton(rootNode.ChildNodes[i]));
				}
				else if (rootNode.ChildNodes[i].Name == "combobox")
				{
					toolBar.Items.Add(this.GetComboBox(rootNode.ChildNodes[i]));
				}
				else if (rootNode.ChildNodes[i].Name == "checkbox")
				{
					toolBar.Items.Add(this.GetCheckBox(rootNode.ChildNodes[i]));
				}
				else if (rootNode.ChildNodes[i].Name == "separator")
				{
					toolBar.Items.AddSeparator();
				}
			}
			return toolBar;
		}
		
		/**
		* Creates a context menu from the specified xml file
		*/
		public CommandBarContextMenu GenerateContextMenu(string contextMenuXmlFile)
		{
			CommandBarContextMenu contextMenu = new CommandBarContextMenu();
			XmlNode rootNode = this.LoadXMLFile(contextMenuXmlFile);
			int count = rootNode.ChildNodes.Count;
			for (int i = 0; i<count; i++)
			{
				if (rootNode.ChildNodes[i].Name == "button")
				{
					contextMenu.Items.Add(this.GetButton(rootNode.ChildNodes[i]));
				}
				else if (rootNode.ChildNodes[i].Name == "menu")
				{
					contextMenu.Items.Add(this.GetMenu(rootNode.ChildNodes[i]));
				}
				else if (rootNode.ChildNodes[i].Name == "checkbox")
				{
					contextMenu.Items.Add(this.GetCheckBox(rootNode.ChildNodes[i]));
				}
				else if (rootNode.ChildNodes[i].Name == "separator")
				{
					contextMenu.Items.AddSeparator();
				}
			}
			return contextMenu;
		}
		
		/**
		* Creates a menu from the specified xml node
		*/
		public CommandBarMenu GetMenu(XmlNode node)
		{
			CommandBarMenu menu = new CommandBarMenu();
			if (this.HasAttribute(node, "label"))
			{
				menu.Text = this.GetAttribute(node, "label");
			}
			if (this.HasAttribute(node, "image"))
			{
				string image = this.GetAttribute(node, "image");
				menu.Image = this.Images.GetImage(Convert.ToInt32(image));
			}
			if (this.HasAttribute(node, "name"))
			{
				string name = this.GetAttribute(node, "name");
				menu.Name = name;
			}
			if (this.HasAttribute(node, "enabled"))
			{
				string enabled = this.GetAttribute(node, "enabled");
				menu.IsEnabled = Convert.ToBoolean(enabled);
			}
			if (this.HasAttribute(node, "visible"))
			{
				string visible = this.GetAttribute(node, "visible");
				menu.IsVisible = Convert.ToBoolean(visible);
			}
			if(this.HasAttribute(node, "dropdown"))
			{
				string dropDown = this.GetAttribute(node, "dropdown");
				menu.DropDown += this.ToClickHandler(dropDown);
			}
			if (this.HasAttribute(node, "propertychanged"))
			{
				string propertyChanged = this.GetAttribute(node, "propertychanged");
				menu.PropertyChanged += this.ToChangedHandler(propertyChanged);
			}
			if (this.HasAttribute(node, "tag"))
			{
				string tag = this.GetAttribute(node, "tag");
				menu.Tag = tag;
			}
			int count = node.ChildNodes.Count;
			for (int i = 0; i<count; i++)
			{
				if (node.ChildNodes[i].Name == "menu")
				{
					ArrayList menuItem = new ArrayList();
					menuItem.Add(this.GetMenu(node.ChildNodes[i]));
					menu.Items.AddRange(menuItem);
				}
				if (node.ChildNodes[i].Name == "button")
				{
					menu.Items.Add(this.GetButton(node.ChildNodes[i]));
				}
				if (node.ChildNodes[i].Name == "checkbox")
				{
					menu.Items.Add(this.GetCheckBox(node.ChildNodes[i]));
				}
				if (node.ChildNodes[i].Name == "separator")
				{
					menu.Items.AddSeparator();
				}
			}
			this.Items.Add(menu);
			this.Menus.Add(menu);
			return menu;
		}
		
		/**
		* Creates a button from the specified xml node
		*/
		public CommandBarButton GetButton(XmlNode node)
		{
			CommandBarButton button = new CommandBarButton();
			if (this.HasAttribute(node, "label"))
			{
				button.Text = this.GetAttribute(node, "label");
			}
			if (this.HasAttribute(node, "image"))
			{
				string image = this.GetAttribute(node, "image");
				button.Image = this.Images.GetImage(Convert.ToInt16(image));
			}
			if (this.HasAttribute(node, "name"))
			{
				string name = this.GetAttribute(node, "name");
				button.Name = name;
			}
			if (this.HasAttribute(node, "enabled"))
			{
				string enabled = this.GetAttribute(node, "enabled");
				button.IsEnabled = Convert.ToBoolean(enabled);
			}
			if (this.HasAttribute(node, "visible"))
			{
				string visible = this.GetAttribute(node, "visible");
				button.IsVisible = Convert.ToBoolean(visible);
			}
			if (this.HasAttribute(node, "shortcut"))
			{
				string shortcut = this.GetAttribute(node, "shortcut");
				button.Shortcut = this.ToShortcut(shortcut);
			}
			if (this.HasAttribute(node, "propertychanged"))
			{
				string propertyChanged = this.GetAttribute(node, "propertychanged");
				button.PropertyChanged += this.ToChangedHandler(propertyChanged);
			}
			if (this.HasAttribute(node, "click"))
			{
				string handler = this.GetAttribute(node, "click");
				button.Click += this.ToClickHandler(handler);
			}
			if (this.HasAttribute(node, "tag"))
			{
				string tag = this.GetAttribute(node, "tag");
				button.Tag = tag;
			}
			this.Items.Add(button);
			this.Buttons.Add(button);
			return button;
		}
		
		/**
		* Creates a combobox from the specified xml node
		*/
		public CommandBarComboBox GetComboBox(XmlNode node)
		{
			CommandBarComboBox comboBox = new CommandBarComboBox();
			if (this.HasAttribute(node, "label"))
			{
				comboBox.Text = this.GetAttribute(node, "label");
			}
			if (this.HasAttribute(node, "image"))
			{
				string image = this.GetAttribute(node, "image");
				comboBox.Image = this.Images.GetImage(Convert.ToInt16(image));
			}
			if (this.HasAttribute(node, "name"))
			{
				string name = this.GetAttribute(node, "name");
				comboBox.Name = name;
			}
			if (this.HasAttribute(node, "enabled"))
			{
				string enabled = this.GetAttribute(node, "enabled");
				comboBox.IsEnabled = Convert.ToBoolean(enabled);
			}
			if (this.HasAttribute(node, "visible"))
			{
				string visible = this.GetAttribute(node, "visible");
				comboBox.IsVisible = Convert.ToBoolean(visible);
			}
			if (this.HasAttribute(node, "value"))
			{
				string val = this.GetAttribute(node, "value");
				comboBox.Value = val;
			}
			if (this.HasAttribute(node, "click"))
			{
				string val = this.GetAttribute(node, "click");
				comboBox.Value = val;
			}
			if (this.HasAttribute(node, "propertychanged"))
			{
				string propertyChanged = this.GetAttribute(node, "propertychanged");
				comboBox.PropertyChanged += this.ToChangedHandler(propertyChanged);
			}
			if (this.HasAttribute(node, "tag"))
			{
				string tag = this.GetAttribute(node, "tag");
				comboBox.Tag = tag;
			}
			this.Items.Add(comboBox);
			this.ComboBoxes.Add(comboBox);
			return comboBox;
		}
		
		/**
		* Creates a checkbox from the specified xml node
		*/
		public CommandBarCheckBox GetCheckBox(XmlNode node)
		{
			CommandBarCheckBox checkBox = new CommandBarCheckBox();
			if (this.HasAttribute(node, "label"))
			{
				checkBox.Text = this.GetAttribute(node, "label");
			}
			if (this.HasAttribute(node, "click"))
			{
				string handler = this.GetAttribute(node, "click");
				checkBox.Click += this.ToClickHandler(handler);
			}
			if (this.HasAttribute(node, "image"))
			{
				string image = this.GetAttribute(node, "image");
				checkBox.Image = this.Images.GetImage(Convert.ToInt16(image));
			}
			if (this.HasAttribute(node, "name"))
			{
				string name = this.GetAttribute(node, "name");
				checkBox.Name = name;
			}
			if (this.HasAttribute(node, "enabled"))
			{
				string enabled = this.GetAttribute(node, "enabled");
				checkBox.IsEnabled = Convert.ToBoolean(enabled);
			}
			if (this.HasAttribute(node, "visible"))
			{
				string visible = this.GetAttribute(node, "visible");
				checkBox.IsVisible = Convert.ToBoolean(visible);
			}
			if (this.HasAttribute(node, "tag"))
			{
				string tag = this.GetAttribute(node, "tag");
				checkBox.Tag = tag;
			}
			if (this.HasAttribute(node, "propertychanged"))
			{
				string propertyChanged = this.GetAttribute(node, "propertychanged");
				checkBox.PropertyChanged += this.ToChangedHandler(propertyChanged);
			}
			if(this.HasAttribute(node, "shortcut"))
			{
				string shortcut = this.GetAttribute(node, "shortcut");
				checkBox.Shortcut = this.ToShortcut(shortcut);
			}
			if (this.HasAttribute(node, "checked"))
			{
				string checkd = this.GetAttribute(node, "checked");
				checkBox.IsChecked = Convert.ToBoolean(checkd);
			}
			this.Items.Add(checkBox);
			this.CheckBoxes.Add(checkBox);
			return checkBox;
		}
		
		/**
		* Checks that if the xml node has an attribute
		*/
		private bool HasAttribute(XmlNode node, string attName)
		{
			try
			{
				string attribute = node.Attributes.GetNamedItem(attName).Value;
				return true;
			}
			catch
			{
				return false;
			}
		}
		
		/**
		* Gets the specified xml node attribute
		*/
		private string GetAttribute(XmlNode node, string attName)
		{
			try
			{
				return node.Attributes.GetNamedItem(attName).Value;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Specified attribute ("+attName+") not found", ex);
				return null;
			}
		}
		
		/**
		* Creates a shortcut from a string
		*/
		private Keys ToShortcut(string shortcutText)
		{
			try
			{
				Shortcut shortcut = (Shortcut)Enum.Parse(typeof(Shortcut), shortcutText);
				if(!this.Shortcuts.Contains(shortcut))
				{
					this.Shortcuts.Add(shortcut);
				} 
				return (Keys)shortcut;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Specified shortcut ("+shortcutText+") not found.", ex);
				return Keys.None;
			}
		}
		
		/**
		* Creates a property change handler from a string
		*/
		private PropertyChangedEventHandler ToChangedHandler(string changedHandlerText)
		{
			try
			{
				return (PropertyChangedEventHandler)Delegate.CreateDelegate(typeof(PropertyChangedEventHandler), this.OwnerForm, changedHandlerText);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Specified propertyChangedEventHandler ("+changedHandlerText+") not found.", ex);
				return null;
			}
		}
		
		/**
		* Creates a click handler from a string
		*/
		private EventHandler ToClickHandler(string clickHandlerText)
		{
			try
			{
				return (EventHandler)Delegate.CreateDelegate(typeof(EventHandler), this.OwnerForm, clickHandlerText);
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Specified clickEventHandler ("+clickHandlerText+") not found.", ex);
				return null;
			}
		}
		
		#endregion

	}

}
