package fl.controls
{
import fl.controls.BaseButton;
import fl.controls.SliderDirection;
import fl.controls.ScrollBar;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.SliderEvent;
import fl.events.InteractionInputType;
import fl.events.SliderEventClickTarget;
import fl.managers.IFocusManagerComponent;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

/**
* The Slider component lets users select a value by moving a slider 	 * thumb between the end points of the slider track. The current 	 * value of the Slider component is determined by the relative location of 	 * the thumb between the end points of the slider, corresponding to      * the <code>minimum</code> and <code>maximum</code> values of the Slider	 * component.	 *     * @includeExample examples/SliderExample.as     *     * @see fl.events.SliderEvent SliderEvent     *     * @langversion 3.0     * @playerversion Flash 9.0.28.0
*/
public class Slider extends UIComponent implements IFocusManagerComponent
{
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _direction : String;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _minimum : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _maximum : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _value : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _tickInterval : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _snapInterval : Number;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _liveDragging : Boolean;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var tickContainer : Sprite;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var thumb : BaseButton;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var track : BaseButton;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static var defaultStyles : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const TRACK_STYLES : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const THUMB_STYLES : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected static const TICK_STYLES : Object;

	/**
	* Sets the direction of the slider. Acceptable values are <code>SliderDirection.HORIZONTAL</code> and          * <code>SliderDirection.VERTICAL</code>.          *         * @default SliderDirection.HORIZONTAL         *		 * @includeExample examples/Slider.direction.1.as -noswf		 *         * @see SliderDirection         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get direction () : String;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set direction (value:String) : Void;

	/**
	* The minimum value allowed on the Slider component instance.         *         * @default 0         *         * @see #maximum         * @see #value         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get minimum () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set minimum (value:Number) : Void;

	/**
	* The maximum allowed value on the Slider component instance.         *         * @default 10         *         * @see #minimum         * @see #value         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get maximum () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set maximum (value:Number) : Void;

	/**
	* The spacing of the tick marks relative to the maximum value 		 * of the component. The Slider component displays tick marks whenever          * you set the <code>tickInterval</code> property to a nonzero value.         *         * @default 0         *         * @see #snapInterval         *		 * @includeExample examples/Slider.tickInterval.1.as -noswf		 *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get tickInterval () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set tickInterval (value:Number) : Void;

	/**
	* Gets or sets the increment by which the value is increased or decreased		 * as the user moves the slider thumb. 		 *		 * <p>For example, this property is set to 2, the <code>minimum</code> value is 0, 		 * and the <code>maximum</code> value is 10, the position of the thumb will always  		 * be at 0, 2, 4, 6, 8, or 10. If this property is set to 0, the slider 		 * moves continuously between the <code>minimum</code> and <code>maximum</code> values.</p>         *         * @default 0         *         * @includeExample examples/Slider.snapInterval.2.as -noswf         * @includeExample examples/Slider.snapInterval.1.as -noswf         *         * @see #tickInterval         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get snapInterval () : Number;

	/**
	* @private (setter)         *		 * @includeExample examples/Slider.snapInterval.1.as -noswf		 *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set snapInterval (value:Number) : Void;

	/**
	* Gets or sets a Boolean value that indicates whether the <code>SliderEvent.CHANGE</code> 		 * event is dispatched continuously as the user moves the slider thumb. If the 		 * <code>liveDragging</code> property is <code>false</code>, the <code>SliderEvent.CHANGE</code> 		 * event is dispatched when the user releases the slider thumb.         *         * @default false         *		 * @includeExample examples/Slider.liveDragging.1.as -noswf		 *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set liveDragging (value:Boolean) : Void;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get liveDragging () : Boolean;

	/**
	* @copy fl.core.UIComponent#enabled         *         * @default true         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get enabled () : Boolean;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set enabled (value:Boolean) : Void;

	/**
	* Gets or sets the current value of the Slider component. This value is 		 * determined by the position of the slider thumb between the minimum and 		 * maximum values.         *         * @default 0         *         * @see #maximum         * @see #minimum         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get value () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set value (value:Number) : Void;

	/**
	* @copy fl.core.UIComponent#getStyleDefinition()         *		 * @includeExample ../core/examples/UIComponent.getStyleDefinition.1.as -noswf		 *         * @see fl.core.UIComponent#getStyle() UIComponent.getStyle()         * @see fl.core.UIComponent#setStyle() UIComponent.setStyle()         * @see fl.managers.StyleManager StyleManager         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static function getStyleDefinition () : Object;
	/**
	* Creates a new Slider component instance.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function Slider ();
	/**
	* @copy fl.core.UIComponent#setSize()         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function setSize (w:Number, h:Number) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function doSetValue (val:Number, interactionType:String =null, clickTarget:String =null, keyCode:int =undefined) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function setStyles () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function draw () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function positionThumb () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawTicks () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function clearTicks () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function calculateValue (pos:Number, interactionType:String, clickTarget:String, keyCode:int = undefined) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function doDrag (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function thumbPressHandler (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function thumbReleaseHandler (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function onTrackClick (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function keyDownHandler (event:KeyboardEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function configUI () : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function getPrecision (num:Number) : Number;
}
}
