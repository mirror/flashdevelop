/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import mx.managers.IFocusManagerContainer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.scrollClasses.ScrollBar;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	public class Container extends UIComponent implements IContainer, IDataRenderer, IFocusManagerContainer, IListItemRenderer, IRawChildrenContainer {
		/**
		 * The creation policy of this container.
		 *  This property is useful when the container inherits its creation policy
		 *  from its parent container.
		 */
		protected var actualCreationPolicy:String;
		/**
		 * If true, measurement and layout are done
		 *  when the position or size of a child is changed.
		 *  If false, measurement and layout are done only once,
		 *  when children are added to or removed from the container.
		 */
		public function get autoLayout():Boolean;
		public function set autoLayout(value:Boolean):void;
		/**
		 * Returns an EdgeMetrics object that has four properties:
		 *  left, top, right,
		 *  and bottom.
		 *  The value of each property is equal to the thickness of one side
		 *  of the border, expressed in pixels.
		 */
		public function get borderMetrics():EdgeMetrics;
		/**
		 * Array of UIComponentDescriptor objects produced by the MXML compiler.
		 */
		public function get childDescriptors():Array;
		/**
		 * Whether to apply a clip mask if the positions and/or sizes
		 *  of this container's children extend outside the borders of
		 *  this container.
		 *  If false, the children of this container
		 *  remain visible when they are moved or sized outside the
		 *  borders of this container.
		 *  If true, the children of this container are clipped.
		 */
		public function get clipContent():Boolean;
		public function set clipContent(value:Boolean):void;
		/**
		 * Returns the x position of the mouse, in the content coordinate system.
		 *  Content coordinates specify a pixel position relative to the upper left
		 *  corner of the component's content, and include all of the component's
		 *  content area, including any regions that are currently clipped and must
		 *  be accessed by scrolling the component.
		 */
		public function get contentMouseX():Number;
		/**
		 * Returns the y position of the mouse, in the content coordinate system.
		 *  Content coordinates specify a pixel position relative to the upper left
		 *  corner of the component's content, and include all of the component's
		 *  content area, including any regions that are currently clipped and must
		 *  be accessed by scrolling the component.
		 */
		public function get contentMouseY():Number;
		/**
		 * Containers use an internal content pane to control scrolling.
		 *  The creatingContentPane is true while the container is creating
		 *  the content pane so that some events can be ignored or blocked.
		 */
		public function get creatingContentPane():Boolean;
		public function set creatingContentPane(value:Boolean):void;
		/**
		 * Specifies the order to instantiate and draw the children
		 *  of the container.
		 */
		public function get creationIndex():int;
		public function set creationIndex(value:int):void;
		/**
		 * The child creation policy for this Container.
		 *  ActionScript values can be ContainerCreationPolicy.AUTO,
		 *  ContainerCreationPolicy.ALL,
		 *  ContainerCreationPolicy.NONE,
		 *  or ContainerCreationPolicy.QUEUED.
		 *  MXML values can be "auto", "all",
		 *  "none", or "queued".
		 */
		public function get creationPolicy():String;
		public function set creationPolicy(value:String):void;
		/**
		 * The data property lets you pass a value
		 *  to the component when you use it in an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The Button control designated as the default button
		 *  for the container.
		 *  When controls in the container have focus, pressing the
		 *  Enter key is the same as clicking this Button control.
		 */
		public function get defaultButton():IFlexDisplayObject;
		public function set defaultButton(value:IFlexDisplayObject):void;
		/**
		 * Number of pixels to move when the left- or right-arrow
		 *  button in the horizontal scroll bar is pressed.
		 */
		public function get horizontalLineScrollSize():Number;
		public function set horizontalLineScrollSize(value:Number):void;
		/**
		 * Number of pixels to move when the track in the
		 *  horizontal scroll bar is pressed.
		 *  A value of 0 means that the page size
		 *  will be calculated to be a full screen.
		 */
		public function get horizontalPageScrollSize():Number;
		public function set horizontalPageScrollSize(value:Number):void;
		/**
		 * The horizontal scrollbar used in this container.
		 *  This property is null if no horizontal scroll bar
		 *  is currently displayed.
		 *  In general you do not access this property directly.
		 *  Manipulation of the horizontalScrollPolicy
		 *  and horizontalScrollPosition
		 *  properties should provide sufficient control over the scroll bar.
		 */
		public function get horizontalScrollBar():ScrollBar;
		public function set horizontalScrollBar(value:ScrollBar):void;
		/**
		 * Specifies whether the horizontal scroll bar is always present,
		 *  always absent, or automatically added when needed.
		 *  ActionScript values can be ScrollPolicy.ON, ScrollPolicy.OFF,
		 *  and ScrollPolicy.AUTO.
		 *  MXML values can be "on", "off",
		 *  and "auto".
		 */
		public function get horizontalScrollPolicy():String;
		public function set horizontalScrollPolicy(value:String):void;
		/**
		 * The current position of the horizontal scroll bar.
		 *  This is equal to the distance in pixels between the left edge
		 *  of the scrollable surface and the leftmost piece of the surface
		 *  that is currently visible.
		 */
		public function get horizontalScrollPosition():Number;
		public function set horizontalScrollPosition(value:Number):void;
		/**
		 * The Class of the icon displayed by some navigator
		 *  containers to represent this Container.
		 */
		public function get icon():Class;
		public function set icon(value:Class):void;
		/**
		 * The text displayed by some navigator containers to represent
		 *  this Container.
		 */
		public function get label():String;
		public function set label(value:String):void;
		/**
		 * The largest possible value for the
		 *  horizontalScrollPosition property.
		 *  Defaults to 0 if the horizontal scrollbar is not present.
		 */
		public function get maxHorizontalScrollPosition():Number;
		/**
		 * The largest possible value for the
		 *  verticalScrollPosition property.
		 *  Defaults to 0 if the vertical scrollbar is not present.
		 */
		public function get maxVerticalScrollPosition():Number;
		/**
		 * Number of child components in this container.
		 */
		public function get numChildren():int;
		/**
		 * A container typically contains child components, which can be enumerated
		 *  using the Container.getChildAt() method and
		 *  Container.numChildren property.  In addition, the container
		 *  may contain style elements and skins, such as the border and background.
		 *  Flash Player and AIR do not draw any distinction between child components
		 *  and skins.  They are all accessible using the player's
		 *  getChildAt() method  and
		 *  numChildren property.
		 *  However, the Container class overrides the getChildAt() method
		 *  and numChildren property (and several other methods)
		 *  to create the illusion that
		 *  the container's children are the only child components.
		 */
		public function get rawChildren():IChildList;
		/**
		 * Number of pixels to scroll when the up- or down-arrow
		 *  button in the vertical scroll bar is pressed,
		 *  or when you scroll by using the mouse wheel.
		 */
		public function get verticalLineScrollSize():Number;
		public function set verticalLineScrollSize(value:Number):void;
		/**
		 * Number of pixels to scroll when the track
		 *  in the vertical scroll bar is pressed.
		 *  A value of 0 means that the page size
		 *  will be calculated to be a full screen.
		 */
		public function get verticalPageScrollSize():Number;
		public function set verticalPageScrollSize(value:Number):void;
		/**
		 * The vertical scrollbar used in this container.
		 *  This property is null if no vertical scroll bar
		 *  is currently displayed.
		 *  In general you do not access this property directly.
		 *  Manipulation of the verticalScrollPolicy
		 *  and verticalScrollPosition
		 *  properties should provide sufficient control over the scroll bar.
		 */
		public function get verticalScrollBar():ScrollBar;
		public function set verticalScrollBar(value:ScrollBar):void;
		/**
		 * Specifies whether the vertical scroll bar is always present,
		 *  always absent, or automatically added when needed.
		 *  Possible values are ScrollPolicy.ON, ScrollPolicy.OFF,
		 *  and ScrollPolicy.AUTO.
		 *  MXML values can be "on", "off",
		 *  and "auto".
		 */
		public function get verticalScrollPolicy():String;
		public function set verticalScrollPolicy(value:String):void;
		/**
		 * The current position of the vertical scroll bar.
		 *  This is equal to the distance in pixels between the top edge
		 *  of the scrollable surface and the topmost piece of the surface
		 *  that is currently visible.
		 */
		public function get verticalScrollPosition():Number;
		public function set verticalScrollPosition(value:Number):void;
		/**
		 * Returns an object that has four properties: left,
		 *  top, right, and bottom.
		 *  The value of each property equals the thickness of the chrome
		 *  (visual elements) around the edge of the container.
		 */
		public function get viewMetrics():EdgeMetrics;
		/**
		 * Returns an object that has four properties: left,
		 *  top, right, and bottom.
		 *  The value of each property is equal to the thickness of the chrome
		 *  (visual elements)
		 *  around the edge of the container plus the thickness of the object's margins.
		 */
		public function get viewMetricsAndPadding():EdgeMetrics;
		/**
		 * Constructor.
		 */
		public function Container();
		/**
		 * Adds a child DisplayObject to this Container.
		 *  The child is added after other existing children,
		 *  so that the first child added has index 0,
		 *  the next has index 1, an so on.
		 *
		 * @param child             <DisplayObject> The DisplayObject to add as a child of this Container.
		 *                            It must implement the IUIComponent interface.
		 * @return                  <DisplayObject> The added child as an object of type DisplayObject.
		 *                            You typically cast the return value to UIComponent,
		 *                            or to the type of the added component.
		 */
		public override function addChild(child:DisplayObject):DisplayObject;
		/**
		 * Adds a child DisplayObject to this Container.
		 *  The child is added at the index specified.
		 *
		 * @param child             <DisplayObject> The DisplayObject to add as a child of this Container.
		 *                            It must implement the IUIComponent interface.
		 * @param index             <int> The index to add the child at.
		 * @return                  <DisplayObject> The added child as an object of type DisplayObject.
		 *                            You typically cast the return value to UIComponent,
		 *                            or to the type of the added component.
		 */
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * Used internally by the Dissolve Effect to add the overlay to the chrome of a container.
		 */
		protected override function attachOverlay():void;
		/**
		 * Converts a Point object from content coordinates to global coordinates.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *  Global coordinates specify a pixel position relative to the upper-left corner
		 *  of the stage, that is, the outermost edge of the application.
		 *
		 * @param point             <Point> A Point object that
		 *                            specifies the x and y coordinates in the content coordinate system
		 *                            as properties.
		 * @return                  <Point> A Point object with coordinates relative to the Stage.
		 */
		public override function contentToGlobal(point:Point):Point;
		/**
		 * Converts a Point object from content to local coordinates.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *  Local coordinates specify a pixel position relative to the
		 *  upper left corner of the component.
		 *
		 * @param point             <Point> A Point object that specifies the x and y
		 *                            coordinates in the content coordinate system as properties.
		 * @return                  <Point> Point A Point object with coordinates relative to the
		 *                            local coordinate system.
		 */
		public override function contentToLocal(point:Point):Point;
		/**
		 * Creates the container's border skin
		 *  if it is needed and does not already exist.
		 */
		protected function createBorder():void;
		/**
		 * Given a single UIComponentDescriptor, create the corresponding
		 *  component and add the component as a child of this Container.
		 *
		 * @param descriptor        <ComponentDescriptor> The UIComponentDescriptor for the
		 *                            component to be created. This argument is either a
		 *                            UIComponentDescriptor object or the index of one of the container's
		 *                            children (an integer between 0 and n-1, where n is the total
		 *                            number of children of this container).
		 * @param recurse           <Boolean> If false, create this component
		 *                            but none of its children.
		 *                            If true, after creating the component, Flex calls
		 *                            the createComponentsFromDescriptors() method to create all or some
		 *                            of its children, based on the value of the component's creationPolicy property.
		 */
		public function createComponentFromDescriptor(descriptor:ComponentDescriptor, recurse:Boolean):IFlexDisplayObject;
		/**
		 * Iterate through the Array of childDescriptors,
		 *  and call the createComponentFromDescriptor() method for each one.
		 *
		 * @param recurse           <Boolean (default = true)> If true, recursively
		 *                            create components.
		 */
		public function createComponentsFromDescriptors(recurse:Boolean = true):void;
		/**
		 * Executes all the data bindings on this Container. Flex calls this method
		 *  automatically once a Container has been created to cause any data bindings that
		 *  have destinations inside of it to execute.
		 *  Workaround for MXML container/bindings problem (177074):
		 *  override Container.executeBindings() to prefer descriptor.document over parentDocument in the
		 *  call to BindingManager.executeBindings().
		 *  This should always provide the correct behavior for instances created by descriptor, and will
		 *  provide the original behavior for procedurally-created instances. (The bug may or may not appear
		 *  in the latter case.)
		 *  A more complete fix, guaranteeing correct behavior in both non-DI and reparented-component
		 *  scenarios, is anticipated for updater 1.
		 *
		 * @param recurse           <Boolean (default = false)> 
		 */
		public override function executeBindings(recurse:Boolean = false):void;
		/**
		 * Executes the bindings into this Container's child UIComponent objects.
		 *  Flex calls this method automatically once a Container has been created.
		 *
		 * @param recurse           <Boolean> If false, then only execute the bindings
		 *                            on the immediate children of this Container.
		 *                            If true, then also execute the bindings on this
		 *                            container's grandchildren,
		 *                            great-grandchildren, and so on.
		 */
		public function executeChildBindings(recurse:Boolean):void;
		/**
		 * Gets the nth child component object.
		 *
		 * @param index             <int> Number from 0 to (numChildren - 1).
		 * @return                  <DisplayObject> Reference to the child as an object of type DisplayObject.
		 *                            You typically cast the return value to UIComponent,
		 *                            or to the type of a specific Flex control, such as ComboBox or TextArea.
		 */
		public override function getChildAt(index:int):DisplayObject;
		/**
		 * Returns the child whose name property is the specified String.
		 *
		 * @param name              <String> The identifier of the child.
		 * @return                  <DisplayObject> The DisplayObject representing the child as an object of type DisplayObject.
		 *                            You typically cast the return value to UIComponent,
		 *                            or to the type of a specific Flex control, such as ComboBox or TextArea.
		 */
		public override function getChildByName(name:String):DisplayObject;
		/**
		 * Gets the zero-based index of a specific child.
		 *
		 * @param child             <DisplayObject> Reference to child whose index to get.
		 * @return                  <int> Number between 0 and (numChildren - 1).
		 */
		public override function getChildIndex(child:DisplayObject):int;
		/**
		 * Returns an Array of DisplayObject objects consisting of the content children
		 *  of the container.
		 *  This array does not include the DisplayObjects that implement
		 *  the container's display elements, such as its border and
		 *  the background image.
		 *
		 * @return                  <Array> Array of DisplayObject objects consisting of the content children
		 *                            of the container.
		 */
		public function getChildren():Array;
		/**
		 * Converts a Point object from global to content coordinates.
		 *  Global coordinates specify a pixel position relative to the upper-left corner
		 *  of the stage, that is, the outermost edge of the application.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *
		 * @param point             <Point> A Point object that
		 *                            specifies the x and y coordinates in the global (Stage)
		 *                            coordinate system as properties.
		 * @return                  <Point> Point A Point object with coordinates relative to the component.
		 */
		public override function globalToContent(point:Point):Point;
		/**
		 * Respond to size changes by setting the positions and sizes
		 *  of this container's borders.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of Container.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void;
		/**
		 * Converts a Point object from local to content coordinates.
		 *  Local coordinates specify a pixel position relative to the
		 *  upper left corner of the component.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *
		 * @param point             <Point> A Point object that specifies the x and y
		 *                            coordinates in the local coordinate system as properties.
		 * @return                  <Point> Point A Point object with coordinates relative to the
		 *                            content coordinate system.
		 */
		public override function localToContent(point:Point):Point;
		/**
		 * Removes all children from the child list of this container.
		 */
		public function removeAllChildren():void;
		/**
		 * Removes a child DisplayObject from the child list of this Container.
		 *  The removed child will have its parent
		 *  property set to null.
		 *  The child will still exist unless explicitly destroyed.
		 *  If you add it to another container,
		 *  it will retain its last known state.
		 *
		 * @param child             <DisplayObject> The DisplayObject to remove.
		 * @return                  <DisplayObject> The removed child as an object of type DisplayObject.
		 *                            You typically cast the return value to UIComponent,
		 *                            or to the type of the removed component.
		 */
		public override function removeChild(child:DisplayObject):DisplayObject;
		/**
		 * Removes a child DisplayObject from the child list of this Container
		 *  at the specified index.
		 *  The removed child will have its parent
		 *  property set to null.
		 *  The child will still exist unless explicitly destroyed.
		 *  If you add it to another container,
		 *  it will retain its last known state.
		 *
		 * @param index             <int> The child index of the DisplayObject to remove.
		 * @return                  <DisplayObject> The removed child as an object of type DisplayObject.
		 *                            You typically cast the return value to UIComponent,
		 *                            or to the type of the removed component.
		 */
		public override function removeChildAt(index:int):DisplayObject;
		/**
		 * Positions the container's content area relative to the viewable area
		 *  based on the horizontalScrollPosition and verticalScrollPosition properties.
		 *  Content that doesn't appear in the viewable area gets clipped.
		 *  This method should be overridden by subclasses that have scrollable
		 *  chrome in the content area.
		 */
		protected function scrollChildren():void;
		/**
		 * Sets the index of a particular child.
		 *  See the getChildIndex() method for a
		 *  description of the child's index.
		 *
		 * @param child             <DisplayObject> Reference to child whose index to set.
		 * @param newIndex          <int> Number that indicates the new index.
		 *                            Must be an integer between 0 and (numChildren - 1).
		 */
		public override function setChildIndex(child:DisplayObject, newIndex:int):void;
		/**
		 * Respond to size changes by setting the positions and sizes
		 *  of this container's children.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
