/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class Event {
		/**
		 * Indicates whether an event is a bubbling event. If the event can bubble,
		 *  this value is true; otherwise it is false.
		 */
		public function get bubbles():Boolean;
		/**
		 * Indicates whether the behavior associated with the event can be prevented.
		 *  If the behavior can be canceled, this value is true; otherwise it is false.
		 */
		public function get cancelable():Boolean;
		/**
		 * The object that is actively processing the Event object with an event listener. For example, if a user clicks an OK button, the current target could be the node containing that button or one of its ancestors that has registered an event listener for that event.
		 */
		public function get currentTarget():Object;
		/**
		 * The current phase in the event flow. This property can contain the following numeric values:
		 *  The capture phase (EventPhase.CAPTURING_PHASE).
		 *  The target phase (EventPhase.AT_TARGET).
		 *  The bubbling phase (EventPhase.BUBBLING_PHASE).
		 */
		public function get eventPhase():uint;
		/**
		 * The event target. This property contains the target node. For example, if a user clicks an OK button, the target node is the display list node containing that button.
		 */
		public function get target():Object;
		/**
		 * The type of event. The type is case-sensitive.
		 */
		public function get type():String;
		/**
		 * Creates an Event object to pass as a parameter to event listeners.
		 *
		 * @param type              <String> The type of the event, accessible as Event.type.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. The default value is false.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. The default values is false.
		 */
		public function Event(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 * Duplicates an instance of an Event subclass.
		 *
		 * @return                  <Event> A new Event object that is identical to the original.
		 */
		public function clone():Event;
		/**
		 * A utility function for implementing the toString() method in custom
		 *  ActionScript 3.0 Event classes. Overriding the
		 *  toString() method is recommended, but not required.
		 *
		 * @param className         <String> The name of your custom Event class. In the previous example,
		 *                            the className parameter is PingEvent.
		 * @return                  <String> The name of your custom Event class and the String value of your ...arguments
		 *                            parameter.
		 */
		public function formatToString(className:String, ... arguments):String;
		/**
		 * Checks whether the preventDefault() method has been called on the event. If the
		 *  preventDefault() method has been called,
		 *  returns true; otherwise, returns false.
		 *
		 * @return                  <Boolean> If preventDefault() has been called, returns true; otherwise,
		 *                            returns false.
		 */
		public function isDefaultPrevented():Boolean;
		/**
		 * Cancels an event's default behavior if that behavior can be canceled.
		 */
		public function preventDefault():void;
		/**
		 * Prevents processing of any event listeners in the current node and any subsequent nodes in
		 *  the event flow. This method takes effect immediately, and it affects event listeners
		 *  in the current node. In contrast, the stopPropagation() method doesn't take
		 *  effect until all the event listeners in the current node finish processing.
		 */
		public function stopImmediatePropagation():void;
		/**
		 * Prevents processing of any event listeners in nodes subsequent to the current node in the
		 *  event flow. This method does not affect any event listeners in the current node
		 *  (currentTarget). In contrast, the stopImmediatePropagation() method
		 *  prevents processing of event listeners in both the current node and subsequent nodes.
		 *  Additional calls to this method have no effect. This method can be called in any phase
		 *  of the event flow.
		 */
		public function stopPropagation():void;
		/**
		 * Returns a string containing all the properties of the Event object.
		 *
		 * @return                  <String> A string containing all the properties of the Event object.
		 */
		public function toString():String;
		/**
		 * The Event.ACTIVATE constant defines the value of the type property of an activate event object.
		 */
		public static const ACTIVATE:String = "activate";
		/**
		 * The Event.ADDED constant defines the value of the type property of
		 *  an added event object.
		 */
		public static const ADDED:String = "added";
		/**
		 * The Event.ADDED_TO_STAGE constant defines the value of the type
		 *  property of an addedToStage event object.
		 */
		public static const ADDED_TO_STAGE:String = "addedToStage";
		/**
		 * The Event.CANCEL constant defines the value of the type property of a cancel event object.
		 */
		public static const CANCEL:String = "cancel";
		/**
		 * The Event.CHANGE constant defines the value of the type property of a change event object.
		 */
		public static const CHANGE:String = "change";
		/**
		 * The Event.CLOSE constant defines the value of the type property of a close event object.
		 */
		public static const CLOSE:String = "close";
		/**
		 * The Event.CLOSING constant defines the value of the
		 *  type property of a closing event object.
		 */
		public static const CLOSING:String = "closing";
		/**
		 * The Event.COMPLETE constant defines the value of the type property of a complete event object.
		 */
		public static const COMPLETE:String = "complete";
		/**
		 * The Event.CONNECT constant defines the value of the type property of a connect event object.
		 */
		public static const CONNECT:String = "connect";
		/**
		 * The Event.DEACTIVATE constant defines the value of the type property of a deactivate event object.
		 */
		public static const DEACTIVATE:String = "deactivate";
		/**
		 * Defines the value of the type property of a displaying event object.
		 */
		public static const DISPLAYING:String = "displaying";
		/**
		 * The Event.ENTER_FRAME constant defines the value of the type property of
		 *  an enterFrame event object.
		 */
		public static const ENTER_FRAME:String = "enterFrame";
		/**
		 * The Event.EXITING constant defines the value of the type property of an exiting event object.
		 */
		public static const EXITING:String = "exiting";
		/**
		 * The Event.FULL_SCREEN constant defines the value of the type property of a fullScreen event object.
		 */
		public static const FULLSCREEN:String = "fullScreen";
		/**
		 * The Event.HTML_BOUNDS_CHANGE constant defines the value of the type property of an htmlBoundsChange event object.
		 */
		public static const HTML_BOUNDS_CHANGE:String = "htmlBoundsChange";
		/**
		 * The Event.HTML_DOM_INITIALIZE constant defines the value of the type property
		 *  of an htmlDOMInitialize event object.
		 */
		public static const HTML_DOM_INITIALIZE:String = "htmlDOMInitialize";
		/**
		 * The Event.HTML_RENDER constant defines the value of the type property of an htmlRender event object.
		 */
		public static const HTML_RENDER:String = "htmlRender";
		/**
		 * The Event.ID3 constant defines the value of the type property of an id3 event object.
		 */
		public static const ID3:String = "id3";
		/**
		 * The Event.INIT constant defines the value of the type property of an init event object.
		 */
		public static const INIT:String = "init";
		/**
		 * The Event.LOCATION_CHANGE constant defines the value of the type property of a locationChange event object.
		 */
		public static const LOCATION_CHANGE:String = "locationChange";
		/**
		 * The Event.MOUSE_LEAVE constant defines the value of the type property of a mouseLeave event object.
		 */
		public static const MOUSE_LEAVE:String = "mouseLeave";
		/**
		 * The Event.NETWORK_CHANGE constant defines the value of the type property of a networkChange event object.
		 */
		public static const NETWORK_CHANGE:String = "networkChange";
		/**
		 * The Event.OPEN constant defines the value of the type property of an open event object.
		 */
		public static const OPEN:String = "open";
		/**
		 * The Event.REMOVED constant defines the value of the type property of
		 *  a removed event object.
		 */
		public static const REMOVED:String = "removed";
		/**
		 * The Event.REMOVED_FROM_STAGE constant defines the value of the type
		 *  property of a removedFromStage event object.
		 */
		public static const REMOVED_FROM_STAGE:String = "removedFromStage";
		/**
		 * The Event.RENDER constant defines the value of the type property of a render event object.
		 */
		public static const RENDER:String = "render";
		/**
		 * The Event.RESIZE constant defines the value of the type property of a resize event object.
		 */
		public static const RESIZE:String = "resize";
		/**
		 * The Event.SCROLL constant defines the value of the type property of a scroll event object.
		 */
		public static const SCROLL:String = "scroll";
		/**
		 * The Event.SELECT constant defines the value of the type property of a select event object.
		 */
		public static const SELECT:String = "select";
		/**
		 * The Event.SOUND_COMPLETE constant defines the value of the type property of a soundComplete event object.
		 */
		public static const SOUND_COMPLETE:String = "soundComplete";
		/**
		 * The Event.TAB_CHILDREN_CHANGE constant defines the value of the type
		 *  property of a tabChildrenChange event object.
		 */
		public static const TAB_CHILDREN_CHANGE:String = "tabChildrenChange";
		/**
		 * The Event.TAB_ENABLED_CHANGE constant defines the value of the type
		 *  property of a tabEnabledChange event object.
		 */
		public static const TAB_ENABLED_CHANGE:String = "tabEnabledChange";
		/**
		 * The Event.TAB_INDEX_CHANGE constant defines the value of the
		 *  type property of a tabIndexChange event object.
		 */
		public static const TAB_INDEX_CHANGE:String = "tabIndexChange";
		/**
		 * The Event.UNLOAD constant defines the value of the type property of an unload event object.
		 */
		public static const UNLOAD:String = "unload";
		/**
		 * The Event.USER_IDLE constant defines the value of the type property of a userIdle event object.
		 */
		public static const USER_IDLE:String = "userIdle";
		/**
		 * The Event.USER_PRESENT constant defines the value of the type property of a userPresent event object.
		 */
		public static const USER_PRESENT:String = "userPresent";
	}
}
