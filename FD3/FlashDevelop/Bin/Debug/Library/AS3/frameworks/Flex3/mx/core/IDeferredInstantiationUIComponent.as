/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	public interface IDeferredInstantiationUIComponent extends IUIComponent, IFlexDisplayObject, IBitmapDrawable, IEventDispatcher {
		/**
		 * Used by Flex to suggest bitmap caching for the object.
		 *  If cachePolicy is UIComponentCachePolicy.AUTO,
		 *  then cacheHeuristic
		 *  is used to control the object's cacheAsBitmap property.
		 */
		public function set cacheHeuristic(value:Boolean):void;
		/**
		 * Specifies the bitmap caching policy for this object.
		 *  Possible values in MXML are "on",
		 *  "off" and
		 *  "auto" (default).
		 */
		public function get cachePolicy():String;
		/**
		 * Reference to the UIComponentDescriptor, if any, that was used
		 *  by the createComponentFromDescriptor() method to create this
		 *  UIComponent instance. If this UIComponent instance
		 *  was not created from a descriptor, this property is null.
		 */
		public function get descriptor():UIComponentDescriptor;
		public function set descriptor(value:UIComponentDescriptor):void;
		/**
		 * ID of the component. This value becomes the instance name of the object
		 *  and should not contain any white space or special characters. Each component
		 *  throughout an application should have a unique id.
		 */
		public function get id():String;
		public function set id(value:String):void;
		/**
		 * Creates an id reference to this IUIComponent object
		 *  on its parent document object.
		 *  This function can create multidimensional references
		 *  such as b[2][4] for objects inside one or more repeaters.
		 *  If the indices are null, it creates a simple non-Array reference.
		 *
		 * @param parentDocument    <IFlexDisplayObject> The parent of this IUIComponent object.
		 */
		public function createReferenceOnParentDocument(parentDocument:IFlexDisplayObject):void;
		/**
		 * Deletes the id reference to this IUIComponent object
		 *  on its parent document object.
		 *  This function can delete from multidimensional references
		 *  such as b[2][4] for objects inside one or more Repeaters.
		 *  If the indices are null, it deletes the simple non-Array reference.
		 *
		 * @param parentDocument    <IFlexDisplayObject> The parent of this IUIComponent object.
		 */
		public function deleteReferenceOnParentDocument(parentDocument:IFlexDisplayObject):void;
		/**
		 * Executes the data bindings into this UIComponent object.
		 *  Workaround for MXML container/bindings problem (177074):
		 *  override Container.executeBindings() to prefer descriptor.document over parentDocument in the
		 *  call to BindingManager.executeBindings().
		 *  This should always provide the correct behavior for instances created by descriptor, and will
		 *  provide the original behavior for procedurally-created instances. (The bug may or may not appear
		 *  in the latter case.)
		 *  A more complete fix, guaranteeing correct behavior in both non-DI and reparented-component
		 *  scenarios, is anticipated for updater 1.
		 *
		 * @param recurse           <Boolean (default = false)> Recursively execute bindings for children of this component.
		 */
		public function executeBindings(recurse:Boolean = false):void;
		/**
		 * For each effect event, register the EffectManager
		 *  as one of the event listeners.
		 *
		 * @param effects           <Array> An Array of strings of effect names.
		 */
		public function registerEffects(effects:Array):void;
	}
}
