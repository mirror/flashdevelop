package flash.printing
{
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.printing.PrintJobOptions;

	/// The PrintJob class lets you create content and print it to one or more pages.
	public class PrintJob extends EventDispatcher
	{
		/// The image orientation for printing.
		public function get orientation () : String;

		/// The height of the actual printable area on the page, in points.
		public function get pageHeight () : int;

		/// The width of the actual printable area on the page, in points.
		public function get pageWidth () : int;

		/// The overall paper height, in points.
		public function get paperHeight () : int;

		/// The overall paper width, in points.
		public function get paperWidth () : int;

		/// Sends the specified Sprite object as a single page to the print spooler.
		public function addPage (sprite:Sprite, printArea:Rectangle, options:PrintJobOptions, frameNum:int) : void;

		/// Sends spooled pages to the printer after PrintJob.start() and PrintJob.addPage() have been successful.
		public function send () : void;

		/// Displays the operating system's Print dialog box, starts spooling, and sets the PrintJob read-only property values.
		public function start () : Boolean;
	}
}
