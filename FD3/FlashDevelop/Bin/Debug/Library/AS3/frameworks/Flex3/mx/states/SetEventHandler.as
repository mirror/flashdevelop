/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.states {
	import flash.events.EventDispatcher;
	import mx.core.UIComponent;
	public class SetEventHandler extends EventDispatcher implements IOverride {
		/**
		 * The handler function for the event.
		 *  This property is intended for developers who use ActionScript to
		 *  create and access view states.
		 *  In MXML, you can use the equivalent handler
		 *  event attribute; do not use both in a single MXML tag.
		 */
		public var handlerFunction:Function;
		/**
		 * The name of the event whose handler is being set.
		 *  You must set this property, either in
		 *  the SetEventHandler constructor or by setting
		 *  the property value directly.
		 */
		public var name:String;
		/**
		 * The component that dispatches the event.
		 *  If the property value is null, Flex uses the
		 *  immediate parent of the <mx:states> tag.
		 */
		public var target:EventDispatcher;
		/**
		 * Constructor.
		 *
		 * @param target            <EventDispatcher (default = null)> The object that dispatches the event to be handled.
		 *                            By default, Flex uses the immediate parent of the State object.
		 * @param name              <String (default = null)> The event type for which to set the handler.
		 */
		public function SetEventHandler(target:EventDispatcher = null, name:String = null);
		/**
		 * Applies the override. Flex retains the original value, so that it can
		 *  restore the value later in the remove() method.
		 *
		 * @param parent            <UIComponent> The parent of the state object containing this override.
		 *                            The override should use this as its target if an explicit target was
		 *                            not specified.
		 */
		public function apply(parent:UIComponent):void;
		/**
		 * Initializes the override.
		 *  Flex calls this method before the first call to the
		 *  apply() method, so you put one-time initialization
		 *  code for the override in this method.
		 */
		public function initialize():void;
		/**
		 * Removes the override. The value remembered in the apply()
		 *  method is restored.
		 *
		 * @param parent            <UIComponent> The parent of the state object containing this override.
		 *                            The override should use this as its target if an explicit target was
		 *                            not specified.
		 */
		public function remove(parent:UIComponent):void;
	}
}
