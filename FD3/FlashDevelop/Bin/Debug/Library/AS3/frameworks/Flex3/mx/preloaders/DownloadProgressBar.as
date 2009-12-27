package mx.preloaders
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.graphics.RectangularDropShadow;
	import mx.graphics.RoundedRectangle;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.system.Capabilities;
	import flash.text.TextFieldAutoSize;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import mx.preloaders.DownloadProgressBar;

include "../core/Version.as"
	/**
	 *  The DownloadProgressBar class displays download progress.
 *  It is used by the Preloader control to provide user feedback
 *  while the application is downloading and loading. 
 *
 *  <p>The download progress bar displays information about 
 *  two different phases of the application: 
 *  the download phase and the initialization phase. </p>
 *
 *  <p>In the <code>&lt;mx:Application&gt;</code> tag, use the 
 *  the <code>preloader</code> property to specify the name of your subclass.</p>
 *
 *  <p>You can implement a custom download progress bar component 
 *  by creating a subclass of the DownloadProgressBar class. 
 *  Do not implement a download progress bar as an MXML component 
 *  because it loads too slowly.</p>
 *
 *  @see mx.core.Application
 *  @see mx.preloaders.IPreloaderDisplay
 *  @see mx.preloaders.Preloader
	 */
	public class DownloadProgressBar extends Sprite implements IPreloaderDisplay
	{
		/**
		 *  The minimum number of milliseconds
	 *  that the display should appear visible.
	 *  If the downloading and initialization of the application
	 *  takes less time than this value, then Flex pauses for this amount
	 *  of time before dispatching the <code>complete</code> event.
	 *
	 *  @default 0
		 */
		protected var MINIMUM_DISPLAY_TIME : uint;
		/**
		 *  The percentage of the progress bar that the downloading phase
	 *  fills when the SWF file is fully downloaded.
	 *  The rest of the progress bar is filled during the initializing phase.
	 *  This should be a value from 0 to 100. 
	 *
	 *  @default 60
		 */
		protected var DOWNLOAD_PERCENTAGE : uint;
		/**
		 *  @private
		 */
		private var _showProgressBar : Boolean;
		/**
		 *  @private
	 *  Cached Rectangle returned by the labelRect getter.
		 */
		private var _labelRect : Rectangle;
		/**
		 *  @private
	 *  Cached Rectangle returned by the percentRect getter.
		 */
		private var _percentRect : Rectangle;
		/**
		 *  @private
	 *  Cached RoundedRectangle returned by the borderRect getter.
		 */
		private var _borderRect : RoundedRectangle;
		/**
		 *  @private
	 *  Cached RoundedRectangle returned by the barFrameRect getter.
		 */
		private var _barFrameRect : RoundedRectangle;
		/**
		 *  @private
	 *  Cached RoundedRectangle returned by the barRect getter.
		 */
		private var _barRect : RoundedRectangle;
		/**
		 *  @private
		 */
		private var _xOffset : Number;
		/**
		 *  @private
		 */
		private var _yOffset : Number;
		/**
		 *  @private
		 */
		private var _maximum : Number;
		/**
		 *  @private
		 */
		private var _value : Number;
		/**
		 *  @private
		 */
		private var _barSprite : Sprite;
		/**
		 *  @private
		 */
		private var _barFrameSprite : Sprite;
		/**
		 *  @private
		 */
		private var _labelObj : TextField;
		/**
		 *  @private
		 */
		private var _percentObj : TextField;
		/**
		 *  @private
		 */
		private var _startTime : int;
		/**
		 *  @private
		 */
		private var _displayTime : int;
		/**
		 *  @private
		 */
		private var _startedLoading : Boolean;
		/**
		 *  @private
		 */
		private var _startedInit : Boolean;
		/**
		 *  @private
		 */
		private var _showingDisplay : Boolean;
		/**
		 *  @private
		 */
		private var _displayStartCount : uint;
		/**
		 *  @private
		 */
		private var _initProgressCount : uint;
		/**
		 *  @private
		 */
		private var _initProgressTotal : uint;
		/**
		 *  @private
	 *  Storage for the visible property.
		 */
		private var _visible : Boolean;
		/**
		 *  @private
	 *  Storage for the backgroundAlpha property.
		 */
		private var _backgroundAlpha : Number;
		/**
		 *  @private
	 *  Storage for the backgroundColor property.
		 */
		private var _backgroundColor : uint;
		/**
		 *  @private
	 *  Storage for the backgroundImage property.
		 */
		private var _backgroundImage : Object;
		/**
		 *  @private
	 *  Storage for the backgroundSize property.
		 */
		private var _backgroundSize : String;
		/**
		 *  @private
	 *  Storage for the preloader property.
		 */
		private var _preloader : Sprite;
		/**
		 *  @private
	 *  Storage for the stageHeight property.
		 */
		private var _stageHeight : Number;
		/**
		 *  @private
	 *  Storage for the stageHeight property.
		 */
		private var _stageWidth : Number;
		/**
		 *  @private
	 *  Storage for the downloadingLabel property.
		 */
		private var _downloadingLabel : String;
		/**
		 *  @private
  	 *  Storage for the initializingLabel property.
		 */
		private static var _initializingLabel : String;
		/**
		 *  @private
	 *  Storage for the label property.
		 */
		private var _label : String;
		/**
		 *  @private
	 *  Storage for the showLabel property.
		 */
		private var _showLabel : Boolean;
		/**
		 *  @private
	 *  Storage for the showPercentage property.
		 */
		private var _showPercentage : Boolean;

		/**
		 *  Specifies whether the download progress bar is visible.
	 *
	 *  <p>When the Preloader control determines that the progress bar should be displayed, 
	 *  it sets this value to <code>true</code>. When the Preloader control determines that
	 *  the progress bar should be hidden, it sets the value to <code>false</code>.</p>
	 *
	 *  <p>A subclass of the DownloadProgressBar class should never modify this property. 
	 *  Instead, you can override the setter method to recognize when 
	 *  the Preloader control modifies it, and perform any necessary actions. </p>
	 *
	 *  @default false
		 */
		public function get visible () : Boolean;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;

		/**
		 *  Alpha level of the SWF file or image defined by 
     *  the <code>backgroundImage</code> property, or the color defined by 
	 *  the <code>backgroundColor</code> property. 
	 *  Valid values range from 0 to 1.0.	 
	 *
	 *  <p>You can specify either a <code>backgroundColor</code> 
	 *  or a <code>backgroundImage</code>, but not both.</p>
	 *
	 *  @default 1.0
	 *
		 */
		public function get backgroundAlpha () : Number;
		/**
		 *  @private
		 */
		public function set backgroundAlpha (value:Number) : void;

		/**
		 *  Background color of a download progress bar.
     *  You can have either a <code>backgroundColor</code> or a
     *  <code>backgroundImage</code>, but not both.
		 */
		public function get backgroundColor () : uint;
		/**
		 *  @private
		 */
		public function set backgroundColor (value:uint) : void;

		/**
		 *  The background image of the application,
	 *  which is passed in by the preloader.
	 *  You can specify either a <code>backgroundColor</code> 
	 *  or a <code>backgroundImage</code>, but not both.
	 *
	 *  <p>A value of null means "not set". 
	 *  If this style and the <code>backgroundColor</code> style are undefined, 
	 *  the component has a transparent background.</p>
	 *
	 *  <p>The preloader does not display embedded images. 
	 *  You can only use images loaded at runtime.</p>
	 *
	 *  @default null
		 */
		public function get backgroundImage () : Object;
		/**
		 *  @private
		 */
		public function set backgroundImage (value:Object) : void;

		/**
		 *  Scales the image specified by <code>backgroundImage</code>
     *  to different percentage sizes.
     *  A value of <code>"100%"</code> stretches the image
     *  to fit the entire component.
     *  To specify a percentage value, you must include the percent sign (%).
     *  A value of <code>"auto"</code>, maintains
     *  the original size of the image.
	 *
	 *  @default "auto"
		 */
		public function get backgroundSize () : String;
		/**
		 *  @private
		 */
		public function set backgroundSize (value:String) : void;

		/**
		 *  The Preloader class passes in a reference to itself to the display class
	 *  so that it can listen for events from the preloader.
		 */
		public function set preloader (value:Sprite) : void;

		/**
		 *  The height of the stage,
	 *  which is passed in by the Preloader class.
		 */
		public function get stageHeight () : Number;
		/**
		 *  @private
		 */
		public function set stageHeight (value:Number) : void;

		/**
		 *  The width of the stage,
	 *  which is passed in by the Preloader class.
		 */
		public function get stageWidth () : Number;
		/**
		 *  @private
		 */
		public function set stageWidth (value:Number) : void;

		/**
		 *  The dimensions of the progress bar border.
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get barFrameRect () : RoundedRectangle;

		/**
		 *  The dimensions of the progress bar.
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get barRect () : RoundedRectangle;

		/**
		 *  The dimensions of the border of the display.
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get borderRect () : RoundedRectangle;

		/**
		 *  The string to display as the label while in the downloading phase.
	 *
	 *  @default "Loading"
		 */
		protected function get downloadingLabel () : String;
		/**
		 *  @private
		 */
		protected function set downloadingLabel (value:String) : void;

		/**
		 *  The string to display as the label while in the initializing phase.
	 *
	 *  @default "Initializing"
		 */
		public static function get initializingLabel () : String;
		/**
		 *  @private
		 */
		public static function set initializingLabel (value:String) : void;

		/**
		 *  Text to display when the progress bar is active.
	 *  The Preloader class sets this value
	 *  before displaying the progress bar.
	 *  Implementing this property in a subclass is optional.
	 *
	 *  @default ""
		 */
		protected function get label () : String;
		/**
		 *  @private
		 */
		protected function set label (value:String) : void;

		/**
		 *  The TextFormat object of the TextField component of the label.
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get labelFormat () : TextFormat;

		/**
		 *  The dimensions of the TextField component for the label. 
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get labelRect () : Rectangle;

		/**
		 *  The TextFormat of the TextField component for displaying the percent.
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get percentFormat () : TextFormat;

		/**
		 *  The dimensions of the TextField component for displaying the percent.
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get percentRect () : Rectangle;

		/**
		 *  Controls whether to display the label, <code>true</code>, 
	 *  or not, <code>false</code>.
	 *
	 *  @default true
		 */
		protected function get showLabel () : Boolean;
		/**
		 *  @private
		 */
		protected function set showLabel (value:Boolean) : void;

		/**
		 *  Controls whether to display the percentage, <code>true</code>, 
	 *  or not, <code>false</code>.
	 *
	 *  @default true
		 */
		protected function get showPercentage () : Boolean;
		/**
		 *  @private
		 */
		protected function set showPercentage (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function DownloadProgressBar ();

		/**
		 *  Called by the Preloader after the download progress bar
	 *  has been added as a child of the Preloader. 
	 *  This should be the starting point for configuring your download progress bar.
		 */
		public function initialize () : void;

		/**
		 *  Centers the download progress bar based on the passed in dimensions.
	 *
	 *  @param width The width of the area in which to center the download progress bar.
	 *
	 *  @param height The height of the area in which to center the download progress bar.
		 */
		protected function center (width:Number, height:Number) : void;

		/**
		 *  @private
	 *  Updates the display.
		 */
		private function draw () : void;

		/**
		 *  Creates the subcomponents of the display.
		 */
		protected function createChildren () : void;

		/**
		 *  @private
	 *  Draws the progress bar.
		 */
		private function drawProgressBar (percentage:Number) : void;

		/**
		 *  Updates the display of the download progress bar
	 *  with the current download information. 
	 *  A typical implementation divides the loaded value by the total value
	 *  and displays a percentage.
	 *  If you do not implement this method, you should create
	 *  a progress bar that displays an animation to indicate to the user
	 *  that a download is occurring.
	 *
	 *  <p>The <code>setProgress()</code> method is only called
     *  if the application is being downloaded from a remote server
     *  and the application is not in the browser cache.</p>
     *
	 *  @param completed Number of bytes of the application SWF file
	 *  that have been downloaded.
	 *
	 *  @param total Size of the application SWF file in bytes.
		 */
		protected function setProgress (completed:Number, total:Number) : void;

		/**
		 *  Returns the percentage value of the application loaded. 
     *
	 *  @param loaded Number of bytes of the application SWF file
	 *  that have been downloaded.
	 *
	 *  @param total Size of the application SWF file in bytes.
	 *
	 *  @return The percentage value of the loaded application.
		 */
		protected function getPercentLoaded (loaded:Number, total:Number) : Number;

		/**
		 *  @private
	 *  Make the display class visible.
		 */
		private function show () : void;

		/**
		 *  @private
		 */
		private function hide () : void;

		/**
		 *  @private
		 */
		private function calcX (base:Number) : Number;

		/**
		 *  @private
		 */
		private function calcY (base:Number) : Number;

		/**
		 *  @private
	 *  Figure out the scale for the display class based on the stage size.
	 *  Then creates the children subcomponents.
		 */
		private function calcScale () : void;

		/**
		 *  Defines the algorithm for determining whether to show
	 *  the download progress bar while in the download phase.
	 *
	 *  @param elapsedTime number of milliseconds that have elapsed
	 *  since the start of the download phase.
	 *
	 *  @param event The ProgressEvent object that contains
	 *  the <code>bytesLoaded</code> and <code>bytesTotal</code> properties.
	 *
	 *  @return If the return value is <code>true</code>, then show the 
	 *  download progress bar.
	 *  The default behavior is to show the download progress bar 
	 *  if more than 700 milliseconds have elapsed
	 *  and if Flex has downloaded less than half of the bytes of the SWF file.
		 */
		protected function showDisplayForDownloading (elapsedTime:int, event:ProgressEvent) : Boolean;

		/**
		 *  Defines the algorithm for determining whether to show the download progress bar
	 *  while in the initialization phase, assuming that the display
	 *  is not currently visible.
	 *
	 *  @param elapsedTime number of milliseconds that have elapsed
	 *  since the start of the download phase.
	 *
	 *  @param count number of times that the <code>initProgress</code> event
	 *  has been received from the application.
	 *
	 *  @return If <code>true</code>, then show the download progress bar.
		 */
		protected function showDisplayForInit (elapsedTime:int, count:int) : Boolean;

		/**
		 *  @private
		 */
		private function loadBackgroundImage (classOrString:Object) : void;

		/**
		 *  @private
		 */
		private function initBackgroundImage (image:DisplayObject) : void;

		/**
		 *  @private
		 */
		private function calcBackgroundSize () : Number;

		/**
		 *  Event listener for the <code>ProgressEvent.PROGRESS</code> event. 
	 *  This implementation updates the progress bar
	 *  with the percentage of bytes downloaded.
	 *
	 *  @param event The event object.
		 */
		protected function progressHandler (event:ProgressEvent) : void;

		/**
		 *  Event listener for the <code>Event.COMPLETE</code> event. 
	 *  The default implementation does nothing.
	 *
	 *  @param event The event object.
		 */
		protected function completeHandler (event:Event) : void;

		/**
		 *  Event listener for the <code>RSLEvent.RSL_PROGRESS</code> event. 
	 *  The default implementation does nothing.
	 *
	 *  @param event The event object.
		 */
		protected function rslProgressHandler (event:RSLEvent) : void;

		/**
		 *  Event listener for the <code>RSLEvent.RSL_COMPLETE</code> event. 
	 *
	 *  @param event The event object.
		 */
		protected function rslCompleteHandler (event:RSLEvent) : void;

		/**
		 *  Event listener for the <code>RSLEvent.RSL_ERROR</code> event. 
	 *  This event listner handles any errors detected when downloading an RSL.
	 *
	 *  @param event The event object.
		 */
		protected function rslErrorHandler (event:RSLEvent) : void;

		/**
		 *  @private
	 *  Helper function that dispatches the Complete event to the preloader.
	 *
	 *  @param event The event object.
		 */
		private function timerHandler (event:Event = null) : void;

		/**
		 *  Event listener for the <code>FlexEvent.INIT_PROGRESS</code> event. 
	 *  This implementation updates the progress bar
	 *  each time the event is dispatched, and changes the text of the label. 
	 *
	 *  @param event The event object.
		 */
		protected function initProgressHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function initCompleteHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function loader_completeHandler (event:Event) : void;

		private function loader_ioErrorHandler (event:IOErrorEvent) : void;
	}
	/**
	 * @private
 * 
 * Area to display error messages to help debug startup problems.
 *
	 */
	private class ErrorField extends Sprite
	{
		private var downloadProgressBar : DownloadProgressBar;
		private const MIN_WIDTH_INCHES : int = 2;
		private const MAX_WIDTH_INCHES : int = 6;
		private const TEXT_MARGIN_PX : int = 10;

		/**
		 *  The TextFormat object of the TextField component of the label.
	 *  This is a read-only property which you must override
	 *  if you need to change it.
		 */
		protected function get labelFormat () : TextFormat;

		/**
		 * @private
   * 
   * @param - parent - parent of the error field.
		 */
		public function ErrorField (downloadProgressBar:DownloadProgressBar);

		/**
		 * Create and show the error message.
    * 
    * @param errorText - text for error message.
		 */
		public function show (errorText:String) : void;
	}
}
