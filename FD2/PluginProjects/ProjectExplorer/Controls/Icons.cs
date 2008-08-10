using System;
using System.Collections;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using System.Reflection;
using PluginCore;

namespace ProjectExplorer.Controls
{
	/// <summary>
	/// Contains all icons used by the Project Explorer
	/// </summary>
	public class Icons
	{
		public class FDImage
		{
			public readonly Image Img;
			public readonly int Index;

			public FDImage(Image img, int index)
			{
				Img = img;
				Index = index;
			}
		}

		private static IMainForm mainForm;
		private static ImageList imageList;

		public static FDImage XmlFile;
		public static FDImage HiddenFolder;
		public static FDImage HiddenFile;
		public static FDImage Project;
		public static FDImage Classpath;
		public static FDImage Font;
		public static FDImage ImageResource;
		public static FDImage ActionScript;
		public static FDImage SwfFile;
		public static FDImage SwfFileHidden;
		public static FDImage Folder;
		public static FDImage FolderCompile;
		public static FDImage TextFile;
		public static FDImage ActionScriptCompile;
		public static FDImage HtmlFile;
		public static FDImage AddFile;
		public static FDImage OpenFile;
		public static FDImage EditFile;
		public static FDImage Cut;
		public static FDImage Copy;
		public static FDImage Paste;
		public static FDImage Delete;
		public static FDImage Options;
		public static FDImage NewProject;
		public static FDImage GreenCheck;
		public static FDImage Gear;
		public static FDImage Class;
		public static FDImage Refresh;
		public static FDImage Debug;

		public static ImageList ImageList { get { return imageList; } }

		public static void Initialize(IMainForm mainForm)
		{
			Icons.mainForm = mainForm;

			imageList = new ImageList();
			imageList.ColorDepth = ColorDepth.Depth32Bit;
			imageList.ImageSize = new Size(16, 16);
			imageList.TransparentColor = Color.Transparent;

			XmlFile = Get("Icons.XmlFile.png");
			HiddenFolder = Get("Icons.HiddenFolder.png");
			HiddenFile = Get(156);
			Project = Get(110);
			Classpath = Get(27);
			Font = Get(97);
			ImageResource = Get("Icons.ImageResource.png");
			ActionScript = Get("Icons.ActionscriptFile.png");
			SwfFile = Get("Icons.SwfMovie.png");
			SwfFileHidden = Get("Icons.SwfMovieHidden.png");
			Folder = Get("Icons.Folder.png"); //Get(84);
			FolderCompile = Get("Icons.FolderCompile.png");
			TextFile = Get("Icons.TextFile.png");
			ActionScriptCompile = Get("Icons.ActionscriptCompile.png");
			HtmlFile = Get("Icons.HtmlFile.png");
			AddFile = Get("Icons.AddFile.png");
			OpenFile = Get(1);
			EditFile = Get(7);
			Cut = Get(3);
			Copy = Get(4);
			Paste = Get(5);
			Delete = Get(29);
			Options = Get(132);
			NewProject = Get(111);
			GreenCheck = Get(21);
			Gear = Get(66);
			Class = Get("Icons.Class.png");
			Refresh = Get(10);
			Debug = Get(51);
		}

		public static FDImage Get(int fdIndex)
		{
			Image image = mainForm.GetSystemImage(fdIndex);
			imageList.Images.Add(image);
			return new FDImage(image,imageList.Images.Count-1);
		}

		public static FDImage Get(string resourceID)
		{
			Assembly assembly = Assembly.GetExecutingAssembly();
			Image image = new Bitmap(assembly.GetManifestResourceStream(resourceID));
			imageList.Images.Add(image);
			return new FDImage(image,imageList.Images.Count-1);
		}
	}
}
