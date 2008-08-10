/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.styles {
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	public class StyleManager {
		/**
		 * Returns an Array of all the CSS selectors that are registered with the StyleManager.
		 *  You can pass items in this Array to the getStyleDeclaration() method to get the corresponding CSSStyleDeclaration object.
		 *  Class selectors are prepended with a period.
		 */
		public static function get selectors():Array;
		/**
		 * Clears the CSSStyleDeclaration object that stores the rules
		 *  for the specified CSS selector.
		 *
		 * @param selector          <String> The name of the CSS selector to clear.
		 * @param update            <Boolean> Set to true to force an immediate update of the styles.
		 *                            Set to false to avoid an immediate update of the styles in the application.
		 *                            For more information about this method, see the description in the setStyleDeclaration()
		 *                            method.
		 */
		public static function clearStyleDeclaration(selector:String, update:Boolean):void;
		/**
		 * Returns the numeric RGB color value that corresponds to the
		 *  specified color string.
		 *  The color string can be either a case-insensitive color name
		 *  such as "red", "Blue", or
		 *  "haloGreen", a hexadecimal value such as 0xFF0000, or a #-hexadecimal String
		 *  such as "#FF0000".
		 *
		 * @param colorName         <Object> The color name.
		 * @return                  <uint> Returns a uint that represents the color value or NOT_A_COLOR
		 *                            if the value of the colorName property is not an alias for a color.
		 */
		public static function getColorName(colorName:Object):uint;
		/**
		 * Converts each element of the colors Array from a color name
		 *  to a numeric RGB color value.
		 *  Each color String can be either a case-insensitive color name
		 *  such as "red", "Blue", or
		 *  "haloGreen", a hexadecimal value such as 0xFF0000, or a #-hexadecimal String
		 *  such as "#FF0000"..
		 *
		 * @param colors            <Array> An Array of color names.
		 */
		public static function getColorNames(colors:Array):void;
		/**
		 * Gets the CSSStyleDeclaration object that stores the rules
		 *  for the specified CSS selector.
		 *
		 * @param selector          <String> The name of the CSS selector.
		 * @return                  <CSSStyleDeclaration> The style declaration whose name matches the selector property.
		 */
		public static function getStyleDeclaration(selector:String):CSSStyleDeclaration;
		/**
		 * Tests to see if the given String is an alias for a color value. For example,
		 *  by default, the String "blue" is an alias for 0x0000FF.
		 *
		 * @param colorName         <String> The color name to test. This parameter is not case-sensitive.
		 * @return                  <Boolean> Returns true if colorName is an alias
		 *                            for a color.
		 */
		public static function isColorName(colorName:String):Boolean;
		/**
		 * Tests to see if a style is inheriting.
		 *
		 * @param styleName         <String> The name of the style that you test to see if it is inheriting.
		 * @return                  <Boolean> Returns true if the specified style is inheriting.
		 */
		public static function isInheritingStyle(styleName:String):Boolean;
		/**
		 * Test to see if a TextFormat style is inheriting.
		 *
		 * @param styleName         <String> The name of the style that you test to see if it is inheriting.
		 * @return                  <Boolean> Returns true if the specified TextFormat style
		 *                            is inheriting.
		 */
		public static function isInheritingTextFormatStyle(styleName:String):Boolean;
		/**
		 * Tests to see if this style affects the component's parent container in
		 *  such a way as to require that the parent container redraws itself when this style changes.
		 *
		 * @param styleName         <String> The name of the style to test.
		 * @return                  <Boolean> Returns true if the specified style is one
		 *                            which may affect the appearance or layout of the component's
		 *                            parent container.
		 */
		public static function isParentDisplayListInvalidatingStyle(styleName:String):Boolean;
		/**
		 * Tests to see if the style changes the size of the component's parent container.
		 *
		 * @param styleName         <String> The name of the style to test.
		 * @return                  <Boolean> Returns true if the specified style is one
		 *                            which may affect the measured size of the component's
		 *                            parent container.
		 */
		public static function isParentSizeInvalidatingStyle(styleName:String):Boolean;
		/**
		 * Tests to see if a style changes the size of a component.
		 *
		 * @param styleName         <String> The name of the style to test.
		 * @return                  <Boolean> Returns true if the specified style is one
		 *                            which may affect the measured size of the component.
		 */
		public static function isSizeInvalidatingStyle(styleName:String):Boolean;
		/**
		 * Determines if a specified parameter is a valid style property.
		 *
		 * @param value             <*> The style property to test.
		 * @return                  <Boolean> If you pass the value returned by a getStyle() method call
		 *                            to this method, it returns true if the style
		 *                            was set and false if it was not set.
		 */
		public static function isValidStyleValue(value:*):Boolean;
		/**
		 * Loads a style SWF.
		 *
		 * @param url               <String> Location of the style SWF.
		 * @param update            <Boolean (default = true)> Set to true to force
		 *                            an immediate update of the styles.
		 *                            Set to false to avoid an immediate update
		 *                            of the styles in the application.
		 *                            This parameter is optional and defaults to true
		 *                            For more information about this parameter, see the description
		 *                            in the setStyleDeclaration() method.
		 * @param trustContent      <Boolean (default = false)> Obsolete, no longer used.
		 *                            This parameter is optional and defaults to false.
		 * @param applicationDomain <ApplicationDomain (default = null)> The ApplicationDomain passed to the
		 *                            load() method of the IModuleInfo that loads the style SWF.
		 *                            This parameter is optional and defaults to null.
		 * @param securityDomain    <SecurityDomain (default = null)> The SecurityDomain passed to the
		 *                            load() method of the IModuleInfo that loads the style SWF.
		 *                            This parameter is optional and defaults to null.
		 * @return                  <IEventDispatcher> An IEventDispatcher implementation that supports
		 *                            StyleEvent.PROGRESS, StyleEvent.COMPLETE, and
		 *                            StyleEvent.ERROR.
		 */
		public static function loadStyleDeclarations(url:String, update:Boolean = true, trustContent:Boolean = false, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null):IEventDispatcher;
		/**
		 * Adds a color name to the list of aliases for colors.
		 *
		 * @param colorName         <String> The name of the color to add to the list; for example, "blue".
		 *                            If you later access this color name, the value is not case-sensitive.
		 * @param colorValue        <uint> Color value, for example, 0x0000FF.
		 */
		public static function registerColorName(colorName:String, colorValue:uint):void;
		/**
		 * Adds to the list of styles that can inherit values
		 *  from their parents.
		 *
		 * @param styleName         <String> The name of the style that is added to the list of styles that can inherit values.
		 */
		public static function registerInheritingStyle(styleName:String):void;
		/**
		 * Adds to the list of styles which may affect the appearance
		 *  or layout of the component's parent container.
		 *  When one of these styles is set with setStyle(),
		 *  the invalidateDisplayList() method is auomatically called on the component's
		 *  parent container to make it redraw and/or relayout its children.
		 *
		 * @param styleName         <String> The name of the style to register.
		 */
		public static function registerParentDisplayListInvalidatingStyle(styleName:String):void;
		/**
		 * Adds to the list of styles which may affect the measured size
		 *  of the component's parent container.
		 *
		 * @param styleName         <String> The name of the style to register.
		 */
		public static function registerParentSizeInvalidatingStyle(styleName:String):void;
		/**
		 * Adds to the list of styles which may affect the measured size
		 *  of the component.
		 *  When one of these styles is set with setStyle(),
		 *  the invalidateSize() method is automatically called on the component
		 *  to make its measured size get recalculated later.
		 *
		 * @param styleName         <String> The name of the style that you add to the list.
		 */
		public static function registerSizeInvalidatingStyle(styleName:String):void;
		/**
		 * Sets the CSSStyleDeclaration object that stores the rules
		 *  for the specified CSS selector.
		 *
		 * @param selector          <String> The name of the CSS selector.
		 * @param styleDeclaration  <CSSStyleDeclaration> The new style declaration.
		 * @param update            <Boolean> Set to true to force an immediate update of the styles; internally, Flex
		 *                            calls the styleChanged() method of UIComponent.
		 *                            Set to false to avoid an immediate update of the styles in the application.
		 *                            The styles will be updated the next time one of the following methods is called with
		 *                            the update property set to true:
		 *                            clearStyleDeclaration()
		 *                            loadStyleDeclarations()
		 *                            setStyleDeclaration()
		 *                            unloadStyleDeclarations()
		 *                            Typically, if you call the one of these methods multiple times,
		 *                            you set this property to true only on the last call,
		 *                            so that Flex does not call the styleChanged() method multiple times.
		 *                            If you call the getStyle() method, Flex returns the style value
		 *                            that was last applied to the UIComponent through a call to the styleChanged() method.
		 *                            The component's appearance might not reflect the value returned by the getStyle() method. This occurs
		 *                            because one of these style declaration methods might not yet have been called with the
		 *                            update property set to true.
		 */
		public static function setStyleDeclaration(selector:String, styleDeclaration:CSSStyleDeclaration, update:Boolean):void;
		/**
		 * Unloads a style SWF.
		 *
		 * @param url               <String> Location of the style SWF.
		 * @param update            <Boolean (default = true)> Set to true to force an immediate update of the styles.
		 *                            Set to false to avoid an immediate update of the styles in the application.
		 *                            For more information about this method, see the description in the setStyleDeclaration()
		 *                            method.
		 */
		public static function unloadStyleDeclarations(url:String, update:Boolean = true):void;
		/**
		 * The getColorName() method returns this value if the passed-in
		 *  String is not a legitimate color name.
		 */
		public static const NOT_A_COLOR:uint = 0xFFFFFFFF;
	}
}
