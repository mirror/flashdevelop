package mx.preloaders
{
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;

	/**
	 *  Defines the interface that  *  a class must implement to be used as a download progress bar. *  The IPreloaderDisplay receives events from the Preloader class *  and is responsible for visualizing that information to the user. * *  @see mx.preloaders.DownloadProgressBar *  @see mx.preloaders.Preloader
	 */
	public interface IPreloaderDisplay extends IEventDispatcher
	{
		/**
		 *  @copy mx.preloaders.DownloadProgressBar#backgroundAlpha
		 */
		public function get backgroundAlpha () : Number;
		/**
		 *  @private
		 */
		public function set backgroundAlpha (value:Number) : void;
		/**
		 *  @copy mx.preloaders.DownloadProgressBar#backgroundColor
		 */
		public function get backgroundColor () : uint;
		/**
		 *  @private
		 */
		public function set backgroundColor (value:uint) : void;
		/**
		 *  @copy mx.preloaders.DownloadProgressBar#backgroundImage
		 */
		public function get backgroundImage () : Object;
		/**
		 *  @private
		 */
		public function set backgroundImage (value:Object) : void;
		/**
		 *  @copy mx.preloaders.DownloadProgressBar#backgroundSize
		 */
		public function get backgroundSize () : String;
		/**
		 *  @private
		 */
		public function set backgroundSize (value:String) : void;
		/**
		 *  @copy mx.preloaders.DownloadProgressBar#preloader
		 */
		public function set preloader (obj:Sprite) : void;
		/**
		 *  @copy mx.preloaders.DownloadProgressBar#stageHeight
		 */
		public function get stageHeight () : Number;
		/**
		 *  @private
		 */
		public function set stageHeight (value:Number) : void;
		/**
		 *  @copy mx.preloaders.DownloadProgressBar#stageWidth
		 */
		public function get stageWidth () : Number;
		/**
		 *  @private
		 */
		public function set stageWidth (value:Number) : void;

		/**
		 *  @copy mx.preloaders.DownloadProgressBar#initialize()
		 */
		public function initialize () : void;
	}
}
