/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	import flash.display.InteractiveObject;
	import flash.desktop.Clipboard;
	import flash.desktop.NativeDragOptions;
	public class NativeDragEvent extends MouseEvent {
		/**
		 * The NativeDragOptions object specifying the actions that are allowed by the
		 *  display object that initiated this drag operation.
		 */
		public var allowedActions:NativeDragOptions;
		/**
		 * The Clipboard object containing the data in this drag operation.
		 */
		public var clipboard:Clipboard;
		/**
		 * The current action. In the nativeDragComplete event, the dropAction
		 *  property reports the final action.
		 */
		public var dropAction:String;
		/**
		 * Creates an Event object with specific information relevant to native drag-and-drop events.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            NativeDragEvent.NATIVE_DRAG_START,
		 *                            NativeDragEvent.NATIVE_DRAG_UPDATE,
		 *                            NativeDragEvent.NATIVE_DRAG_ENTER,
		 *                            NativeDragEvent.NATIVE_DRAG_OVER,
		 *                            NativeDragEvent.NATIVE_DRAG_EXIT,
		 *                            NativeDragEvent.NATIVE_DRAG_DROP,
		 *                            and NativeDragEvent.NATIVE_DRAG_COMPLETE.
		 * @param bubbles           <Boolean (default = false)> Indicates whether the Event object participates in the bubbling phase of the event flow.
		 * @param cancelable        <Boolean (default = true)> Indicates whether the Event object can be canceled.
		 * @param localX            <Number (default = NaN)> The horizontal coordinate at which the event occurred relative to the containing sprite.
		 * @param localY            <Number (default = NaN)> The vertical coordinate at which the event occurred relative to the containing sprite.
		 * @param relatedObject     <InteractiveObject (default = null)> The related interactive display object.
		 * @param clipboard         <Clipboard (default = null)> The Clipboard object containing the data to be transfered.
		 * @param allowedActions    <NativeDragOptions (default = null)> The NativeDragOptions object defining the allowed actions (move, copy, and link).
		 * @param dropAction        <String (default = null)> The current action.
		 * @param controlKey        <Boolean (default = false)> Indicates whether the Control key is activated.
		 * @param altKey            <Boolean (default = false)> Indicates whether the Alt key is activated.
		 * @param shiftKey          <Boolean (default = false)> Indicates whether the Shift key is activated.
		 * @param commandKey        <Boolean (default = false)> Indicates whether the Command key is activated.
		 */
		public function NativeDragEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, clipboard:Clipboard = null, allowedActions:NativeDragOptions = null, dropAction:String = null, controlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, commandKey:Boolean = false);
		/**
		 * Creates a copy of this NativeDragEvent object.
		 *
		 * @return                  <Event> A new NativeDragEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Formats the properties of this NativeDragEvent object as a string.
		 *
		 * @return                  <String> The properties of this NativeDragEvent as a string.
		 */
		public override function toString():String;
		/**
		 * NativeDragEvent.NATIVE_DRAG_COMPLETE defines the value of the
		 *  type property of a nativeDragComplete event object.
		 */
		public static const NATIVE_DRAG_COMPLETE:String = "nativeDragComplete";
		/**
		 * NativeDragEvent.NATIVE_DRAG_DROP defines the value of the type
		 *  property of a nativeDragDrop event object.
		 */
		public static const NATIVE_DRAG_DROP:String = "nativeDragDrop";
		/**
		 * NativeDragEvent.NATIVE_DRAG_ENTER defines the value of the
		 *  type property of a nativeDragEnter event object.
		 */
		public static const NATIVE_DRAG_ENTER:String = "nativeDragEnter";
		/**
		 * NativeDragEvent.NATIVE_DRAG_EXIT defines the value of the type
		 *  property of a nativeDragExit event object.
		 */
		public static const NATIVE_DRAG_EXIT:String = "nativeDragExit";
		/**
		 * NativeDragEvent.NATIVE_DRAG_OVER defines the value of the type
		 *  property of a nativeDragOver event object.
		 */
		public static const NATIVE_DRAG_OVER:String = "nativeDragOver";
		/**
		 * NativeDragEvent.NATIVE_DRAG_START defines the value of the type
		 *  property of a nativeDragStart event object.
		 */
		public static const NATIVE_DRAG_START:String = "nativeDragStart";
		/**
		 * NativeDragEvent.NATIVE_DRAG_UPDATE defines the value of the
		 *  type property of a nativeDragUpdate event object.
		 */
		public static const NATIVE_DRAG_UPDATE:String = "nativeDragUpdate";
	}
}
