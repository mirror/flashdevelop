/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import flash.events.EventDispatcher;
	public class FlexClient extends EventDispatcher {
		/**
		 * The global FlexClient Id for this Player instance.
		 *  This value is server assigned and is set as part of the Channel connect process.
		 *  Once set, it will not change for the duration of the Player instance's lifespan.
		 *  If no Channel has connected to a server this value is null.
		 */
		public function get id():String;
		public function set id(value:String):void;
		/**
		 * Returns the sole instance of this singleton class,
		 *  creating it if it does not already exist.
		 */
		public static function getInstance():FlexClient;
	}
}
