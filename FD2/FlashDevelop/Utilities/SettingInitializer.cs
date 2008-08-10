using System;
using PluginCore;
using System.Windows.Forms;

namespace FlashDevelop.Utilities
{
	public class SettingInitializer
	{
		private SettingParser settings;
		private string[,] settingArray;

		public SettingInitializer(SettingParser settings)
		{
			this.settings = settings;
			this.InitializeSettingArray();
			this.AddMissingSettings();
		}

		/**
		* Checks and adds the missing default settings.
		*/
		public void AddMissingSettings()
		{
			try
			{
				int count = this.settingArray.GetLength(0);
				for (int i = 0; i<count; i++)
				{
					if (!this.settings.HasKey(this.settingArray[i,0]))
					{
						this.settings.AddValue(this.settingArray[i,0], this.settingArray[i,1]);
					}
				}
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Error while checking default settings.", ex);
			}
		}

		/**
		* Initializes the default settings array.
		*/
		public void InitializeSettingArray()
		{
			this.settingArray = new string[,]
			{
				{"FlashDevelop.BackSpaceUnIndents", "false"},
				{"FlashDevelop.BooleanButtons", "ViewWSButton,ViewEOLButton,WrapTextButton,ViewIndentGuidesButton"},
				{"FlashDevelop.BraceMatchingEnabled", "true"},
				{"FlashDevelop.CaretLineVisible", "false"},
				{"FlashDevelop.CaretPeriod", "500"},
				{"FlashDevelop.CaretWidth", "2"},
				{"FlashDevelop.CollapseAllOnFileOpen", "false"},
				{"FlashDevelop.CreatedPanels", "0"},
				{"FlashDevelop.DefaultCodePage", System.Text.Encoding.Default.CodePage.ToString()},
				{"FlashDevelop.DefaultFileExtension", "as"},
				{"FlashDevelop.EnsureConsistentLineEnds", "true"},
				{"FlashDevelop.EnsureLastLineEnd", "false"},
				{"FlashDevelop.EOLMode", "0"},
				{"FlashDevelop.FoldAtElse", "false"},
				{"FlashDevelop.FoldComment", "true"},
				{"FlashDevelop.FoldCompact", "false"},
				{"FlashDevelop.FoldFlags", "16"},
				{"FlashDevelop.FoldHtml", "true"},
				{"FlashDevelop.FoldPreprocessor", "true"},
				{"FlashDevelop.HighlightGuide", "true"},
				{"FlashDevelop.IndentSize", "4"},
				{"FlashDevelop.LineCommentsAfterIndent", "true"},
				{"FlashDevelop.LatestDialogPath", Application.StartupPath.ToString()},
				{"FlashDevelop.MoveCursorAfterComment", "false"},
				{"FlashDevelop.ScrollWidth", "3000"},
				{"FlashDevelop.SingleInstance", "true"},
				{"FlashDevelop.SmartIndentType", "1"},
				{"FlashDevelop.StripTrailingSpaces", "false"},
				{"FlashDevelop.SequentialTabbing", "false"},
				{"FlashDevelop.TabIndents", "true"},
				{"FlashDevelop.TabWidth", "4"},
				{"FlashDevelop.UseFolding", "true"},
				{"FlashDevelop.UseTabs", "true"},
				{"FlashDevelop.ViewEOL", "false"},
				{"FlashDevelop.ViewBookmarks", "true"},
				{"FlashDevelop.ViewLineNumbers", "true"},
				{"FlashDevelop.ViewIndentationGuides", "true"},
				{"FlashDevelop.ViewToolBar", "true"},
				{"FlashDevelop.ViewWhitespace", "false"},
				{"FlashDevelop.WindowPosition.X", "-4"},
				{"FlashDevelop.WindowPosition.Y", "-4"},
				{"FlashDevelop.WindowSize.Height", "600"},
				{"FlashDevelop.WindowSize.Width", "750"},
				{"FlashDevelop.WindowState", "Maximized"},
				{"FlashDevelop.WrapText", "false"}
			};
		}

	}

}
