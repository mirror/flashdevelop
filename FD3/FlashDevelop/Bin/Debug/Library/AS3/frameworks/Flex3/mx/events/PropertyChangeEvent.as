/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class PropertyChangeEvent extends Event {
		/**
		 * Specifies the kind of change.
		 *  The possible values are PropertyChangeEventKind.UPDATE,
		 *  PropertyChangeEventKind.DELETE, and null.
		 */
		public var kind:String;
		/**
		 * The value of the property after the change.
		 */
		public var newValue:Object;
		/**
		 * The value of the property before the change.
		 */
		public var oldValue:Object;
		/**
		 * A String, QName, or int specifying the property that changed.
		 */
		public var property:Object;
		/**
		 * The object that the change occured on.
		 */
		public var source:Object;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param kind              <String (default = null)> Specifies the kind of change.
		 *                            The possible values are PropertyChangeEventKind.UPDATE,
		 *                            PropertyChangeEventKind.DELETE, and null.
		 * @param property          <Object (default = null)> A String, QName, or int
		 *                            specifying the property that changed.
		 * @param oldValue          <Object (default = null)> The value of the property before the change.
		 * @param newValue          <Object (default = null)> The value of the property after the change.
		 * @param source            <Object (default = null)> The object that the change occured on.
		 */
		public function PropertyChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, kind:String = null, property:Object = null, oldValue:Object = null, newValue:Object = null, source:Object = null);
		/**
		 * Returns a new PropertyChangeEvent of kind
		 *  PropertyChangeEventKind.UPDATE
		 *  with the specified properties.
		 *  This is a convenience method.
		 *
		 * @param source            <Object> The object where the change occured.
		 * @param property          <Object> A String, QName, or int
		 *                            specifying the property that changed,
		 * @param oldValue          <Object> The value of the property before the change.
		 * @param newValue          <Object> The value of the property after the change.
		 * @return                  <PropertyChangeEvent> A newly constructed PropertyChangeEvent
		 *                            with the specified properties.
		 */
		public static function createUpdateEvent(source:Object, property:Object, oldValue:Object, newValue:Object):PropertyChangeEvent;
		/**
		 * The PropertyChangeEvent.PROPERTY_CHANGE constant defines the value of the
		 *  type property of the event object for a PropertyChange event.
		 */
		public static const PROPERTY_CHANGE:String = "propertyChange";
	}
}
