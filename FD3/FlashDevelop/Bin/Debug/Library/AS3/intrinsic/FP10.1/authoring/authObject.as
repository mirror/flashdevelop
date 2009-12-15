package authoring
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import authoring.authObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Matrix3D;

	public class authObject extends Object
	{
		public function get FirstChild () : authObject;

		public function get Key () : uint;

		public function get NextSibling () : authObject;

		public static function get offScreenSurfaceRenderingEnabled () : Boolean;
		public static function set offScreenSurfaceRenderingEnabled (value:Boolean) : void;

		public function get SwfKey () : uint;

		public function get Type () : uint;

		public static function ApplyColorXForm (target:DisplayObject, srcXForm:ColorTransform = null) : Boolean;

		public static function ApplyMatrix (target:DisplayObject, srcMatrix:Matrix) : Boolean;

		public function authObject (key:uint);

		public function BlendingMode () : String;

		public function Bounds (flags:uint, minFrame:int = -16000, maxFrame:int = 16000) : Rectangle;

		public function CacheAsBitmap () : Boolean;

		public function CenterPoint () : Point;

		public function ColorXForm (resultXForm:ColorTransform = null) : ColorTransform;

		public function EndPosition () : int;

		public function Filters () : Array;

		public function FrameForFrameNumber (frameNum:int) : authObject;

		public function FrameOffset () : int;

		public function FrameType () : uint;

		public function GetData () : String;

		public function Has3DInside () : Boolean;

		public function HasEmptyPath () : Boolean;

		public function HasShapeSelection () : Boolean;

		public function IsFloater () : Boolean;

		public function IsPrimitive () : Boolean;

		public function IsSelected () : Boolean;

		public function IsVisible (inThumbnailPreview:Boolean) : Boolean;

		public function LivePreviewSize () : Point;

		public function Locked () : Boolean;

		public function MaskLayer (inThumbnailPreview:Boolean, frameNum:int = -1) : authObject;

		public function MotionPath () : authObject;

		public function NeedsBorder () : Boolean;

		public function ObjMatrix (resultMatrix:Matrix = null) : Matrix;

		public function OutlineColor () : uint;

		public function OutlineMode () : Boolean;

		public function RegistrationPoint () : Point;

		public function Scale9Grid () : Rectangle;

		public function SetData (data:String) : void;

		public function StartPosition () : int;

		public function SymbolBehavior () : int;

		public function SymbolMode () : int;

		public function ThreeDMatrix () : Matrix3D;

		public function ThreeDTranslationHandlePoints () : Array;
	}
}
