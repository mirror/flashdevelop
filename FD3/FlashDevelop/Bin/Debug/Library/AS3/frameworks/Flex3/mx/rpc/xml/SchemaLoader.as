package mx.rpc.xml
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.SchemaLoadEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.URLUtil;

	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 
	[Event(name="schemaLoad", type="mx.rpc.events.SchemaLoadEvent")] 

	/**
	 * Manages the loading of an XML Schema at runtime, including all imports and * includes. *  * @private
	 */
	public class SchemaLoader extends XMLLoader
	{
		private var topLevelSchema : Schema;
		private var locationMap : Object;
		private var _schemaManager : SchemaManager;
		private static const LOAD_INCLUDE : String = "include";
		private static const LOAD_IMPORT : String = "import";

		public function SchemaLoader (httpService:HTTPService = null);
		/**
		 * Asynchronously loads an XSD Schema for a given URL including any     * XSD imports and includes.
		 */
		public function load (url:String) : void;
		public function schemaImports (schema:Schema, parentLocation:String, schemaManager:SchemaManager = null) : void;
		public function schemaIncludes (schema:Schema, parentLocation:String) : void;
		protected function resultHandler (event:ResultEvent) : void;
		private function loadSchema (location:String, parent:Schema = null, ns:Namespace = null, loadType:String = null) : AsyncToken;
	}
}
