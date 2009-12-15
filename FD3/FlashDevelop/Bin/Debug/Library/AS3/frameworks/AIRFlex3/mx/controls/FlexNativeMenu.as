package mx.controls
{
	import flash.events.EventDispatcher;
	import mx.managers.ILayoutManagerClient;
	import mx.controls.IFlexContextMenu;
	import flash.display.NativeMenu;
	import flash.events.Event;
	import mx.collections.ICollectionView;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.events.CollectionEvent;
	import flash.display.Stage;
	import flash.display.InteractiveObject;
	import flash.events.TimerEvent;

	public class FlexNativeMenu extends EventDispatcher implements ILayoutManagerClient, IFlexContextMenu
	{
		public var _rootModel : ICollectionView;
		public static const VERSION : String;

		public function get dataDescriptor () : IMenuDataDescriptor;
		public function set dataDescriptor (value:IMenuDataDescriptor) : void;

		public function get dataProvider () : Object;
		public function set dataProvider (value:Object) : void;

		public function get hasRoot () : Boolean;

		public function get initialized () : Boolean;
		public function set initialized (value:Boolean) : void;

		public function get keyEquivalentField () : String;
		public function set keyEquivalentField (value:String) : void;

		public function get keyEquivalentFunction () : Function;
		public function set keyEquivalentFunction (value:Function) : void;

		public function get keyEquivalentModifiersFunction () : Function;
		public function set keyEquivalentModifiersFunction (value:Function) : void;

		public function get labelField () : String;
		public function set labelField (value:String) : void;

		public function get labelFunction () : Function;
		public function set labelFunction (value:Function) : void;

		public function get mnemonicIndexField () : String;
		public function set mnemonicIndexField (value:String) : void;

		public function get mnemonicIndexFunction () : Function;
		public function set mnemonicIndexFunction (value:Function) : void;

		public function get nativeMenu () : NativeMenu;

		public function get nestLevel () : int;
		public function set nestLevel (value:int) : void;

		public function get processedDescriptors () : Boolean;
		public function set processedDescriptors (value:Boolean) : void;

		public function get showRoot () : Boolean;
		public function set showRoot (value:Boolean) : void;

		public function get updateCompletePendingFlag () : Boolean;
		public function set updateCompletePendingFlag (value:Boolean) : void;

		public function display (stage:Stage, x:int, y:int) : void;

		public function FlexNativeMenu ();

		public function invalidateProperties () : void;

		public function setContextMenu (component:InteractiveObject) : void;

		public function unsetContextMenu (component:InteractiveObject) : void;

		public function validateDisplayList () : void;

		public function validateNow () : void;

		public function validateProperties () : void;

		public function validatePropertiesTimerHandler (event:TimerEvent) : void;

		public function validateSize (recursive:Boolean = false) : void;
	}
}
