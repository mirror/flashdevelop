package flash.printing
{
	/// The PrintJob class lets you create content and print it to one or more pages.
	public class PrintJob extends flash.events.EventDispatcher
	{
		/// The overall paper height, in points.
		public var paperHeight:int;

		/// The overall paper width, in points.
		public var paperWidth:int;

		/// The height of the actual printable area on the page, in points.
		public var pageHeight:int;

		/// The width of the actual printable area on the page, in points.
		public var pageWidth:int;

		/// The image orientation for printing.
		public var orientation:String;

		/// Creates a PrintJob object that you can use to print one or more pages.
		public function PrintJob();

		/// Displays the operating system's Print dialog box, starts spooling, and sets the PrintJob read-only property values.
		public function start():Boolean;

		/// Sends spooled pages to the printer after PrintJob.start() and PrintJob.addPage() have been successful.
		public function send():void;

		/// Sends the specified Sprite object as a single page to the print spooler.
		public function addPage(sprite:flash.display.Sprite, printArea:flash.geom.Rectangle=null, options:flash.printing.PrintJobOptions=null, frameNum:int=0):void;

	}

}

