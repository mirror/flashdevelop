package mx.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import mx.managers.ISystemManager;

	/**
	 *  The IUIComponent interface defines the basic set of APIs
 *  that you must implement to create a child of a Flex container or list.
	 */
	public interface IUIComponent extends IFlexDisplayObject
	{
		/**
		 *  The y-coordinate of the baseline
     *  of the first line of text of the component.
     * 
     *  <p>This property is used to implement
     *  the <code>baseline</code> constraint style.
     *  It is also used to align the label of a FormItem
     *  with the controls in the FormItem.</p>
		 */
		public function get baselinePosition () : Number;

		/**
		 *  A reference to the document object associated with this component. 
     *  A document object is an Object at the top of the hierarchy
     *  of a Flex application, MXML component, or ActionScript component.
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;

		/**
		 *  Whether the component can accept user interaction. After setting the <code>enabled</code>
     *  property to <code>false</code>, some components still respond to mouse interactions such 
     *  as mouseOver. As a result, to fully disable UIComponents,
     *  you should also set the value of the <code>mouseEnabled</code> property to <code>false</code>.
     *  If you set the <code>enabled</code> property to <code>false</code>
     *  for a container, Flex dims the color of the container and of all
     *  of its children, and blocks user input to the container
     *  and to all of its children.
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  The explicitly specified height for the component, 
     *  in pixels, as the component's coordinates.
     *  If no height is explicitly specified, the value is <code>NaN</code>.
     *
     *  @see mx.core.UIComponent#explicitHeight
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;

		/**
		 *  Number that specifies the maximum height of the component, 
     *  in pixels, as the component's coordinates. 
     *
     *  @see mx.core.UIComponent#explicitMaxHeight
		 */
		public function get explicitMaxHeight () : Number;

		/**
		 *  Number that specifies the maximum width of the component, 
     *  in pixels, as the component's coordinates. 
     *
     *  @see mx.core.UIComponent#explicitMaxWidth
		 */
		public function get explicitMaxWidth () : Number;

		/**
		 *  Number that specifies the minimum height of the component, 
     *  in pixels, as the component's coordinates. 
     *
     *  @see mx.core.UIComponent#explicitMinHeight
		 */
		public function get explicitMinHeight () : Number;

		/**
		 *  Number that specifies the minimum width of the component, 
     *  in pixels, as the component's coordinates. 
     *
     *  @see mx.core.UIComponent#explicitMinWidth
		 */
		public function get explicitMinWidth () : Number;

		/**
		 *  The explicitly specified width for the component, 
     *  in pixels, as the component's coordinates.
     *  If no width is explicitly specified, the value is <code>NaN</code>.
     *
     *  @see mx.core.UIComponent#explicitWidth
		 */
		public function get explicitWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;

		/**
		 *  A single Sprite object that is shared among components
     *  and used as an overlay for drawing focus.
     *  Components share this object if their parent is a focused component,
     *  not if the component implements the IFocusManagerComponent interface.
     *
     *  @see mx.core.UIComponent#focusPane
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;

		/**
		 *  @copy mx.core.UIComponent#includeInLayout
		 */
		public function get includeInLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set includeInLayout (value:Boolean) : void;

		/**
		 *  @copy mx.core.UIComponent#isPopUp
		 */
		public function get isPopUp () : Boolean;
		/**
		 *  @private
		 */
		public function set isPopUp (value:Boolean) : void;

		/**
		 *  Number that specifies the maximum height of the component, 
     *  in pixels, as the component's coordinates.
     *
     *  @see mx.core.UIComponent#maxHeight
		 */
		public function get maxHeight () : Number;

		/**
		 *  Number that specifies the maximum width of the component, 
     *  in pixels, as the component's coordinates.
     *
     *  @see mx.core.UIComponent#maxWidth
		 */
		public function get maxWidth () : Number;

		/**
		 *  @copy mx.core.UIComponent#measuredMinHeight
		 */
		public function get measuredMinHeight () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinHeight (value:Number) : void;

		/**
		 *  @copy mx.core.UIComponent#measuredMinWidth
		 */
		public function get measuredMinWidth () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinWidth (value:Number) : void;

		/**
		 *  Number that specifies the minimum height of the component, 
     *  in pixels, as the component's coordinates. 
     *
     *  @see mx.core.UIComponent#minHeight
		 */
		public function get minHeight () : Number;

		/**
		 *  Number that specifies the minimum width of the component, 
     *  in pixels, as the component's coordinates. 
     *
     *  @see mx.core.UIComponent#minWidth
		 */
		public function get minWidth () : Number;

		/**
		 *  Typically the parent container of this component. 
     *  However, if this is a popup component, the owner is 
     *  the component that popped it up.  
     *  For example, the owner of a dropdown list of a ComboBox control
     *  is the ComboBox control itself.
     *  This property is not managed by Flex, but 
     *  by each component. 
     *  Therefore, if you popup a component,
     *  you should set this property accordingly.
		 */
		public function get owner () : DisplayObjectContainer;
		/**
		 *  @private
		 */
		public function set owner (value:DisplayObjectContainer) : void;

		/**
		 *  Number that specifies the height of a component as a 
     *  percentage of its parent's size.
     *  Allowed values are 0 to 100.
		 */
		public function get percentHeight () : Number;
		/**
		 *  @private
		 */
		public function set percentHeight (value:Number) : void;

		/**
		 *  Number that specifies the width of a component as a 
     *  percentage of its parent's size.
     *  Allowed values are 0 to 100.
		 */
		public function get percentWidth () : Number;
		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;

		/**
		 *  A reference to the SystemManager object for this component.
		 */
		public function get systemManager () : ISystemManager;
		/**
		 *  @private
		 */
		public function set systemManager (value:ISystemManager) : void;

		/**
		 *  Used by EffectManager.
     *  Returns non-null if a component
     *  is not using the EffectManager to execute a Tween.
		 */
		public function get tweeningProperties () : Array;
		/**
		 *  @private
		 */
		public function set tweeningProperties (value:Array) : void;

		/**
		 *  Initialize the object.
     *
     *  @see mx.core.UIComponent#initialize()
		 */
		public function initialize () : void;

		/**
		 *  @copy mx.core.UIComponent#parentChanged()
		 */
		public function parentChanged (p:DisplayObjectContainer) : void;

		/**
		 *  @copy mx.core.UIComponent#getExplicitOrMeasuredWidth()
		 */
		public function getExplicitOrMeasuredWidth () : Number;

		/**
		 *  @copy mx.core.UIComponent#getExplicitOrMeasuredHeight()
		 */
		public function getExplicitOrMeasuredHeight () : Number;

		/**
		 *  @copy mx.core.UIComponent#setVisible()
		 */
		public function setVisible (value:Boolean, noEvent:Boolean = false) : void;

		/**
		 *  @copy mx.core.UIComponent#owns()
		 */
		public function owns (displayObject:DisplayObject) : Boolean;
	}
}
