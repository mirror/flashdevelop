package mx.core
{
	/**
	 *  The IDeferredInstantiationUIComponent interface defines the interface for a component  *  or object that defers instantiation.
	 */
	public interface IDeferredInstantiationUIComponent extends IUIComponent
	{
		/**
		 *  @copy mx.core.UIComponent#cacheHeuristic
		 */
		public function set cacheHeuristic (value:Boolean) : void;
		/**
		 *  @copy mx.core.UIComponent#cachePolicy
		 */
		public function get cachePolicy () : String;
		/**
		 *  @copy mx.core.UIComponent#descriptor
		 */
		public function get descriptor () : UIComponentDescriptor;
		/**
		 *  @private
		 */
		public function set descriptor (value:UIComponentDescriptor) : void;
		/**
		 *  @copy mx.core.UIComponent#id
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;

		/**
		 *  Creates an <code>id</code> reference to this IUIComponent object	 *  on its parent document object.     *  This function can create multidimensional references     *  such as b[2][4] for objects inside one or more repeaters.     *  If the indices are null, it creates a simple non-Array reference.     *     *  @param parentDocument The parent of this IUIComponent object.
		 */
		public function createReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  Deletes the <code>id</code> reference to this IUIComponent object	 *  on its parent document object.     *  This function can delete from multidimensional references     *  such as b[2][4] for objects inside one or more Repeaters.     *  If the indices are null, it deletes the simple non-Array reference.     *     *  @param parentDocument The parent of this IUIComponent object.
		 */
		public function deleteReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  @copy mx.core.UIComponent#executeBindings()
		 */
		public function executeBindings (recurse:Boolean = false) : void;
		/**
		 *  For each effect event, register the EffectManager	 *  as one of the event listeners.	 *	 *  @param effects An Array of strings of effect names.
		 */
		public function registerEffects (effects:Array) : void;
	}
}
