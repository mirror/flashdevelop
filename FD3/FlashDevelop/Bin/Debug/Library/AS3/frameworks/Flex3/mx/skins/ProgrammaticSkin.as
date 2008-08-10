/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.skins {
	import mx.core.FlexShape;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.managers.ILayoutManagerClient;
	import mx.styles.ISimpleStyleClient;
	import mx.core.IProgrammaticSkin;
	import flash.geom.Matrix;
	public class ProgrammaticSkin extends FlexShape implements IFlexDisplayObject, IInvalidating, ILayoutManagerClient, ISimpleStyleClient, IProgrammaticSkin {
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout: commitment, measurement, and layout (provided that any were required).
		 */
		public function get initialized():Boolean;
		public function set initialized(value:Boolean):void;
		/**
		 * The measured height of this object.
		 *  This should be overridden by subclasses to return the preferred height for
		 *  the skin.
		 */
		public function get measuredHeight():Number;
		/**
		 * The measured width of this object.
		 *  This should be overridden by subclasses to return the preferred width for
		 *  the skin.
		 */
		public function get measuredWidth():Number;
		/**
		 * Depth of this object in the containment hierarchy.
		 *  This number is used by the measurement and layout code.
		 *  The value is 0 if this component is not on the DisplayList.
		 */
		public function get nestLevel():int;
		public function set nestLevel(value:int):void;
		/**
		 * Set to true after immediate or deferred child creation,
		 *  depending on which one happens. For a Container object, it is set
		 *  to true at the end of
		 *  the createComponentsFromDescriptors() method,
		 *  meaning after the Container object creates its children from its child descriptors.
		 */
		public function get processedDescriptors():Boolean;
		public function set processedDescriptors(value:Boolean):void;
		/**
		 * A parent component used to obtain style values. This is typically set to the
		 *  component that created this skin.
		 */
		public function get styleName():Object;
		public function set styleName(value:Object):void;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout validation (provided that any were required).
		 */
		public function get updateCompletePendingFlag():Boolean;
		public function set updateCompletePendingFlag(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function ProgrammaticSkin();
		/**
		 * Programatically draws a rectangle into this skin's Graphics object.
		 *
		 * @param x                 <Number> Horizontal position of upper-left corner
		 *                            of rectangle within this skin.
		 * @param y                 <Number> Vertical position of upper-left corner
		 *                            of rectangle within this skin.
		 * @param width             <Number> Width of rectangle, in pixels.
		 * @param height            <Number> Height of rectangle, in pixels.
		 * @param cornerRadius      <Object (default = null)> Corner radius/radii of rectangle.
		 *                            Can be null, a Number, or an Object.
		 *                            If it is null, it specifies that the corners should be square
		 *                            rather than rounded.
		 *                            If it is a Number, it specifies the same radius, in pixels,
		 *                            for all four corners.
		 *                            If it is an Object, it should have properties named
		 *                            tl, tr, bl, and
		 *                            br, whose values are Numbers specifying
		 *                            the radius, in pixels, for the top left, top right,
		 *                            bottom left, and bottom right corners.
		 *                            For example, you can pass a plain Object such as
		 *                            { tl: 5, tr: 5, bl: 0, br: 0 }.
		 *                            The default value is null (square corners).
		 * @param color             <Object (default = null)> The RGB color(s) for the fill.
		 *                            Can be null, a uint, or an Array.
		 *                            If it is null, the rectangle not filled.
		 *                            If it is a uint, it specifies an RGB fill color.
		 *                            For example, pass 0xFF0000 to fill with red.
		 *                            If it is an Array, it should contain uints
		 *                            specifying the gradient colors.
		 *                            For example, pass [ 0xFF0000, 0xFFFF00, 0x0000FF ]
		 *                            to fill with a red-to-yellow-to-blue gradient.
		 *                            You can specify up to 15 colors in the gradient.
		 *                            The default value is null (no fill).
		 * @param alpha             <Object (default = null)> Alpha value(s) for the fill.
		 *                            Can be null, a Number, or an Array.
		 *                            This argument is ignored if color is null.
		 *                            If color is a uint specifying an RGB fill color,
		 *                            then alpha should be a Number specifying
		 *                            the transparency of the fill, where 0.0 is completely transparent
		 *                            and 1.0 is completely opaque.
		 *                            You can also pass null instead of 1.0 in this case
		 *                            to specify complete opaqueness.
		 *                            If color is an Array specifying gradient colors,
		 *                            then alpha should be an Array of Numbers, of the
		 *                            same length, that specifies the corresponding alpha values
		 *                            for the gradient.
		 *                            In this case, the default value is null (completely opaque).
		 * @param gradientMatrix    <Matrix (default = null)> Matrix object used for the gradient fill.
		 *                            The utility methods horizontalGradientMatrix(),
		 *                            verticalGradientMatrix(), and
		 *                            rotatedGradientMatrix() can be used to create the value for
		 *                            this parameter.
		 * @param gradientType      <String (default = "linear")> Type of gradient fill. The possible values are
		 *                            GradientType.LINEAR or GradientType.RADIAL.
		 *                            (The GradientType class is in the package flash.display.)
		 * @param gradientRatios    <Array (default = null)> (optional default [0,255])
		 *                            Specifies the distribution of colors. The number of entries must match
		 *                            the number of colors defined in the color parameter.
		 *                            Each value defines the percentage of the width where the color is
		 *                            sampled at 100%. The value 0 represents the left-hand position in
		 *                            the gradient box, and 255 represents the right-hand position in the
		 *                            gradient box.
		 * @param hole              <Object (default = null)> (optional) A rounded rectangular hole
		 *                            that should be carved out of the middle
		 *                            of the otherwise solid rounded rectangle
		 *                            { x: #, y: #, w: #, h: #, r: # or { br: #, bl: #, tl: #, tr: # } }
		 */
		protected function drawRoundRect(x:Number, y:Number, width:Number, height:Number, cornerRadius:Object = null, color:Object = null, alpha:Object = null, gradientMatrix:Matrix = null, gradientType:String = "linear", gradientRatios:Array = null, hole:Object = null):void;
		/**
		 * Returns the value of the specified style property.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @return                  <*> The style value. This can be any type of object that style properties can be, such as
		 *                            int, Number, String, etc.
		 */
		public function getStyle(styleProp:String):*;
		/**
		 * Utility function to create a horizontal gradient matrix.
		 *
		 * @param x                 <Number> The left edge of the gradient.
		 * @param y                 <Number> The top edge of the gradient.
		 * @param width             <Number> The width of the gradient.
		 * @param height            <Number> The height of the gradient.
		 * @return                  <Matrix> The horizontal gradient matrix. This is a temporary
		 *                            object that should only be used for a single subsequent call
		 *                            to the drawRoundRect() method.
		 */
		protected function horizontalGradientMatrix(x:Number, y:Number, width:Number, height:Number):Matrix;
		/**
		 * Marks a component so that its updateDisplayList()
		 *  method gets called during a later screen update.
		 */
		public function invalidateDisplayList():void;
		/**
		 * Calling this method results in a call to the component's
		 *  validateProperties() method
		 *  before the display list is rendered.
		 */
		public function invalidateProperties():void;
		/**
		 * Calling this method results in a call to the component's
		 *  validateSize() method
		 *  before the display list is rendered.
		 */
		public function invalidateSize():void;
		/**
		 * Moves this object to the specified x and y coordinates.
		 *
		 * @param x                 <Number> The horizontal position, in pixels.
		 * @param y                 <Number> The vertical position, in pixels.
		 */
		public function move(x:Number, y:Number):void;
		/**
		 * Utility function to create a rotated gradient matrix.
		 *
		 * @param x                 <Number> The left edge of the gradient.
		 * @param y                 <Number> The top edge of the gradient.
		 * @param width             <Number> The width of the gradient.
		 * @param height            <Number> The height of the gradient.
		 * @param rotation          <Number> The amount to rotate, in degrees.
		 * @return                  <Matrix> The horizontal gradient matrix. This is a temporary
		 *                            object that should only be used for a single subsequent call
		 *                            to the drawRoundRect() method.
		 */
		protected function rotatedGradientMatrix(x:Number, y:Number, width:Number, height:Number, rotation:Number):Matrix;
		/**
		 * Sets the height and width of this object.
		 *
		 * @param newWidth          <Number> The width, in pixels, of this object.
		 * @param newHeight         <Number> The height, in pixels, of this object.
		 */
		public function setActualSize(newWidth:Number, newHeight:Number):void;
		/**
		 * Whenever any style changes, redraw this skin.
		 *  Subclasses can override this method
		 *  and perform a more specific test before calling invalidateDisplayList().
		 *
		 * @param styleProp         <String> The name of the style property that changed, or null
		 *                            if all styles have changed.
		 */
		public function styleChanged(styleProp:String):void;
		/**
		 * Programmatically draws the graphics for this skin.
		 *
		 * @param unscaledWidth     <Number> The width, in pixels, of this object before any scaling.
		 * @param unscaledHeight    <Number> The height, in pixels, of this object before any scaling.
		 */
		protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
		/**
		 * This function is called by the LayoutManager
		 *  when it's time for this control to draw itself.
		 *  The actual drawing happens in the updateDisplayList
		 *  function, which is called by this function.
		 */
		public function validateDisplayList():void;
		/**
		 * Validate and update the properties and layout of this object
		 *  and redraw it, if necessary.
		 */
		public function validateNow():void;
		/**
		 * This function is an empty stub so that ProgrammaticSkin
		 *  can implement the ILayoutManagerClient  interface.
		 *  Skins do not call LayoutManager.invalidateProperties(),
		 *  which would normally trigger a call to this method.
		 */
		public function validateProperties():void;
		/**
		 * This function is an empty stub so that ProgrammaticSkin
		 *  can implement the ILayoutManagerClient  interface.
		 *  Skins do not call LayoutManager.invalidateSize(),
		 *  which would normally trigger a call to this method.
		 *
		 * @param recursive         <Boolean (default = false)> Determines whether children of this skin are validated.
		 */
		public function validateSize(recursive:Boolean = false):void;
		/**
		 * Utility function to create a vertical gradient matrix.
		 *
		 * @param x                 <Number> The left edge of the gradient.
		 * @param y                 <Number> The top edge of the gradient.
		 * @param width             <Number> The width of the gradient.
		 * @param height            <Number> The height of the gradient.
		 * @return                  <Matrix> The horizontal gradient matrix. This is a temporary
		 *                            object that should only be used for a single subsequent call
		 *                            to the drawRoundRect() method.
		 */
		protected function verticalGradientMatrix(x:Number, y:Number, width:Number, height:Number):Matrix;
	}
}
