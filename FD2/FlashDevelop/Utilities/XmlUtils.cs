using System;
using System.Xml;
using PluginCore;

namespace FlashDevelop.Utilities
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
			catch
			{
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
			catch
			{
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
		
		/**
		* Reads a xml file and returns it as a XmlDocument.
		*/
		public static XmlDocument GetXmlDocument(string file)
		{
			try
			{
				XmlDocument document = new XmlDocument();
				document.PreserveWhitespace = false;
				document.Load(file); 
				return document;
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while opening file:\n"+file, ex);
				return null;
			}
		}
		
	}
	
}
