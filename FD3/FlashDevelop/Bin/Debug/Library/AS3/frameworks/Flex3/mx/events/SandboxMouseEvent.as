package mx.events
{
	import flash.events.Event;

include "../core/Version.as"
	/**
	 *  This is an event sent between applications in different security sandboxes to notify listeners
 *  about mouse activity in another security sandbox.
 *
 *  For security reasons, some fields of a MouseEvent are not sent
 *  in a SandboxMouseEvent.
	 */
	public class SandboxMouseEvent extends Event
	{
		/**
		 *  Mouse was clicked somewhere outside your sandbox.
		 */
		public static const CLICK_SOMEWHERE : String = "clickSomewhere";
		/**
		 *  Mouse was double-clicked somewhere outside your sandbox.
		 */
		public static const DOUBLE_CLICK_SOMEWHERE : String = "coubleClickSomewhere";
		/**
		 *  Mouse button was pressed down somewhere outside your sandbox.
		 */
		public static const MOUSE_DOWN_SOMEWHERE : String = "mouseDownSomewhere";
		/**
		 *  Mouse was moved somewhere outside your sandbox.
		 */
		public static const MOUSE_MOVE_SOMEWHERE : String = "mouseMoveSomewhere";
		/**
		 *  Mouse button was released somewhere outside your sandbox.
		 */
		public static const MOUSE_UP_SOMEWHERE : String = "mouseUpSomewhere";
		/**
		 *  Mouse wheel was spun somewhere outside your sandbox.
		 */
		public static const MOUSE_WHEEL_SOMEWHERE : String = "mouseWheelSomewhere";
		/**
		 *  Indicates whether the <code>Alt</code> key was pressed.
	 *  
	 *  @see flash.events.MouseEvent#altkey
		 */
		public var altKey : Boolean;
		/**
		 *  Indicates whether the primary mouse button is pressed (true) or not (false).
	 *  
	 *  @see flash.events.MouseEvent#buttonDown
		 */
		public var buttonDown : Boolean;
		/**
		 *  Indicates whether the <code>Ctrl</code> key was pressed.
	 *  
	 *  @see flash.events.MouseEvent#ctrlKey
		 */
		public var ctrlKey : Boolean;
		/**
		 *  Indicates whether the <code>Shift</code> key was pressed.
	 *  
	 *  @see flash.events.MouseEvent#shiftKey
		 */
		public var shiftKey : Boolean;

		/**
		 *  Marshal a SWFBridgeRequest from a remote ApplicationDomain into the current
     *  ApplicationDomain.
     * 
     *  @param event A SWFBridgeRequest that might have been created in a different ApplicationDomain.
     * 
     *  @return A SandboxMouseEvent created in the caller's ApplicationDomain.
		 */
		public static function marshal (event:Event) : SandboxMouseEvent;

		/**
		 *  Constructor.
	 *  
	 *  @param type The event type; indicates the action that caused the event.
	 *
	 *  @param bubbles Specifies whether the event can bubble up the display list hierarchy.
	 *
	 *  @param cancelable Specifies whether the behavior associated with the event can be prevented.
	 *
	 *  @param ctrlKey Indicates whether the <code>Ctrl</code> key was pressed.
	 *
	 *  @param altKey Indicates whether the <code>Alt</code> key was pressed.
	 *
	 *  @param shiftKey Indicates whether the <code>Shift</code> key was pressed.	 
	 *  
	 *  @param buttonDown Indicates whether the primary mouse button is pressed (true) or not (false).
	 *
		 */
		public function SandboxMouseEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false);

		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
