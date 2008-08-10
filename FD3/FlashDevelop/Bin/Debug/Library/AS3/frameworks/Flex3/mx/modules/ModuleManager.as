/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.modules {
	public class ModuleManager {
		/**
		 * See if the referenced object is associated with (or, in the managed
		 *  ApplicationDomain of) a known IFlexModuleFactory implementation.
		 *
		 * @param object            <Object> The object that the ModuleManager tries to create.
		 * @return                  <IFlexModuleFactory> Returns the IFlexModuleFactory implementation, or null
		 *                            if the object type cannot be created from the factory.
		 */
		public static function getAssociatedFactory(object:Object):IFlexModuleFactory;
		/**
		 * Get the IModuleInfo interface associated with a particular URL.
		 *  There is no requirement that this URL successfully load,
		 *  but the ModuleManager returns a unique IModuleInfo handle for each unique URL.
		 *
		 * @param url               <String> A URL that represents the location of the module.
		 * @return                  <IModuleInfo> The IModuleInfo interface associated with a particular URL.
		 */
		public static function getModule(url:String):IModuleInfo;
	}
}
