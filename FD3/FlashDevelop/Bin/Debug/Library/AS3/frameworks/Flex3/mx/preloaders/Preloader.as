package mx.preloaders
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.core.ResourceModuleRSLItem;
	import mx.core.RSLItem;
	import mx.core.RSLListLoader;
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;

	/**
	 *  The Preloader class is used by the SystemManager to monitor *  the download and initialization status of a Flex application. *  It is also responsible for downloading the runtime shared libraries (RSLs). * *  <p>The Preloader class instantiates a download progress bar,  *  which must implement the IPreloaderDisplay interface, and passes download *  and initialization events to the download progress bar.</p> * *  @see mx.preloaders.DownloadProgressBar *  @see mx.preloaders.Preloader
	 */
	public class Preloader extends Sprite
	{
		/**
		 *  @private
		 */
		private var displayClass : IPreloaderDisplay;
		/**
		 *  @private
		 */
		private var timer : Timer;
		/**
		 *  @private
		 */
		private var showDisplay : Boolean;
		/**
		 *  @private
		 */
		private var rslListLoader : RSLListLoader;
		/**
		 *  @private
		 */
		private var rslDone : Boolean;
		/**
		 *  @private
		 */
		private var app : IEventDispatcher;

		/**
		 *	Constructor.
		 */
		public function Preloader ();
		/**
		 *  Called by the SystemManager to initialize a Preloader object.	 * 	 *  @param showDisplay Determines if the display class should be displayed.	 *	 *  @param displayClassName The IPreloaderDisplay class to use	 *  for displaying the preloader status.	 *	 *  @param backgroundColor Background color of the application.	 *	 *  @param backgroundAlpha Background alpha of the application.	 *	 *  @param backgroundImage Background image of the application.	 *	 *  @param backgroundSize Background size of the application.	 *	 *  @param displayWidth Width of the application.	 *	 *  @param displayHeight Height of the application.	 *	 *  @param libs Array of string URLs for the runtime shared libraries.	 *	 *  @param sizes Array of uint values containing the byte size for each URL	 *  in the libs argument	 * 	 *  @param rslList Array of object of type RSLItem and CdRSLItem.	 *  This array describes all the RSLs to load.	 *  The libs and sizes parameters are ignored and must be set to null.	 *	 *  @param resourceModuleURLs Array of Strings specifying URLs	 *  from which to preload resource modules.
		 */
		public function initialize (showDisplay:Boolean, displayClassName:Class, backgroundColor:uint, backgroundAlpha:Number, backgroundImage:Object, backgroundSize:String, displayWidth:Number, displayHeight:Number, libs:Array = null, sizes:Array = null, rslList:Array = null, resourceModuleURLs:Array = null) : void;
		/**
		 *  Called by the SystemManager after it has finished instantiating	 *  an instance of the application class. Flex calls this method; you 	 *  do not call it yourself.	 *	 *  @param app The application object.
		 */
		public function registerApplication (app:IEventDispatcher) : void;
		/**
		 *  @private	 *  Return the number of bytes loaded and total for the SWF and any RSLs.
		 */
		private function getByteValues () : Object;
		/**
		 *  @private
		 */
		private function dispatchAppEndEvent (event:Object = null) : void;
		/**
		 *  @private	 *  We don't listen for the events directly	 *  because we don't know which RSL is sending the event.	 *  So we have the RSLNode listen to the events	 *  and then pass them along to the Preloader.
		 */
		function rslProgressHandler (event:ProgressEvent) : void;
		/**
		 *  @private	 *  Load the next RSL in the list and dispatch an event.
		 */
		function rslCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function rslErrorHandler (event:ErrorEvent) : void;
		/**
		 *  @private	 *  Listen or poll for progress events and dispatch events	 *  describing the current state of the download
		 */
		private function timerHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function ioErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  @private	 *	Called when the displayClass has finished animating	 *  and no longer needs to be displayed.
		 */
		private function displayClassCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function appCreationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function appProgressHandler (event:Event) : void;
	}
}
