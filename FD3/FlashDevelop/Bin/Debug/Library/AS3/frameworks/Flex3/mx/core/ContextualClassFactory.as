/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class ContextualClassFactory extends ClassFactory {
		/**
		 * The context in which an object should be created.
		 */
		public var moduleFactory:IFlexModuleFactory;
		/**
		 * Constructor.
		 *
		 * @param generator         <Class (default = null)> The Class that the newInstance() method
		 *                            uses to generate objects from this factory object.
		 * @param moduleFactory     <IFlexModuleFactory (default = null)> The system manager context in which the object
		 *                            should be created.
		 */
		public function ContextualClassFactory(generator:Class = null, moduleFactory:IFlexModuleFactory = null);
		/**
		 * Creates a new instance of the generator class,
		 *  with the properties specified by properties.
		 *
		 * @return                  <*> The new instance that was created.
		 */
		public override function newInstance():*;
	}
}
