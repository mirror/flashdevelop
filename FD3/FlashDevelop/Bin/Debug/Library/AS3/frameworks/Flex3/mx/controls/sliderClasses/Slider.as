package mx.controls.sliderClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.effects.Tween;
	import mx.events.FlexEvent;
	import mx.events.SliderEvent;
	import mx.events.SliderEventClickTarget;
	import mx.formatters.NumberFormatter;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the slider changes value due to mouse or keyboard interaction.
 *
 *  <p>If the <code>liveDragging</code> property is <code>true</code>,
 *  the event is dispatched continuously as the user moves the thumb.
 *  If <code>liveDragging</code> is <code>false</code>,
 *  the event is dispatched when the user releases the slider thumb.</p>
 *
 *  @eventType mx.events.SliderEvent.CHANGE
	 */
	[Event(name="change", type="mx.events.SliderEvent")] 

	/**
	 *  Dispatched when the slider's thumb is pressed and then moved by the mouse.
 *  This event is always preceded by a <code>thumbPress</code> event.
 *  @eventType mx.events.SliderEvent.THUMB_DRAG
	 */
	[Event(name="thumbDrag", type="mx.events.SliderEvent")] 

	/**
	 *  Dispatched when the slider's thumb is pressed, meaning
 *  the user presses the mouse button over the thumb.
 *
 *  @eventType mx.events.SliderEvent.THUMB_PRESS
	 */
	[Event(name="thumbPress", type="mx.events.SliderEvent")] 

	/**
	 *  Dispatched when the slider's thumb is released, 
 *  meaning the user releases the mouse button after 
 *  a <code>thumbPress</code> event.
 *
 *  @eventType mx.events.SliderEvent.THUMB_RELEASE
	 */
	[Event(name="thumbRelease", type="mx.events.SliderEvent")] 

