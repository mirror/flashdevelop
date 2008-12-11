package flash.display
{
	/// The Loader class is used to load SWF files or image (JPG, PNG, or GIF) files.
	public class Loader extends flash.display.DisplayObjectContainer
	{
		/// Contains the root display object of the SWF file or image (JPG, PNG, or GIF) file that was loaded by using the load() or loadBytes() methods.
		public var content:flash.display.DisplayObject;

		/// Returns a LoaderInfo object corresponding to the object being loaded.
		public var contentLoaderInfo:flash.display.LoaderInfo;

		/// Creates a Loader object that you can use to load files, such as SWF, JPEG, GIF, or PNG files.
		public function Loader();

		/// Loads a SWF file or image file into a DisplayObject that is a child of this Loader instance.
		public function load(request:flash.net.URLRequest, context:flash.system.LoaderContext=null):void;

		/// Loads from binary data stored in a ByteArray object.
		public function loadBytes(bytes:flash.utils.ByteArray, context:flash.system.LoaderContext=null):void;

		/// Cancels a load() method operation that is currently in progress for the Loader instance.
		public function close():void;

		/// Removes a child of this Loader object that was loaded by using the load() method.
		public function unload():void;

		/// Attempts to unload child SWF file contents and stops the execution of commands from loaded SWF files.
		public function unloadAndStop(gc:Boolean=true):void;

	}

}

