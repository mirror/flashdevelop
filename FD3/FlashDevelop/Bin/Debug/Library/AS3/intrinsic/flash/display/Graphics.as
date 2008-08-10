/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/*** Added drawRoundRectComplex [Philippe 2008-Jun-06]  ***/
/**********************************************************/
package flash.display {
	import flash.geom.Matrix;
	public final  class Graphics {
		/**
		 * Fills a drawing area with a bitmap image. The bitmap can be repeated or tiled to fill
		 *  the area. The fill remains in effect until you call the beginFill(),
		 *  beginBitmapFill(), or beginGradientFill() method.
		 *  Calling the clear() method clears the fill.
		 *
		 * @param bitmap            <BitmapData> A transparent or opaque bitmap image that contains the bits to be displayed.
		 * @param matrix            <Matrix (default = null)> A matrix object (of the flash.geom.Matrix class), which you can use to
		 *                            define transformations on the bitmap. For instance, you can use the following matrix
		 *                            to rotate a bitmap by 45 degrees (pi/4 radians):
		 *                            matrix = new flash.geom.Matrix();
		 *                            matrix.rotate(Math.PI/4);
		 * @param repeat            <Boolean (default = true)> If true, the bitmap image repeats in a tiled pattern. If
		 *                            false, the bitmap image does not repeat, and the edges of the bitmap are
		 *                            used for any fill area that extends beyond the bitmap.
		 *                            For example, consider the following bitmap (a 20 x 20-pixel checkerboard pattern):
		 *                            When repeat is set to true (as in the following example), the bitmap fill
		 *                            repeats the bitmap:
		 *                            When repeat is set to false, the bitmap fill uses the edge
		 *                            pixels for the fill area outside of the bitmap:
		 * @param smooth            <Boolean (default = false)> If false, upscaled bitmap images are rendered by using a
		 *                            nearest-neighbor algorithm and look pixelated. If true, upscaled
		 *                            bitmap images are rendered by using a bilinear algorithm. Rendering by using the nearest
		 *                            neighbor algorithm is usually faster.
		 */
		public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void;
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
		 * Specifies a gradient fill that subsequent calls to other
		 *  Graphics methods (such as lineTo() or drawCircle()) use when drawing.
		 *  The fill remains in effect until you call the beginFill(),
		 *  beginBitmapFill(), or beginGradientFill() method.
		 *  Calling the clear() method clears the fill.
		 *
		 * @param type              <String> A value from the GradientType class that
		 *                            specifies which gradient type to use: GradientType.LINEAR or
		 *                            GradientType.RADIAL.
		 * @param colors            <Array> An array of RGB hexadecimal color values to be used in the gradient; for example,
		 *                            red is 0xFF0000, blue is 0x0000FF, and so on. You can specify up to 15 colors.
		 *                            For each color, be sure you specify a corresponding value in the alphas and ratios parameters.
		 * @param alphas            <Array> An array of alpha values for the corresponding colors in the colors array;
		 *                            valid values are 0 to 1. If the value is less than 0, the default is 0. If the value is
		 *                            greater than 1, the default is 1.
		 * @param ratios            <Array> An array of color distribution ratios; valid values are 0 to 255. This value
		 *                            defines the percentage of the width where the color is sampled at 100%. The value 0 represents
		 *                            the left-hand position in the gradient box, and 255 represents the right-hand position in the
		 *                            gradient box.
		 *                            Note: This value represents positions in the gradient box, not the
		 *                            coordinate space of the final gradient, which might be wider or thinner than the gradient box.
		 *                            Specify a value for each value in the colors parameter.
		 *                            For example, for a linear gradient that includes two colors, blue and green, the
		 *                            following example illustrates the placement of the colors in the gradient based on different values
		 *                            in the ratios array:
		 *                            ratios
		 *                            Gradient
		 *                            [0, 127]
		 */
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void;
		/**
		 * Clears the graphics that were drawn to this Graphics object, and resets fill and
		 *  line style settings.
		 */
		public function clear():void;
		/**
		 * Draws a curve using the current line style from the current drawing position
		 *  to (anchorX, anchorY) and using the control point that (controlX,
		 *  controlY) specifies. The current drawing position is then set to
		 *  (anchorX, anchorY). If the movie clip in which you are
		 *  drawing contains content created with the Flash drawing tools, calls to the
		 *  curveTo() method are drawn underneath this content. If you call the
		 *  curveTo() method before any calls to the moveTo() method,
		 *  the default of the current drawing position is (0, 0). If any of the parameters are
		 *  missing, this method fails and the current drawing position is not changed.
		 *
		 * @param controlX          <Number> A number that specifies the horizontal position of the control
		 *                            point relative to the registration point of the parent display object.
		 * @param controlY          <Number> A number that specifies the vertical position of the control
		 *                            point relative to the registration point of the parent display object.
		 * @param anchorX           <Number> A number that specifies the horizontal position of the next anchor
		 *                            point relative to the registration point of the parent display object.
		 * @param anchorY           <Number> A number that specifies the vertical position of the next anchor
		 *                            point relative to the registration point of the parent display object.
		 */
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void;
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
		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = NaN):void;
		/**
		 * Draws a rounded rectangle using the size of a radius to draw the rounded corners.
		 * You must set the line style, fill, or both on the Graphics object before
		 * you call the drawRoundRectComplex() method by calling the
		 * linestyle(), lineGradientStyle(), beginFill(), beginGradientFill(), or beginBitmapFill() method.
		 * @param x                    <Number> A number indicating the horizontal position relative to the
		 *                               registration point of the parent display object (in pixels).
		 * @param y                    <Number> A number indicating the vertical position relative to the
		 *                               registration point of the parent display object (in pixels).
		 * @param width                <Number> The width of the round rectangle (in pixels).
		 * @param height               <Number> The height of the round rectangle (in pixels).
		 * @param   topLeftRadius      <Number> The radius of the upper-left corner (in pixels ).
		 * @param   topRightRadius      <Number> The radius of the upper-right corner (in pixels ).
		 * @param   bottomLeftRadius   <Number> The radius of the bottom-left corner (in pixels ).
		 * @param   bottomRightRadius   <Number> The radius of the bottom-right corner (in pixels ).
		 */
		public function drawRoundRectComplex(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number):void; 
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
		 * Specifies a gradient for the line style that subsequent calls to other
		 *  Graphics methods (such as lineTo() or drawCircle()) use for drawing.
		 *  The line style remains in effect until you call the lineStyle() method or the
		 *  lineGradientStyle() method with different parameters. You can call the
		 *  lineGradientStyle() method in the middle of drawing a path to specify different
		 *  styles for different line segments within a path.
		 *
		 * @param type              <String> A value from the GradientType class that
		 *                            specifies which gradient type to use, either GradientType.LINEAR or GradientType.RADIAL.
		 * @param colors            <Array> An array of RGB hex color values to be used in the gradient (for example,
		 *                            red is 0xFF0000, blue is 0x0000FF, and so on).
		 * @param alphas            <Array> An array of alpha values for the corresponding colors in the colors array;
		 *                            valid values are 0 to 1. If the value is less than 0, the default is 0. If the value is
		 *                            greater than 1, the default is 1.
		 * @param ratios            <Array> An array of color distribution ratios; valid values are from 0 to 255. This value
		 *                            defines the percentage of the width where the color is sampled at 100%. The value 0 represents
		 *                            the left-hand position in the gradient box, and 255 represents the right-hand position in the
		 *                            gradient box. This value represents positions in the gradient box, not the
		 *                            coordinate space of the final gradient, which might be wider or thinner than the gradient box.
		 *                            Specify a value for each value in the colors parameter.
		 *                            For example, for a linear gradient that includes two colors, blue and green, the
		 *                            following figure illustrates the placement of the colors in the gradient based on different values
		 *                            in the ratios array:
		 *                            ratios
		 *                            Gradient
		 *                            [0, 127]
		 */
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void;
		/**
		 * Specifies a line style that Flash uses for subsequent calls to other
		 *  Graphics methods (such as lineTo() or drawCircle()) for the object.
		 *  The line style remains in effect until you call the lineGradientStyle()
		 *  method or the lineStyle() method with different parameters.
		 *  You can call lineStyle() in the middle of drawing a path to specify different
		 *  styles for different line segments within the path.
		 *
		 * @param thickness         <Number (default = NaN)> An integer that indicates the thickness of the line in
		 *                            points; valid values are 0 to 255. If a number is not specified, or if the
		 *                            parameter is undefined, a line is not drawn. If a value of less than 0 is passed,
		 *                            the default is 0. The value 0 indicates hairline thickness; the maximum thickness
		 *                            is 255. If a value greater than 255 is passed, the default is 255.
		 * @param color             <uint (default = 0)> A hexadecimal color value of the line; for example, red is 0xFF0000, blue is
		 *                            0x0000FF, and so on. If a value is not indicated, the default is 0x000000 (black). Optional.
		 * @param alpha             <Number (default = 1.0)> A number that indicates the alpha value of the color of the line;
		 *                            valid values are 0 to 1. If a value is not indicated, the default is 1 (solid). If
		 *                            the value is less than 0, the default is 0. If the value is greater than 1, the default is 1.
		 * @param pixelHinting      <Boolean (default = false)> A Boolean value that specifies whether to hint strokes
		 *                            to full pixels. This affects both the position of anchors of a curve and the line stroke size
		 *                            itself. With pixelHinting set to true, line widths are adjusted
		 *                            to full pixel widths. With pixelHinting set to false, disjoints can
		 *                            appear for curves and straight lines. For example, the following illustrations show how
		 *                            Flash Player or Adobe AIR renders two rounded rectangles that are identical, except that the
		 *                            pixelHinting parameter used in the lineStyle() method is set
		 *                            differently (the images are scaled by 200%, to emphasize the difference):
		 *                            If a value is not supplied, the line does not use pixel hinting.
		 * @param scaleMode         <String (default = "normal")> A value from the LineScaleMode class that
		 *                            specifies which scale mode to use:
		 *                            LineScaleMode.NORMAL-Always scale the line thickness when the object is scaled
		 *                            (the default).
		 *                            LineScaleMode.NONE-Never scale the line thickness.
		 *                            LineScaleMode.VERTICAL-Do not scale the line thickness if the object is scaled vertically
		 *                            only. For example, consider the following circles, drawn with a one-pixel line, and each with the
		 *                            scaleMode parameter set to LineScaleMode.VERTICAL. The circle on the left
		 *                            is scaled vertically only, and the circle on the right is scaled both vertically and horizontally:
		 *                            LineScaleMode.HORIZONTAL-Do not scale the line thickness if the object is scaled horizontally
		 *                            only. For example, consider the following circles, drawn with a one-pixel line, and each with the
		 *                            scaleMode parameter set to LineScaleMode.HORIZONTAL. The circle on the left
		 *                            is scaled horizontally only, and the circle on the right is scaled both vertically and horizontally:
		 * @param caps              <String (default = null)> A value from the CapsStyle class that specifies the type of caps at the end
		 *                            of lines. Valid values are: CapsStyle.NONE, CapsStyle.ROUND, and CapsStyle.SQUARE.
		 *                            If a value is not indicated, Flash uses round caps.
		 *                            For example, the following illustrations show the different capsStyle
		 *                            settings. For each setting, the illustration shows a blue line with a thickness of 30 (for
		 *                            which the capsStyle applies), and a superimposed black line with a thickness of 1
		 *                            (for which no capsStyle applies):
		 * @param joints            <String (default = null)> A value from the JointStyle class that specifies the type of joint appearance
		 *                            used at angles. Valid
		 *                            values are: JointStyle.BEVEL, JointStyle.MITER, and JointStyle.ROUND.
		 *                            If a value is not indicated, Flash uses round joints.
		 *                            For example, the following illustrations show the different joints
		 *                            settings. For each setting, the illustration shows an angled blue line with a thickness of
		 *                            30 (for which the jointStyle applies), and a superimposed angled black line with a
		 *                            thickness of 1 (for which no jointStyle applies):
		 *                            Note: For joints set to JointStyle.MITER,
		 *                            you can use the miterLimit parameter to limit the length of the miter.
		 * @param miterLimit        <Number (default = 3)> A number that indicates the limit at which a miter is cut off.
		 *                            Valid values range from 1 to 255 (and values outside of that range are rounded to 1 or 255).
		 *                            This value is only used if the jointStyle
		 *                            is set to "miter". The
		 *                            miterLimit value represents the length that a miter can extend beyond the point
		 *                            at which the lines meet to form a joint. The value expresses a factor of the line
		 *                            thickness. For example, with a miterLimit factor of 2.5 and a
		 *                            thickness of 10 pixels, the miter is cut off at 25 pixels.
		 *                            For example, consider the following angled lines, each drawn with a thickness
		 *                            of 20, but with miterLimit set to 1, 2, and 4. Superimposed are black reference
		 *                            lines showing the meeting points of the joints:
		 *                            Notice that a given miterLimit value has a specific maximum angle
		 *                            for which the miter is cut off. The following table lists some examples:
		 *                            miterLimit value:Angles smaller than this are cut off:
		 *                            1.41490 degrees
		 */
		public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void;
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
		 * Moves the current drawing position to (x, y). If any of the parameters
		 *  are missing, this method fails and the current drawing position is not changed.
		 *
		 * @param x                 <Number> A number that indicates the horizontal position relative to the
		 *                            registration point of the parent display object (in pixels).
		 * @param y                 <Number> A number that indicates the vertical position relative to the
		 *                            registration point of the parent display object (in pixels).
		 */
		public function moveTo(x:Number, y:Number):void;
	}
}
