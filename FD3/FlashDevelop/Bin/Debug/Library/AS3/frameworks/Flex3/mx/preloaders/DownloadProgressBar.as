/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.preloaders {
	import flash.display.Sprite;
	import mx.graphics.RoundedRectangle;
	import flash.text.TextFormat;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import mx.events.RSLEvent;
	public class DownloadProgressBar extends Sprite implements IPreloaderDisplay {
		/**
		 * Alpha level of the SWF file or image defined by
		 *  the backgroundImage property, or the color defined by
		 *  the backgroundColor property.
		 *  Valid values range from 0 to 1.0.
		 */
		public function get backgroundAlpha():Number;
		public function set backgroundAlpha(value:Number):void;
		/**
		 * Background color of a download progress bar.
		 *  You can have either a backgroundColor or a
		 *  backgroundImage, but not both.
		 */
		public function get backgroundColor():uint;
		public function set backgroundColor(value:uint):void;
		/**
		 * The background image of the application,
		 *  which is passed in by the preloader.
		 *  You can specify either a backgroundColor
		 *  or a backgroundImage, but not both.
		 */
		public function get backgroundImage():Object;
		public function set backgroundImage(value:Object):void;
		/**
		 * Scales the image specified by backgroundImage
		 *  to different percentage sizes.
		 *  A value of "100%" stretches the image
		 *  to fit the entire component.
		 *  To specify a percentage value, you must include the percent sign (%).
		 *  A value of "auto", maintains
		 *  the original size of the image.
		 */
		public function get backgroundSize():String;
		public function set backgroundSize(value:String):void;
		/**
		 * The dimensions of the progress bar border.
		 *  This is a read-only property which you must override
		 *  if you need to change it.
		 */
		protected function get barFrameRect():RoundedRectangle;
		/**
		 * The dimensions of the progress bar.
		 *  This is a read-only property which you must override
		 *  if you need to change it.
		 */
		protected function get barRect():RoundedRectangle;
		/**
		 * The dimensions of the border of the display.
		 *  This is a read-only property which you must override
		 *  if you need to change it.
		 */
		protected function get borderRect():RoundedRectangle;
		/**
		 * The percentage of the progress bar that the downloading phase
		 *  fills when the SWF file is fully downloaded.
		 *  The rest of the progress bar is filled during the initializing phase.
		 *  This should be a value from 0 to 100.
		 */
		protected var DOWNLOAD_PERCENTAGE:uint = 60;
		/**
		 * The string to display as the label while in the downloading phase.
		 */
		protected function get downloadingLabel():String;
		protected function set downloadingLabel(value:String):void;
		/**
		 * The string to display as the label while in the initializing phase.
		 */
		public static function get initializingLabel():String;
		public function set initializingLabel(value:String):void;
		/**
		 * Text to display when the progress bar is active.
		 *  The Preloader class sets this value
		 *  before displaying the progress bar.
		 *  Implementing this property in a subclass is optional.
		 */
		protected function get label():String;
		protected function set label(value:String):void;
		/**
		 * The TextFormat object of the TextField component of the label.
		 *  This is a read-only property which you must override
		 *  if you need to change it.
		 */
		protected function get labelFormat():TextFormat;
		/**
		 * The dimensions of the TextField component for the label.
		 *  This is a read-only property which you must override
		 *  if you need to change it.
		 */
		protected function get labelRect():Rectangle;
		/**
		 * The minimum number of milliseconds
		 *  that the display should appear visible.
		 *  If the downloading and initialization of the application
		 *  takes less time than this value, then Flex pauses for this amount
		 *  of time before dispatching the complete event.
		 */
		protected var MINIMUM_DISPLAY_TIME:uint = 0;
		/**
		 * The TextFormat of the TextField component for displaying the percent.
		 *  This is a read-only property which you must override
		 *  if you need to change it.
		 */
		protected function get percentFormat():TextFormat;
		/**
		 * The dimensions of the TextField component for displaying the percent.
		 *  This is a read-only property which you must override
		 *  if you need to change it.
		 */
		protected function get percentRect():Rectangle;
		/**
		 * The Preloader class passes in a reference to itself to the display class
		 *  so that it can listen for events from the preloader.
		 */
		public function set preloader(value:Sprite):void;
		/**
		 * Controls whether to display the label, true,
		 *  or not, false.
		 */
		protected function get showLabel():Boolean;
		protected function set showLabel(value:Boolean):void;
		/**
		 * Controls whether to display the percentage, true,
		 *  or not, false.
		 */
		protected function get showPercentage():Boolean;
		protected function set showPercentage(value:Boolean):void;
		/**
		 * The height of the stage,
		 *  which is passed in by the Preloader class.
		 */
		public function get stageHeight():Number;
		public function set stageHeight(value:Number):void;
		/**
		 * The width of the stage,
		 *  which is passed in by the Preloader class.
		 */
		public function get stageWidth():Number;
		public function set stageWidth(value:Number):void;
		/**
		 * Specifies whether the download progress bar is visible.
		 */
		public function get visible():Boolean;
		public function set visible(value:Boolean):void;
		/**
		 * Constructor
		 */
		public function DownloadProgressBar();
		/**
		 * Centers the download progress bar based on the passed in dimensions.
		 *
		 * @param width             <Number> The width of the area in which to center the download progress bar.
		 * @param height            <Number> The height of the area in which to center the download progress bar.
		 */
		protected function center(width:Number, height:Number):void;
		/**
		 * Event listener for the Event.COMPLETE event.
		 *  The default implementation does nothing.
		 *
		 * @param event             <Event> The event object.
		 */
		protected function completeHandler(event:Event):void;
		/**
		 * Creates the subcomponents of the display.
		 */
		protected function createChildren():void;
		/**
		 * Returns the percentage value of the application loaded.
		 *
		 * @param loaded            <Number> Number of bytes of the application SWF file
		 *                            that have been downloaded.
		 * @param total             <Number> Size of the application SWF file in bytes.
		 * @return                  <Number> The percentage value of the loaded application.
		 */
		protected function getPercentLoaded(loaded:Number, total:Number):Number;
		/**
		 * Called by the Preloader after the download progress bar
		 *  has been added as a child of the Preloader.
		 *  This should be the starting point for configuring your download progress bar.
		 */
		public function initialize():void;
		/**
		 * Event listener for the FlexEvent.INIT_PROGRESS event.
		 *  This implementation updates the progress bar
		 *  each time the event is dispatched, and changes the text of the label.
		 *
		 * @param event             <Event> The event object.
		 */
		protected function initProgressHandler(event:Event):void;
		/**
		 * Event listener for the ProgressEvent.PROGRESS event.
		 *  This implementation updates the progress bar
		 *  with the percentage of bytes downloaded.
		 *
		 * @param event             <ProgressEvent> The event object.
		 */
		protected function progressHandler(event:ProgressEvent):void;
		/**
		 * Event listener for the RSLEvent.RSL_COMPLETE event.
		 *
		 * @param event             <RSLEvent> The event object.
		 */
		protected function rslCompleteHandler(event:RSLEvent):void;
		/**
		 * Event listener for the RSLEvent.RSL_ERROR event.
		 *  This event listner handles any errors detected when downloading an RSL.
		 *
		 * @param event             <RSLEvent> The event object.
		 */
		protected function rslErrorHandler(event:RSLEvent):void;
		/**
		 * Event listener for the RSLEvent.RSL_PROGRESS event.
		 *  The default implementation does nothing.
		 *
		 * @param event             <RSLEvent> The event object.
		 */
		protected function rslProgressHandler(event:RSLEvent):void;
		/**
		 * Updates the display of the download progress bar
		 *  with the current download information.
		 *  A typical implementation divides the loaded value by the total value
		 *  and displays a percentage.
		 *  If you do not implement this method, you should create
		 *  a progress bar that displays an animation to indicate to the user
		 *  that a download is occurring.
		 *
		 * @param completed         <Number> Number of bytes of the application SWF file
		 *                            that have been downloaded.
		 * @param total             <Number> Size of the application SWF file in bytes.
		 */
		protected function setProgress(completed:Number, total:Number):void;
		/**
		 * Defines the algorithm for determining whether to show
		 *  the download progress bar while in the download phase.
		 *
		 * @param elapsedTime       <int> number of milliseconds that have elapsed
		 *                            since the start of the download phase.
		 * @param event             <ProgressEvent> The ProgressEvent object that contains
		 *                            the bytesLoaded and bytesTotal properties.
		 * @return                  <Boolean> If the return value is true, then show the
		 *                            download progress bar.
		 *                            The default behavior is to show the download progress bar
		 *                            if more than 700 milliseconds have elapsed
		 *                            and if Flex has downloaded less than half of the bytes of the SWF file.
		 */
		protected function showDisplayForDownloading(elapsedTime:int, event:ProgressEvent):Boolean;
		/**
		 * Defines the algorithm for determining whether to show the download progress bar
		 *  while in the initialization phase, assuming that the display
		 *  is not currently visible.
		 *
		 * @param elapsedTime       <int> number of milliseconds that have elapsed
		 *                            since the start of the download phase.
		 * @param count             <int> number of times that the initProgress event
		 *                            has been received from the application.
		 * @return                  <Boolean> If true, then show the download progress bar.
		 */
		protected function showDisplayForInit(elapsedTime:int, count:int):Boolean;
	}
}
