using System;
using System.Xml;
using PluginCore;

namespace FlashConnect
{
	public class XmlUtils
	{
		/**
		* Gets the value of the specified XmlNode.
		*/
		public static string GetValue(XmlNode node)
		{
			try
			{
				return node.FirstChild.Value;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(String.Format("Node '{0}' value not found.", node.Name), ex);
				return null;
			}
		}
		
		/**
		* Gets the specified attribute from the specified XmlNode.
		*/
		public static string GetAttribute(XmlNode node, string attName)
		{
			try
			{
				return node.Attributes.GetNamedItem(attName).Value;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError(String.Format("Attribute '{0}' value not found.", attName), ex);
				return null;
			}
		}
		
		/**
		* Checks that if the XmlNode has a value.
		*/
		public static bool HasValue(XmlNode node)
		{
			try
			{
				string val = node.FirstChild.Value;
				return true;
			}
			catch
			{
				return false;
			}
		}
		
		/**
		* Checks that if the XmlNode has the specified attribute.
		*/
		public static bool HasAttribute(XmlNode node, string attName)
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
		
	}
	
}
