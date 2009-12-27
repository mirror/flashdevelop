package mx.controls.menuClasses
{
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	import mx.controls.MenuBar;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IProgrammaticSkin;
	import mx.core.IStateClient;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;

include "../../styles/metadata/LeadingStyle.as"
include "../../styles/metadata/TextStyles.as"
include "../../core/Version.as"
	/**
	 *  The MenuBarItem class defines the default item 
 *  renderer for the top-level menu bar of a MenuBar control. 
 *  By default, the item renderer draws the text associated
 *  with each item in the top-level menu bar, and an optional icon. 
 *
 *  <p>A MenuBarItem
 *  instance passes mouse and keyboard interactions to the MenuBar so 
 *  that the MenuBar can correctly show and hide menus. </p>
 *
 *  <p>You can override the default MenuBar item renderer
 *  by creating a custom item renderer that implements the 
 *  IMenuBarItemRenderer interface.</p>
 * 
 *  <p>You can also define an item renderer for the pop-up submenus 
 *  of the MenuBar control. 
 *  Because each pop-up submenu is an instance of the Menu control, 
 *  you use the class MenuItemRenderer to define an item renderer 
 *  for the pop-up submenus.</p>
 *
 *  @see mx.controls.MenuBar
 *  @see mx.controls.Menu
 *  @see mx.controls.menuClasses.IMenuBarItemRenderer
 *  @see mx.controls.menuClasses.MenuItemRenderer
	 */
	public class MenuBarItem extends UIComponent implements IMenuBarItemRenderer
	{
		/**
		 *  @private
		 */
		private var leftMargin : int;
		/**
		 *  The skin defining the border and background for this MenuBarItem.
		 */
		var currentSkin : IFlexDisplayObject;
		/**
		 *  The IFlexDisplayObject that displays the icon in this MenuBarItem.
		 */
		protected var icon : IFlexDisplayObject;
		/**
		 *  The UITextField that displays the text in this MenuBarItem.
		 */
		protected var label : IUITextField;
		/**
		 *  The default skin's style name
		 */
		var skinName : String;
		/**
		 *  Flags used to save information about the skin and icon styles
		 */
		private var defaultSkinUsesStates : Boolean;
		private var checkedDefaultSkin : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  @private
     *  Storage for the menuBar property.
		 */
		private var _menuBar : MenuBar;
		/**
		 *  @private
     *  Storage for the menuBarItemIndex property.
		 */
		private var _menuBarItemIndex : int;
		/**
		 *  @private
     *  Storage for the menuBarItemState property.
		 */
		private var _menuBarItemState : String;
		/**
		 *  @private
	 *  Storage for data provider
		 */
		private var _dataProvider : Object;

		/**
		 *  @private
     *  The baselinePosition of a MenuBarItem is calculated
     *  for its label.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  The implementation of the <code>data</code> property
     *  as defined by the IDataRenderer interface.
     *  All item renderers must implement the IDataRenderer interface.
     *
     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;

		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  The implementation of the <code>menuBar</code> property
     *  as defined by the IMenuBarItemRenderer interface. 
     *  
     *  @copy mx.controls.menuClasses.IMenuBarItemRenderer#menuBar 
     * 
     *  @see mx.controls.menuClasses.IMenuBarItemRenderer#menuBar
		 */
		public function get menuBar () : MenuBar;
		/**
		 *  @private
		 */
		public function set menuBar (value:MenuBar) : void;

		/**
		 *  The implementation of the <code>menuBarItemIndex</code> property
     *  as defined by the IMenuBarItemRenderer interface.  
     *  
     *  @copy mx.controls.menuClasses.IMenuBarItemRenderer#menuBarItemIndex 
     * 
     *  @see mx.controls.menuClasses.IMenuBarItemRenderer#menuBarItemIndex
		 */
		public function get menuBarItemIndex () : int;
		/**
		 *  @private
		 */
		public function set menuBarItemIndex (value:int) : void;

		/**
		 *  The implementation of the <code>menuBarItemState</code> property
     *  as defined by the IMenuBarItemRenderer interface.  
     * 
     *  @copy mx.controls.menuClasses.IMenuBarItemRenderer#menuBarItemState
     * 
     *  @see mx.controls.menuClasses.IMenuBarItemRenderer#menuBarItemState
		 */
		public function get menuBarItemState () : String;
		/**
		 *  @private
		 */
		public function set menuBarItemState (value:String) : void;

		/**
		 *  The object that provides the data for the Menu that is popped up
	 *  when this MenuBarItem is selected.
	 * 
	 *  @default "undefined"
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function MenuBarItem ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

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
     *  Creates the label and adds it as a child of this component.
     * 
     *  @param childIndex The index of where to add the child.
	 *  If -1, the text field is appended to the end of the list.
		 */
		function createLabel (childIndex:int) : void;

		/**
		 *  @private
     *  Removes the label from this component.
		 */
		function removeLabel () : void;

		/**
		 *  @private
		 */
		private function viewSkin (state:String) : void;

		/**
		 *  @private
		 */
		function getLabel () : IUITextField;
	}
}