include "../../styles/metadata/FillStyles.as"
	/**
	 *  The color of the black section of the border. 
 *  
 *  @default 0x919999
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  Invert the direction of the thumbs. 
 *  If <code>true</code>, the thumbs will be flipped.
 *  
 *  @default false
	 */
	[Style(name="invertThumbDirection", type="Boolean", inherit="no")] 

	/**
	 *  The y-position offset (if direction is horizontal)
 *  or x-position offset (if direction is vertical)
 *  of the labels relative to the track.
 *
  *  @default -10
	 */
	[Style(name="labelOffset", type="Number", format="Length", inherit="no")] 

	/**
	 *  The name of the style to use for the slider label.  
 *
 *  @default undefined
	 */
	[Style(name="labelStyleName", type="String", inherit="no")] 

	/**
	 *  Duration in milliseconds for the sliding animation
 *  when you click on the track to move a thumb.
 *
 *  @default 300
	 */
	[Style(name="slideDuration", type="Number", format="Time", inherit="no")] 

	/**
	 *  Tweening function used by the sliding animation
 *  when you click on the track to move a thumb.
 *
 *  @default undefined
	 */
	[Style(name="slideEasingFunction", type="Function", inherit="no")] 

	/**
	 *  The y-position offset (if direction is horizontal)
 *  or x-position offset (if direction is vertical)
 *  of the thumb relative to the track.
 *
 *  @default 0
	 */
	[Style(name="thumbOffset", type="Number", format="Length", inherit="no")] 

	/**
	 *  The color of the tick marks.
 *  Can be a hex color value or the string name of a known color.
 *
 *  @default 0x6F7777.
	 */
	[Style(name="tickColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  The length in pixels of the tick marks.
 *  If <code>direction</code> is <code>Direction.HORIZONTAL</code>,
 *  then adjust the height of the tick marks.
 *  If <code>direction</code> is <code>Direction.VERTICAL</code>,
 *  then adjust the width.
 *
 *  @default 3
	 */
	[Style(name="tickLength", type="Number", format="Length", inherit="no")] 

	/**
	 *  The y-position offset (if direction is horizontal)
 *  or x-position offset (if direction is vertical)
 *  of the tick marks relative to the track.
 *
 *  @default -6
	 */
	[Style(name="tickOffset", type="Number", format="Length", inherit="no")] 

	/**
	 *  The thickness in pixels of the tick marks.
 *  If direction is horizontal,
 *  then adjust the width of the tick marks.
 *  If direction is vertical,
 *  then adjust the height.
 *
 *  @default 1
	 */
	[Style(name="tickThickness", type="Number", format="Length", inherit="no")] 

	/**
	 *  The colors of the track, as an array of two colors.
 *  You can use the same color twice for a solid track color.
 *
 *  <p>You use this property along with the <code>fillAlphas</code> 
 *  property. Typically you set <code>fillAlphas</code> to [ 1.0, 1.0 ] 
 *  when setting <code>trackColors</code>.</p>
 *
 *  @default [ 0xE7E7E7, 0xE7E7E7 ]
	 */
	[Style(name="trackColors", type="Array", arrayType="uint", format="Color", inherit="no")] 

	/**
	 *  Specifies whether to enable track highlighting between thumbs
 *  (or a single thumb and the beginning of the track).
 *
 *  @default false
	 */
	[Style(name="showTrackHighlight", type="Boolean", inherit="no")] 

	/**
	 *  The size of the track margins, in pixels.
 *  If <code>undefined</code>, then the track margins will be determined
 *  by the length of the first and last labels.
 *  If given a value, Flex attempts to fit the labels in the available space.
 *
 *  @default undefined
	 */
	[Style(name="trackMargin", type="Number", format="Length", inherit="no")] 

	/**
	 *  The name of the style declaration to use for the data tip.
 *
 *  @default undefined
	 */
	[Style(name="dataTipStyleName", type="String", inherit="no")] 

	/**
	 *  The offset, in pixels, of the data tip relative to the thumb.
 *  Used in combination with the <code>dataTipPlacement</code>
 *  style property of the HSlider and VSlider controls.
 *
 *  @default 16
	 */
	[Style(name="dataTipOffset", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of decimal places to use for the data tip text.
 *  A value of 0 means to round all values to an integer.
 *
 *  @default 2
	 */
	[Style(name="dataTipPrecision", type="int", inherit="no")] 

	/**
	 *  The default skin for the slider thumb.
 * 
 *  @default SliderThumbSkin
	 */
	[Style(name="thumbSkin", type="Class", inherit="no", states="up, over, down, disabled")] 

	/**
	 *  The skin for the slider thumb up state.
 *
 *  @default SliderThumbSkin
	 */
	[Style(name="thumbUpSkin", type="Class", inherit="no")] 

	/**
	 *  The skin for the slider thumb over state.
 *
 *  @default SliderThumbSkin
	 */
	[Style(name="thumbOverSkin", type="Class", inherit="no")] 

	/**
	 *  The skin for the slider thumb down state.
 *
 *  @default SliderThumbSkin
	 */
	[Style(name="thumbDownSkin", type="Class", inherit="no")] 

	/**
	 *  The skin for the slider thumb disabled state.
 *
 *  @default SliderThumbSkin
	 */
	[Style(name="thumbDisabledSkin", type="Class", inherit="no")] 

	/**
	 *  The skin for the slider track when it is selected.
	 */
	[Style(name="trackHighlightSkin", type="Class", inherit="no")] 

	/**
	 *  The skin for the slider track.
	 */
	[Style(name="trackSkin", type="Class", inherit="no")] 

include "../../core/Version.as"
	/**
	 *  The Slider class is the base class for the Flex slider controls.
 *  The slider controls let users select a value by moving a slider thumb 
 *  between the end points of the slider
 *  track. The current value of the slider is determined by 
 *  the relative location of the thumb between the
 *  end points of the slider, corresponding to the slider's minimum and maximum values.
 *  The Slider class is subclassed by HSlider and VSlider.
 *
 *  @mxml
 *  
 *  <p>The Slider class cannot be used as an MXML tag. Use the <code>&lt;mx:HSlider&gt;</code> 
 *  and <code>&lt;mx:VSlider&gt;</code> tags instead. However, the Slider class does define tag 
 *  attributes used by the <code>&lt;mx:HSlider&gt;</code> and <code>&lt;mx:VSlider&gt;</code> tags. </p>
 *
 *  <p>The Slider class inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:<i>tagname</i>
 *    <strong>Properties</strong>
 *    allowThumbOverlap="false|true"
 *    allowTrackClick="true|false"
 *    dataTipFormatFunction="undefined"
 *    direction="horizontal|vertical"
 *    labels="undefined"
 *    liveDragging="false|true"
 *    maximum="10"
 *    minimum="0"
 *    showDataTip="true|false"
 *    sliderDataTipClass="sliderDataTip"
 *    sliderThumbClass="SliderThumb"
 *    snapInterval="0"
 *    thumbCount="1"
 *    tickInterval="0"
 *    tickValues="undefined"
 *    value="<i>The value of the minimum property.</i>"
 * 
 *    <strong>Styles</strong>
 *    borderColor="0x919999"
 *    dataTipOffset="16"
 *    dataTipPrecision="2"
 *    dataTipStyleName="undefined"
 *    fillAlphas="[0.6, 0.4, 0.75, 0.65]"
 *    fillColors="[0xFFFFFF, 0xCCCCCC, 0xFFFFFF, 0xEEEEEE;]"
 *    labelOffset="-10"
 *    labelStyleName="undefined"
 *    showTrackHighlight="false"
 *    slideDuration="300"
 *    slideEasingFunction="undefined"
 *    thumbDisabledSkin="SliderThumbSkin"
 *    thumbDownSkin="SliderThumbSkin"
 *    thumbOffset="0"
 *    thumbOverSkin="SliderThumbSkin"
 *    thumbUpSkin="SliderThumbSkin"
 *    tickColor="0x6F7777"
 *    tickLength="3"
 *    tickOffset="-6"
 *    tickThickness="1"
 *    trackColors="[ 0xEEEEEE, 0xFFFFFF ]"
 *    tracHighlightSkin="SliderHighlightSkin"
 *    trackMargin="undefined"
 *    trackSkin="SliderTrackSkin"
 *  
 *    <strong>Events</strong>
 *    change="<i>No default</i>"
 *    thumbDrag="<i>No default</i>"
 *    thumbPress="<i>No default</i>"
 *    thumbRelease="<i>No default</i>"
 *  /&gt;
 *  </pre>
	 */
	public class Slider extends UIComponent
	{
		/**
		 *  @private
     *  Placeholder for mixin by SliderAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var track : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var thumbs : UIComponent;
		/**
		 *  @private
		 */
		private var thumbsChanged : Boolean;
		/**
		 *  @private
		 */
		private var ticks : UIComponent;
		/**
		 *  @private
		 */
		private var ticksChanged : Boolean;
		/**
		 *  @private
		 */
		private var labelObjects : UIComponent;
		/**
		 *  @private
		 */
		private var highlightTrack : IFlexDisplayObject;
		/**
		 *  @private
		 */
		var innerSlider : UIComponent;
		/**
		 *  @private
		 */
		private var trackHitArea : UIComponent;
		/**
		 *  @private
		 */
		var dataTip : SliderDataTip;
		/**
		 *  @private
		 */
		private var trackHighlightChanged : Boolean;
		/**
		 *  @private
		 */
		private var initValues : Boolean;
		/**
		 *  @private
		 */
		private var dataFormatter : NumberFormatter;
		/**
		 *  @private
		 */
		private var interactionClickTarget : String;
		/**
		 *  @private
		 */
		private var labelStyleChanged : Boolean;
		/**
		 *  @private
    *  is the last interaction from the keyboard?
		 */
		var keyInteraction : Boolean;
		/**
		 *  @private
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
		 */
		private var _tabIndex : Number;
		/**
		 *  @private
		 */
		private var tabIndexChanged : Boolean;
		/**
		 *  If set to <code>false</code>, then each thumb can only be moved to the edge of
     *  the adjacent thumb.
     *  If <code>true</code>, then each thumb can be moved to any position on the track.
     *
     *  @default false
		 */
		public var allowThumbOverlap : Boolean;
		/**
		 *  Specifies whether clicking on the track will move the slider thumb.
     *
     *  @default true
		 */
		public var allowTrackClick : Boolean;
		/**
		 *  @private
		 */
		private var _dataTipFormatFunction : Function;
		/**
		 *  @private
		 */
		private var _direction : String;
		/**
		 *  @private
		 */
		private var directionChanged : Boolean;
		/**
		 *  @private
		 */
		private var _labels : Array;
		/**
		 *  @private
		 */
		private var labelsChanged : Boolean;
		/**
		 *  Specifies whether live dragging is enabled for the slider.
     *  If <code>false</code>, Flex sets the <code>value</code> and
     *  <code>values</code> properties and dispatches the <code>change</code>
     *  event when the user stops dragging the slider thumb.
     *  If <code>true</code>,  Flex sets the <code>value</code> and
     *  <code>values</code> properties and dispatches the <code>change</code>
     *  event continuously as the user moves the thumb.
     *
     *  @default false
		 */
		public var liveDragging : Boolean;
		/**
		 *  @private
     *  Storage for the maximum property.
		 */
		private var _maximum : Number;
		/**
		 *  @private
     *  Storage for the minimum property.
		 */
		private var _minimum : Number;
		/**
		 *  @private
		 */
		private var minimumSet : Boolean;
		/**
		 *  If set to <code>true</code>, show a data tip during user interaction
     *  containing the current value of the slider.
     *
     *  @default true
		 */
		public var showDataTip : Boolean;
		/**
		 *  @private
		 */
		private var _thumbClass : Class;
		/**
		 *  @private
		 */
		private var _sliderDataTipClass : Class;
		/**
		 *  @private
		 */
		private var _snapInterval : Number;
		/**
		 *  @private
		 */
		private var snapIntervalPrecision : int;
		/**
		 *  @private
		 */
		private var snapIntervalChanged : Boolean;
		/**
		 *  @private
     *  Storage for the thumbCount property.
		 */
		private var _thumbCount : int;
		/**
		 *  @private
		 */
		private var _tickInterval : Number;
		/**
		 *  @private
		 */
		private var _tickValues : Array;
		/**
		 *  @private
		 */
		private var _values : Array;
		/**
		 *  @private
		 */
		private var valuesChanged : Boolean;

		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set tabIndex (value:int) : void;

		/**
		 *  Callback function that formats the data tip text.
     *  The function takes a single Number as an argument
     *  and returns a formatted String.
     *
     *  <p>The function has the following signature:</p>
     *  <pre>
     *  funcName(value:Number):String
     *  </pre>
     *
     *  <p>The following example prefixes the data tip text with a dollar sign and 
     *  formats the text using the <code>dataTipPrecision</code> 
     *  of a Slider Control named 'slide': </p>
     *
     *  <pre>
     *  import mx.formatters.NumberBase;
     *  function myDataTipFormatter(value:Number):String { 
     *      var dataFormatter:NumberBase = new NumberBase(".", ",", ".", ""); 
     *      return   "$ " + dataFormatter.formatPrecision(String(value), slide.getStyle("dataTipPrecision")); 
     *  }
     *  </pre>
     *
     *  @default undefined
		 */
		public function get dataTipFormatFunction () : Function;
		/**
		 *  @private
		 */
		public function set dataTipFormatFunction (value:Function) : void;

		/**
		 *  The orientation of the slider control.
     *  Valid values in MXML are <code>"horizontal"</code> or <code>"vertical"</code>.
     *
     *  <p>In ActionScript, you use the following constants
     *  to set this property:
     *  <code>SliderDirection.VERTICAL</code> and
     *  <code>SliderDirection.HORIZONTAL</code>.</p>
     *
     *  The HSlider and VSlider controls set this property for you;
     *  do not set it when using those controls.
     *
     *  @default SliderDirection.HORIZONTAL
     *  @see mx.controls.sliderClasses.SliderDirection
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;

		/**
		 *  An array of strings used for the slider labels.
     *  Flex positions the labels at the beginning of the track,
     *  and spaces them evenly between the beginning of the track
     *  and the end of the track.
     *
     *  <p>For example, if the array contains three items,
     *  the first item is placed at the beginning of the track,
     *  the second item in the middle, and the last item
     *  at the end of the track.</p>
     *
     *  <p>If only one label is specified, it is placed at the
     *  beginning of the track.
     *  By default, labels are placed above the tick marks
     *  (if present) or above  the track.
     *  To align the labels with the tick marks, make sure that
     *  the number of tick marks is equal to the number of labels.</p>
     *
     *  @default undefined
		 */
		public function get labels () : Array;
		/**
		 *  @private
		 */
		public function set labels (value:Array) : void;

		/**
		 *  The maximum allowed value on the slider.
     *
     *  @default  10
		 */
		public function get maximum () : Number;
		/**
		 *  @private
		 */
		public function set maximum (value:Number) : void;

		/**
		 *  The minimum allowed value on the slider control.
     *
     *  @default 0
		 */
		public function get minimum () : Number;
		/**
		 *  @private
		 */
		public function set minimum (value:Number) : void;

		/**
		 *  A reference to the class to use for each thumb.
     *
     *  @default SliderThumb
		 */
		public function get sliderThumbClass () : Class;
		/**
		 *  @private
		 */
		public function set sliderThumbClass (value:Class) : void;

		/**
		 *  A reference to the class to use for the data tip.
     *
     *  @default SliderDataTip
		 */
		public function get sliderDataTipClass () : Class;
		/**
		 *  @private
		 */
		public function set sliderDataTipClass (value:Class) : void;

		/**
		 *  Specifies the increment value of the slider thumb
     *  as the user moves the thumb.
     *  For example, if <code>snapInterval</code> is 2,
     *  the <code>minimum</code> value is 0,
     *  and the <code>maximum</code> value is 10,
     *  the thumb snaps to the values 0, 2, 4, 6, 8, and 10
     *  as the user move the thumb.
     *  A value of 0, means that the slider moves continuously
     *  between the <code>minimum</code> and <code>maximum</code> values.
     *
     *  @default 0
		 */
		public function get snapInterval () : Number;
		/**
		 *  @private
		 */
		public function set snapInterval (value:Number) : void;

		/**
		 *  The number of thumbs allowed on the slider.
     *  Possible values are 1 or 2.
     *  If set to 1, then the <code>value</code> property contains
     *  the current value of the slider.
     *  If set to 2, then the <code>values</code> property contains
     *  an array of values representing the value for each thumb.
     *
     *  @default 1
		 */
		public function get thumbCount () : int;
		/**
		 *  @private
		 */
		public function set thumbCount (value:int) : void;

		/**
		 *  Set of styles to pass from the Slider to the thumbs.
     *  @see mx.styles.StyleProxy
		 */
		protected function get thumbStyleFilters () : Object;

		/**
		 *  The spacing of the tick marks relative to the <code>maximum</code> value
     *  of the control.
     *  Flex displays tick marks whenever you set the <code>tickInterval</code>
     *  property to a nonzero value.
     *
     *  <p>For example, if <code>tickInterval</code> is 1 and
     *  <code>maximum</code> is 10,  then a tick mark is placed at each
     *  1/10th interval along the slider.
     *  A value of 0 shows no tick marks. If the <code>tickValues</code> property 
     *  is set to a non-empty Array, then this property is ignored.</p>
     *
     *  @default 0
		 */
		public function get tickInterval () : Number;
		/**
		 *  @private
		 */
		public function set tickInterval (value:Number) : void;

		/**
		 *  The positions of the tick marks on the slider. The positions correspond
     *  to the values on the slider and should be between 
     *  the <code>minimum</code> and <code>maximum</code> values.
     *  For example, if the <code>tickValues</code> property 
     *  is [0, 2.5, 7.5, 10] and <code>maximum</code> is 10, then a tick mark is placed
     *  in the following positions along the slider: the beginning of the slider, 
     *  1/4 of the way in from the left, 
     *  3/4 of the way in from the left, and at the end of the slider. 
     *  
     *  <p>If this property is set to a non-empty Array, then the <code>tickInterval</code> property
     *  is ignored.</p>
     *
     *  @default undefined
		 */
		public function get tickValues () : Array;
		/**
		 *  @private
		 */
		public function set tickValues (value:Array) : void;

		/**
		 *  Contains the position of the thumb, and is a number between the
     *  <code>minimum</code> and <code>maximum</code> properties.
     *  Use the <code>value</code> property when <code>thumbCount</code> is 1.
     *  When <code>thumbCount</code> is greater than 1, use the
     *  <code>values</code> property instead.
     *  The default value is equal to the minimum property.
		 */
		public function get value () : Number;
		/**
		 *  @private
		 */
		public function set value (val:Number) : void;

		/**
		 *  An array of values for each thumb when <code>thumbCount</code>
     *  is greater than 1.
		 */
		public function get values () : Array;
		/**
		 *  @private
		 */
		public function set values (value:Array) : void;

		/**
		 *  Constructor.
		 */
		public function Slider ();

		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the amount of space that the component takes up.
     *  A horizontal slider control calculates its height by examining
     *  the position of its labels, tick marks, and thumbs
     *  relative to the track.
     *  The height of the control is equivalent to the position
     *  of the bottom of the lowest element subtracted
     *  from the position of the top of the highest element.
     *  The width of a horizontal slider control defaults to 250 pixels.
     *  For a vertical slider control, the width and the length
     *  measurements are reversed.
		 */
		protected function measure () : void;

		/**
		 *  Positions the elements of the control.
     *  The track, thumbs, labels, and tick marks are all positioned
     *  and sized by this method.
     *  The track is sized based on the length of the labels and on the track margin.
     *  If you specify a <code>trackMargin</code>, then the size of the track
     *  is equal to the available width minus the <code>trackMargin</code> times 2.
     *
     *  <p>Tick marks are spaced at even intervals along the track starting from the beginning of the track. An additional tick mark is placed
     *  at the end of the track if one doesn't already exist (if the tick interval isn't a multiple of the maximum value). The tick mark
     *  y-position is based on the <code>tickOffset</code>. An offset of 0 places the bottom of the tick at the top of the track. Negative offsets
     *  move the ticks upwards while positive offsets move them downward through the track.</p>
     *
     *  <p>Labels are positioned at even intervals along the track. The labels are always horizontally centered above their
     *  interval position unless the <code>trackMargin</code> setting is too small. If you specify a <code>trackMargin</code>, then the first and last labels will
     *  position themselves at the left and right borders of the control. Labels will not crop or resize themselves if they overlap,
     *  so be sure to allow enough space for them to fit on the track. The y-position is based on the <code>labelOffset</code> property. An offset of 0
     *  places the bottom of the label at the top of the track. Unlike tick marks, the labels can not be positioned to overlap the track.
     *  If the offset is a positive number, then the top of the label will be positioned below the bottom of the track.</p>
     *
     *  <p>The thumbs are positioned to overlap the track. Their x-position is determined by their value. The y-position is
     *  controlled by the <code>thumbOffset</code> property. An offset of 0 places the center of the thumb at the center of the track. A negative
     *  offset moves the thumbs upwards while a positive offset moves the thumbs downwards.</p>
     *
     *  <p>The placement of the tick marks, labels and thumbs are all independent from each other. They will not attempt to reposition
     *  themselves if they overlap.</p>
     *
     *  <p>For a vertical slider control, the same rules apply. In the above description, substitute width for height, height for width,
     *  left for up or top, right for down or bottom, x-position for y-position, and y-position for x-position.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		private function createBackgroundTrack () : void;

		/**
		 *  @private
		 */
		private function createHighlightTrack () : void;

		/**
		 *  @private
		 */
		private function createThumbs () : void;

		/**
		 *  @private
		 */
		private function createLabels () : void;

		/**
		 *  @private
		 */
		private function createTicks () : void;

		/**
		 *  @private
		 */
		private function getComponentBounds () : Object;

		/**
		 *  @private
		 */
		private function layoutTicks () : void;

		/**
		 *  @private
		 */
		private function layoutLabels () : void;

		/**
		 *  @private
		 */
		function drawTrackHighlight () : void;

		/**
		 *  @private
     *  Helper function that starts the dataTip and dispatches the press event.
		 */
		function onThumbPress (thumb:Object) : void;

		/**
		 *  @private
		 */
		function onThumbRelease (thumb:Object) : void;

		/**
		 *  @private
		 */
		function onThumbMove (thumb:Object) : void;

		/**
		 *  @private
		 */
		private function positionDataTip (thumb:Object) : void;

		/**
		 *  @private
		 */
		private function destroyDataTip () : void;

		/**
		 *  @private
     *  Utility for finding the x position which corresponds
     *  to the given value.
		 */
		function getXFromValue (v:Number) : Number;

		/**
		 *  @private
		 */
		function getXBounds (selectedThumbIndex:int) : Object;

		/**
		 *  @private
     *  Utility for positioning the thumb(s) from the current value.
		 */
		private function setPosFromValue () : void;

		/**
		 *  @private
     *  Utility for getting a value corresponding to a given x.
		 */
		function getValueFromX (xPos:Number) : Number;

		/**
		 *  @private
     *  Utility for committing a value of a given thumb.
		 */
		private function setValueFromPos (thumbIndex:int) : void;

		/**
		 *  @private
		 */
		function getSnapValue (value:Number, thumb:SliderThumb = null) : Number;

		/**
		 *  @private Accessed by the Thumb to find out the snap interval
		 */
		function getSnapIntervalWidth () : Number;

		/**
		 *  @private
		 */
		function updateThumbValue (thumbIndex:int) : void;

		/**
		 *  Returns the thumb object at the given index. Use this method to
     *  style and customize individual thumbs in a slider control.
     *
     *  @param index The zero-based index number of the thumb.
     *
     *  @return A reference to the SliderThumb object.
		 */
		public function getThumbAt (index:int) : SliderThumb;

		/**
		 *  This method sets the value of a slider thumb, and updates the display.
     *
     *  @param index The zero-based index number of the thumb to set
     *  the value of, where a value of 0 corresponds to the first thumb.
     *
     *  @param value The value to set the thumb to
		 */
		public function setThumbValueAt (index:int, value:Number) : void;

		/**
		 *  @private
		 */
		private function setValueAt (value:Number, index:int, isProgrammatic:Boolean = false) : void;

		/**
		 *  @private
		 */
		function registerMouseMove (listener:Function) : void;

		/**
		 *  @private
		 */
		function unRegisterMouseMove (listener:Function) : void;

		/**
		 *  @private
     *  Move the thumb when pressed.
		 */
		private function track_mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function thumb_focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		private function thumb_focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		function getTrackHitArea () : UIComponent;
	}
}
