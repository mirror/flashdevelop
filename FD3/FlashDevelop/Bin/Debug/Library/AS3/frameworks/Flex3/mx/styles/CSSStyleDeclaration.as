﻿package mx.styles
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.core.Singleton;
	import mx.core.mx_internal;
	import mx.managers.SystemManagerGlobals;

include "../core/Version.as"
	/**
	 *  The CSSStyleDeclaration class represents a set of CSS style rules.
 *  The MXML compiler automatically generates one CSSStyleDeclaration object
 *  for each selector in the CSS files associated with a Flex application.
 *  
 *  <p>A CSS rule such as
 *  <pre>
 *      Button { color: #FF0000 }
 *  </pre>
 *  affects every instance of the Button class;
 *  a selector like <code>Button</code> is called a type selector
 *  and must not start with a dot.</p>
 *
 *  <p>A CSS rule such as
 *  <pre>
 *      .redButton { color: #FF0000 }
 *  </pre>
 *  affects only components whose <code>styleName</code> property
 *  is set to <code>".redButton"</code>;
 *  a selector like <code>.redButton</code> is called a class selector
 *  and must start with a dot.</p>
 *
 *  <p>You can access the autogenerated CSSStyleDeclaration objects
 *  using the <code>StyleManager.getStyleDeclaration()</code> method,
 *  passing it either a type selector
 *  <pre>
 *  var buttonDeclaration:CSSStyleDeclaration =
 *      StyleManager.getStyleDeclaration("Button");
 *  </pre>
 *  or a class selector
 *  <pre>
 *  var redButtonStyleDeclaration:CSSStyleDeclaration =
 *      StyleManager.getStyleDeclaration(".redButton");
 *  </pre>
 *  </p>
 *
 *  <p>You can use the <code>getStyle()</code>, <code>setStyle()</code>,
 *  and <code>clearStyle()</code> methods to get, set, and clear 
 *  style properties on a CSSStyleDeclaration.</p>
 *
 *  <p>You can also create and install a CSSStyleDeclaration at run time
 *  using the <code>StyleManager.setStyleDeclaration()</code> method:
 *  <pre>
 *  var newStyleDeclaration:CSSStyleDeclaration = new CSSStyleDeclaration();
 *  newStyleDeclaration.defaultFactory = function():void
 *  {
 *      leftMargin = 50;
 *      rightMargin = 50;
 *  }
 *  StyleManager.setStyleDeclaration(".bigMargins", newStyleDeclaration, true);
 *  </pre>
 *  </p>
 *
 *  @see mx.core.UIComponent
 *  @see mx.styles.StyleManager
	 */
	public class CSSStyleDeclaration extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private static const NOT_A_COLOR : uint = 0xFFFFFFFF;
		/**
		 *  @private
		 */
		private static const FILTERMAP_PROP : String = "__reserved__filterMap";
		/**
		 *  @private
     *  This Array keeps track of all the style name/value objects
     *  produced from this CSSStyleDeclaration and already inserted into
     *  prototype chains. Whenever this CSSStyleDeclaration's overrides object
     *  is updated by setStyle(), these clone objects must also be updated.
		 */
		private var clones : Dictionary;
		/**
		 *  @private
     *  The number of CSS selectors pointing to this CSSStyleDeclaration.
     *  It will be greater than 0 if this CSSStyleDeclaration has been
     *  installed in the StyleManager.styles table by
     *  StyleManager.setStyleDeclaration().
		 */
		var selectorRefCount : int;
		/**
		 *  @private
     *  Array that specifies the names of the events declared
     *  by this CSS style declaration.
     *  This Array is used by the <code>StyleProtoChain.initObject()</code>
     *  method to register the effect events with the Effect manager.
		 */
		var effects : Array;
		/**
		 *  @private
     *  reference to StyleManager
		 */
		private var styleManager : IStyleManager2;
		/**
		 *  This function, if it isn't <code>null</code>,
     *  is usually autogenerated by the MXML compiler.
     *  It produce copies of a plain Object, such as
     *  <code>{ leftMargin: 10, rightMargin: 10 }</code>,
     *  containing name/value pairs for style properties; the object is used
     *  to build a node of the prototype chain for looking up style properties.
     *
     *  <p>If this CSSStyleDeclaration is owned by a UIComponent
     *  written in MXML, this function encodes the style attributes
     *  that were specified on the root tag of the component definition.</p>
     *
     *  <p>If the UIComponent was written in ActionScript,
     *  this property is <code>null</code>.</p>
		 */
		public var defaultFactory : Function;
		/**
		 *  This function, if it isn't <code>null</code>,
     *  is usually autogenerated by the MXML compiler.
     *  It produce copies of a plain Object, such as
     *  <code>{ leftMargin: 10, rightMargin: 10 }</code>,
     *  containing name/value pairs for style properties; the object is used
     *  to build a node of the prototype chain for looking up style properties.
     *
     *  <p>If this CSSStyleDeclaration is owned by a UIComponent,
     *  this function encodes the style attributes that were specified in MXML
     *  for an instance of that component.</p>
		 */
		public var factory : Function;
		/**
		 *  If the <code>setStyle()</code> method is called on a UIComponent or CSSStyleDeclaration
     *  at run time, this object stores the name/value pairs that were set;
     *  they override the name/value pairs in the objects produced by
     *  the  methods specified by the <code>defaultFactory</code> and 
     *  <code>factory</code> properties.
		 */
		protected var overrides : Object;

		/**
		 *  Constructor.
     *
     *  @param selector If not null, this CSSStyleDeclaration will be
     *  registered with the StyleManager using the selector value.
		 */
		public function CSSStyleDeclaration (selector:String = null);

		/**
		 *  Gets the value for a specified style property,
     *  as determined solely by this CSSStyleDeclaration.
     *
     *  <p>The returned value may be of any type.</p>
     *
     *  <p>The values <code>null</code>, <code>""</code>, <code>false</code>,
     *  <code>NaN</code>, and <code>0</code> are all valid style values,
     *  but the value <code>undefined</code> is not; it indicates that
     *  the specified style is not set on this CSSStyleDeclaration.
     *  You can use the method <code>StyleManager.isValidStyleValue()</code>
     *  to test the value that is returned.</p>
     *
     *  @param styleProp The name of the style property.
     *
     *  @return The value of the specified style property if set,
     *  or <code>undefined</code> if not.
		 */
		public function getStyle (styleProp:String) : *;

		/**
		 *  Sets a style property on this CSSStyleDeclaration.
     *
     *  @param styleProp The name of the style property.
     *
     *  @param newValue The value of the style property.
     *  The value may be of any type.
     *  The values <code>null</code>, <code>""</code>, <code>false</code>,
     *  <code>NaN</code>, and <code>0</code> are all valid style values,
     *  but the value <code>undefined</code> is not.
     *  Setting a style property to the value <code>undefined</code>
     *  is the same as calling the <code>clearStyle()</code> method.
		 */
		public function setStyle (styleProp:String, newValue:*) : void;

		/**
		 *  @private
     *  Sets a style property on this CSSStyleDeclaration.
     *
     *  @param styleProp The name of the style property.
     *
     *  @param newValue The value of the style property.
     *  The value may be of any type.
     *  The values <code>null</code>, <code>""</code>, <code>false</code>,
     *  <code>NaN</code>, and <code>0</code> are all valid style values,
     *  but the value <code>undefined</code> is not.
     *  Setting a style property to the value <code>undefined</code>
     *  is the same as calling <code>clearStyle()</code>.
		 */
		function setStyle (styleProp:String, value:*) : void;

		/**
		 *  Clears a style property on this CSSStyleDeclaration.
     *
     *  This is the same as setting the style value to <code>undefined</code>.
     *
     *  @param styleProp The name of the style property.
		 */
		public function clearStyle (styleProp:String) : void;

		/**
		 *  @private
		 */
		function createProtoChainRoot () : Object;

		/**
		 *  @private
		 */
		function addStyleToProtoChain (chain:Object, target:DisplayObject, filterMap:Object = null) : Object;

		/**
		 *  @private
		 */
		function clearOverride (styleProp:String) : void;

		/**
		 *  @private
		 */
		private function clearStyleAttr (styleProp:String) : void;
	}
}
