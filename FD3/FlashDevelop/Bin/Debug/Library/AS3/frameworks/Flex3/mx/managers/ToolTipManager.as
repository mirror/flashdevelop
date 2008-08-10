/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	import mx.core.IToolTip;
	import mx.effects.IAbstractEffect;
	import mx.core.IUIComponent;
	public class ToolTipManager extends EventDispatcher {
		/**
		 * The UIComponent that is currently displaying a ToolTip,
		 *  or null if none is.
		 */
		public static function get currentTarget():DisplayObject;
		public function set currentTarget(value:DisplayObject):void;
		/**
		 * The ToolTip object that is currently visible,
		 *  or null if none is shown.
		 */
		public static function get currentToolTip():IToolTip;
		public function set currentToolTip(value:IToolTip):void;
		/**
		 * If true, the ToolTipManager will automatically show
		 *  ToolTips when the user moves the mouse pointer over components.
		 *  If false, no ToolTips will be shown.
		 */
		public static function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * The amount of time, in milliseconds, that Flex waits
		 *  to hide the ToolTip after it appears.
		 *  Once Flex hides a ToolTip, the user must move the mouse
		 *  off the component and then back onto it to see the ToolTip again.
		 *  If you set hideDelay to Infinity,
		 *  Flex does not hide the ToolTip until the user triggers an event,
		 *  such as moving the mouse off of the component.
		 */
		public static function get hideDelay():Number;
		public function set hideDelay(value:Number):void;
		/**
		 * The effect that plays when a ToolTip is hidden,
		 *  or null if the ToolTip should disappear with no effect.
		 */
		public static function get hideEffect():IAbstractEffect;
		public function set hideEffect(value:IAbstractEffect):void;
		/**
		 * The amount of time, in milliseconds, that a user can take
		 *  when moving the mouse between controls before Flex again waits
		 *  for the duration of showDelay to display a ToolTip.
		 */
		public static function get scrubDelay():Number;
		public function set scrubDelay(value:Number):void;
		/**
		 * The amount of time, in milliseconds, that Flex waits
		 *  before displaying the ToolTip box once a user
		 *  moves the mouse over a component that has a ToolTip.
		 *  To make the ToolTip appear instantly, set showDelay to 0.
		 */
		public static function get showDelay():Number;
		public function set showDelay(value:Number):void;
		/**
		 * The effect that plays when a ToolTip is shown,
		 *  or null if the ToolTip should appear with no effect.
		 */
		public static function get showEffect():IAbstractEffect;
		public function set showEffect(value:IAbstractEffect):void;
		/**
		 * The class to use for creating ToolTips.
		 */
		public static function get toolTipClass():Class;
		public function set toolTipClass(value:Class):void;
		/**
		 * Creates an instance of the ToolTip class with the specified text
		 *  and displays it at the specified location in stage coordinates.
		 *
		 * @param text              <String> The text to display in the ToolTip instance.
		 * @param x                 <Number> The horizontal coordinate of the ToolTip in stage coordinates.
		 *                            In case of multiple stages, the relevant stage is determined
		 *                            from the context argument.
		 * @param y                 <Number> The vertical coordinate of the ToolTip in stage coordinates.
		 *                            In case of multiple stages, the relevant stage is determined
		 *                            from the context argument.
		 * @param errorTipBorderStyle<String (default = null)> The border style of an error tip. This method
		 *                            argument can be null, "errorTipRight", "errorTipAbove", or "errorTipBelow".
		 *                            If it is null, then the createToolTip() method creates a normal ToolTip. If it is
		 *                            "errorTipRight", "errorTipAbove", or "errorTipBelow", then the createToolTip()
		 *                            method creates an error tip, and this parameter determines where the arrow
		 *                            of the error tip points to (the error's target). For example, if you pass "errorTipRight", Flex
		 *                            positions the error tip (via the x and y arguments) to the
		 *                            right of the error target; the arrow is on the left edge of the error tip.
		 * @param context           <IUIComponent (default = null)> This property is not currently used.
		 * @return                  <IToolTip> The newly created ToolTip.
		 */
		public static function createToolTip(text:String, x:Number, y:Number, errorTipBorderStyle:String = null, context:IUIComponent = null):IToolTip;
		/**
		 * Destroys a specified ToolTip that was created by the createToolTip() method.
		 *
		 * @param toolTip           <IToolTip> The ToolTip instance to destroy.
		 */
		public static function destroyToolTip(toolTip:IToolTip):void;
	}
}
