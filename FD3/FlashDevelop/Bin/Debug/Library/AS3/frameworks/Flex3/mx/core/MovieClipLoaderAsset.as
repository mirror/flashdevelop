package mx.core
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	/**
	 *  Dispatched after the SWF asset has been fully loaded.
 *
 *  @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 

include "../core/Version.as"
	/**
	 *  MovieClipLoaderAsset is a subclass of the MovieClipAsset class
 *  which represents SWF files that you embed in a Flex application.
	 */
	public class MovieClipLoaderAsset extends MovieClipAsset implements IFlexAsset
	{
		/**
		 *  @private
		 */
		private var loader : Loader;
		/**
		 *  @private
		 */
		private var initialized : Boolean;
		/**
		 *  @private
		 */
		private var requestedWidth : Number;
		/**
		 *  @private
		 */
		private var requestedHeight : Number;
		/**
		 *  Backing storage for the <code>measuredWidth</code> property.
	 *  Subclasses should set this value in the constructor.
		 */
		protected var initialWidth : Number;
		/**
		 *  Backing storage for the <code>measuredHeight</code> property.
	 *  Subclasses should set this value in the constructor.
		 */
		protected var initialHeight : Number;

		/**
		 *  @private
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;

		/**
		 *  @private
	 *  The default height, in pixels.
		 */
		public function get measuredHeight () : Number;

		/**
		 *  @private
	 *  The default width, in pixels.
		 */
		public function get measuredWidth () : Number;

		/**
		 *  @private
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;

		/**
		 *  A ByteArray containing the inner content.
	 *  Overridden in subclasses.
		 */
		public function get movieClipData () : ByteArray;

		/**
		 *  Constructor.
		 */
		public function MovieClipLoaderAsset ();

		/**
		 *  @private
	 *  The event handler for the <code>complete</code> event.
		 */
		private function completeHandler (event:Event) : void;
	}
}
