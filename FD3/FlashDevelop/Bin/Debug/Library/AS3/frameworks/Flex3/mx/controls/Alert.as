﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import mx.containers.Panel;
	import mx.controls.alertClasses.AlertForm;
	import mx.core.Application;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.graphics.RadialGradient;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Name of the CSS style declaration that specifies  *  styles for the Alert buttons.  *  *  @default "alertButtonStyle"
	 */
	[Style(name="buttonStyleName", type="String", inherit="no")] 
	/**
	 *  Name of the CSS style declaration that specifies *  styles for the Alert message text.  * *  <p>You only set this style by using a type selector, which sets the style  *  for all Alert controls in your application.   *  If you set it on a specific instance of the Alert control, it can cause the control to  *  size itself incorrectly.</p> *  *  @default undefined
	 */
	[Style(name="messageStyleName", type="String", inherit="no")] 
	/**
	 *  Name of the CSS style declaration that specifies styles *  for the Alert title text.  * *  <p>You only set this style by using a type selector, which sets the style  *  for all Alert controls in your application.   *  If you set it on a specific instance of the Alert control, it can cause the control to  *  size itself incorrectly.</p> *  *  @default "windowStyles"
	 */
	[Style(name="titleStyleName", type="String", inherit="no")] 

	/**
	 *  The Alert control is a pop-up dialog box that can contain a message, *  a title, buttons (any combination of OK, Cancel, Yes, and No) and an icon.  *  The Alert control is modal, which means it will retain focus until the user closes it. * *  <p>Import the mx.controls.Alert class into your application,  *  and then call the static <code>show()</code> method in ActionScript to display *  an Alert control. You cannot create an Alert control in MXML.</p> * *  <p>The Alert control closes when you select a button in the control,  *  or press the Escape key.</p> * *  @includeExample examples/SimpleAlert.mxml * *  @see mx.managers.SystemManager *  @see mx.managers.PopUpManager
	 */
	public class Alert extends Panel
	{
		/**
		 *  Value that enables a Yes button on the Alert control when passed     *  as the <code>flags</code> parameter of the <code>show()</code> method.     *  You can use the | operator to combine this bitflag     *  with the <code>OK</code>, <code>CANCEL</code>,     *  <code>NO</code>, and <code>NONMODAL</code> flags.
		 */
		public static const YES : uint = 0x0001;
		/**
		 *  Value that enables a No button on the Alert control when passed     *  as the <code>flags</code> parameter of the <code>show()</code> method.     *  You can use the | operator to combine this bitflag     *  with the <code>OK</code>, <code>CANCEL</code>,     *  <code>YES</code>, and <code>NONMODAL</code> flags.
		 */
		public static const NO : uint = 0x0002;
		/**
		 *  Value that enables an OK button on the Alert control when passed     *  as the <code>flags</code> parameter of the <code>show()</code> method.     *  You can use the | operator to combine this bitflag     *  with the <code>CANCEL</code>, <code>YES</code>,     *  <code>NO</code>, and <code>NONMODAL</code> flags.
		 */
		public static const OK : uint = 0x0004;
		/**
		 *  Value that enables a Cancel button on the Alert control when passed     *  as the <code>flags</code> parameter of the <code>show()</code> method.     *  You can use the | operator to combine this bitflag     *  with the <code>OK</code>, <code>YES</code>,     *  <code>NO</code>, and <code>NONMODAL</code> flags.
		 */
		public static const CANCEL : uint = 0x0008;
		/**
		 *  Value that makes an Alert nonmodal when passed as the     *  <code>flags</code> parameter of the <code>show()</code> method.     *  You can use the | operator to combine this bitflag     *  with the <code>OK</code>, <code>CANCEL</code>,     *  <code>YES</code>, and <code>NO</code> flags.
		 */
		public static const NONMODAL : uint = 0x8000;
		/**
		 *  @private     *  Placeholder for mixin by AlertAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private	 *  Storage for the resourceManager getter.	 *  This gets initialized on first access,	 *  not at static initialization time, in order to ensure	 *  that the Singleton registry has already been initialized.
		 */
		private static var _resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private static var initialized : Boolean;
		/**
		 *  Height of each Alert button, in pixels.     *  All buttons must be the same height.     *     *  @default 22
		 */
		public static var buttonHeight : Number;
		/**
		 *  Width of each Alert button, in pixels.     *  All buttons must be the same width.     *     *  @default 60
		 */
		public static var buttonWidth : Number;
		/**
		 *  @private	 *  Storage for the cancelLabel property.
		 */
		private static var _cancelLabel : String;
		/**
		 *  @private
		 */
		private static var cancelLabelOverride : String;
		/**
		 *  @private	 *  Storage for the noLabel property.
		 */
		private static var _noLabel : String;
		/**
		 *  @private
		 */
		private static var noLabelOverride : String;
		/**
		 *  @private	 *  Storage for the okLabel property.
		 */
		private static var _okLabel : String;
		/**
		 *  @private
		 */
		private static var okLabelOverride : String;
		/**
		 *  @private	 *  Storage for the yesLabel property.
		 */
		private static var _yesLabel : String;
		/**
		 *  @private
		 */
		private static var yesLabelOverride : String;
		/**
		 *  @private     *  The internal AlertForm object that contains the text, icon, and buttons     *  of the Alert control.
		 */
		local var alertForm : AlertForm;
		/**
		 *  A bitmask that contains <code>Alert.OK</code>, <code>Alert.CANCEL</code>,      *  <code>Alert.YES</code>, and/or <code>Alert.NO</code> indicating	 *  the buttons available in the Alert control.     *     *  @default Alert.OK
		 */
		public var buttonFlags : uint;
		/**
		 *  A bitflag that contains either <code>Alert.OK</code>,      *  <code>Alert.CANCEL</code>, <code>Alert.YES</code>,      *  or <code>Alert.NO</code> to specify the default button.     *     *  @default Alert.OK
		 */
		public var defaultButtonFlag : uint;
		/**
		 *  The class of the icon to display.     *  You typically embed an asset, such as a JPEG or GIF file,     *  and then use the variable associated with the embedded asset      *  to specify the value of this property.     *     *  @default null
		 */
		public var iconClass : Class;
		/**
		 *  The text to display in this alert dialog box.     *     *  @default ""
		 */
		public var text : String;

		/**
		 *  @private     *  A reference to the object which manages     *  all of the application's localized resources.     *  This is a singleton instance which implements     *  the IResourceManager interface.
		 */
		private static function get resourceManager () : IResourceManager;
		/**
		 *  The label for the Cancel button.     *     *  <p>If you use a different label, you may need to adjust the      *  <code>buttonWidth</code> property to fully display it.</p>     *     *  The English resource bundle sets this property to "CANCEL".
		 */
		public static function get cancelLabel () : String;
		/**
		 *  @private
		 */
		public static function set cancelLabel (value:String) : void;
		/**
		 *  The label for the No button.     *     *  <p>If you use a different label, you may need to adjust the      *  <code>buttonWidth</code> property to fully display it.</p>     *     *  The English resource bundle sets this property to "NO".
		 */
		public static function get noLabel () : String;
		/**
		 *  @private
		 */
		public static function set noLabel (value:String) : void;
		/**
		 *  The label for the OK button.     *     *  <p>If you use a different label, you may need to adjust the      *  <code>buttonWidth</code> property to fully display the label.</p>     *     *  The English resource bundle sets this property to "OK".
		 */
		public static function get okLabel () : String;
		/**
		 *  @private
		 */
		public static function set okLabel (value:String) : void;
		/**
		 *  The label for the Yes button.     *     *  <p>If you use a different label, you may need to adjust the      *  <code>buttonWidth</code> property to fully display the label.</p>     *     *  The English resource bundle sets this property to "YES".
		 */
		public static function get yesLabel () : String;
		/**
		 *  @private
		 */
		public static function set yesLabel (value:String) : void;

		/**
		 *  Static method that pops up the Alert control. The Alert control      *  closes when you select a button in the control, or press the Escape key.     *      *  @param text Text string that appears in the Alert control.      *  This text is centered in the alert dialog box.     *     *  @param title Text string that appears in the title bar.      *  This text is left justified.     *     *  @param flags Which buttons to place in the Alert control.     *  Valid values are <code>Alert.OK</code>, <code>Alert.CANCEL</code>,     *  <code>Alert.YES</code>, and <code>Alert.NO</code>.     *  The default value is <code>Alert.OK</code>.     *  Use the bitwise OR operator to display more than one button.      *  For example, passing <code>(Alert.YES | Alert.NO)</code>     *  displays Yes and No buttons.     *  Regardless of the order that you specify buttons,     *  they always appear in the following order from left to right:     *  OK, Yes, No, Cancel.     *     *  @param parent Object upon which the Alert control centers itself.     *     *  @param closeHandler Event handler that is called when any button     *  on the Alert control is pressed.     *  The event object passed to this handler is an instance of CloseEvent;     *  the <code>detail</code> property of this object contains the value     *  <code>Alert.OK</code>, <code>Alert.CANCEL</code>,     *  <code>Alert.YES</code>, or <code>Alert.NO</code>.     *     *  @param iconClass Class of the icon that is placed to the left     *  of the text in the Alert control.     *     *  @param defaultButtonFlag A bitflag that specifies the default button.     *  You can specify one and only one of     *  <code>Alert.OK</code>, <code>Alert.CANCEL</code>,     *  <code>Alert.YES</code>, or <code>Alert.NO</code>.     *  The default value is <code>Alert.OK</code>.     *  Pressing the Enter key triggers the default button     *  just as if you clicked it. Pressing Escape triggers the Cancel     *  or No button just as if you selected it.     *     *  @return A reference to the Alert control.      *     *  @see mx.events.CloseEvent
		 */
		public static function show (text:String = "", title:String = "", flags:uint = 0x4, parent:Sprite = null, closeHandler:Function = null, iconClass:Class = null, defaultButtonFlag:uint = 0x4) : Alert;
		/**
		 *  @private
		 */
		private static function initialize () : void;
		/**
		 *  @private
		 */
		private static function static_resourcesChanged () : void;
		/**
		 *  @private
		 */
		private static function static_resourceManager_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private static function static_creationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  Constructor.
		 */
		public function Alert ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createChildren () : void;
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
		 */
		protected function resourcesChanged () : void;
	}
}
