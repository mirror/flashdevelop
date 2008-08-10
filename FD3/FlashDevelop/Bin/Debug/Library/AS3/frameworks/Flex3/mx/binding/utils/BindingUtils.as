/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.binding.utils {
	public class BindingUtils {
		/**
		 * Binds a public property, prop on the site
		 *  Object, to a bindable property or property chain.
		 *  If a ChangeWatcher instance is successfully created, prop
		 *  is initialized to the current value of chain.
		 *
		 * @param site              <Object> The Object defining the property to be bound
		 *                            to chain.
		 * @param prop              <String> The name of the public property defined in the
		 *                            site Object to be bound.
		 *                            The property will receive the current value of chain,
		 *                            when the value of chain changes.
		 * @param host              <Object> The object that hosts the property or property chain
		 *                            to be watched.
		 * @param chain             <Object> A value specifying the property or chain to be watched.
		 *                            Legal values are:
		 *                            String containing the name of a public bindable property
		 *                            of the host object.
		 *                            An Object in the form:
		 *                            { name: property name, getter: function(host) { return host[property name] } }.
		 *                            This Object must contain the name of, and a getter function for,
		 *                            a public bindable property of the host object.
		 *                            A non-empty Array containing a combination of the first two
		 *                            options that represents a chain of bindable properties accessible
		 *                            from the host.
		 *                            For example, to bind the property host.a.b.c,
		 *                            call the method as:
		 *                            bindProperty(host, ["a","b","c"], ...).
		 *                            Note: The property or properties named in the chain argument
		 *                            must be public, because the describeType() method suppresses all information
		 *                            about non-public properties, including the bindability metadata
		 *                            that ChangeWatcher scans to find the change events that are exposed
		 *                            for a given property.
		 *                            However, the getter function supplied when using the { name, getter }
		 *                            argument form described above can be used to associate an arbitrary
		 *                            computed value with the named (public) property.
		 * @param commitOnly        <Boolean (default = false)> Set to true if the handler
		 *                            should be called only on committing change events;
		 *                            set to false if the handler should be called
		 *                            on both committing and non-committing change events.
		 *                            Note: the presence of non-committing change events for a property
		 *                            is indicated by the [NonCommittingChangeEvent(<event-name>)]
		 *                            metadata tag.
		 *                            Typically these tags are used to indicate fine-grained value changes,
		 *                            such as modifications in a text field prior to confirmation.
		 * @return                  <ChangeWatcher> A ChangeWatcher instance, if at least one property name has
		 *                            been specified to the chain argument; null otherwise.
		 */
		public static function bindProperty(site:Object, prop:String, host:Object, chain:Object, commitOnly:Boolean = false):ChangeWatcher;
		/**
		 * Binds a setter function, setter, to a bindable property
		 *  or property chain.
		 *  If a ChangeWatcher instance is successfully created,
		 *  the setter function is invoked with current value of chain.
		 *
		 * @param setter            <Function> Setter method to invoke with an argument of the current
		 *                            value of chain when that value changes.
		 * @param host              <Object> The host of the property.
		 *                            See the bindProperty() method for more information.
		 * @param chain             <Object> The name of the property, or property chain.
		 *                            See the bindProperty() method for more information.
		 * @param commitOnly        <Boolean (default = false)> Set to true if the handler should be
		 *                            called only on committing change events.
		 *                            See the bindProperty() method for more information.
		 * @return                  <ChangeWatcher> A ChangeWatcher instance, if at least one property name
		 *                            has been  specified to the chain argument; null otherwise.
		 */
		public static function bindSetter(setter:Function, host:Object, chain:Object, commitOnly:Boolean = false):ChangeWatcher;
	}
}
