package mx.core
{
	import mx.core.IWindow;
	import mx.managers.NativeDragManagerImpl;
	import mx.core.IFactory;
	import flash.events.Event;
	import mx.core.IFlexDisplayObject;
	import mx.controls.FlexNativeMenu;
	import flash.events.MouseEvent;
	import mx.core.EdgeMetrics;
	import flash.events.NativeWindowBoundsEvent;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import flash.events.InvokeEvent;
	import flash.geom.Rectangle;
	import flash.desktop.NativeApplication;
	import mx.controls.HTML;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import mx.events.FlexEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import mx.core.Window;
	import flash.events.FullScreenEvent;

	public class WindowedApplication extends Application implements IWindow
	{
		public var statusBarBackground : IFlexDisplayObject;
		public var titleBarBackground : IFlexDisplayObject;
		public static const VERSION : String;

		public function get alwaysInFront () : Boolean;
		public function set alwaysInFront (value:Boolean) : void;

		public function get applicationID () : String;

		public function get autoExit () : Boolean;
		public function set autoExit (value:Boolean) : void;

		public function get closed () : Boolean;

		public function get dockIconMenu () : FlexNativeMenu;
		public function set dockIconMenu (value:FlexNativeMenu) : void;

		public function get height () : Number;
		public function set height (value:Number) : void;

		public function get maxHeight () : Number;
		public function set maxHeight (value:Number) : void;

		public function get maximizable () : Boolean;

		public function get maxWidth () : Number;
		public function set maxWidth (value:Number) : void;

		public function get menu () : FlexNativeMenu;
		public function set menu (value:FlexNativeMenu) : void;

		public function get minHeight () : Number;
		public function set minHeight (value:Number) : void;

		public function get minimizable () : Boolean;

		public function get minWidth () : Number;
		public function set minWidth (value:Number) : void;

		public function get nativeApplication () : NativeApplication;

		public function get nativeWindow () : NativeWindow;

		public function get resizable () : Boolean;

		public function get showGripper () : Boolean;
		public function set showGripper (value:Boolean) : void;

		public function get showStatusBar () : Boolean;
		public function set showStatusBar (value:Boolean) : void;

		public function get showTitleBar () : Boolean;
		public function set showTitleBar (value:Boolean) : void;

		public function get status () : String;
		public function set status (value:String) : void;

		public function get statusBar () : UIComponent;

		public function get statusBarFactory () : IFactory;
		public function set statusBarFactory (value:IFactory) : void;

		public function get systemChrome () : String;

		public function get systemTrayIconMenu () : FlexNativeMenu;
		public function set systemTrayIconMenu (value:FlexNativeMenu) : void;

		public function get title () : String;
		public function set title (value:String) : void;

		public function get titleBar () : UIComponent;

		public function get titleBarFactory () : IFactory;
		public function set titleBarFactory (value:IFactory) : void;

		public function get titleIcon () : Class;
		public function set titleIcon (value:Class) : void;

		public function get transparent () : Boolean;

		public function get type () : String;

		public function get viewMetrics () : EdgeMetrics;

		public function get visible () : Boolean;
		public function set visible (value:Boolean) : void;

		public function get width () : Number;
		public function set width (value:Number) : void;

		public function activate () : void;

		public function close () : void;

		public function exit () : void;

		public function getStatusBarHeight () : Number;

		public function maximize () : void;

		public function minimize () : void;

		public function move (x:Number, y:Number) : void;

		public function orderInBackOf (window:IWindow) : Boolean;

		public function orderInFrontOf (window:IWindow) : Boolean;

		public function orderToBack () : Boolean;

		public function orderToFront () : Boolean;

		public function restore () : void;

		public function styleChanged (styleProp:String) : void;

		public function validateDisplayList () : void;

		public function WindowedApplication ();
	}
}
