using System;
using System.Drawing;
using PluginCore;
using PluginCore.Controls;

namespace FlashDevelop.Utilities
{
	public class SnippetItem : ICompletionListItem
	{
		private string word;
		private string snippet;
		static public MainForm mainForm;
		static public Bitmap stdIcon;
		
		public SnippetItem(string word, string snippet) 
		{
			this.word = word;
			this.snippet = snippet;
		}
		
		public string Label 
		{
			get { return this.word; }
		}
		
		public string Description 
		{
			get 
			{
				if (this.snippet.Length > 40) return "Snippet "+this.snippet.Substring(0, 40)+"...";
				else return "Snippet "+this.snippet;
			}
		}
		
		public Bitmap Icon 
		{
			get { return SnippetItem.stdIcon; }
		}
		
		public string Value 
		{
			get 
			{
				SnippetItem.mainForm.InsertTextByWord(this.word);
				return null;
			}
		}
		
	}
}
