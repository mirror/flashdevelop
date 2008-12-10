package mx.states
{
	import flash.display.DisplayObject;
	import mx.containers.ApplicationControlBar;
	import mx.containers.ControlBar;
	import mx.containers.Panel;
	import mx.core.Application;
	import mx.core.ContainerCreationPolicy;
	import mx.core.IDeferredInstance;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The AddChild class adds a child display object, such as a component,  *  to a container as part of a view state.  *  You use this class in the <code>overrides</code> property of the State class. *  Use the <code>creationPolicy</code> property to specify to create the child  *  at application startup or when you change to a view state.  *   *  <p>The child does not dispatch the <code>creationComplete</code> event until  *  it is added to a container. For example, the following code adds a  *  Button control as part of a view state change:</p> *  *  <pre> *  &lt;mx:AddChild relativeTo="{v1}"&gt; *      &lt;mx:Button id="b0" label="New Button"/&gt; *  &lt;/mx:AddChild&gt; </pre> * *  <p>In the previous example, the Button control does not dispatch  *  the <code>creationComplete</code> event until you change state and the  *  Button control is added to a container.  *  If the AddChild class defines both the Button and a container, such as a Canvas container,  *  then the Button control dispatches the creationComplete event when it is created.  *  For example, if the <code>creationPolicy</code> property is set to <code>all</code>,  *  the Button control dispatches the event at application startup.  *  If the <code>creationPolicy</code> property is set to <code>auto</code>, *  the Button control dispatches the event when you change to the view state. </p> * *  @mxml * *  <p>The <code>&lt;mx:AddChild&gt;</code> tag *  has the following attributes:</p> *   *  <pre> *  &lt;mx:AddChild *  <b>Properties</b> *  target="null" *  targetFactory="null" *  creationPolicy="auto" *  position="lastChild" *  relativeTo="<i>parent of the State object</i>" *  /&gt; *  </pre> * *  @see mx.states.State *  @see mx.states.RemoveChild *  @see mx.states.Transition  *  @see mx.effects.AddChildAction * *  @includeExample examples/StatesExample.mxml
	 */
	public class AddChild implements IOverride
	{
		/**
		 *  @private
		 */
		local var added : Boolean;
		/**
		 *  @private
		 */
		local var instanceCreated : Boolean;
		/**
		 *  @private     *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private     *  Storage for the creationPolicy property.
		 */
		private var _creationPolicy : String;
		/**
		 *  The position of the child in the display list, relative to the     *  object specified by the <code>relativeTo</code> property.     *  Valid values are <code>"before"</code>, <code>"after"</code>,      *  <code>"firstChild"</code>, and <code>"lastChild"</code>.     *     *  @default "lastChild"
		 */
		public var position : String;
		/**
		 *  The object relative to which the child is added. This property is used     *  in conjunction with the <code>position</code> property.      *  This property is optional; if     *  you omit it, Flex uses the immediate parent of the <code>State</code>     *  object, that is, the component that has the <code>states</code>     *  property, or <code>&lt;mx:states&gt;</code>tag that specifies the State     *  object.
		 */
		public var relativeTo : UIComponent;
		/**
		 *  @private     *  Storage for the target property
		 */
		private var _target : DisplayObject;
		/**
		 *  @private     *  Storage for the targetFactory property.
		 */
		private var _targetFactory : IDeferredInstance;

		/**
		 *  The creation policy for this child.     *  This property determines when the <code>targetFactory</code> will create      *  the instance of the child.     *  Flex uses this properthy only if you specify a <code>targetFactory</code> property.     *  The following values are valid:     *      *  <p></p>     * <table class="innertable">     *     <tr><th>Value</th><th>Meaning</th></tr>     *     <tr><td><code>auto</code></td><td>(default)Create the instance the      *         first time it is needed.</td></tr>     *     <tr><td><code>all</code></td><td>Create the instance when the      *         application started up.</td></tr>     *     <tr><td><code>none</code></td><td>Do not automatically create the instance.      *         You must call the <code>createInstance()</code> method to create      *         the instance.</td></tr>     * </table>     *     *  @default "auto"
		 */
		public function get creationPolicy () : String;
		/**
		 *  @private
		 */
		public function set creationPolicy (value:String) : void;
		/**
		 *     *  The child to be added.     *  If you set this property, the child instance is created at app startup.     *  Setting this property is equivalent to setting a <code>targetFactory</code>     *  property with a <code>creationPolicy</code> of <code>"all"</code>.     *     *  <p>Do not set this property if you set the <code>targetFactory</code>     *  property.</p>
		 */
		public function get target () : DisplayObject;
		/**
		 *  @private
		 */
		public function set target (value:DisplayObject) : void;
		/**
		 *     * The factory that creates the child. You can specify either of the following items:     *  <ul>     *      <li>A factory class that implements the IDeferredInstance     *          interface and creates the child instance or instances.     *      </li>     *      <li>A Flex component, (that is, any class that is a subclass     *          of the UIComponent class), such as the Button contol.     *          If you use a Flex component, the Flex compiler automatically     *          wraps the component in a factory class.     *      </li>     *  </ul>     *     *  <p>If you set this property, the child is instantiated at the time     *  determined by the <code>creationPolicy</code> property.</p>     *       *  <p>Do not set this property if you set the <code>target</code>     *  property.     *  This propety is the <code>AddChild</code> class default property.     *  Setting this property with a <code>creationPolicy</code> of "all"     *  is equivalent to setting a <code>target</code> property.</p>
		 */
		public function get targetFactory () : IDeferredInstance;
		/**
		 *  @private
		 */
		public function set targetFactory (value:IDeferredInstance) : void;

		/**
		 *  Constructor.     *     *  @param relativeTo The component relative to which child is added.     *     *  @param target The child object.     *  All Flex components are subclasses of the DisplayObject class.     *     *  @param position the location in the display list of the <code>target</code>     *  relative to the <code>relativeTo</code> component. Must be one of the following:     *  "firstChild", "lastChild", "before" or "after".
		 */
		public function AddChild (relativeTo:UIComponent = null, target:DisplayObject = null, position:String = "lastChild");
		/**
		 *  Creates the child instance from the factory.     *  You must use this method only if you specify a <code>targetFactory</code>     *  property and a <code>creationPolicy</code> value of <code>"none"</code>.     *  Flex automatically calls this method if the <code>creationPolicy</code>     *  property value is <code>"auto"</code> or <code>"all"</code>.     *  If you call this method multiple times, the child instance is     *  created only on the first call.
		 */
		public function createInstance () : void;
		/**
		 *  @inheritDoc
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
