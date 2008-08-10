/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import mx.managers.ISystemManager;
	import flash.display.DisplayObject;
	public interface IUIComponent extends <a href="../../mx/core/IFlexDisplayObject.html">IFlexDisplayObject</a> , <a href="../../flash/display/IBitmapDrawable.html">IBitmapDrawable</a> , <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * The y-coordinate of the baseline
		 *  of the first line of text of the component.
		 */
		public function get baselinePosition():Number;
		/**
		 * A reference to the document object associated with this component.
		 *  A document object is an Object at the top of the hierarchy
		 *  of a Flex application, MXML component, or ActionScript component.
		 */
		public function get document():Object;
		public function set document(value:Object):void;
		/**
		 * Whether the component can accept user interaction. After setting the enabled
		 *  property to false, some components still respond to mouse interactions such
		 *  as mouseOver. As a result, to fully disable UIComponents,
		 *  you should also set the value of the mouseEnabled property to false.
		 *  If you set the enabled property to false
		 *  for a container, Flex dims the color of the container and of all
		 *  of its children, and blocks user input to the container
		 *  and to all of its children.
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * The explicitly specified height for the component,
		 *  in pixels, as the component's coordinates.
		 *  If no height is explicitly specified, the value is NaN.
		 */
		public function get explicitHeight():Number;
		public function set explicitHeight(value:Number):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMaxHeight():Number;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMaxWidth():Number;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMinHeight():Number;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMinWidth():Number;
		/**
		 * The explicitly specified width for the component,
		 *  in pixels, as the component's coordinates.
		 *  If no width is explicitly specified, the value is NaN.
		 */
		public function get explicitWidth():Number;
		public function set explicitWidth(value:Number):void;
		/**
		 * A single Sprite object that is shared among components
		 *  and used as an overlay for drawing focus.
		 *  Components share this object if their parent is a focused component,
		 *  not if the component implements the IFocusManagerComponent interface.
		 */
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		/**
		 * Specifies whether this component is included in the layout of the
		 *  parent container.
		 *  If true, the object is included in its parent container's
		 *  layout.  If false, the object is positioned by its parent
		 *  container as per its layout rules, but it is ignored for the purpose of
		 *  computing the position of the next child.
		 */
		public function get includeInLayout():Boolean;
		public function set includeInLayout(value:Boolean):void;
		/**
		 * Set to true by the PopUpManager to indicate
		 *  that component has been popped up.
		 */
		public function get isPopUp():Boolean;
		public function set isPopUp(value:Boolean):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get maxHeight():Number;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get maxWidth():Number;
		/**
		 * The default minimum height of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredMinHeight():Number;
		public function set measuredMinHeight(value:Number):void;
		/**
		 * The default minimum width of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredMinWidth():Number;
		public function set measuredMinWidth(value:Number):void;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get minHeight():Number;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get minWidth():Number;
		/**
		 * Typically the parent container of this component.
		 *  However, if this is a popup component, the owner is
		 *  the component that popped it up.
		 *  For example, the owner of a dropdown list of a ComboBox control
		 *  is the ComboBox control itself.
		 *  This property is not managed by Flex, but
		 *  by each component.
		 *  Therefore, if you popup a component,
		 *  you should set this property accordingly.
		 */
		public function get owner():DisplayObjectContainer;
		public function set owner(value:DisplayObjectContainer):void;
		/**
		 * Number that specifies the height of a component as a
		 *  percentage of its parent's size.
		 *  Allowed values are 0 to 100.
		 */
		public function get percentHeight():Number;
		public function set percentHeight(value:Number):void;
		/**
		 * Number that specifies the width of a component as a
		 *  percentage of its parent's size.
		 *  Allowed values are 0 to 100.
		 */
		public function get percentWidth():Number;
		public function set percentWidth(value:Number):void;
		/**
		 * A reference to the SystemManager object for this component.
		 */
		public function get systemManager():ISystemManager;
		public function set systemManager(value:ISystemManager):void;
		/**
		 * Used by EffectManager.
		 *  Returns non-null if a component
		 *  is not using the EffectManager to execute a Tween.
		 */
		public function get tweeningProperties():Array;
		public function set tweeningProperties(value:Array):void;
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured height
		 *
		 * @return                  <Number> A Number which is explicitHeight if defined
		 *                            or measuredHeight if not.
		 */
		public function getExplicitOrMeasuredHeight():Number;
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured width
		 *
		 * @return                  <Number> A Number which is explicitWidth if defined
		 *                            or measuredWidth if not.
		 */
		public function getExplicitOrMeasuredWidth():Number;
		/**
		 * Initialize the object.
		 */
		public function initialize():void;
		/**
		 * Returns true if the chain of owner properties
		 *  points from child to this UIComponent.
		 *
		 * @param child             <DisplayObject> A UIComponent.
		 * @return                  <Boolean> true if the child is parented or owned by this UIComponent.
		 */
		public function owns(child:DisplayObject):Boolean;
		/**
		 * Called by Flex when a UIComponent object is added to or removed from a parent.
		 *  Developers typically never need to call this method.
		 *
		 * @param p                 <DisplayObjectContainer> The parent of this UIComponent object.
		 */
		public function parentChanged(p:DisplayObjectContainer):void;
		/**
		 * Called when the visible property changes.
		 *  You should set the visible property to show or hide
		 *  a component instead of calling this method directly.
		 *
		 * @param value             <Boolean> The new value of the visible property.
		 *                            Specify true to show the component, and false to hide it.
		 * @param noEvent           <Boolean (default = false)> If true, do not dispatch an event.
		 *                            If false, dispatch a show event when
		 *                            the component becomes visible, and a hide event when
		 *                            the component becomes invisible.
		 */
		public function setVisible(value:Boolean, noEvent:Boolean = false):void;
	}
}
