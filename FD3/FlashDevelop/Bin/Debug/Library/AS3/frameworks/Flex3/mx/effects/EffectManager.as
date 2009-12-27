package mx.effects
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.utils.Dictionary;
	import mx.core.ApplicationGlobals;
	import mx.core.EventPriority;
	import mx.core.IDeferredInstantiationUIComponent;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.UIComponentCachePolicy;
	import mx.core.mx_internal;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.effects.Effect;
	import mx.effects.EffectInstance;

include "../core/Version.as"
	/**
	 *  The EffectManager class listens for events, such as the <code>show</code>
 *  and <code>move</code> events, dispatched by objects in a Flex application.
 *  For each event, corresponding to an event trigger, it determines if 
 *  there is an effect assigned to the object. 
 *  If an effect is defined, it plays the effect.
	 */
	public class EffectManager extends EventDispatcher
	{
		/**
		 *  @private
	 *  Keeps track of all the triggered effects that are currently playing.
		 */
		static var effectsPlaying : Array;
		/**
		 *  @private
	 *  Map with event type as key and effectTrigger as value.
		 */
		private static var effectTriggersForEvent : Object;
		/**
		 *  @private
	 *  Map with effectTrigger as key and event type as value.
		 */
		private static var eventsForEffectTriggers : Object;
		/**
		 *  @private
	 *  Array containing miscellaneous info about effect targets.
	 *  An element in the array is an Object with three fields:
	 *  target - reference to the target
	 *  bitmapEffectsCount - number of bitmap effects
	 *                       currently playing on the target
	 *  vectorEffectsCount - number of vector effects
	 *                       currently playing on the target
		 */
		private static var targetsInfo : Array;
		/**
		 *  @private
	 *  Remember when suspendEventHandling() has been called
	 *  without a matching resumeEventHandling().
		 */
		private static var eventHandlingSuspendCount : Number;
		/**
		 *  @private
		 */
		static var lastEffectCreated : Effect;
		/**
		 *  @private
	 *  Storage for the resourceManager getter.
	 *  This gets initialized on first access,
	 *  not at static initialization time, in order to ensure
	 *  that the Singleton registry has already been initialized.
		 */
		private static var _resourceManager : IResourceManager;
		private static var effects : Dictionary;

		/**
		 *  @private
     *  A reference to the object which manages
     *  all of the application's localized resources.
     *  This is a singleton instance which implements
     *  the IResourceManager interface.
		 */
		private static function get resourceManager () : IResourceManager;

		/**
		 *  After this method is called, the EffectManager class ignores
	 *  all events, and no effects are triggered, until a call to
	 *  <code>resumeEventHandling()</code>.  
	 *  Used internally so that an effect that is updating the screen
	 *  does not cause another effect to be triggered.
		 */
		public static function suspendEventHandling () : void;

		/**
		 *  Allows the EffectManager class to resume processing events
	 *  after a call to the <code>suspendEventHandling()</code> method.
	 *  Used internally in conjunction with the
	 *  <code>suspendEventHandling()</code> method 
	 *  so that an effect that is updating the screen
	 *  does not cause another effect to be triggered.
		 */
		public static function resumeEventHandling () : void;

		/**
		 *  Immediately ends any effects currently playing on a target.
	 *
	 *  @param target The target component on which to end all effects.
		 */
		public static function endEffectsForTarget (target:IUIComponent) : void;

		/**
		 *  @private
		 */
		static function setStyle (styleProp:String, target:*) : void;

		/**
		 *  @private
	 *  Internal function used to instantiate an effect
		 */
		static function createEffectForType (target:Object, type:String) : Effect;

		/**
		 *  @private
	 *  Internal function used while playing effects
		 */
		private static function animateSameProperty (a:Effect, b:Effect, c:EffectInstance) : Boolean;

		/**
		 *  @private
	 *  Should be called by an effect instance before it starts playing,
	 *  to suggest bitmap caching on the target.
	 *  E.g. Fade calls this function in its play().
		 */
		static function startBitmapEffect (target:IUIComponent) : void;

		/**
		 *  @private
	 *  Should be called by an effect instance after it has finished playing,
	 *  to suggest that the cached bitmap for the target can be freed.
	 *  E.g. Fade calls this function in its onTweenEnd().
		 */
		static function endBitmapEffect (target:IUIComponent) : void;

		/**
		 *  @private
	 *  Should be called by an effect instance before it starts playing, to
	 *  suggest that bitmap caching should be turned off on the target.
	 *  E.g. Resize calls this function in its play().
		 */
		static function startVectorEffect (target:IUIComponent) : void;

		/**
		 *  @private
	 *  Should be called by an effect instance after it has finished playing,
	 *  to suggest that bitmap caching may be turned back on on the target.
	 *  E.g. Resize calls this function in its onTweenEnd().
		 */
		static function endVectorEffect (target:IUIComponent) : void;

		/**
		 *  @private
	 *  Cache or uncache the target as a bitmap depending on which effects are
	 *  currently playing on the target.
	 *
	 *  @param target The effect target.
	 *
	 *  @param effectStart Whether this is the starting of the effect.
	 *  false means it's the ending of the effect.
	 *
	 *  @param bitmapEffect Whether this is a bitmap effect.
	 *  false means it's a vector effect (like resize, zoom, etc.)
	 *  that wants the target object to be uncached.
		 */
		private static function cacheOrUncacheTargetAsBitmap (target:IUIComponent, effectStart:Boolean = true, bitmapEffect:Boolean = true) : void;

		/**
		 *  @private
	 *  Called in code generated by MXML compiler.
		 */
		static function registerEffectTrigger (name:String, event:String) : void;

		/**
		 *  @private
		 */
		static function getEventForEffectTrigger (effectTrigger:String) : String;

		/**
		 *  @private
		 */
		static function eventHandler (eventObj:Event) : void;

		/**
		 *  @private
		 */
		private static function createAndPlayEffect (eventObj:Event, target:Object) : void;

		/**
		 *  @private
	 *  Delayed function call when effect is triggered by "removed" event
		 */
		private static function removedEffectHandler (target:DisplayObject, parent:DisplayObjectContainer, index:int, eventObj:Event) : void;

		/**
		 *  @private
	 *  Internal function used while playing effects
		 */
		static function effectEndHandler (event:EffectEvent) : void;

		static function effectStarted (effect:EffectInstance) : void;

		static function effectFinished (effect:EffectInstance) : void;

		static function effectsInEffect () : Boolean;
	}
	/**
	 *  @private
	 */
	private class EffectNode
	{
		/**
		 *  @private
		 */
		public var factory : Effect;
		/**
		 *  @private
		 */
		public var instance : EffectInstance;

		/**
		 *  Constructor.
		 */
		public function EffectNode (factory:Effect, instance:EffectInstance);
	}
}
