using System;
using System.Windows.Forms;

namespace PluginCore
{

	#region Related Event Classes

	/**
	* FileNew: NotifyEvent
	* FileOpen: TextEvent
	* FileOpening: TextEvent
	* FileClose: TextEvent
	* FileSwitch: TextEvent
	* FileModify: NotifyEvent
	* FileSave: TextEvent
	* FileSaving: TextEvent
	* LanguageChange: TextEvent
	* Shortcut: KeyEvent
	* UIRefresh: NotifyEvent
	* UIClosing: NotifyEvent
	* LogEntry: NotifyEvent
	* ProcessStart: NotifyEvent
	* ProcessEnd: TextEvent
	* SettingUpdate: NotifyEvent
	* Command: TextEvent
	* CustomData: DataEvent
	* ProcessArgs: TextEvent
	*/

	#endregion

	/**
	* EventType enum
	*/
	[Flags]
	public enum EventType
	{
		FileNew = 1<<1,
		FileOpen = 1<<2,
		FileOpening = 1<<3,
	    FileClose = 1<<4,
		FileSwitch = 1<<5,
		FileModify = 1<<6,
		FileSave = 1<<7,
		FileSaving = 1<<8,
		LanguageChange = 1<<9,
		Shortcut = 1<<10,
		UIRefresh = 1<<11,
		UIClosing = 1<<12,
		LogEntry = 1<<13,
		ProcessStart = 1<<14,
		ProcessEnd = 1<<15,
		SettingUpdate = 1<<16,
		Command = 1<<17,
		CustomData = 1<<18,
		ProcessArgs = 1<<19
	}

	/**
	* Event without args
	*/
	public class NotifyEvent
	{
		public bool Handled;
		private EventType type;

		public EventType Type
		{
			get { return type; }
		}

		public NotifyEvent(EventType type)
		{
			this.type = type;
		}
	}

	/**
	* Events with text data
	*/
	public class TextEvent: NotifyEvent
	{
		private string value;

		public string Text
		{
			get { return this.value; }
			set { this.value = value; }
		}

		public TextEvent(EventType type, string text): base(type)
		{
			this.value = text;
		}
	}

	/**
	* Events with number data
	*/
	public class NumberEvent: NotifyEvent
	{
		private int value;

		public int Value
		{
			get { return this.value; }
			set { this.value = value; }
		}

		public NumberEvent(EventType type, int value): base(type)
		{
			this.value = value;
		}

	}

	/**
	* Events with Key data
	*/
	public class KeyEvent: NotifyEvent
	{
		private Keys value;
		public bool ProcessKey;

		public Keys Value
		{
			get { return this.value; }
			set { this.value = value; }
		}

		public KeyEvent(EventType type, Keys value): base(type)
		{
			this.value = value;
		}

	}

	/**
	* Events with custom data
	*/
	public class DataEvent: NotifyEvent
	{
		private string action;
		private object data;

		public string Action
		{
			get { return this.action; }
			set { this.action = value; }
		}

		public object Data
		{
			get { return this.data; }
			set { this.data = value; }
		}

		public DataEvent(EventType type, string action, object data): base(type)
		{
			this.action = action;
			this.data = data;
		}

	}

}
