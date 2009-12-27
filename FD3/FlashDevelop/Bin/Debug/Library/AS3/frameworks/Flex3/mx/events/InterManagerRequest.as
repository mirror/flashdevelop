﻿package mx.events
{
	import flash.events.Event;

include "../core/Version.as"
	/**
	 *  This is an event that is sent between ApplicationDomains
 *  to notify trusted listeners about activity in a particular manager.
	 */
	public class InterManagerRequest extends Event
	{
		/**
		 *  Communication between CursorManagers use this request type.
	 *  The <code>name</code> property is the name of some CursorManager property.
	 *  The <code>value</code> property is the value of that property.
		 */
		public static const CURSOR_MANAGER_REQUEST : String = "cursorManagerRequest";
		/**
		 *  Communication between DragManagers use this request type.
	 *  The <code>name</code> property is the name of some DragManager property.
	 *  The <code>value</code> property is the value of that property.
		 */
		public static const DRAG_MANAGER_REQUEST : String = "dragManagerRequest";
		/**
		 *  Ask the other ApplicationDomain to instantiate a manager in
	 *  that ApplicationDomain (if it is not already instantiated)
	 *  so it is available to listen to subsequent
	 *  InterManagerRequests.
	 *  The <code>name</code> property is the name of the manager to instantiate.
		 */
		public static const INIT_MANAGER_REQUEST : String = "initManagerRequest";
		/**
		 *  Request the SystemManager to perform some action.
	 *  The <code>name</code> property is the name of action to perform.
	 *  The <code>value</code> property is the value needed to perform that action.
		 */
		public static const SYSTEM_MANAGER_REQUEST : String = "systemManagerRequest";
		/**
		 *  Communication between ToolTipManagers use this request type.
	 *  The <code>name</code> property is the name of some ToolTipManager property.
	 *  The <code>value</code> property is the value of that property.
		 */
		public static const TOOLTIP_MANAGER_REQUEST : String = "tooltipManagerRequest";
		/**
		 *  Name of property or method or manager to instantiate.
		 */
		public var name : String;
		/**
		 *  Value of property, or array of parameters for method.
		 */
		public var value : Object;

		/**
		 *  Constructor. Does not return anything, but the <code>value</code> property can be modified
     	 *  to represent a return value of a method.
	 *
	 *  @param type The event type; indicates the action that caused the event.
	 *
	 *  @param bubbles Specifies whether the event can bubble up the display list hierarchy.
	 *
	 *  @param cancelable Specifies whether the behavior associated with the event can be prevented.
	 *
	 *  @param name Name of a property or method or name of a manager to instantiate.
     	 *
	 *  @param value Value of a property, or an array of parameters
     	 *  for a method (if not null).
		 */
		public function InterManagerRequest (type:String, bubbles:Boolean = false, cancelable:Boolean = false, name:String = null, value:Object = null);

		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
