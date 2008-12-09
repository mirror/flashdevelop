package flash.media
{
	/// Use the Microphone class to capture audio from a microphone attached to a computer running Flash Player.
	public class Microphone extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a microphone reports its status.
		 * @eventType flash.events.StatusEvent.STATUS
		 */
		[Event(name="status", type="flash.events.StatusEvent")]

		/** 
		 * Dispatched when a microphone begins or ends a session.
		 * @eventType flash.events.ActivityEvent.ACTIVITY
		 */
		[Event(name="activity", type="flash.events.ActivityEvent")]

		/// An array of strings containing the names of all available sound capture devices.
		public var names:Array;

		/// The microphone gain--that is, the amount by which the microphone multiplies the signal before transmitting it.
		public var gain:Number;

		/// The rate at which the microphone captures sound, in kHz.
		public var rate:int;

		/// The codec to use for compressing audio.
		public var codec:String;

		/// Number of Speex speech frames transmitted in a packet (message).
		public var framesPerPacket:int;

		/// The encoded speech quality when using the Speex codec.
		public var encodeQuality:int;

		/// The amount of sound the microphone is detecting.
		public var activityLevel:Number;

		/// The index of the microphone, as reflected in the array returned by Microphone.names.
		public var index:int;

		/// Specifies whether the user has denied access to the microphone (true) or allowed access (false).
		public var muted:Boolean;

		/// The name of the current sound capture device, as returned by the sound capture hardware.
		public var name:String;

		/// The amount of sound required to activate the microphone and dispatch the activity event.
		public var silenceLevel:Number;

		/// The number of milliseconds between the time the microphone stops detecting sound and the time the activity event is dispatched.
		public var silenceTimeout:int;

		/// Set to true if echo suppression is enabled; false otherwise.
		public var useEchoSuppression:Boolean;

		/// Controls the sound of this microphone object when it is in loopback mode.
		public var soundTransform:flash.media.SoundTransform;

		/// Returns a reference to a Microphone object for capturing audio.
		public static function getMicrophone(index:int=-1):flash.media.Microphone;

		/// Sets the minimum input level that should be considered sound and (optionally) the amount of silent time signifying that silence has actually begun.
		public function setSilenceLevel(silenceLevel:Number, timeout:int=-1):void;

		/// Specifies whether to use the echo suppression feature of the audio codec.
		public function setUseEchoSuppression(useEchoSuppression:Boolean):void;

		/// Routes audio captured by a microphone to the local speakers.
		public function setLoopBack(state:Boolean=true):void;

	}

}

