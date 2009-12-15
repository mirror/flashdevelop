package flash.html
{
	/// An HTMLHistoryItem object describes a location in the navigation history of an HTMLLoader object.
	public class HTMLHistoryItem extends Object
	{
		/// [AIR] Indicates whether the HTML page includes POST data.
		public function get isPost () : Boolean;

		/// [AIR] The original URL of the HTML page, before any redirects.
		public function get originalUrl () : String;

		/// [AIR] The title of the HTML page.
		public function get title () : String;

		/// [AIR] The URL of the HTML page.
		public function get url () : String;

		public function HTMLHistoryItem (url:String, originalUrl:String, isPost:Boolean, title:String);
	}
}
