package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.IRectangularBorder;
	import mx.core.IUIComponent;
	import mx.core.FlexVersion;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.DropdownEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ListEvent;
	import mx.events.MenuEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  Dispatched when the specified UIComponent closes.  * *  @eventType mx.events.DropdownEvent.CLOSE
	 */
	[Event(name="close", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the specified UIComponent opens. * *  @eventType mx.events.DropdownEvent.OPEN
	 */
	[Event(name="open", type="mx.events.DropdownEvent")] 
	/**
	 *  Number of pixels between the divider line and the right  *  edge of the component. *  The default value is 16.
	 */
	[Style(name="arrowButtonWidth", type="Number", format="Length", inherit="no")] 
	/**
	 *  Length of a close transition, in milliseconds. *  The default value is 250.
	 */
	[Style(name="closeDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Easing function to control component closing tween.
	 */
	[Style(name="closeEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The default icon class for the main button. * *  @default null
	 */
	[Style(name="icon", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Length of an open transition, in milliseconds. *  The default value is 250.
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Easing function to control component opening tween.
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The name of a CSS style declaration used by the control.   *  This style allows you to control the appearance of the  *  UIComponent object popped up by this control.  * *  @default undefined
	 */
	[Style(name="popUpStyleName", type="String", inherit="no")] 
	/**
	 *  Skin class for the popUpDown state (when arrowButton is in down  *  state) of the background and border. *  @default mx.skins.halo.PopUpButtonSkin
	 */
	[Style(name="popUpDownSkin", type="Class", inherit="no")] 
	/**
	 *  Number of vertical pixels between the PopUpButton and the *  specified popup UIComponent. *  The default value is 0.
	 */
	[Style(name="popUpGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  The icon used for the right button of PopUpButton. *  Supported classes are mx.skins.halo.PopUpIcon *  and mx.skins.halo.PopUpMenuIcon. *  @default mx.skins.halo.PopUpIcon
	 */
	[Style(name="popUpIcon", type="Class", inherit="no")] 
	/**
	 *  Skin class for the popUpOver state (over arrowButton) of  *  the background and border. *  @default mx.skins.halo.PopUpButtonSkin
	 */
	[Style(name="popUpOverSkin", type="Class", inherit="no")] 
	/**
	 *  Default stateful skin class for the control. *  @default mx.skins.halo.PopUpButtonSkin
	 */
	[Style(name="skin", type="Class", inherit="no", states="up, over, down, disabled, popUpOver, popUpDown")] 

	/**
	 *  The PopUpButton control adds a flexible pop-up control *  interface  to a Button control. *  It contains a main button and a secondary button, *  called the pop-up button, which pops up any UIComponent *  object when a user clicks the pop-up button.  * *  <p>A PopUpButton control can have a text label, an icon, *  or both on its face. *  When a user clicks the main part of the PopUpButton  *  control, it dispatches a <code>click</code> event.</p> * *  <p>One common use for the PopUpButton control is to have *  the pop-up button open a List control or a Menu control *  that changes  the function and label of the main button.</p> * *  <p>The PopUpButton control has the following default characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>Sufficient width to accommodate the label and icon on the main button and the icon on the pop-up button</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>Undefined</td> *        </tr> *     </table> * *  @mxml *   *  <p>The <code>&lt;mx:PopUpButton&gt;</code> tag inherits all of the tag *  attributes of its superclass and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:PopUpButton *    <strong>Properties</strong>  *    openAlways="false|true *    popUp="No default" *   *    <strong>Styles</strong> *    arrowButtonWidth="16" *    closeDuration="250" *    closeEasingFunction="No default" *    disabledIconColor="0x999999" *    iconColor="0x111111" *    openDuration="250" *    openEasingFunction="No default" *    popUpDownSkin="popUpDownSkin" *    popUpGap="0" *    popUpIcon="PopUpIcon" *    popUpOverSkin="popUpOverSkin" *   *    <strong>Events</strong> *    close="No default" *    open="No default" *  /&gt; *  </pre> * *  @includeExample examples/PopUpButtonExample.mxml *
	 */
	public class PopUpButton extends Button
	{
		/**
		 *  @private
		 */
		private var inTween : Boolean;
		/**
		 *  @private     *  Is the popUp list currently shown?
		 */
		private var showingPopUp : Boolean;
		/**
		 *  @private     *  The tween used for showing/hiding the popUp.
		 */
		private var tween : Tween;
		/**
		 *  @private     *  Greater of the arrowButtonWidth style and the icon's width.
		 */
		private var arrowButtonsWidth : Number;
		/**
		 *  @private     *  Greater of the arrowButtonsHeight style and the icon's height.
		 */
		private var arrowButtonsHeight : Number;
		/**
		 *  @private
		 */
		private var popUpIconChanged : Boolean;
		/**
		 *  @private
		 */
		private var popUpChanged : Boolean;
		/**
		 *  @private     *  Storage for the closeOnActivity property.
		 */
		private var _closeOnActivity : Boolean;
		/**
		 *  @private     *  Storage for the openAlways property.
		 */
		private var _openAlways : Boolean;
		/**
		 *  @private     *  Storage for popUp property.
		 */
		private var _popUp : IUIComponent;

		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  @private     *  A PopUpButton is not toggleable by definition, so _toggle is set     *  to false in the constructor and can't be changed via this setter.
		 */
		public function set toggle (value:Boolean) : void;
		/**
		 *  @private     *  Specifies popUp would close on click/enter activity.     *  In popUps like Menu/List/TileList etc, one need not change     *  this as they should close on activity. However for multiple      *  selection, and other popUp, this can be set to false, to      *  prevent the popUp from closing on activity.     *       *  @default true
		 */
		private function get closeOnActivity () : Boolean;
		/**
		 *  @private
		 */
		private function set closeOnActivity (value:Boolean) : void;
		/**
		 *  If <code>true</code>, specifies to pop up the      *  <code>popUp</code> when you click the main button.      *  The <code>popUp</code> always appears when you press the Spacebar,      *  or when you click the pop-up button, regardless of the setting of      *  the <code>openAlways</code> property.     *     *  @default false
		 */
		public function get openAlways () : Boolean;
		/**
		 *  @private
		 */
		public function set openAlways (value:Boolean) : void;
		/**
		 *  Specifies the UIComponent object, or object defined by a subclass      *  of UIComponent, to pop up.      *  For example, you can specify a Menu, TileList, or Tree control.      *     *  @default null
		 */
		public function get popUp () : IUIComponent;
		/**
		 *  @private
		 */
		public function set popUp (value:IUIComponent) : void;
		/**
		 *  @private
		 */
		function get isShowingPopUp () : Boolean;

		/**
		 *  Constructor.
		 */
		public function PopUpButton ();
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
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private     *  Displays one of the six possible skins,     *  creating it if it doesn't already exist.
		 */
		function viewSkin () : void;
		/**
		 *  @private
		 */
		function getCurrentIconName () : String;
		/**
		 *  @private     *  Displays one of the four possible icons,     *  creating it if it doesn't already exist.
		 */
		function viewIcon () : void;
		/**
		 *  @private     *  Used by PopUpMenuButton
		 */
		function getPopUp () : IUIComponent;
		/**
		 *  Opens the UIComponent object specified by the <code>popUp</code> property.
		 */
		public function open () : void;
		/**
		 *  @private
		 */
		private function openWithEvent (trigger:Event = null) : void;
		/**
		 *  Closes the UIComponent object opened by the PopUpButton control.
		 */
		public function close () : void;
		/**
		 *  @private
		 */
		private function closeWithEvent (trigger:Event = null) : void;
		/**
		 *  @private
		 */
		private function displayPopUp (show:Boolean) : void;
		/**
		 *  @private     *  Calculates the ArrowButton's sizes.
		 */
		private function calcArrowButtonSize () : void;
		/**
		 *  @private     *  Returns true if the mouse is over the pop-up button
		 */
		function overArrowButton (event:MouseEvent) : Boolean;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Number) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function rollOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function rollOutHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  Close popUp for IListItemRenderer's like List/Menu.
		 */
		private function popUpItemClickHandler (event:Event) : void;
		/**
		 *  @private     *  Hide is called intermittently before close gets called.     *  Call close() in such cases to  reset variables.
		 */
		private function menuHideHandler (event:MenuEvent) : void;
		/**
		 *  @private
		 */
		private function popMouseDownOutsideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function getUnscaledWidth () : Number;
		/**
		 *  @private
		 */
		function getUnscaledHeight () : Number;
		/**
		 *  @private
		 */
		function getArrowButtonsWidth () : Number;
	}
}
