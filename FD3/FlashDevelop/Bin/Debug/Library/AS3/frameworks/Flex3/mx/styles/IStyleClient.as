/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.styles {
	public interface IStyleClient extends ISimpleStyleClient {
		/**
		 * The name of the component class.
		 */
		public function get className():String;
		/**
		 * An object containing the inheritable styles for this component.
		 */
		public function get inheritingStyles():Object;
		public function set inheritingStyles(value:Object):void;
		/**
		 * An object containing the noninheritable styles for this component.
		 */
		public function get nonInheritingStyles():Object;
		public function set nonInheritingStyles(value:Object):void;
		/**
		 * The style declaration used by this object.
		 */
		public function get styleDeclaration():CSSStyleDeclaration;
		public function set styleDeclaration(value:CSSStyleDeclaration):void;
		/**
		 * Deletes a style property from this component instance.
		 *
		 * @param styleProp         <String> Name of the style property.
		 */
		public function clearStyle(styleProp:String):void;
		/**
		 * Returns an Array of CSSStyleDeclaration objects for the type selector
		 *  that applies to this component, or null if none exist.
		 *
		 * @return                  <Array> Array of CSSStyleDeclaration objects.
		 */
		public function getClassStyleDeclarations():Array;
		/**
		 * Gets a style property that has been set anywhere in this
		 *  component's style lookup chain.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @return                  <*> Style value.
		 */
		public function getStyle(styleProp:String):*;
		/**
		 * Propagates style changes to the children of this component.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @param recursive         <Boolean> Whether to propagate the style changes to the children's children.
		 */
		public function notifyStyleChangeInChildren(styleProp:String, recursive:Boolean):void;
		/**
		 * Sets up the internal style cache values so that the getStyle()
		 *  method functions.
		 *  If this object already has children, then reinitialize the children's
		 *  style caches.
		 *
		 * @param recursive         <Boolean> Regenerate the proto chains of the children.
		 */
		public function regenerateStyleCache(recursive:Boolean):void;
		/**
		 * Registers the EffectManager as one of the event listeners for each effect event.
		 *
		 * @param effects           <Array> An Array of Strings of effect names.
		 */
		public function registerEffects(effects:Array):void;
		/**
		 * Sets a style property on this component instance.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @param newValue          <*> New value for the style.
		 */
		public function setStyle(styleProp:String, newValue:*):void;
	}
}
