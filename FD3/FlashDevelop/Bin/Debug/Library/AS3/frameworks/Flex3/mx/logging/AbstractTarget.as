/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.logging {
	import mx.core.IMXMLObject;
	public class AbstractTarget implements ILoggingTarget, IMXMLObject {
		/**
		 * In addition to the level setting, filters are used to
		 *  provide a psuedo-hierarchical mapping for processing only those events
		 *  for a given category.
		 */
		public function get filters():Array;
		public function set filters(value:Array):void;
		/**
		 * Provides access to the id of this target.
		 *  The id is assigned at runtime by the mxml compiler if used as an mxml
		 *  tag, or internally if used within a script block
		 */
		public function get id():String;
		/**
		 * Provides access to the level this target is currently set at.
		 *  Value values are:
		 *  LogEventLevel.FATAL designates events that are very
		 *  harmful and will eventually lead to application failure
		 *  LogEventLevel.ERROR designates error events that might
		 *  still allow the application to continue running.
		 *  LogEventLevel.WARN designates events that could be
		 *  harmful to the application operation
		 *  LogEventLevel.INFO designates informational messages
		 *  that highlight the progress of the application at
		 *  coarse-grained level.
		 *  LogEventLevel.DEBUG designates informational
		 *  level messages that are fine grained and most helpful when
		 *  debugging an application.
		 *  LogEventLevel.ALL intended to force a target to
		 *  process all messages.
		 */
		public function get level():int;
		public function set level(value:int):void;
		/**
		 * Constructor.
		 */
		public function AbstractTarget();
		/**
		 * Sets up this target with the specified logger.
		 *  This allows this target to receive log events from the specified logger.
		 *
		 * @param logger            <ILogger> The ILogger that this target should listen to.
		 */
		public function addLogger(logger:ILogger):void;
		/**
		 * Called after the implementing object has been created
		 *  and all properties specified on the tag have been assigned.
		 *
		 * @param document          <Object> MXML document that created this object.
		 * @param id                <String> Used by the document to refer to this object.
		 *                            If the object is a deep property on the document, id is null.
		 */
		public function initialized(document:Object, id:String):void;
		/**
		 * This method handles a LogEvent from an associated logger.
		 *  A target uses this method to translate the event into the appropriate
		 *  format for transmission, storage, or display.
		 *  This method will be called only if the event's level is in range of the
		 *  target's level.
		 *  Descendants need to override this method to make it useful.
		 *
		 * @param event             <LogEvent> 
		 */
		public function logEvent(event:LogEvent):void;
		/**
		 * Stops this target from receiving events from the specified logger.
		 *
		 * @param logger            <ILogger> The ILogger that this target should ignore.
		 */
		public function removeLogger(logger:ILogger):void;
	}
}
