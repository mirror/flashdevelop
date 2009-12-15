package flash.html
{
	/// This class defines the options that can be specified when JavaScript running in an HTMLLoader object tries to create a new HTML window by calling the window.open() method.
	public class HTMLWindowCreateOptions extends Object
	{
		/// Specifies whether the window should be full screen.
		public var fullscreen : Boolean;
		/// Specifies the desired initial height of the new window.
		public var height : Number;
		/// Whether a location bar should be displayed.
		public var locationBarVisible : Boolean;
		/// Specifies whether a menu bar should be displayed.
		public var menuBarVisible : Boolean;
		/// Specifies whether the window should be resizable.
		public var resizable : Boolean;
		/// Specifies whether scrollbars should be displayed.
		public var scrollBarsVisible : Boolean;
		/// Specifies whether a status bar should be displayed.
		public var statusBarVisible : Boolean;
		/// Specifies whether a toolbar bar should be displayed.
		public var toolBarVisible : Boolean;
		/// Specifies the desired initial width of the new window.
		public var width : Number;
		/// Specifies the desired initial x position of the new window on the screen.
		public var x : Number;
		/// Specifies the desired initial y position of the new window on the screen.
		public var y : Number;

		public function HTMLWindowCreateOptions ();
	}
}
