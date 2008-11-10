using System;
using System.Drawing;
using System.Reflection;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;
using PluginCore.Utilities;
using PluginCore;
using ProjectManager.Projects;
using System.IO;

namespace ProjectManager.Controls
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

        public Icon Icon { get { return Icon.FromHandle((Img as Bitmap).GetHicon()); } }
    }

	/// <summary>
	/// Contains all icons used by the Project Explorer
	/// </summary>
	public class Icons
	{
        // store all extension icons we've pulled from the file system
        static Dictionary<string, FDImage> extensionIcons = new Dictionary<string, FDImage>();

		private static IMainForm mainForm;
		private static ImageList imageList;

        public static FDImage BulletAdd;
        public static FDImage SilkPage;
        public static FDImage XmlFile;
        public static FDImage MxmlFile;
        public static FDImage MxmlFileCompile;
        public static FDImage HiddenItems;
        public static FDImage HiddenFolder;
		public static FDImage HiddenFile;
        public static FDImage BlankFile;
		public static FDImage Project;
		public static FDImage Classpath;
		public static FDImage Font;
		public static FDImage ImageResource;
		public static FDImage ActionScript;
        public static FDImage FlashCS3;
        public static FDImage HaxeFile;
		public static FDImage SwfFile;
		public static FDImage SwfFileHidden;
        public static FDImage SwcFile;
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
        public static FDImage UpArrow;
        public static FDImage DownArrow;
        public static FDImage AllClasses;

		public static ImageList ImageList { get { return imageList; } }

		public static void Initialize(IMainForm mainForm)
		{
			Icons.mainForm = mainForm;

			imageList = new ImageList();
			imageList.ColorDepth = ColorDepth.Depth32Bit;
			imageList.ImageSize = new Size(16, 16);
			imageList.TransparentColor = Color.Transparent;

            BulletAdd = Get(0);
            SilkPage = GetResource("Icons.SilkPage.png");
            XmlFile = GetResource("Icons.XmlFile.png");
            MxmlFile = GetResource("Icons.MxmlFile.png");
            MxmlFileCompile = GetResource("Icons.MxmlFileCompile.png");
            HiddenItems = GetResource("Icons.HiddenItems.png");
            HiddenFolder = GetGray("203");
            HiddenFile = GetResource("Icons.HiddenFile.png");
            BlankFile = GetResource("Icons.BlankPage.png");
            Project = Get(274);
			Classpath = Get(98);
			Font = Get(408);
			ImageResource = Get(336);
            ActionScript = GetResource("Icons.ActionscriptFile.png");
            HaxeFile = GetResource("Icons.HaxeFile.png");
			SwfFile = GetResource("Icons.SwfMovie.png");
			SwfFileHidden = GetResource("Icons.SwfMovieHidden.png");
            SwcFile = GetResource("Icons.SwcFile.png");
			Folder = Get(203);
            FolderCompile = Get("203|22|-3|3");
			TextFile = Get(315);
            FlashCS3 = GetResource("Icons.FlashCS3.png");
            ActionScriptCompile = GetResource("Icons.ActionscriptCompile.png");
            HtmlFile = GetResource("Icons.HtmlFile.png");
            AddFile = GetResource("Icons.AddFile.png"); //Get("304|0|5|4");
			OpenFile = Get(214);
			EditFile = Get(282);
			Cut = Get(158);
			Copy = Get(292);
			Paste = Get(283);
			Delete = Get(111);
			Options = Get(54);
            NewProject = Get("274|0|5|4");
            GreenCheck = Get(351);
			Gear = Get(127);
			Class = GetResource("Icons.Class.png");
			Refresh = Get(66);
			Debug = Get(101);
            UpArrow = Get(74);
            DownArrow = Get(60);
            AllClasses = Get(202);
		}

        public static FDImage GetGray(string data)
        {
            Image image = (mainForm != null) ? mainForm.FindImage(data) : new Bitmap(16, 16);
            Image converted = ImageKonverter.ImageToGrayscale(image);
            imageList.Images.Add(converted);
            return new FDImage(converted, imageList.Images.Count - 1);
        }

		public static FDImage Get(int fdIndex)
		{
            Image image = (mainForm != null) ? mainForm.FindImage(fdIndex.ToString()) : new Bitmap(16, 16);
			imageList.Images.Add(image);
			return new FDImage(image, imageList.Images.Count - 1);
		}

        public static FDImage Get(string data)
		{
            Image image = (mainForm != null) ? mainForm.FindImage(data) : new Bitmap(16, 16);
			imageList.Images.Add(image);
			return new FDImage(image, imageList.Images.Count - 1);
		}

		public static FDImage GetResource(string resourceID)
		{
            Image image;
            try
            {
                resourceID = "ProjectManager." + resourceID;
                Assembly assembly = Assembly.GetExecutingAssembly();
                image = new Bitmap(assembly.GetManifestResourceStream(resourceID));
            }
            catch {
                image = new Bitmap(16, 16);
            }
			imageList.Images.Add(image);
			return new FDImage(image,imageList.Images.Count-1);
		}

        public static FDImage GetImageForFile(string file)
        {
            if (file == null || file == string.Empty)
                return Icons.BlankFile;
            string ext = Path.GetExtension(file);
            if (FileInspector.IsActionScript(file, ext))
                return Icons.ActionScript;
            else if (FileInspector.IsHaxeFile(file, ext))
                return Icons.HaxeFile;
            else if (FileInspector.IsMxml(file, ext))
                return Icons.MxmlFile;
            else if (FileInspector.IsFont(file, ext))
                return Icons.Font;
            else if (FileInspector.IsImage(file, ext))
                return Icons.ImageResource;
            else if (FileInspector.IsSwf(file, ext))
                return Icons.SwfFile;
            else if (FileInspector.IsSwc(file, ext))
                return Icons.SwcFile;
            else if (FileInspector.IsHtml(file, ext))
                return Icons.HtmlFile;
            else if (FileInspector.IsXml(file, ext))
                return Icons.XmlFile;
            else if (FileInspector.IsText(file, ext))
                return Icons.TextFile;
            else if (FileInspector.IsFLA(file, ext))
                return Icons.FlashCS3;
            else
                return ExtractIconIfNecessary(file);
        }

        public static FDImage ExtractIconIfNecessary(string file)
        {
            string extension = Path.GetExtension(file);
            if (extensionIcons.ContainsKey(extension))
            {
                return extensionIcons[extension];
            }
            else
            {
                Icon icon = IconExtractor.GetIcon(file, true);
                imageList.Images.Add(icon);
                int index = imageList.Images.Count - 1; // of the icon we just added
                FDImage fdImage = new FDImage(icon.ToBitmap(), index);
                extensionIcons.Add(extension, fdImage);
                return fdImage;
            }
        }

        public static Image Overlay(Image image, Image overlay, int x, int y)
        {
            Bitmap composed = image.Clone() as Bitmap;
            using (Graphics destination = Graphics.FromImage(composed))
            {
                destination.DrawImage(overlay, new Rectangle(x, y, 16, 16), 
                    new Rectangle(0, 0, 16, 16), GraphicsUnit.Pixel);
            }

            return composed;
        }

	}

}
