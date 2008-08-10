namespace System.Windows.Forms
{
	using System;
	using System.Drawing;
	using System.Windows.Forms;
	using System.IO;
	using PluginCore;
	
	/**
	* Image collection class
	*/
	public class Images
	{
		/**
		* Variables
		*/
		private int imageSize;
		private Image[] images;
		private string imageFile;
		
		/**
		* Constructor
		*/
		public Images(string imageFile, int imageSize)
		{
			this.ImageSize = imageSize;
			this.ImageFile = imageFile;
		}
		
		#region MethodsAndProperties
		
		/**
		* Sets and get the selected image file
		*/
		public string ImageFile
		{
			set
			{
				this.imageFile = value;
				try
				{
					int counterX = 0;
					int counterY = 0;
					Bitmap bitmap = new Bitmap(this.imageFile);
					int count = (int)((bitmap.Width/this.imageSize)*(bitmap.Height/this.imageSize));
					Rectangle rectangle = new Rectangle(0, 0, this.imageSize, this.imageSize);
					this.images = new Image[count];
					for(int i = 0; i<count; i++)
					{
						if (counterX == bitmap.Width-this.imageSize)
						{
							counterY += this.imageSize;
							counterX = -16;
						}
						this.images[i] = bitmap.Clone(rectangle, bitmap.PixelFormat);
						counterX += this.imageSize;
						rectangle.X = counterX;
						rectangle.Y = counterY;
					}
				}
				catch (Exception ex)
				{
					ErrorHandler.ShowError("The specified image file is invalid.", ex);
				}
			}
			get
			{
				return ImageFile;
			}
		}
		
		/**
		* Gets an image specified by image index
		*/
		public Image GetImage(int imageIndex)
		{
			try
			{
				return this.images[imageIndex];
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Image index ("+imageIndex+") was out of range.", ex);
				return null;
			}
		}
		
		/**
		* Access to the imageSize
		*/
		public int ImageSize
		{
			get { return this.imageSize; }
			set { this.imageSize = value; }
		}
		
		/**
		* Access to the image count
		*/
		public int Count
		{
			get 
			{
				try
				{
					return this.images.Length;
				}
				catch (Exception ex)
				{
					ErrorHandler.ShowError("No valid image file set.", ex);
					return 0;
				}
			}
		}

		#endregion
		
	}

}
