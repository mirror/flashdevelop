package mx.states
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.core.ComponentDescriptor;
	import mx.core.UIComponent;

	/**
	 *  The event handler function to execute in response to the event that is
 *  specified by the <code>name</code> property. 
 *
 *  <p>Do not specify the <code>handler</code> property and the <code>handlerFunction</code>
 *  property in a single <code>&lt;mx:SetEventHandler&gt;</code> tag.</p>
 *
 *  <p>Flex does <i>not</i> dispatch a <code>handler</code> event.
 *  You use the <code>handler</code> key word only as an MXML attribte. 
 *  When you use the <code>handler</code> handler attribute, you can specify a 
 *  method that takes multiple parameters, not just the Event object;
 *  also, you can specify the handler code in-line in the MXML tag.</p>
	 */
	[Event(name="handler", type="Object")] 

include "../core/Version.as"
	/**
	 *  The SetEventHandler class specifies an event handler that is active 
 *  only during a particular view state.
 *  For example, you might define a Button control that uses one event handler 
 *  in the base view state, but uses a different event handler when you change view state.
 *
 *  <p> You use this class in the <code>overrides</code> property of the State class.</p>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:SetEventHanlder&gt;</code> tag
 *  has the following attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:SetEventHandler
 *  <b>Properties</b>
 *  name="null"
 *  handlerFunction="null"
 *  target="null"
 *  
 *  <b>Events</b>
 *  handler=<i>No default</i>
 *  /&gt;
 *  </pre>
 *
 *  @see mx.states.State
 *  @see mx.states.SetProperty
 *  @see mx.states.SetStyle
	 */
	public class SetEventHandler extends EventDispatcher implements IOverride
	{
		/**
		 *  @private
	 *  Storage for the old event handler value.
		 */
		private var oldHandlerFunction : Function;
		/**
		 *  @private
	 *	Dictionary of installed event handlers.
		 */
		private static var installedHandlers : Dictionary;
		/**
		 *  The name of the event whose handler is being set.
	 *  You must set this property, either in 
	 *  the SetEventHandler constructor or by setting
	 *  the property value directly.
		 */
		public var name : String;
		/**
		 *  The handler function for the event.
	 *  This property is intended for developers who use ActionScript to
	 *  create and access view states.
	 *  In MXML, you can use the equivalent <code>handler</code>
	 *  event attribute; do not use both in a single MXML tag.
	 *  
	 *  @default null
		 */
		public var handlerFunction : Function;
		/**
		 *  The component that dispatches the event.
	 *  If the property value is <code>null</code>, Flex uses the
     *  immediate parent of the <code>&lt;mx:states&gt;</code> tag.
     *
	 *  @default null
		 */
		public var target : EventDispatcher;

		/**
		 *  Constructor.
	 *
	 *  @param target The object that dispatches the event to be handled.
	 *  By default, Flex uses the immediate parent of the State object.
	 *
	 *  @param event The event type for which to set the handler.
		 */
		public function SetEventHandler (target:EventDispatcher = null, name:String = null);

		/**
		 *  @private
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

		/**
		 *  IOverride interface method; this class implements it as an empty method.
	 * 
	 *  @copy IOverride#initialize()
		 */
		public function initialize () : void;

		/**
		 *  @inheritDoc
		 */
		public function apply (parent:UIComponent) : void;

		/**
		 *  @inheritDoc
		 */
		public function remove (parent:UIComponent) : void;
	}
}
