/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class CubeEvent extends Event {
		/**
		 * A description of what is being processed.
		 */
		public var message:String;
		/**
		 * The number of elements in the cube that have been updated.
		 */
		public var progress:int;
		/**
		 * The total number of elements in the cube that need to be udpated.
		 */
		public var total:int;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 */
		public function CubeEvent(type:String);
		/**
		 * The CubeEvent.CUBE_COMPLETE constant defines the value of the
		 *  type property of the event object for a
		 *  complete event.
		 */
		public static const CUBE_COMPLETE:String = "complete";
		/**
		 * The CubeEvent.CUBE_PROGRESS constant defines the value of the
		 *  type property of the event object for a
		 *  progress event.
		 */
		public static const CUBE_PROGRESS:String = "progress";
		/**
		 * The CubeEvent.QUERY_PROGRESS constant defines the value of the
		 *  type property of the event object for a
		 *  queryProgress event.
		 */
		public static const QUERY_PROGRESS:String = "queryProgress";
	}
}
