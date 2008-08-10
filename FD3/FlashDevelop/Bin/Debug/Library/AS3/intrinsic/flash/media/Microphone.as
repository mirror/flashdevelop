/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	import flash.events.EventDispatcher;
	public final  class Microphone extends EventDispatcher {
		/**
		 * The amount of sound the microphone is detecting. Values range from
		 *  0 (no sound is detected) to 100 (very loud sound is detected). The value of this property can
		 *  help you determine a good value to pass to the Microphone.setSilenceLevel() method.
		 */
		public function get activityLevel():Number;
		/**
		 * The microphone gain-that is, the amount by which the microphone should multiply the signal before
		 *  transmitting it. A value of 0 multiplies the signal by 0; that is, the microphone transmits no sound.
		 */
		public function get gain():Number;
		public function set gain(value:Number):void;
		/**
		 * The index of the microphone, as reflected in the array returned by
		 *  Microphone.names.
		 */
		public function get index():int;
		/**
		 * Specifies whether the user has denied access to the microphone (true)
		 *  or allowed access (false). When this value changes,
		 *  a status event is dispatched.
		 *  For more information, see Microphone.getMicrophone().
		 */
		public function get muted():Boolean;
		/**
		 * The name of the current sound capture device, as returned by the sound capture hardware.
		 */
		public function get name():String;
		/**
		 * An array of strings containing the names of all available sound capture devices.
		 *  The names are returned without
		 *  having to display the Flash Player Privacy Settings panel to the user. This array
		 *  provides the zero-based index of each sound capture device and the
		 *  number of sound capture devices on the system, through the Microphone.names.length property.
		 *  For more information, see the Array class entry.
		 */
		public static function get names():Array;
		/**
		 * The rate at which the microphone captures sound, in kHz.
		 *  The allowed values are any of the following your sound device supports: 5, 8, 11, 22, or 44.
		 */
		public function get rate():int;
		public function set rate(value:int):void;
		/**
		 * The amount of sound required to activate the microphone and dispatch
		 *  the activity event. The default value is 10.
		 */
		public function get silenceLevel():Number;
		/**
		 * The number of milliseconds between the time the microphone stops
		 *  detecting sound and the time the activity event is dispatched. The default
		 *  value is 2000 (2 seconds).
		 */
		public function get silenceTimeout():int;
		/**
		 * Controls the sound of this microphone object when it is in loopback mode.
		 */
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		/**
		 * Set to true if echo suppression is enabled; false otherwise. The default value is
		 *  false unless the user has selected Reduce Echo in the Flash Player Microphone Settings panel.
		 */
		public function get useEchoSuppression():Boolean;
		/**
		 * Returns a reference to a Microphone object for capturing audio.
		 *  To begin capturing the audio, you must attach the Microphone
		 *  object to a NetStream object (see NetStream.attachAudio()).
		 *
		 * @param index             <int (default = 0)> The index value of the microphone.
		 * @return                  <Microphone> A reference to a Microphone object for capturing audio.
		 */
		public static function getMicrophone(index:int = 0):Microphone;
		/**
		 * Routes audio captured by a microphone to the local speakers.
		 *
		 * @param state             <Boolean (default = true)> 
		 */
		public function setLoopBack(state:Boolean = true):void;
		/**
		 * Sets the minimum input level that should be considered sound and (optionally) the amount
		 *  of silent time signifying that silence has actually begun.
		 *  To prevent the microphone from detecting sound at all, pass a value of 100 for
		 *  silenceLevel; the activity event is never dispatched.
		 *  To determine the amount of sound the microphone is currently detecting, use Microphone.activityLevel.
		 *
		 * @param silenceLevel      <Number> The amount of sound required to activate the microphone
		 *                            and dispatch the activity event. Acceptable values range from 0 to 100.
		 * @param timeout           <int (default = -1)> The number of milliseconds that must elapse without
		 *                            activity before Flash Player or Adobe AIR considers sound to have stopped and dispatches the
		 *                            dispatch event. The default value is 2000 (2 seconds).
		 *                            (Note: The default value shown
		 *                            in the signature, -1, is an internal value that indicates to Flash Player or Adobe AIR to use 2000.)
		 */
		public function setSilenceLevel(silenceLevel:Number, timeout:int = -1):void;
		/**
		 * Specifies whether to use the echo suppression feature of the audio codec. The default value is
		 *  false unless the user has selected Reduce Echo in the Flash Player Microphone
		 *  Settings panel.
		 *
		 * @param useEchoSuppression<Boolean> A Boolean value indicating whether echo suppression should be used
		 *                            (true) or not (false).
		 */
		public function setUseEchoSuppression(useEchoSuppression:Boolean):void;
	}
}
