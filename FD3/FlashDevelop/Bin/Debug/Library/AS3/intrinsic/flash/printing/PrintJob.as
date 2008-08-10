/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.printing {
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	public class PrintJob extends EventDispatcher {
		/**
		 * The image orientation for printing. This property is a value from the
		 *  PrintJobOrientation class. This property is available only after a call to the
		 *  PrintJob.start() method has been made.
		 */
		public function get orientation():String;
		/**
		 * The height of the actual printable area on the page, in points.
		 *  Any user-set margins are ignored. This property is available only
		 *  after a call to the PrintJob.start() method has been made.
		 */
		public function get pageHeight():int;
		/**
		 * The width of the actual printable area on the page, in points.
		 *  Any user-set margins are ignored. This property is available only
		 *  after a call to the PrintJob.start() method has been made.
		 */
		public function get pageWidth():int;
		/**
		 * The overall paper height, in points. This property is available only
		 *  after a call to the PrintJob.start() method has been made.
		 */
		public function get paperHeight():int;
		/**
		 * The overall paper width, in points. This property is available only
		 *  after a call to the PrintJob.start() method has been made.
		 */
		public function get paperWidth():int;
		/**
		 * Creates a PrintJob object that you can use to print one or more pages.
		 *  After you create a PrintJob object, you need to use (in the following sequence) the
		 *  PrintJob.start(), PrintJob.addPage(), and then
		 *  PrintJob.send() methods to send the print job to the printer.
		 */
		public function PrintJob();
		/**
		 * Sends the specified Sprite object as a single page to the print spooler. Before using this
		 *  method, you must create a PrintJob object and then use PrintJob.start(). Then,
		 *  after calling PrintJob.addPage() one or more times for a print job, you use
		 *  PrintJob.send() to send the spooled pages to the printer. In other words, after you create
		 *  a PrintJob object, use (in the following sequence) PrintJob.start(),
		 *  PrintJob.addPage(), and then PrintJob.send() to send the print job to the
		 *  printer. You can use PrintJob.addPage() multiple times after a single call to
		 *  PrintJob.start() to print several pages at once.
		 *
		 * @param sprite            <Sprite> The instance name of the Sprite to print.
		 * @param printArea         <Rectangle (default = null)> A Rectangle object that specifies the area to print.
		 *                            A rectangle's width and height are pixel values. A printer uses points as print units of measurement. Points are a fixed physical size (1/72 inch), but the size of a pixel, onscreen, depends on the resolution of the particular screen. So, the conversion rate between pixels and points depends on the printer settings and whether the sprite is scaled. An unscaled sprite that is 72 pixels wide will print out one inch wide, with one point equal to one pixel, independent of screen resolution.
		 *                            You can use the following equivalencies to convert inches
		 *                            or centimeters to twips or points (a twip is 1/20 of a point):
		 *                            1 point = 1/72 inch = 20 twips
		 *                            1 inch = 72 points = 1440 twips
		 *                            1 cm = 567 twips
		 *                            If you omit the printArea parameter, or if it is passed incorrectly, the full area of
		 *                            sprite is printed.
		 *                            If you don't want to specify a value for printArea but want to specify a value for options
		 *                            or frameNum, pass null for printArea.
		 * @param options           <PrintJobOptions (default = null)> An optional parameter that specifies whether to print as vector or bitmap.
		 *                            The default value is null, which represents a request for vector printing.
		 *                            To print sprite as a
		 *                            bitmap, set the printAsBitmap property of the PrintJobOptions object
		 *                            to true. Remember the following suggestions when determining whether to
		 *                            set printAsBitmap to true:
		 *                            If the content that you're printing includes a bitmap image, set
		 *                            printAsBitmap to true to include any alpha transparency
		 *                            and color effects.
		 *                            If the content does not include bitmap images, omit this parameter
		 *                            to print the content in higher quality vector format.
		 *                            If options is omitted or is passed incorrectly, vector printing is used.
		 *                            If you don't want to specify a value for
		 *                            options but want to specify a value for frameNumber,
		 *                            pass null for options.
		 * @param frameNum          <int (default = 0)> An optional number that is used in the Flash authoring environment. When writing Flex applications,
		 *                            you should omit this parameter or pass a value of 0.
		 */
		public function addPage(sprite:Sprite, printArea:Rectangle = null, options:PrintJobOptions = null, frameNum:int = 0):void;
		/**
		 * Sends spooled pages to the printer after PrintJob.start() and PrintJob.addPage() have been successful. Calls to PrintJob.send() will not be successful if the call to PrintJob.start() fails, or PrintJob.addpage() throws an exception. So, you should check for PrintJob.start() to return true, and catch any PrintJob.addpage() exceptions before calling PrintJob.send().
		 */
		public function send():void;
		/**
		 * Displays the operating system's Print dialog box, starts spooling, and sets the PrintJob read-only property values. The Print dialog box lets the user change print settings. When the PrintJob.
		 *
		 * @return                  <Boolean> A value of true if the user clicks OK when the Print dialog box appears; false if the user clicks Cancel or if an error occurs.
		 */
		public function start():Boolean;
	}
}
