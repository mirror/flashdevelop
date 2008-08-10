using System;
using System.Collections;
using System.Windows.Forms;
using System.IO;

namespace FileExplorer 
{
	public class ListViewSorter : IComparer
	{
		private int columnToSort;
		private GenericComparer comparer;
		private SortOrder orderOfSort;
	
		public ListViewSorter()
		{
			this.columnToSort = 0;
			this.comparer = new GenericComparer();
			this.orderOfSort = SortOrder.None;
		}
	
		/**
		* Compares the two objects passed using a case insensitive comparison.
		*/
		public int Compare(object x, object y)
		{
			int compareResult = 0;
			ListViewItem listviewX = (ListViewItem)x;
			ListViewItem listviewY = (ListViewItem)y;
			//
			if (this.columnToSort == 0)
			{
				compareResult = comparer.CompareFiles(listviewX, listviewY);
			} 
			else if (this.columnToSort == 1)
			{
				compareResult = comparer.CompareSize(listviewX, listviewY);
			} 
			else if (this.columnToSort == 2)
			{
				compareResult = comparer.CompareType(listviewX, listviewY);
			}
			else if (this.columnToSort == 3)
			{
				compareResult = comparer.CompareModified(listviewX, listviewY);
			}
			if (this.orderOfSort == SortOrder.Ascending)
			{
				return compareResult;
			}
			else if (this.orderOfSort == SortOrder.Descending)
			{
				return (-compareResult);
			}
			else
			{
				return 0;
			}
		}
	
		/**
		* Gets or sets the number of the column.
		*/
		public int SortColumn
		{
			set { this.columnToSort = value; }
			get { return this.columnToSort; }
		}
		
		/**
		* Gets or sets the order of sorting to apply.
		*/		
		public SortOrder Order
		{
			set { this.orderOfSort = value; }
			get { return this.orderOfSort; }
		}
		
	}
	
	public class GenericComparer
	{
		/**
		* Checks if the item is a browser (button).
		*/
		public bool ItemIsBrowser(ListViewItem item)
		{
			return (item.SubItems[0].Text == "[..]");
		}
		
		/**
		* Checks if the item is a folder. 
		*/
		public bool ItemIsFolder(ListViewItem item)
		{
			string path = item.Tag.ToString();
			return Directory.Exists(path);
		}
		
		/**
		* Compares two supplied ListViewItems. 
		*/
		public int CompareFiles(ListViewItem x, ListViewItem y)
		{
			string xVal = x.SubItems[0].Text;
			string yVal = y.SubItems[0].Text;
			//
			if (this.ItemIsBrowser(x) || this.ItemIsBrowser(y))
			{
				return 0;
			}
			if (this.ItemIsFolder(x) && this.ItemIsFolder(y)) 
			{
				return String.Compare(xVal, yVal);
			}
			if (this.ItemIsFolder(x) && !this.ItemIsFolder(y)) 
			{
				return -1;
			}
			if (!this.ItemIsFolder(x) && this.ItemIsFolder(y))
			{
				return 1;
			}
			return String.Compare(xVal, yVal);
		}
		
		/**
		* Compares two supplied ListViewItems. 
		*/
		public int CompareSize(ListViewItem x, ListViewItem y)
		{
			string xVal = x.SubItems[1].Text.Replace("KB", "").Trim();
			string yVal = y.SubItems[1].Text.Replace("KB", "").Trim();
			//
			if (this.ItemIsBrowser(x) || this.ItemIsBrowser(y))
			{
				return 0;
			}
			if (this.ItemIsFolder(x) && this.ItemIsFolder(y))
			{
				return String.Compare(x.SubItems[0].Text, y.SubItems[0].Text);
			}
			if (this.ItemIsFolder(x) && !this.ItemIsFolder(y)) 
			{
				return -1;
			}
			if (!this.ItemIsFolder(x) && this.ItemIsFolder(y))
			{
				return 1;
			}
			int numX = Int32.Parse(xVal);
			int numY = Int32.Parse(yVal);
			if (numX>numY) return -1;
			else if(numX<numY) return 1;
			else return 0;
		}
		
		/**
		* Compares two supplied ListViewItems. 
		*/
		public int CompareModified(ListViewItem x, ListViewItem y)
		{
			string xVal = x.SubItems[3].Text;
			string yVal = y.SubItems[3].Text;
			//
			if (this.ItemIsBrowser(x) || this.ItemIsBrowser(y))
			{
				return 0;
			}
			if (this.ItemIsFolder(x) && this.ItemIsFolder(y))
			{
				return String.Compare(x.SubItems[0].Text, y.SubItems[0].Text);
			}
			if (this.ItemIsFolder(x) && !this.ItemIsFolder(y)) 
			{
				return -1;
			}
			if (!this.ItemIsFolder(x) && this.ItemIsFolder(y))
			{
				return +1;
			}
			return DateTime.Compare(DateTime.Parse(xVal), DateTime.Parse(yVal));
		}
		
		/**
		* Compares two supplied ListViewItems. 
		*/
		public int CompareType(ListViewItem x, ListViewItem y)
		{
			string xVal = x.SubItems[2].Text;
			string yVal = y.SubItems[2].Text;
			//
			if (this.ItemIsBrowser(x) || this.ItemIsBrowser(y))
			{
				return 0;
			}
			if (this.ItemIsFolder(x) && this.ItemIsFolder(y))
			{
				return String.Compare(x.SubItems[0].Text, y.SubItems[0].Text);
			}
			if (this.ItemIsFolder(x) && !this.ItemIsFolder(y)) 
			{
				return -1;
			}
			if (!this.ItemIsFolder(x) && this.ItemIsFolder(y))
			{
				return +1;
			}
			return String.Compare(xVal, yVal);
		}
	}
	
}
