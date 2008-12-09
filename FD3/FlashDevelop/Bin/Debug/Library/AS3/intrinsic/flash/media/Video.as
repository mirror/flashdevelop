package flash.media
{
	/// The Video class displays live or recorded video in an application without embedding the video in your SWF file.
	public class Video extends flash.display.DisplayObject
	{
		/// Indicates the type of filter applied to decoded video as part of post-processing.
		public var deblocking:int;

		/// Specifies whether the video should be smoothed (interpolated) when it is scaled.
		public var smoothing:Boolean;

		/// An integer specifying the width of the video stream, in pixels.
		public var videoWidth:int;

		/// An integer specifying the height of the video stream, in pixels.
		public var videoHeight:int;

		/// Creates a new Video instance.
		public function Video(width:int=320, height:int=240);

		/// Clears the image currently displayed in the Video object (not the video stream).
		public function clear():void;

		/// Specifies a video stream to be displayed within the boundaries of the Video object in the application.
		public function attachNetStream(netStream:flash.net.NetStream):void;

		/// Specifies a video stream from a camera to be displayed within the boundaries of the Video object in the application.
		public function attachCamera(camera:flash.media.Camera):void;

	}

}

