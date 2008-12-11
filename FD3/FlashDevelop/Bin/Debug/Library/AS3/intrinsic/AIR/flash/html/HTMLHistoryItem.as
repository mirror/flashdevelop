package flash.html
{
	/// An HTMLHistoryItem object describes a location in the navigation history of an HTMLLoader object.
	public class HTMLHistoryItem
	{
		/// [AIR] The URL of the HTML page.
		public var url:String;

		/// [AIR] The original URL of the HTML page, before any redirects.
		public var originalUrl:String;

		/// [AIR] Indicates whether the HTML page includes POST data.
		public var isPost:Boolean;

		/// [AIR] The title of the HTML page.
		public var title:String;

	}

}

