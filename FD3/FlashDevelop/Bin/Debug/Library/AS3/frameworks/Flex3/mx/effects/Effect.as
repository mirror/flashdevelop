package mx.effects
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.effects.effectClasses.AddRemoveEffectTargetFilter;
	import mx.effects.effectClasses.HideShowEffectTargetFilter;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.events.EffectEvent;
	import mx.managers.LayoutManager;

	/**
	 *  Dispatched when the effect finishes playing, *  either when the effect finishes playing or when the effect has  *  been interrupted by a call to the <code>end()</code> method. * *  @eventType mx.events.EffectEvent.EFFECT_END
	 */
	[Event(name="effectEnd", type="mx.events.EffectEvent")] 
	/**
	 *  Dispatched when the effect starts playing. * *  @eventType mx.events.EffectEvent.EFFECT_START
	 */
	[Event(name="effectStart", type="mx.events.EffectEvent")] 

	/**
	 *  The Effect class is an abstract base class that defines the basic  *  functionality of all Flex effects. *  The Effect class defines the base factory class for all effects. *  The EffectInstance class defines the base class for all effect *  instance subclasses. * *  <p>You do not create an instance of the Effect class itself *  in an application. *  Instead, you create an instance of one of the subclasses, *  such as Fade or WipeLeft.</p> *   *  @mxml * *  <p>The Effect class defines the following properties, *  which all of its subclasses inherit:</p> *   *  <pre> *  &lt;mx:<i>tagname</i> *    <b>Properties</b> *    customFilter="" *    duration="500" *    filter="" *    hideFocusRing="false" *    perElementOffset="0" *    repeatCount="1" *    repeatDelay="0" *    startDelay="0" *    suspendBackgroundProcessing="false|true" *    target="<i>effect target</i>" *    targets="<i>array of effect targets</i>" *      *    <b>Events</b> *    effectEnd="<i>No default</i>" *    efectStart="<i>No default</i>" *  /&gt; *  </pre> * *  @see mx.effects.EffectInstance *  *  @includeExample examples/SimpleEffectExample.mxml
	 */
	public class Effect extends EventDispatcher implements IEffect
	{
		/**
		 *  @private
		 */
		private var _instances : Array;
		/**
		 *  @private
		 */
		private var _callValidateNow : Boolean;
		/**
		 *  @private
		 */
		private var isPaused : Boolean;
		/**
		 *  @private
		 */
		local var filterObject : EffectTargetFilter;
		/**
		 *  @private	 *  Used in applyValueToTarget()
		 */
		local var applyActualDimensions : Boolean;
		/**
		 *  @private     *  Holds the init object passed in by the Transition.
		 */
		local var propertyChangesArray : Array;
		/**
		 *  @private     *  Storage for the customFilter property.
		 */
		private var _customFilter : EffectTargetFilter;
		/**
		 *  @private     *  Storage for the duration property.
		 */
		private var _duration : Number;
		/**
		 *  @private
		 */
		local var durationExplicitlySet : Boolean;
		/**
		 *  @private	 *  Storage for the effectTargetHost property.
		 */
		private var _effectTargetHost : IEffectTargetHost;
		/**
		 *  A flag containing <code>true</code> if the end values	 *  of an effect have already been determined,      *  or <code>false</code> if they should be acquired from the	 *  current properties of the effect targets when the effect runs.      *  This property is required by data effects because the sequence	 *  of setting up the data effects, such as DefaultListEffect	 *  and DefaultTileListEffect, is more complicated than for	 *  normal effects.     *     *  @default false
		 */
		protected var endValuesCaptured : Boolean;
		/**
		 *  @private     *  Storage for the filter property.
		 */
		private var _filter : String;
		/**
		 *  @private	 *  Storage for the hideFocusRing property.
		 */
		private var _hideFocusRing : Boolean;
		/**
		 *  An object of type Class that specifies the effect     *  instance class class for this effect class.      *       *  <p>All subclasses of the Effect class must set this property      *  in their constructor.</p>
		 */
		public var instanceClass : Class;
		/**
		 *  @private	 *  Storage for the perElementOffset property.
		 */
		private var _perElementOffset : Number;
		/**
		 *  @private     *  Storage for the relevantProperties property.
		 */
		private var _relevantProperties : Array;
		/**
		 *  @private	 *  Storage for the relevantStyles property.
		 */
		private var _relevantStyles : Array;
		/**
		 *  Number of times to repeat the effect.     *  Possible values are any integer greater than or equal to 0.     *  A value of 1 means to play the effect once.     *  A value of 0 means to play the effect indefinitely     *  until stopped by a call to the <code>end()</code> method.     *     *  @default 1
		 */
		public var repeatCount : int;
		/**
		 *  Amount of time, in milliseconds, to wait before repeating the effect.     *  Possible values are any integer greater than or equal to 0.     *     *  @default 0
		 */
		public var repeatDelay : int;
		/**
		 *  Amount of time, in milliseconds, to wait before starting the effect.     *  Possible values are any int greater than or equal to 0.     *  If the effect is repeated by using the <code>repeatCount</code>     *  property, the <code>startDelay</code> is only applied     *  to the first time the effect is played.     *     *  @default 0
		 */
		public var startDelay : int;
		/**
		 *  If <code>true</code>, blocks all background processing     *  while the effect is playing.     *  Background processing includes measurement, layout, and     *  processing responses that have arrived from the server.     *  The default value is <code>false</code>.     *     *  <p>You are encouraged to set this property to     *  <code>true</code> in most cases, because it improves     *  the performance of the application.     *  However, the property should be set to <code>false</code>     *  if either of the following is true:</p>     *  <ul>     *    <li>User input may arrive while the effect is playing,     *    and the application must respond to the user input     *    before the effect finishes playing.</li>     *    <li>A response may arrive from the server while the effect     *    is playing, and the application must process the response     *    while the effect is still playing.</li>     *  </ul>     *     *  @default false
		 */
		public var suspendBackgroundProcessing : Boolean;
		/**
		 *  @private     *  Storage for the targets property.
		 */
		private var _targets : Array;
		/**
		 *  @private     *  Storage for the triggerEvent property.
		 */
		private var _triggerEvent : Event;

		/**
		 *  @copy mx.effects.IEffect#className
		 */
		public function get className () : String;
		/**
		 *  @copy mx.effects.IEffect#customFilter
		 */
		public function get customFilter () : EffectTargetFilter;
		/**
		 *  @private
		 */
		public function set customFilter (value:EffectTargetFilter) : void;
		/**
		 *  @copy mx.effects.IEffect#duration
		 */
		public function get duration () : Number;
		/**
		 *  @private
		 */
		public function set duration (value:Number) : void;
		/**
		 *  @copy mx.effects.IEffect#effectTargetHost
		 */
		public function get effectTargetHost () : IEffectTargetHost;
		/**
		 *  @private
		 */
		public function set effectTargetHost (value:IEffectTargetHost) : void;
		/**
		 *  @copy mx.effects.IEffect#filter
		 */
		public function get filter () : String;
		/**
		 *  @private
		 */
		public function set filter (value:String) : void;
		/**
		 *  @copy mx.effects.IEffect#hideFocusRing
		 */
		public function get hideFocusRing () : Boolean;
		/**
		 *  @private
		 */
		public function set hideFocusRing (value:Boolean) : void;
		/**
		 *  @copy mx.effects.IEffect#isPlaying
		 */
		public function get isPlaying () : Boolean;
		/**
		 *  @copy mx.effects.IEffect#perElementOffset
		 */
		public function get perElementOffset () : Number;
		/**
		 *  @private
		 */
		public function set perElementOffset (value:Number) : void;
		/**
		 *  @copy mx.effects.IEffect#relevantProperties
		 */
		public function get relevantProperties () : Array;
		/**
		 *  @private
		 */
		public function set relevantProperties (value:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#relevantStyles
		 */
		public function get relevantStyles () : Array;
		/**
		 *  @private
		 */
		public function set relevantStyles (value:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#target
		 */
		public function get target () : Object;
		/**
		 *  @private
		 */
		public function set target (value:Object) : void;
		/**
		 *  @copy mx.effects.IEffect#targets
		 */
		public function get targets () : Array;
		/**
		 *  @private
		 */
		public function set targets (value:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#triggerEvent
		 */
		public function get triggerEvent () : Event;
		/**
		 *  @private
		 */
		public function set triggerEvent (value:Event) : void;

		/**
		 *  @private
		 */
		private static function mergeArrays (a1:Array, a2:Array) : Array;
		/**
		 *  @private
		 */
		private static function stripUnchangedValues (propChanges:Array) : Array;
		/**
		 *  Constructor.     *     *  <p>Starting an effect is usually a three-step process:</p>     *     *  <ul>     *    <li>Create an instance of the effect object     *    with the <code>new</code> operator.</li>     *    <li>Set properties on the effect object,     *    such as <code>duration</code>.</li>     *    <li>Call the <code>play()</code> method     *    or assign the effect to a trigger.</li>     *  </ul>     *     *  @param target The Object to animate with this effect.
		 */
		public function Effect (target:Object = null);
		/**
		 *  @copy mx.effects.IEffect#getAffectedProperties()
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  @copy mx.effects.IEffect#createInstances()
		 */
		public function createInstances (targets:Array = null) : Array;
		/**
		 *  @copy mx.effects.IEffect#createInstance()
		 */
		public function createInstance (target:Object = null) : IEffectInstance;
		/**
		 *  Copies properties of the effect to the effect instance.      *     *  <p>Flex calls this method from the <code>Effect.createInstance()</code>     *  method; you do not have to call it yourself. </p>     *     *  <p>When you create a custom effect, override this method to      *  copy properties from the Effect class to the effect instance class.      *  In your override, you must call <code>super.initInstance()</code>. </p>     *     *  @param EffectInstance The effect instance to initialize.
		 */
		protected function initInstance (instance:IEffectInstance) : void;
		/**
		 *  @copy mx.effects.IEffect#deleteInstance()
		 */
		public function deleteInstance (instance:IEffectInstance) : void;
		/**
		 *  @copy mx.effects.IEffect#play()
		 */
		public function play (targets:Array = null, playReversedFromEnd:Boolean = false) : Array;
		/**
		 *  @copy mx.effects.IEffect#pause()
		 */
		public function pause () : void;
		/**
		 *  @copy mx.effects.IEffect#stop()
		 */
		public function stop () : void;
		/**
		 *  @copy mx.effects.IEffect#resume()
		 */
		public function resume () : void;
		/**
		 *  @copy mx.effects.IEffect#reverse()
		 */
		public function reverse () : void;
		/**
		 *  @copy mx.effects.IEffect#end()
		 */
		public function end (effectInstance:IEffectInstance = null) : void;
		/**
		 *  Determines the logic for filtering out an effect instance.     *  The CompositeEffect class overrides this method.     *     *  @param propChanges The properties modified by the effect.     *     *  @param targ The effect target.     *     *  @return Returns <code>true</code> if the effect instance should play.
		 */
		protected function filterInstance (propChanges:Array, target:Object) : Boolean;
		/**
		 *  @copy mx.effects.IEffect#captureStartValues()
		 */
		public function captureStartValues () : void;
		/**
		 *  @copy mx.effects.IEffect#captureMoreStartValues()
		 */
		public function captureMoreStartValues (targets:Array) : void;
		/**
		 *  @copy mx.effects.IEffect#captureEndValues()
		 */
		public function captureEndValues () : void;
		/**
		 *  @private     *  Used internally to grab the values of the relevant properties
		 */
		function captureValues (propChanges:Array, setStartValues:Boolean) : Array;
		/**
		 *  Called by the <code>captureStartValues()</code> method to get the value     *  of a property from the target.     *  This function should only be called internally     *  by the effects framework.     *  The default behavior is to simply return <code>target[property]</code>.     *  Effect developers can override this function     *  if you need a different behavior.      *     *  @param target The effect target.     *     *  @param property The target property.     *     *  @return The value of the target property.
		 */
		protected function getValueFromTarget (target:Object, property:String) : *;
		/**
		 *  @private     *  Applies the start values found in the array of PropertyChanges     *  to the relevant targets.
		 */
		function applyStartValues (propChanges:Array, targets:Array) : void;
		/**
		 *  Used internally by the Effect infrastructure.     *  If <code>captureStartValues()</code> has been called,     *  then when Flex calls the <code>play()</code> method, it uses this function     *  to set the targets back to the starting state.     *  The default behavior is to take the value captured     *  using the <code>getValueFromTarget()</code> method     *  and set it directly on the target's property. For example: <pre>     *       *  target[property] = value;</pre>     *     *  <p>Only override this method if you need to apply     *  the captured values in a different way.     *  Note that style properties of a target are set     *  using a different mechanism.     *  Use the <code>relevantStyles</code> property to specify     *  which style properties to capture and apply. </p>     *     *  @param target The effect target.     *     *  @param property The target property.     *     *  @param value The value of the property.      *     *  @param props Array of Objects, where each Array element contains a      *  <code>start</code> and <code>end</code> Object     *  for the properties that the effect is monitoring.
		 */
		protected function applyValueToTarget (target:Object, property:String, value:*, props:Object) : void;
		/**
		 *  This method is called when the effect instance starts playing.      *  If you override this method, ensure that you call the super method.      *     *  @param event An event object of type EffectEvent.
		 */
		protected function effectStartHandler (event:EffectEvent) : void;
		/**
		 *  Called when an effect instance has finished playing.      *  If you override this method, ensure that you call the super method.     *     *  @param event An event object of type EffectEvent.
		 */
		protected function effectEndHandler (event:EffectEvent) : void;
	}
}
