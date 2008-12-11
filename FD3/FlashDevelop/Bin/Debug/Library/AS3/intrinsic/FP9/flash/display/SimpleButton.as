package flash.display
{
	/// The SimpleButton class lets you control all instances of button symbols in a SWF file.
	public class SimpleButton extends flash.display.InteractiveObject
	{
		/// A Boolean value that, when set to true, indicates whether Flash Player displays the hand cursor when the mouse rolls over a button.
		public var useHandCursor:Boolean;

		/// A Boolean value that specifies whether a button is enabled.
		public var enabled:Boolean;

		/// Indicates whether other display objects that are SimpleButton or MovieClip objects can receive mouse release events.
		public var trackAsMenu:Boolean;

		/// Specifies a display object that is used as the visual object for the button up state &#8212; the state that the button is in when the mouse is not positioned over the button.
		public var upState:flash.display.DisplayObject;

		/// Specifies a display object that is used as the visual object for the button over state &#8212; the state that the button is in when the mouse is positioned over the button.
		public var overState:flash.display.DisplayObject;

		/// Specifies a display object that is used as the visual object for the button "Down" state &#8212;the state that the button is in when the user clicks the hitTestState object.
		public var downState:flash.display.DisplayObject;

		/// Specifies a display object that is used as the hit testing object for the button.
		public var hitTestState:flash.display.DisplayObject;

		/// The SoundTransform object assigned to this button.
		public var soundTransform:flash.media.SoundTransform;

		/// Creates a new SimpleButton instance.
		public function SimpleButton(upState:flash.display.DisplayObject=null, overState:flash.display.DisplayObject=null, downState:flash.display.DisplayObject=null, hitTestState:flash.display.DisplayObject=null);

	}

}

