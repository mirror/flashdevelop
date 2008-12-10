package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.text.TextLineMetrics;
	import flash.utils.Timer;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.mx_internal;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.events.FlexEvent;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  Dispatched when the load completes. * *  @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 
	/**
	 *  Dispatched when an object's state changes from visible to invisible. * *  @eventType mx.events.FlexEvent.HIDE
	 */
	[Event(name="hide", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched as content loads in event *  or polled mode. * *  @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	/**
	 *  Dispatched when the component becomes visible. * *  @eventType mx.events.FlexEvent.SHOW
	 */
	[Event(name="show", type="mx.events.FlexEvent")] 
	/**
	 *  Skin style for a determinate progress bar. * *  @default mx.skins.halo.ProgressBarSkin
	 */
	[Style(name="barSkin", type="Class", inherit="no")] 
	/**
	 *  Black section of a three-dimensional border, or the color section *  of a two-dimensional border. *  @default 0xB7BABC
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")] 
	/**
	 *  The number of pixels to move the indeterminate progress bar for each indeterminate loop. *  Once the progress bar has moved the specified number of pixels, it gets respositioned back to *  its starting point. A value of 0 means that the bar is not moved.  * *  @default 26
	 */
	[Style(name="indeterminateMoveInterval", type="Number", inherit="no")] 
	/**
	 *  Skin style for an indeterminate progress bar. * *  @default mx.skins.halo.ProgressIndeterminateSkin
	 */
	[Style(name="indeterminateSkin", type="Class", inherit="no")] 
	/**
	 *  Skin style for the mask of the determinate and indeterminate bars. * *  @default mx.skins.halo.ProgressMaskSkin
	 */
	[Style(name="maskSkin", type="Class", inherit="no")] 
	/**
	 *  Skin style for the progress indicator track. * *  @default mx.skins.halo.ProgressTrackSkin
	 */
	[Style(name="trackSkin", type="Class", inherit="no")] 
	/**
	 *  Theme color of the ProgressBar control. *  Possible values are haloGreen, haloBlue, and haloOrange. *  Adobe recommends setting the <code>themeColor</code> style *  in the <code>&lt;mx:Application&gt;</code> tag, instead of in *  individual controls.  * *  @default "haloBlue"
	 */
	[Style(name="themeColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The colors of the track, as an array of two colors. *  You can use the same color twice for a solid track color. * *  @default [ 0xE6EEEE, 0xE6EEEE ]
	 */
	[Style(name="trackColors", type="Array", arrayType="uint", format="Color", inherit="no")] 
	/**
	 *  The height of the track in pixels. If the value is NaN, then *  use the height of the skin specified by the <code>trackSkin</code> property.  *   *  @default NaN
	 */
	[Style(name="trackHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  The width of the label in pixels. If the value is NaN, *  the ProgressBar control sets it to the width of the control. * *  @default NaN
	 */
	[Style(name="labelWidth", type="Number", format="Length", inherit="yes")] 

	/**
	 *  The ProgressBar control provides a visual representation of the progress of a task over *  time. There are two types of ProgressBar controls: determinate and indeterminate. * *  <p>A determinate ProgressBar control is a linear representation of the progress of a task over time. *  You use a determinate ProgressBar when the scope of the task is known. It displays when the user *  has to wait for an extended amount of time.</p> * *  <p>An indeterminate ProgressBar control represents time-based processes for which the scope is *  not yet known. As soon as you can determine the scope,  *  you should use a determinate ProgressBar control.</p> * *  <p>The ProgressBar control has the following default characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>default size</td> *           <td>150 pixels wide by 4 pixels high</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>Undefined</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:ProgressBar&gt;</code> tag inherits all of the tag attributes  *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:ProgressBar *    <strong>Properties</strong> *    conversion="1" *    direction="right|left" *    indeterminate="false|true" *    label="<i>No default</i>" *    labelPlacement="bottom|top|left|right|center" *    maximum="0" *    minimum="0" *    mode="event|polled|manual" *    source="<i>No default</i>" *   *    <strong>Styles</strong> *    barColor="undefined" *    barSkin="ProgressBarSkin" *    borderColor="0xAAB3B3" *    color="0x0B333C" *    disabledColor="0xAAB3B3" *    fontAntiAliasType="advanced" *    fontFamily="Verdana" *    fontGridFitType="pixel" *    fontSharpness="0" *    fontSize="10" *    fontThickness="0" *    fontStyle="normal|italic" *    fontWeight="normal|bold" *    horizontalGap="8" *    indeterminateMoveInterval="26" *    indeterminateSkin="ProgressIndeterminateSkin" *    labelWidth="Computed" *    leading="0" *    maskSkin="ProgressMaskSkin" *    paddingLeft="0" *    paddingRight="0" *    textAlign="left|right|center" *    textDecoration="none|underline" *    textIndent="0" *    themeColor="haloGreen|haloBlue|haloOrange" *    trackColors="[0xE6EEEE,0xE6EEEE]" *    trackHeight="Calculated" *    trackSkin="ProgressTrackSkin" *    verticalGap="6" *   *    <strong>Events</strong> *    complete="<i>No default</i>" *    hide="<i>No default</i>" *    progress="<i>No default</i>" *    show="<i>No default</i>" *   *    <strong>Effects</strong> *    completeEffect="<i>No default</i>" *  /&gt; *  </pre> *  </p> * *  @see mx.controls.ProgressBarDirection *  @see mx.controls.ProgressBarLabelPlacement *  @see mx.controls.ProgressBarMode * *  @includeExample examples/SimpleProgressBar.mxml
	 */
	public class ProgressBar extends UIComponent implements IFontContextComponent
	{
		/**
		 *  @private
		 */
		local var _content : UIComponent;
		/**
		 *  @private
		 */
		local var _bar : UIComponent;
		/**
		 *  @private
		 */
		local var _indeterminateBar : IFlexDisplayObject;
		/**
		 *  @private
		 */
		local var _determinateBar : IFlexDisplayObject;
		/**
		 *  @private
		 */
		local var _track : IFlexDisplayObject;
		/**
		 *  @private
		 */
		local var _barMask : IFlexDisplayObject;
		/**
		 *  @private
		 */
		local var _labelField : IUITextField;
		/**
		 *  @private
		 */
		private var pollTimer : Timer;
		/**
		 *  @private
		 */
		private var _interval : Number;
		/**
		 *  @private
		 */
		private var indeterminatePlaying : Boolean;
		/**
		 *  @private
		 */
		private var stopPolledMode : Boolean;
		/**
		 *  @private
		 */
		private var barSkinChanged : Boolean;
		/**
		 *  @private
		 */
		private var trackSkinChanged : Boolean;
		/**
		 *  @private
		 */
		private var indeterminateSkinChanged : Boolean;
		/**
		 *  @private
		 */
		private var visibleChanged : Boolean;
		/**
		 *  @private     *  Storage for the conversion property.
		 */
		private var _conversion : Number;
		/**
		 *  @private     *  Storage for the direction property.
		 */
		private var _direction : String;
		/**
		 *  @private     *  Storage for the indeterminate property.
		 */
		private var _indeterminate : Boolean;
		/**
		 *  @private
		 */
		private var indeterminateChanged : Boolean;
		/**
		 *  @private     *  Storage for the label property.
		 */
		private var _label : String;
		/**
		 *  @private
		 */
		private var labelOverride : String;
		/**
		 *  @private     *  Storage for the labelPlacement property.
		 */
		private var _labelPlacement : String;
		/**
		 *  @private     *  Storage for the maximum property.
		 */
		private var _maximum : Number;
		/**
		 *  @private     *  Storage for the minimum property.
		 */
		private var _minimum : Number;
		/**
		 *  @private     *  Storage for the mode property.
		 */
		private var _mode : String;
		/**
		 *  @private
		 */
		private var modeChanged : Boolean;
		/**
		 *  @private     *  Storage for the source property.
		 */
		private var _source : Object;
		/**
		 *  @private
		 */
		private var _stringSource : String;
		/**
		 *  @private
		 */
		private var sourceChanged : Boolean;
		/**
		 *  @private
		 */
		private var stringSourceChanged : Boolean;
		/**
		 *  @private     *  Storage for the value property.
		 */
		private var _value : Number;

		/**
		 *  Number used to convert incoming current bytes loaded value and     *  the total bytes loaded values.     *  Flex divides the current and total values by this property and     *  uses the closest integer that is less than or equal to each     *  value in the label string. A value of 1 does no conversion.     *     *  @default 1
		 */
		public function get conversion () : Number;
		/**
		 *  @private
		 */
		public function set conversion (value:Number) : void;
		/**
		 *  Direction in which the fill of the ProgressBar expands toward completion.      *  Valid values in MXML are     *  <code>"right"</code> and <code>"left"</code>.     *     *  <p>In ActionScript, you use use the following constants     *  to set this property:     *  <code>ProgressBarDirection.RIGHT</code> and     *  <code>ProgressBarDirection.LEFT</code>.</p>     *     *  @see mx.controls.ProgressBarDirection     *  @default ProgressBarDirection.RIGHT
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  Whether the ProgressBar control has a determinate or     *  indeterminate appearance.     *  Use an indeterminate appearance when the progress status cannot be determined.     *  If <code>true</code>, the appearance is indeterminate.     *     *  @default false
		 */
		public function get indeterminate () : Boolean;
		/**
		 *  @private
		 */
		public function set indeterminate (value:Boolean) : void;
		/**
		 *  Text that accompanies the progress bar. You can include     *  the following special characters in the text string:     *      *  <ul>     *    <li>%1 = current loaded bytes</li>     *    <li>%2 = total bytes</li>     *    <li>%3 = percent loaded</li>     *    <li>%% = "%" character</li>     *  </ul>     *     *  <p>If a field is unknown, it is replaced by "??".     *  If undefined, the label is not displayed.</p>     *       *  <p>If you are in manual mode, you can set the values of these special characters      *  by using the <code>setProgress()</code> method.</p>     *     *  @default "LOADING %3%%"
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;
		/**
		 *  Placement of the label.     *  Valid values in MXML are <code>"right"</code>, <code>"left"</code>,     *  <code>"bottom"</code>, <code>"center"</code>, and <code>"top"</code>.     *     *  <p>In ActionScript, you can use use the following constants to set this property:     *  <code>ProgressBarLabelPlacement.RIGHT</code>, <code>ProgressBarLabelPlacement.LEFT</code>,     *  <code>ProgressBarLabelPlacement.BOTTOM</code>, <code>ProgressBarLabelPlacement.CENTER</code>,     *  and <code>ProgressBarLabelPlacement.TOP</code>.</p>     *     *  @see mx.controls.ProgressBarLabelPlacement     *  @default ProgressBarLabelPlacement.BOTTOM
		 */
		public function get labelPlacement () : String;
		/**
		 *  @private
		 */
		public function set labelPlacement (value:String) : void;
		/**
		 *  Largest progress value for the ProgressBar. You     *  can only use this property in manual mode.     *     *  @default 0
		 */
		public function get maximum () : Number;
		/**
		 *  @private
		 */
		public function set maximum (value:Number) : void;
		/**
		 *  Smallest progress value for the ProgressBar. This     *  property is set by the developer only in manual mode.     *     *  @default 0
		 */
		public function get minimum () : Number;
		/**
		 *  @private
		 */
		public function set minimum (value:Number) : void;
		/**
		 *  Specifies the method used to update the bar.      *  Use one of the following values in MXML:     *     *  <ul>     *    <li><code>event</code> The control specified by the <code>source</code>     *    property must dispatch progress and completed events.     *    The ProgressBar control uses these events to update its status.     *    The ProgressBar control only updates if the value of      *    the <code>source</code> property extends the EventDispatcher class.</li>     *     *    <li><code>polled</code> The <code>source</code> property must specify     *    an object that exposes <code>bytesLoaded</code> and     *    <code>bytesTotal</code> properties. The ProgressBar control     *    calls these methods to update its status.</li>     *     *    <li><code>manual</code> You manually update the ProgressBar status.     *    In this mode you specify the <code>maximum</code> and <code>minimum</code>     *    properties and use the <code>setProgress()</code> property method to     *    specify the status. This mode is often used when the <code>indeterminate</code>     *    property is <code>true</code>.</li>     *  </ul>     *     *  <p>In ActionScript, you can use use the following constants to set this property:     *  <code>ProgressBarMode.EVENT</code>, <code>ProgressBarMode.POLLED</code>,     *  and <code>ProgressBarMode.MANUAL</code>.</p>     *     *  @see mx.controls.ProgressBarMode     *     *  @default ProgressBarMode.EVENT
		 */
		public function get mode () : String;
		/**
		 *  @private
		 */
		public function set mode (value:String) : void;
		/**
		 *  Percentage of process that is completed.The range is 0 to 100.     *  Use the <code>setProgress()</code> method to change the percentage.
		 */
		public function get percentComplete () : Number;
		/**
		 *  Refers to the control that the ProgressBar is measuring the progress of. Use this property only in     *  event and polled mode. A typical usage is to set this property to a Loader control.
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;
		/**
		 *  Read-only property that contains the amount of progress     *  that has been made - between the minimum and maximum values.
		 */
		public function get value () : Number;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function ProgressBar ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function childrenCreated () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Sets the state of the bar to reflect the amount of progress made     *  when using manual mode.     *  The <code>value</code> argument is assigned to the <code>value</code>     *  property and the <code>maximum</code> argument is assigned to the     *  <code>maximum</code> property.     *  The <code>minimum</code> property is not altered.     *     *  @param value Current value.     *     *  @param maximum Total or target value.
		 */
		public function setProgress (value:Number, total:Number) : void;
		/**
		 *  @private     *  Changes the value and the maximum properties.
		 */
		private function _setProgress (value:Number, maximum:Number) : void;
		/**
		 *  @private
		 */
		private function createTrack () : void;
		/**
		 *  @private
		 */
		private function createBar () : void;
		/**
		 *  @private
		 */
		private function createIndeterminateBar () : void;
		/**
		 *  @private
		 */
		private function layoutContent (newWidth:Number, newHeight:Number) : void;
		/**
		 *  @private
		 */
		private function getFullLabelText () : String;
		/**
		 *  @private     *  Make a good guess at the largest size of the label based on which placeholders are present
		 */
		private function predictLabelText () : String;
		/**
		 *  @private
		 */
		private function startPlayingIndeterminate () : void;
		/**
		 *  @private
		 */
		private function stopPlayingIndeterminate () : void;
		/**
		 *  @private
		 */
		private function addSourceListeners () : void;
		/**
		 *  @private
		 */
		private function removeSourceListeners () : void;
		/**
		 *  @private     *  "progress" event handler for event mode
		 */
		private function progressHandler (event:ProgressEvent) : void;
		/**
		 *  @private     *  "complete" event handler for event mode
		 */
		private function completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function updateIndeterminateHandler (event:Event) : void;
		/**
		 *  @private     *  Callback method for polled mode.
		 */
		private function updatePolledHandler (event:Event) : void;
	}
}
