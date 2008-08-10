/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.styles {
	public class StyleProxy implements IStyleClient {
		/**
		 * The name of the component class.
		 */
		public function get className():String;
		/**
		 * A set of string pairs. The first item of the string pair is the name of the style
		 *  in the source component. The second item of the String pair is the name of the style
		 *  in the subcomponent. With this object, you can map a particular style in the parent component
		 *  to a different style in the subcomponent. This is useful if both the parent
		 *  component and the subcomponent share the same style, but you want to be able to
		 *  control the values seperately.
		 */
		public function get filterMap():Object;
		public function set filterMap(value:Object):void;
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
		 * The object that implements the IStyleClient interface. This is the object
		 *  that is being proxied.
		 */
		public function get source():IStyleClient;
		public function set source(value:IStyleClient):void;
		/**
		 * The style declaration used by this object.
		 */
		public function get styleDeclaration():CSSStyleDeclaration;
		public function set styleDeclaration(value:CSSStyleDeclaration):void;
		/**
		 * The source of this object's style values.
		 *  The value of the styleName property can be one of three possible types:
		 *  String, such as "headerStyle". The String names a class selector that is defined in a CSS style sheet.
		 *  CSSStyleDeclaration, such as StyleManager.getStyleDeclaration(".headerStyle").
		 *  UIComponent. The object that implements this interface inherits all the style values from the referenced UIComponent.
		 */
		public function get styleName():Object;
		public function set styleName(value:Object):void;
		/**
		 * Constructor.
		 *
		 * @param source            <IStyleClient> The object that implements the IStyleClient interface.
		 * @param filterMap         <Object> The set of styles to pass from the source to the subcomponent.
		 */
		public function StyleProxy(source:IStyleClient, filterMap:Object);
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
		/**
		 * Called when the value of a style property is changed.
		 *
		 * @param styleProp         <String> The name of the style property that changed.
		 */
		public function styleChanged(styleProp:String):void;
	}
}
