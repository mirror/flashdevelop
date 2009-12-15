package flash.media
{
	import flash.events.EventDispatcher;
	import flash.net.NetStream;
	import flash.geom.Rectangle;
	import flash.geom.Point;

	public class StageVideo extends EventDispatcher
	{
		public function get colorSpaces () : Vector.<String>;

		public function get deblocking () : int;
		public function set deblocking (value:int) : void;

		public function get depth () : int;
		public function set depth (depth:int) : void;

		public function get pan () : Point;
		public function set pan (point:Point) : void;

		public function get videoHeight () : int;

		public function get videoWidth () : int;

		public function get viewPort () : Rectangle;
		public function set viewPort (rect:Rectangle) : void;

		public function get zoom () : Point;
		public function set zoom (point:Point) : void;

		public function attachNetStream (netStream:NetStream) : void;

		public function codecCapability (codecID:uint, profileName:String = null, levelName:String = null) : String;

		public function StageVideo ();
	}
}
