/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	public class PolarDataCanvas extends ChartElement {
		/**
		 * Defines the labels, tick marks, and data position
		 *  for items on the x-axis.
		 *  Use either the LinearAxis class or the CategoryAxis class
		 *  to set the properties of the angularAxis as a child tag in MXML
		 *  or create a LinearAxis or CategoryAxis object in ActionScript.
		 */
		public function get angularAxis():IAxis;
		public function set angularAxis(value:IAxis):void;
		/**
		 * The DataTransform object that the element is associated with.
		 *  A DataTransform object represents an association between a set of elements
		 *  and a set of axis objects used to transform those elements
		 *  from data space to screen coordinates and back.
		 *  A chart element uses its associated DataTransform object to calculate
		 *  how to render its data.
		 */
		public function set dataTransform(value:DataTransform):void;
		/**
		 * If true, the computed range of the chart is affected by this
		 *  canvas.
		 */
		public function get includeInRanges():Boolean;
		public function set includeInRanges(value:Boolean):void;
		/**
		 * Defines the labels, tick marks, and data position
		 *  for items on the y-axis.
		 *  Use either the LinearAxis class or the CategoryAxis class
		 *  to set the properties of the angular axis as a child tag in MXML
		 *  or to create a LinearAxis or CategoryAxis object in ActionScript.
		 */
		public function get radialAxis():IAxis;
		public function set radialAxis(value:IAxis):void;
		/**
		 */
		public function get totalValue():Number;
		public function set totalValue(value:Number):void;
		/**
		 * Constructor
		 */
		public function PolarDataCanvas();
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added
		 *  to the front (top) of all other children in this DisplayObjectContainer instance. (To add a child to a
		 *  specific index position, use the addChildAt() method.)
		 *
		 * @param child             <DisplayObject> The DisplayObject to add as a child.
		 * @return                  <DisplayObject> The child that was added; this is the same
		 *                            as the argument passed in.
		 */
		public override function addChild(child:DisplayObject):DisplayObject;
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer
		 *  instance. The child is added
		 *  at the index position specified. An index of 0 represents the back (bottom)
		 *  of the display list for this DisplayObjectContainer object.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to add as a child of this
		 *                            DisplayObjectContainer instance.
		 * @param index             <int> The index position to which the child is added. If you specify a
		 *                            currently occupied index position, the child object that exists at that position and all
		 *                            higher positions are moved up one position in the child list.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * This adds any DisplayObject as child to current canvas
		 *
		 * @param child             <DisplayObject> A DisplayObject instance that is to be added as child to the current canvas.
		 * @param angleLeft         <* (default = NaN)> Left angular coordinate of the child, in data coordinates.
		 * @param radialTop         <* (default = NaN)> Top radial coordinate of the child, in data coordinates.
		 * @param angleRight        <* (default = NaN)> Right angular coordinate of the child, in data coordinates.
		 * @param radialBottom      <* (default = NaN)> Bottom radial coordinate of the child, in data coordinates.
		 * @param angleCenter       <* (default = NaN)> Middle angular coordinate of the child, in data coordinates.
		 * @param radialCenter      <* (default = NaN)> Middle radial coordinate of the child, in data coordinates.
		 */
		public function addDataChild(child:DisplayObject, angleLeft:*, radialTop:*, angleRight:*, radialBottom:*, angleCenter:*, radialCenter:*):void;
		/**
		 * Fills a drawing area with a bitmap image. Coordinate are in terms of the angularAxis or
		 *  radialAxis properties of the canvas.
		 *
		 * @param bitmap            <BitmapData> 
		 * @param x                 <* (default = NaN)> 
		 * @param y                 <* (default = NaN)> 
		 * @param matrix            <Matrix (default = null)> 
		 * @param repeat            <Boolean (default = true)> 
		 * @param smooth            <Boolean (default = true)> 
		 */
		public function beginBitmapFill(bitmap:BitmapData, x:*, y:*, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = true):void;
		/**
		 * Specifies a simple one-color fill that subsequent calls to other
		 *  Graphics methods (such as lineTo() or drawCircle()) use when drawing.
		 *  The fill remains in effect until you call the beginFill(),
		 *  beginBitmapFill(), or beginGradientFill() method.
		 *  Calling the clear() method clears the fill.
		 *
		 * @param color             <uint> The color of the fill (0xRRGGBB).
		 * @param alpha             <Number (default = 1.0)> The alpha value of the fill (0.0 to 1.0).
		 */
		public function beginFill(color:uint, alpha:Number = 1.0):void;
		/**
		 * Clears the canvas.
		 */
		public function clear():void;
		/**
		 * Processes the properties set on the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function commitProperties():void;
		/**
		 * Draws a curve using the current line style from the current drawing position to (anchorX, anchorY) and using the
		 *  control point that (controlX, controlY) specifies. The coordinates that you pass to this method are in terms of
		 *  chart data rather than screen coordinates.
		 *
		 * @param controlAngle      <*> 
		 * @param controlRadial     <*> 
		 * @param anchorAngle       <*> 
		 * @param anchorRadial      <*> 
		 */
		public function curveTo(controlAngle:*, controlRadial:*, anchorAngle:*, anchorRadial:*):void;
		/**
		 * Called by the governing DataTransform to obtain a description
		 *  of the data represented by this IChartElement.
		 *  Implementors fill out and return an Array of
		 *  mx.charts.chartClasses.DataDescription objects
		 *  to guarantee that their data is correctly accounted for
		 *  by any axes that are autogenerating values
		 *  from the displayed data (such as minimum, maximum,
		 *  interval, and unitSize).
		 *  Most element types return an Array
		 *  containing a single DataDescription.
		 *  Aggregate elements, such as BarSet and ColumnSet,
		 *  might return multiple DataDescription instances
		 *  that describe the data displayed by their subelements.
		 *  When called, the implementor describes the data
		 *  along the axis indicated by the dimension argument.
		 *  This function might be called for each axis
		 *  supported by the containing chart.
		 *
		 * @param dimension         <String> Determines the axis to get data descriptions of.
		 * @param requiredFields    <uint> A bitfield that indicates which values
		 *                            of the DataDescription object the particular axis cares about.
		 *                            Implementors can optimize by only calculating the necessary fields.
		 * @return                  <Array> An Array containing the DataDescription instances that describe
		 *                            the data that is displayed.
		 */
		public override function describeData(dimension:String, requiredFields:uint):Array;
		/**
		 * Draws a circle. You must set the line style, fill, or both before
		 *  you call the drawCircle() method, by calling the linestyle(),
		 *  lineGradientStyle(), beginFill(), beginGradientFill(),
		 *  or beginBitmapFill() method.
		 *
		 * @param x                 <Number> The x location of the center of the circle relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param y                 <Number> The y location of the center of the circle relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param radius            <Number> The radius of the circle (in pixels).
		 */
		public function drawCircle(x:Number, y:Number, radius:Number):void;
		/**
		 * Draws an ellipse. You must set the line style, fill, or both before
		 *  you call the drawEllipse() method, by calling the linestyle(),
		 *  lineGradientStyle(), beginFill(), beginGradientFill(),
		 *  or beginBitmapFill() method.
		 *
		 * @param x                 <Number> The x location of the center of the ellipse relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param y                 <Number> The y location of the center of the ellipse relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param width             <Number> The width of the ellipse (in pixels).
		 * @param height            <Number> The height of the ellipse (in pixels).
		 */
		public function drawEllipse(x:Number, y:Number, width:Number, height:Number):void;
		/**
		 * Draws a rectangle. You must set the line style, fill, or both before
		 *  you call the drawRect() method, by calling the linestyle(),
		 *  lineGradientStyle(), beginFill(), beginGradientFill(),
		 *  or beginBitmapFill() method.
		 *
		 * @param x                 <Number> A number indicating the horizontal position relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param y                 <Number> A number indicating the vertical position relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param width             <Number> The width of the rectangle (in pixels).
		 * @param height            <Number> The height of the rectangle (in pixels).
		 */
		public function drawRect(x:Number, y:Number, width:Number, height:Number):void;
		/**
		 * Draws a rounded rectangle. You must set the line style, fill, or both before
		 *  you call the drawRoundRect() method, by calling the linestyle(),
		 *  lineGradientStyle(), beginFill(), beginGradientFill(), or
		 *  beginBitmapFill() method.
		 *
		 * @param x                 <Number> A number indicating the horizontal position relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param y                 <Number> A number indicating the vertical position relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param width             <Number> The width of the round rectangle (in pixels).
		 * @param height            <Number> The height of the round rectangle (in pixels).
		 * @param ellipseWidth      <Number> The width of the ellipse used to draw the rounded corners (in pixels).
		 * @param ellipseHeight     <Number (default = NaN)> The height of the ellipse used to draw the rounded corners (in pixels).
		 *                            Optional; if no value is specified, the default value matches that provided for the
		 *                            ellipseWidth parameter.
		 */
		public function drawRoundedRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = NaN):void;
		/**
		 * Applies a fill to the lines and curves that were added since the last call to the
		 *  beginFill(), beginGradientFill(), or
		 *  beginBitmapFill() method. Flash uses the fill that was specified in the previous
		 *  call to the beginFill(), beginGradientFill(), or beginBitmapFill()
		 *  method. If the current drawing position does not equal the previous position specified in a
		 *  moveTo() method and a fill is defined, the path is closed with a line and then
		 *  filled.
		 */
		public function endFill():void;
		/**
		 * Informs the canvas that the underlying data
		 *  in the dataProvider has changed.
		 *  This function triggers calls to the updateMapping()
		 *  and updateTransform() methods on the next call
		 *  to the commitProperties() method.
		 *
		 * @param invalid           <Boolean (default = true)> 
		 */
		protected function invalidateData(invalid:Boolean = true):void;
		/**
		 * Marks a component so that its updateDisplayList()
		 *  method gets called during a later screen update.
		 */
		public override function invalidateDisplayList():void;
		/**
		 * Specifies a line style that Flash uses for subsequent calls to other Graphics methods (such as lineTo()
		 *  or drawCircle()) for the object.
		 *
		 * @param thickness         <Number> 
		 * @param color             <uint (default = 0)> 
		 * @param alpha             <Number (default = 1.0)> 
		 * @param pixelHinting      <Boolean (default = false)> 
		 * @param scaleMode         <String (default = "normal")> 
		 * @param caps              <String (default = null)> 
		 * @param joints            <String (default = null)> 
		 * @param miterLimit        <Number (default = 3)> 
		 */
		public function lineStyle(thickness:Number, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void;
		/**
		 * Draws a line using the current line style from the current drawing position to (x, y);
		 *  the current drawing position is then set to (x, y).
		 *  If the display object in which you are drawing contains content that was created with
		 *  the Flash drawing tools, calls to the lineTo() method are drawn underneath the content. If
		 *  you call lineTo() before any calls to the moveTo() method, the
		 *  default position for the current drawing is (0, 0). If any of the parameters are missing, this
		 *  method fails and the current drawing position is not changed.
		 *
		 * @param x                 <Number> A number that indicates the horizontal position relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param y                 <Number> A number that indicates the vertical position relative to the
		 *                            registration point of the parent display object (in pixels).
		 */
		public function lineTo(x:Number, y:Number):void;
		/**
		 * Called when the mapping of one or more associated axes changes.
		 *  The DataTransform assigned to this ChartElement will call this method
		 *  when any of the axes it represents is modified in some way.
		 */
		public override function mappingChanged():void;
		/**
		 * Moves the current drawing position to (x, y). If any of the parameters
		 *  are missing, this method fails and the current drawing position is not changed.
		 *
		 * @param x                 <Number> A number that indicates the horizontal position relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param y                 <Number> A number that indicates the vertical position relative to the
		 *                            registration point of the parent display object (in pixels).
		 */
		public function moveTo(x:Number, y:Number):void;
		/**
		 * Removes all data children (DisplayObject instances) of the canvas.
		 */
		public function removeAllChildren():void;
		/**
		 * Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.
		 *  The parent property of the removed child is set to null
		 *  , and the object is garbage collected if no other
		 *  references to the child exist. The index positions of any display objects above the child in the
		 *  DisplayObjectContainer are decreased by 1.
		 *
		 * @param child             <DisplayObject> The DisplayObject to remove.
		 * @return                  <DisplayObject> The child that was removed; this is the same
		 *                            as the argument passed in.
		 */
		public override function removeChild(child:DisplayObject):DisplayObject;
		/**
		 * Removes a child DisplayObject from the specified index position in the child list of
		 *  the DisplayObjectContainer. The parent property of the removed child is set to
		 *  null, and the object is garbage collected if no other references to the child exist. The index
		 *  positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
		 *
		 * @param index             <int> The child index of the DisplayObject to remove.
		 * @return                  <DisplayObject> The child that was removed.
		 */
		public override function removeChildAt(index:int):DisplayObject;
		/**
		 * Removes any item from the provided cache whose field
		 *  property is NaN.
		 *  Derived classes can call this method from their updateFilter()
		 *  implementation to remove any ChartItems filtered out by the axes.
		 *
		 * @param cache             <Array> 
		 * @param field             <String> 
		 */
		protected function stripNaNs(cache:Array, field:String):void;
		/**
		 * Updates the position of any child to the current canvas.
		 *
		 * @param child             <DisplayObject> A DisplayObject instance that is to be added as a child of the current canvas.
		 * @param angleLeft         <* (default = NaN)> Left angular coordinate of the child, in data coordinates.
		 * @param radialTop         <* (default = NaN)> Top radial coordinate of the child, in data coordinates.
		 * @param angleRight        <* (default = NaN)> Right angular coordinate of the child, in data coordinates.
		 * @param radialBottom      <* (default = NaN)> Bottom radial coordinate of the child, in data coordinates.
		 * @param angleCenter       <* (default = NaN)> Middle angular coordinate of the child, in data coordinates.
		 * @param radialCenter      <* (default = NaN)> Middle radial coordinate of the child, in data coordinates.
		 *                            For example:
		 *                            var lbl:Label = new Label();
		 *                            lbl.text = "Last Month";
		 *                            canvas.addChild(lbl);
		 *                            canvas.updateDataChild(lbl,200,20);
		 */
		public function updateDataChild(child:DisplayObject, angleLeft:*, radialTop:*, angleRight:*, radialBottom:*, angleCenter:*, radialCenter:*):void;
		/**
		 * Draws the object and/or sizes and positions its children.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
		/**
		 * Called when the underlying data the canvas represents
		 *  needs to be filtered against the ranges represented by the axes
		 *  of the associated data transform.
		 *  This can happen either because the underlying data has changed
		 *  or because the range of the associated axes has changed.
		 *  If you implement a custom canvas type, you should override this method
		 *  and filter out any outlying data using the filterCache()
		 *  method of the axes managed by its associated data transform.
		 *  The filterCache() method converts any values
		 *  that are out of range to NaN.
		 *  You must be sure to call the super.updateFilter() method
		 *  in your subclass.
		 *  You should not generally call this method directly.
		 *  Instead, if you need to guarantee that your data has been filtered
		 *  at a given point, call the validateTransform() method
		 *  of the PolarDataCanvas class.
		 *  You can generally assume that your updateData()
		 *  and updateMapping() methods have been called
		 *  prior to this method, if necessary.
		 */
		protected function updateFilter():void;
		/**
		 * Calls the updateMapping()
		 *  and updateFilter() methods of the canvas, if necessary.
		 *  This method is called automatically by the canvas
		 *  from the commitProperties() method, as necessary,
		 *  but a derived canvas might call it explicitly
		 *  if the generated values are needed at an explicit time.
		 *  Loading and mapping data against the axes is designed
		 *  to be acceptable by the axes at any time.
		 *  It is safe this method explicitly at any point.
		 */
		protected function validateData():void;
		/**
		 * Calls the updateTransform() method of the canvas, if necessary.
		 *  This method is called automatically by the canvas
		 *  during the commitProperties() method, as necessary,
		 *  but a derived canvas might call it explicitly
		 *  if the generated values are needed at an explicit time.
		 *  Filtering and transforming of data relies on specific values
		 *  being calculated by the axes, which can in turn
		 *  depend on the data that is displayed in the chart.
		 *  Calling this function at the wrong time might result
		 *  in extra work being done, if those values are updated.
		 */
		protected function validateTransform():Boolean;
	}
}
