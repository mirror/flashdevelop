package flash.display
{
	/// The FocusDirection class enumerates values to be used for the direction parameter of the assignFocus() method of a Stage object and for the direction property of a FocusEvent object.
	public class FocusDirection extends Object
	{
		/// [AIR] Indicates that focus should be given to the object at the end of the reading order.
		public static const BOTTOM : String;
		/// [AIR] Indicates that focus object within the interactive object should not change.
		public static const NONE : String;
		/// [AIR] Indicates that focus should be given to the object at the beginning of the reading order.
		public static const TOP : String;

		public function FocusDirection ();
	}
}
