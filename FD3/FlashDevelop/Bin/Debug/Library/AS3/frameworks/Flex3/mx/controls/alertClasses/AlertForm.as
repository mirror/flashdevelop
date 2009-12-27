package mx.controls.alertClasses
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.mx_internal;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.events.CloseEvent;
	import mx.managers.IFocusManagerContainer;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;

include "../../styles/metadata/LeadingStyle.as"
include "../../styles/metadata/TextStyles.as"
include "../../core/Version.as"
	/**
	 *  @private
 *  The AlertForm control exists within the Alert control, and contains
 *  messages, buttons, and, optionally, an icon. It is not intended for
 *  direct use by application developers.
 *
 *  @see mx.controls.TextArea
 *  @see mx.controls.Alert
 *  @see mx.controls.Button
	 */
	public class AlertForm extends UIComponent implements IFontContextComponent
	{
		/**
		 *  The UITextField that displays the text of the Alert control.
		 */
		var textField : IUITextField;
		/**
		 *  @private
	 *  Width of the text object.
		 */
		private var textWidth : Number;
		/**
		 *  @private
	 *  Height of the text object.
		 */
		private var textHeight : Number;
		/**
		 *  The DisplayObject that displays the icon.
		 */
		private var icon : DisplayObject;
		/**
		 *  An Array that contains any Buttons appearing in the Alert control.
		 */
		var buttons : Array;
		/**
		 *  @private
		 */
		var defaultButton : Button;
		/**
		 *  @private
		 */
		private var defaultButtonChanged : Boolean;

		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  Constructor.
		 */
		public function AlertForm ();

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
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
	 *  Updates the button labels.
		 */
		protected function resourcesChanged () : void;

		/**
		 *  @private
     *  Creates the title text field child
	 *  and adds it as a child of this component.
     * 
     *  @param childIndex The index of where to add the child.
	 *  If -1, the text field isappended to the end of the list.
		 */
		function createTextField (childIndex:int) : void;

		/**
		 *  @private
     *  Removes the title text field from this component.
		 */
		function removeTextField () : void;

		/**
		 *  @private
		 */
		private function createButton (label:String, name:String) : Button;

		/**
		 *  @private
     *  Remove the popup and dispatch Click event corresponding to the Button Pressed.
		 */
		private function removeAlert (buttonPressed:String) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
     *  On a button click, dismiss the popup and send notification.
		 */
		private function clickHandler (event:MouseEvent) : void;
	}
}
