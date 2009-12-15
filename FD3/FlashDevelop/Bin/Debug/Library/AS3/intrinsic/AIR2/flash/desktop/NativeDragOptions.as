package flash.desktop
{
	/// Specifies which drag-and-drop actions are allowed by the source of a drag operation.
	public class NativeDragOptions extends Object
	{
		/// A drop target is allowed to copy the dragged data.
		public var allowCopy : Boolean;
		/// A drop target is allowed to create a link to the dragged data.
		public var allowLink : Boolean;
		/// A drop target is allowed to move the dragged data.
		public var allowMove : Boolean;

		public function NativeDragOptions ();

		/// Returns the string representation of the specified object.
		public function toString () : String;
	}
}
