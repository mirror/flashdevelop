package flash.ui
{
	import flash.ui.ContextMenuBuiltInItems;

	/// The ContextMenuBuiltInItems class describes the items that are built in to a context menu.
	public class ContextMenuBuiltInItems extends Object
	{
		/// Lets the user move forward or backward one frame in a SWF file at run time (does not appear for a single-frame SWF file).
		public function get forwardAndBack () : Boolean;
		public function set forwardAndBack (val:Boolean) : void;

		/// Lets the user set a SWF file to start over automatically when it reaches the final frame (does not appear for a single-frame SWF file).
		public function get loop () : Boolean;
		public function set loop (val:Boolean) : void;

		/// Lets the user start a paused SWF file (does not appear for a single-frame SWF file).
		public function get play () : Boolean;
		public function set play (val:Boolean) : void;

		/// Lets the user send the displayed frame image to a printer.
		public function get print () : Boolean;
		public function set print (val:Boolean) : void;

		/// Lets the user set the resolution of the SWF file at run time.
		public function get quality () : Boolean;
		public function set quality (val:Boolean) : void;

		/// Lets the user set a SWF file to play from the first frame when selected, at any time (does not appear for a single-frame SWF file).
		public function get rewind () : Boolean;
		public function set rewind (val:Boolean) : void;

		/// Lets the user with Shockmachine installed save a SWF file.
		public function get save () : Boolean;
		public function set save (val:Boolean) : void;

		/// Lets the user zoom in and out on a SWF file at run time.
		public function get zoom () : Boolean;
		public function set zoom (val:Boolean) : void;

		public function clone () : ContextMenuBuiltInItems;

		/// Creates a new ContextMenuBuiltInItems object so that you can set the properties for Flash Player to display or hide each menu item.
		public function ContextMenuBuiltInItems ();
	}
}
