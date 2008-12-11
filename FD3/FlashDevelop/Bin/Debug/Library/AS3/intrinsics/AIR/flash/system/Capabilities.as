package flash.system
{
	/// The Capabilities class provides properties that describe the system and player that are hosting a SWF file.
	public class Capabilities
	{
		/// [AIR] Specifies whether the player is embedded in a PDF file that is open in Acrobat 9.0 or higher (true) or not (false).
		public var isEmbeddedInAcrobat:Boolean;

		/// Specifies whether the system supports (true) or does not support (false) embedded video.
		public var hasEmbeddedVideo:Boolean;

		/// Specifies whether the system has audio capabilities.
		public var hasAudio:Boolean;

		/// Specifies whether access to the user's camera and microphone has been administratively prohibited (true) or allowed (false).
		public var avHardwareDisable:Boolean;

		/// Specifies whether the system supports (true) or does not support (false) communication with accessibility aids.
		public var hasAccessibility:Boolean;

		/// Specifies whether the system can (true) or cannot (false) encode an audio stream, such as that coming from a microphone.
		public var hasAudioEncoder:Boolean;

		/// Specifies whether the system does (true) or does not (false) have an MP3 decoder.
		public var hasMP3:Boolean;

		/// Specifies whether the system does (true) or does not (false) support printing.
		public var hasPrinting:Boolean;

		/// Specifies whether the system does (true) or does not (false) support the development of screen broadcast applications to be run through Flash Media Server.
		public var hasScreenBroadcast:Boolean;

		/// Specifies whether the system does (true) or does not (false) support the playback of screen broadcast applications that are being run through Flash Media Server.
		public var hasScreenPlayback:Boolean;

		/// Specifies whether the system can (true) or cannot (false) play streaming audio.
		public var hasStreamingAudio:Boolean;

		/// Specifies whether the system can (true) or cannot (false) play streaming video.
		public var hasStreamingVideo:Boolean;

		/// Specifies whether the system can (true) or cannot (false) encode a video stream, such as that coming from a web camera.
		public var hasVideoEncoder:Boolean;

		/// Specifies whether the system is using special debugging software (true) or an officially released version (false).
		public var isDebugger:Boolean;

		/// Specifies whether read access to the user's hard disk has been administratively prohibited (true) or allowed (false).
		public var localFileReadDisable:Boolean;

		/// Specifies the language code of the system on which the content is running.
		public var language:String;

		/// [AIR] An array of strings that contain information about the user's preferred languages, as set through the operating system.
		public var languages:Array;

		/// Specifies the manufacturer of the running version of Flash Player or  the AIR runtime, in the format "Adobe <em>OSName".
		public var manufacturer:String;

		/// Specifies the current operating system.
		public var os:String;

		/// Specifies the type of runtime environment.
		public var playerType:String;

		/// A URL-encoded string that specifies values for each Capabilities property.
		public var serverString:String;

		/// Specifies the Flash Player or Adobe&#xAE; AIR platform and version information.
		public var version:String;

		/// Specifies the screen color.
		public var screenColor:String;

		/// Specifies the pixel aspect ratio of the screen.
		public var pixelAspectRatio:Number;

		/// Specifies the dots-per-inch (dpi) resolution of the screen, in pixels.
		public var screenDPI:Number;

		/// Specifies the maximum horizontal resolution of the screen.
		public var screenResolutionX:Number;

		/// Specifies the maximum vertical resolution of the screen.
		public var screenResolutionY:Number;

		/// Specifies whether the system does (true) or does not (false) have an input method editor (IME) installed.
		public var hasIME:Boolean;

		/// Specifies whether the system supports native SSL sockets through NetConnection (true) or does not (false).
		public var hasTLS:Boolean;

		/// Retrieves the highest H.264 Level IDC that the client hardware supports.
		public var maxLevelIDC:String;

	}

}

