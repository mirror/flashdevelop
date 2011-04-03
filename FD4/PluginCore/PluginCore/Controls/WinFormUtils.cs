using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using System.Diagnostics;
using System.Windows.Forms;


namespace PluginCore.Controls
{
	public class WinFormUtils
	{

		private static RichTextBox _tempRTB = new RichTextBox();

		public static Size MeasureRichTextBox(RichTextBox richTextBox)
		{
			return MeasureRichTextBox(richTextBox, true, richTextBox.Width, richTextBox.Height, richTextBox.WordWrap);
		}
		public static Size MeasureRichTextBox(RichTextBox richTextBox, Boolean useSelfForTest, int width, int height, Boolean wordWrap)
		{
			Size outSize = new Size();

			if (richTextBox == null)
				return outSize;

			String rtf = richTextBox.Rtf;
			if (rtf == null)
				return outSize;

			int lastIdx = rtf.LastIndexOf("}");
			if (lastIdx < 1)
				return outSize;

			_tempRTB.Visible = false;
			RichTextBox rtb = useSelfForTest ? richTextBox : _tempRTB;
			rtb.Rtf = rtf.Substring(0, lastIdx) + @"\par}";
			rtb.Width = width;
			rtb.Height = height;
			rtb.WordWrap = wordWrap;

			if (rtb.ScrollBars != richTextBox.ScrollBars)
				rtb.ScrollBars = richTextBox.ScrollBars;

			outSize.Height = rtb.GetPositionFromCharIndex(rtb.TextLength).Y;

			lastIdx = -1;
			int maxW = rtb.GetPositionFromCharIndex(rtb.TextLength).X;
			int currW = 0;
			while (true)
			{
				lastIdx = rtb.Text.IndexOf("\n", lastIdx + 1);
				if (lastIdx < 0)
					break;

				currW = rtb.GetPositionFromCharIndex(lastIdx).X;
				if (currW > maxW)
					maxW = currW;
			}

			if (useSelfForTest)
				rtb.Rtf = rtf;

			outSize.Width = maxW;
			return outSize;
		}
		
	}
}
