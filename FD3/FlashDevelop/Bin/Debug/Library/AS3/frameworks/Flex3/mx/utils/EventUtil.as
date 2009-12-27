package mx.utils
{
	import flash.events.MouseEvent;
	import mx.events.SandboxMouseEvent;

include "../core/Version.as"
	/**
	 *  @private
 * 
 *  Utilities to help with event dispatching or event handling.
	 */
	public class EventUtil
	{
		/**
		 *  @private
		 */
		private static var _sandboxEventMap : Object;
		/**
		 *  @private
		 */
		private static var _mouseEventMap : Object;

		/**
		 *  Mapping of MouseEvents to SandboxMouseEvent types.
		 */
		public static function get sandboxMouseEventMap () : Object;

		/**
		 *  Mapping of SandboxMouseEvent to MouseEvents types.
		 */
		public static function get mouseEventMap () : Object;
	}
}
