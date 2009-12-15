package mx.controls
{
	import mx.core.ScrollControlBase;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.managers.IFocusManagerComponent;
	import flash.events.Event;
	import mx.core.IFactory;
	import flash.system.ApplicationDomain;
	import flash.html.HTMLLoader;
	import flash.html.HTMLHistoryItem;
	import mx.controls.listClasses.BaseListData;
	import flash.events.MouseEvent;
	import flash.html.HTMLHost;
	import flash.events.HTMLUncaughtScriptExceptionEvent;

	public class HTML extends ScrollControlBase implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFocusManagerComponent
	{
		public var htmlLoader : HTMLLoader;
		public static const VERSION : String;

		public function get contentHeight () : Number;

		public function get contentWidth () : Number;

		public function get data () : Object;
		public function set data (value:Object) : void;

		public function get domWindow () : Object;

		public function get historyLength () : int;

		public function get historyPosition () : int;
		public function set historyPosition (value:int) : void;

		public function get htmlHost () : HTMLHost;
		public function set htmlHost (value:HTMLHost) : void;

		public function get htmlLoaderFactory () : IFactory;
		public function set htmlLoaderFactory (value:IFactory) : void;

		public function get htmlText () : String;
		public function set htmlText (value:String) : void;

		public function get listData () : BaseListData;
		public function set listData (value:BaseListData) : void;

		public function get loaded () : Boolean;

		public function get location () : String;
		public function set location (value:String) : void;

		public function get paintsDefaultBackground () : Boolean;
		public function set paintsDefaultBackground (value:Boolean) : void;

		public static function get pdfCapability () : int;

		public function get runtimeApplicationDomain () : ApplicationDomain;
		public function set runtimeApplicationDomain (value:ApplicationDomain) : void;

		public function get userAgent () : String;
		public function set userAgent (value:String) : void;

		public function set verticalScrollPosition (value:Number) : void;

		public function cancelLoad () : void;

		public function getHistoryAt (position:int) : HTMLHistoryItem;

		public function historyBack () : void;

		public function historyForward () : void;

		public function historyGo (steps:int) : void;

		public function HTML ();

		public function reload () : void;
	}
}
