package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.containers.Box;
	import mx.containers.BoxDirection;
	import mx.containers.ViewStack;
	import mx.core.ClassFactory;
	import mx.core.Container;
	import mx.core.FlexVersion;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.CollectionEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ItemClickEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.logging.AbstractTarget;

	/**
	 *  Dispatched when a navigation item is selected. * *  @eventType mx.events.ItemClickEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.ItemClickEvent")] 

	/**
	 *  The NavBar control is the superclass for navigator controls, such as the *  LinkBar and TabBar controls, and cannot be instantiated directly. * *  @mxml * *  <p>The <code><mx:NavBar></code> tag inherits all of the tag attributes *  of its superclass, with the exception of scrolling-related *  attributes, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:<i>tagname</i> *    <strong>Properties</strong> *    dataProvider="<i>No default</i>" *    iconField="icon" *    labeField="label" *    selectedIndex="-1" *    toolTipField="toolTip" *      *    <strong>Events</strong> *    itemClick="<i>No default</i>" *    &gt; *     ... *       <i>child tags</i> *     ... *    &lt;/mx:<i>tagname</i>&gt; *  </pre> * *  @see mx.collections.IList *  @see mx.containers.ViewStack *  @see mx.controls.LinkBar *  @see mx.controls.TabBar *  @see mx.controls.ButtonBar *
	 */
	public class NavBar extends Box
	{
		/**
		 *  @private     *  The target ViewStack.     *  If this is null, the dataProvider is an Array.
		 */
		local var targetStack : ViewStack;
		/**
		 *  @private     *  This variable is set when the NavBar is still initializing and the     *  dataProvider is set to a ViewStack (or a String that might identify     *  a ViewStack in the parent document).
		 */
		private var pendingTargetStack : Object;
		/**
		 *  @private     *  The factory that generates the instances of the navigation items.     *  It generates instances of ButtonBarButton for ButtonBar and     *  ToggleButtonBar, of LinkButton for LinkBar, and of Tab for TabBar.     *  This var is expected to be set before the navigation items are created;     *  setting it does not re-create existing navigation items based on the     *  new factory.
		 */
		local var navItemFactory : IFactory;
		/**
		 *  @private     *  allows us to null out child containers' toolTips without descending     *  into recursive madness.
		 */
		private var lastToolTip : String;
		/**
		 *  @private
		 */
		private var measurementHasBeenCalled : Boolean;
		/**
		 *  @private     *  Storage for the dataProvider property.
		 */
		private var _dataProvider : IList;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private     *  Storage for the iconField property.
		 */
		private var _iconField : String;
		/**
		 *  @private     *  Storage for the <code>labelField</code> property.
		 */
		private var _labelField : String;
		/**
		 *  @private     *  Storage for labelFunction property.
		 */
		private var _labelFunction : Function;
		/**
		 *  @private     *  Storage for the selectedIndex property.
		 */
		private var _selectedIndex : int;
		/**
		 *  @private     *  Storage for the toolTipField property.
		 */
		private var _toolTipField : String;

		/**
		 *  @private     *  The baselinePosition of a NavBar is calculated	 *  for the label of the first nav item. 	 *  If there are no nav items, the NavBar doesn't appear	 *  and the baselinePosition is irrelevant.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private     *  The NavBar control's <code>horizontalScrollPolicy</code> is always     *  <code>ScrollPolicy.OFF</code>.     *  It cannot be set to any other value.
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private     *  The NavBar control's <code>verticalScrollPolicy</code> is always     *  <code>ScrollPolicy.OFF</code>.     *  It cannot be set to any other value.
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 *  Data used to populate the navigator control.     *  The type of data can either be a ViewStack container or an Array.     *     *  <p>When you use a ViewStack container, the <code>label</code>     *  and <code>icon</code> properties of the ViewStack container's children     *  are used to populate the navigation items,     *  as in the following example:</p>     *      *  <pre>     *  &lt;mx:LinkBar dataProvider="{vs}"/&gt;     *  &lt;mx:ViewStack id="vs"&gt;     *    &lt;mx:VBox label="Accounts" icon="account_icon"/&gt;     *    &lt;mx:VBox label="Leads" icon="leads_icon"/&gt;     *  &lt;/mx:ViewStack&gt; </pre>     *       *  <p>The LinkBar control contains two links: "Accounts" and "Leads,"     *  each with its own icon as specified on the VBox tags.     *  When you click a link, the ViewStack container navigates     *  to the corresponding view.</p>     *     *  <p>When you use an Array, the <code>labelField</code> property     *  determines the name of the <code>dataProvider</code> field     *  to use as the label for each navigation item; the <code>iconField</code>     *  property determines the name of the <code>dataProvider</code> field     *  to use as the icon for each navigation item.      *  If you use an Array of Strings, the <code>labelField</code>     *  property is ignored.</p>     *     *  @default "undefined"
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  Name of the field in the <code>dataProvider</code> object     *  to display as the icon for each navigation item.      *     *  @default "icon"
		 */
		public function get iconField () : String;
		/**
		 *  @private
		 */
		public function set iconField (value:String) : void;
		/**
		 *  Name of the field in the <code>dataProvider</code> object     *  to display as the label for each navigation item.      *     *  @default "label"
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  A user-supplied function to run on each item to determine its label.       *  By default, the component looks for a property named <code>label</code>      *  on each data provider item and displays it.     *  However, some data sets do not have a <code>label</code> property     *  nor do they have another property that can be used for displaying.     *  An example is a data set that has lastName and firstName fields     *  but you want to display full names.     *     *  <p>You can supply a <code>labelFunction</code> that finds the      *  appropriate fields and returns a displayable string. The      *  <code>labelFunction</code> is also good for handling formatting and      *  localization. </p>     *     *  <p>For most components, the label function takes a single argument     *  which is the item in the data provider and returns a String.</p>     *  <pre>     *  myLabelFunction(item:Object):String</pre>     *     *     *  @default null
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  Index of the active navigation item,     *  where the first item is at an index of 0.     *     *  @default -1
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  Name of the the field in the <code>dataProvider</code> object     *  to display as the tooltip label.     *       *  @default "toolTip"
		 */
		public function get toolTipField () : String;
		/**
		 *  @private
		 */
		public function set toolTipField (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function NavBar ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private     *  Always do a recursive notification since our content children may have us as     *  the styleName.
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  Returns the string the renderer would display for the given data object     *  based on the labelField and labelFunction properties.     *  If the method cannot convert the parameter to a string, it returns a     *  single space.     *     *  @param data Object to be rendered.     *     *  @return The string to be displayed based on the data.
		 */
		public function itemToLabel (data:Object) : String;
		/**
		 *  Creates the individual navigator items.       *      *  By default, this method performs no action.      *  You can override this method in a      *  subclass to create a navigator item based on the type of      *  navigator items in your subclass.     *     *  @param label The label for the created navigator item.      *     *  @param icon The icon for the created navigator item.      *  Typically, this is an icon that you have embedded in the application.     *     *  @return The created navigator item.
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;
		/**
		 *  Highlights the selected navigator item.      *      *  By default, this method performs no action.      *  You can override this method in a subclass to      *  highlight the selected navigator item.     *     *  @param index The index of the selected item in the NavBar control.     *  The first item is at an index of 0.
		 */
		protected function hiliteSelectedNavItem (index:int) : void;
		/**
		 *  Resets the navigator bar to its default state.     *      *  By default, this method performs no action.      *  You can override this method in a subclass to      *  reset the navigator bar to a default state.
		 */
		protected function resetNavItems () : void;
		/**
		 *  Sets the label property of a navigator item in the      *  NavBar control.      *      *  You can override this method in a subclass to      *  set the label of a navigator item based on the type of      *  navigator items in your subclass.     *     *  @param index The index of the navigator item in the NavBar control.     *  The first navigator item is at an index of 0.     *     *  @param label The new label text for the navigator item.
		 */
		protected function updateNavItemLabel (index:int, label:String) : void;
		/**
		 *  Resets the icon of a navigator item in the      *  NavBar control.      *      *  You can override this method in a subclass to      *  set the icon of a navigator item based on the type of      *  navigator items in your subclass.     *     *  @param index The index of the navigator item in the NavBar control.     *  The first navigator item is at an index of 0.     *     *  @param icon The new icon for the navigator item.      *  Typically, this is an icon that you have embedded in the application.
		 */
		protected function updateNavItemIcon (index:int, icon:Class) : void;
		/**
		 *  @private
		 */
		private function createNavChildren () : void;
		/**
		 *  @private
		 */
		private function setTargetViewStack (newStack:Object) : void;
		/**
		 *  @private
		 */
		private function _setTargetViewStack (newStack:Object) : void;
		/**
		 *  @private
		 */
		private function checkPendingTargetStack () : void;
		/**
		 *  @private
		 */
		private function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function childAddHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function childIndexChangeHandler (event:IndexChangedEvent) : void;
		/**
		 *  @private
		 */
		private function labelChangedHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function iconChangedHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function toolTipChangedHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function enabledChangedHandler (event:Event) : void;
		/**
		 *  Handles the <code>MouseEvent.CLICK</code> event      *  for the items in the NavBar control. This handler     *  dispatches the <code>itemClick</code> event for the NavBar control.     *     *  @param event The event object.
		 */
		protected function clickHandler (event:MouseEvent) : void;
	}
}
