/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	import flash.media.SoundTransform;
	public class SimpleButton extends InteractiveObject {
		/**
		 * Specifies a display object that is used as the visual
		 *  object for the button "Down" state -the state that the button is in when the user
		 *  clicks the hitTestState object.
		 */
		public function get downState():DisplayObject;
		public function set downState(value:DisplayObject):void;
		/**
		 * A Boolean value that specifies whether a button is enabled. When a
		 *  button is disabled (the enabled property is set to false),
		 *  the button is visible but cannot be clicked. The default value is
		 *  true. This property is useful if you want to
		 *  disable part of your navigation; for example, you might want to disable a
		 *  button in the currently displayed page so that it can't be clicked and
		 *  the page cannot be reloaded.
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * Specifies a display object that is used as the hit testing object for the button. For a basic button, set the
		 *  hitTestState property to the same display object as the overState
		 *  property. If you do not set the hitTestState property, the SimpleButton
		 *  is inactive - it does not respond to mouse and keyboard events.
		 */
		public function get hitTestState():DisplayObject;
		public function set hitTestState(value:DisplayObject):void;
		/**
		 * Specifies a display object that is used as the visual
		 *  object for the button over state - the state that the button is in when
		 *  the mouse is positioned over the button.
		 */
		public function get overState():DisplayObject;
		public function set overState(value:DisplayObject):void;
		/**
		 * The SoundTransform object assigned to this button. A SoundTransform object
		 *  includes properties for setting volume, panning, left speaker assignment, and right
		 *  speaker assignment. This SoundTransform object applies to all states of the button.
		 *  This SoundTransform object affects only embedded sounds.
		 */
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		/**
		 * Indicates whether other display objects that are SimpleButton or MovieClip objects can receive
		 *  mouse release events. The trackAsMenu property lets you create menus. You
		 *  can set the trackAsMenu property on any SimpleButton or MovieClip object.
		 *  If the trackAsMenu property does not exist, the default behavior is
		 *  false.
		 */
		public function get trackAsMenu():Boolean;
		public function set trackAsMenu(value:Boolean):void;
		/**
		 * Specifies a display object that is used as the visual
		 *  object for the button up state - the state that the button is in when
		 *  the mouse is not positioned over the button.
		 */
		public function get upState():DisplayObject;
		public function set upState(value:DisplayObject):void;
		/**
		 * A Boolean value that, when set to true, indicates whether
		 *  the hand cursor is shown when the mouse rolls over a button.
		 *  If this property is set to false, the arrow pointer cursor is displayed
		 *  instead. The default is true.
		 */
		public function get useHandCursor():Boolean;
		public function set useHandCursor(value:Boolean):void;
		/**
		 * Creates a new SimpleButton instance. Any or all of the display objects that represent
		 *  the various button states can be set as parameters in the constructor.
		 *
		 * @param upState           <DisplayObject (default = null)> The initial value for the SimpleButton up state.
		 * @param overState         <DisplayObject (default = null)> The initial value for the SimpleButton over state.
		 * @param downState         <DisplayObject (default = null)> The initial value for the SimpleButton down state.
		 * @param hitTestState      <DisplayObject (default = null)> The initial value for the SimpleButton hitTest state.
		 */
		public function SimpleButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null);
	}
}
