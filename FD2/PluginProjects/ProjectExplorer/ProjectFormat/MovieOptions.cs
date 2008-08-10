using System;
using System.Drawing;
using System.Text;

namespace ProjectExplorer.ProjectFormat
{
	public class MovieOptions
	{
		public int Fps;
		public int Width;
		public int Height;
		public int Version;
		public string Background;
		public TestMovieBehavior TestMovieBehavior;

		public MovieOptions()
		{
			Fps = 21;
			Width = 300;
			Height = 300;
			Version = 7;
			Background = "#FFFFFF";
			TestMovieBehavior = TestMovieBehavior.NewTab;
		}

		public Color BackgroundColor
		{
			get { return ColorTranslator.FromHtml(Background); }
			set { Background = string.Format("#{0:X6}", (value.R << 16) + (value.G << 8) + value.B); }
		}
	}

	public enum TestMovieBehavior
	{
		NewTab,
		NewWindow,
		ExternalPlayer
	}
}
