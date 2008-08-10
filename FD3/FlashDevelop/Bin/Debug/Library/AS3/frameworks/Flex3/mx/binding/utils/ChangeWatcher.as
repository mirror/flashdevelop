/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.binding.utils {
	public class ChangeWatcher {
		/**
		 * Constructor.
		 *  Not for public use. This method is called only from the watch() method.
		 *  See the watch() method for parameter usage.
		 *
		 * @param access            <Object> 
		 * @param handler           <Function> 
		 * @param commitOnly        <Boolean (default = false)> 
		 * @param next              <ChangeWatcher (default = null)> 
		 */
		public function ChangeWatcher(access:Object, handler:Function, commitOnly:Boolean = false, next:ChangeWatcher = null);
		/**
		 * Lets you determine if the host exposes a data-binding event
		 *  on the property.
		 *
		 * @param host              <Object> The host of the property.
		 *                            See the watch() method for more information.
		 * @param name              <String> The name of the property, or property chain.
		 *                            See the watch() method for more information.
		 * @param commitOnly        <Boolean (default = false)> Set to true if the handler
		 *                            should be called only on committing change events.
		 *                            See the watch() method for more information.
		 * @return                  <Boolean> true if host exposes
		 *                            any change events on name.
		 */
		public static function canWatch(host:Object, name:String, commitOnly:Boolean = false):Boolean;
		/**
		 * Returns all the binding events for all bindable properties
		 *  in the host object.
		 *
		 * @param host              <Object> The host of the property.
		 *                            See the watch() method for more information.
		 * @param name              <String> The name of the property, or property chain.
		 *                            See the watch() method for more information.
		 * @param commitOnly        <Boolean (default = false)> Controls inclusion of non-committing
		 *                            change events in the returned value.
		 * @return                  <Object> Object of the form { eventName: isCommitting, ... }
		 *                            containing all change events for the property.
		 */
		public static function getEvents(host:Object, name:String, commitOnly:Boolean = false):Object;
		/**
		 * Retrieves the current value of the watched property or property chain,
		 *  or null if the host object is null.
		 *
		 * @return                  <Object> The current value of the watched property or property chain.
		 */
		public function getValue():Object;
		/**
		 * Returns true if each watcher in the chain is attached
		 *  to at least one change event.
		 *  Note that the isWatching() method
		 *  varies with host, since different hosts may expose different change
		 *  events for the watcher's chosen property.
		 *
		 * @return                  <Boolean> true if each watcher in the chain is attached
		 *                            to at least one change event.
		 */
		public function isWatching():Boolean;
		/**
		 * Resets this ChangeWatcher instance to use a new host object.
		 *  You can call this method to reuse a watcher instance
		 *  on a different host.
		 *
		 * @param newHost           <Object> The new host of the property.
		 *                            See the watch() method for more information.
		 */
		public function reset(newHost:Object):void;
		/**
		 * Sets the handler function.
		 *
		 * @param handler           <Function> The handler function. This argument must not be null.
		 */
		public function setHandler(handler:Function):void;
		/**
		 * Detaches this ChangeWatcher instance, and its handler function,
		 *  from the current host.
		 *  You can use the reset() method to reattach
		 *  the ChangeWatcher instance, or watch the same property
		 *  or chain on a different host object.
		 */
		public function unwatch():void;
		/**
		 * Creates and starts a ChangeWatcher instance.
		 *  A single ChangeWatcher instance can watch one property,
		 *  or a property chain.
		 *  A property chain is a sequence of properties accessible from
		 *  a host object.
		 *  For example, the expression
		 *  obj.a.b.c contains the property chain (a, b, c).
		 *
		 * @param host              <Object> The object that hosts the property or property chain
		 *                            to be watched.
		 *                            You can use the use the reset() method to change
		 *                            the value of the host argument after creating
		 *                            the ChangeWatcher instance.
		 * @param chain             <Object> A value specifying the property or chain to be watched.
		 *                            Legal values are:
		 *                            A String containing the name of a public bindable property
		 *                            of the host object.
		 *                            An Object in the form:
		 *                            { name: property name, getter: function(host) { return host[name] } }.
		 *                            The Object contains the name of a public bindable property,
		 *                            and a function which serves as a getter for that property.
		 *                            A non-empty Array containing any combination
		 *                            of the first two options.
		 *                            This represents a chain of bindable properties
		 *                            accessible from the host.
		 *                            For example, to watch the property host.a.b.c,
		 *                            call the method as: watch(host, ["a","b","c"], ...).
		 *                            Note: The property or properties named in the chain argument
		 *                            must be public, because the describeType() method suppresses all information
		 *                            about non-public properties, including the bindability metadata
		 *                            that ChangeWatcher scans to find the change events that are exposed
		 *                            for a given property.
		 *                            However, the getter function supplied when using the { name, getter }
		 *                            argument form described above can be used to associate an arbitrary
		 *                            computed value with the named (public) property.
		 * @param handler           <Function> An event handler function called when the value of the
		 *                            watched property (or any property in a watched chain) is modified.
		 *                            The modification is signaled when any host object in the watcher
		 *                            chain dispatches the event that has been specified in that host object's
		 *                            [Bindable] metadata tag for the corresponding watched property.
		 *                            The default event is named propertyChange.
		 *                            The event object dispatched by the bindable property is passed
		 *                            to this handler function without modification.
		 *                            By default, Flex dispatches an event object of type PropertyChangeEvent.
		 *                            However, you can define your own event type when you use the
		 *                            [Bindable] metadata tag to define a bindable property.
		 * @param commitOnly        <Boolean (default = false)> Set to true if the handler should be
		 *                            called only on committing change events;
		 *                            set to false if the handler should be called on both
		 *                            committing and non-committing change events.
		 *                            Note: the presence of non-committing change events for a property is
		 *                            indicated by the [NonCommittingChangeEvent(<event-name>)] metadata tag.
		 *                            Typically these tags are used to indicate fine-grained value changes,
		 *                            such as modifications in a text field prior to confirmation.
		 * @return                  <ChangeWatcher> The ChangeWatcher instance, if at least one property name has
		 *                            been specified to the chain argument; null otherwise.
		 *                            Note that the returned watcher is not guaranteed to have successfully
		 *                            discovered and attached itself to change events, since none may have
		 *                            been exposed on the given property or chain by the host.
		 *                            You can use the isWatching() method to determine the
		 *                            watcher's state.
		 */
		public static function watch(host:Object, chain:Object, handler:Function, commitOnly:Boolean = false):ChangeWatcher;
	}
}
