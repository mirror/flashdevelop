package flash.desktop
{
	/// Specifies which drag-and-drop actions are allowed by the source of a drag operation.
	public class NativeDragOptions extends Object
	{
		/// [AIR] A drop target is allowed to copy the dragged data.
		public var allowCopy : Boolean;
		/// [AIR] A drop target is allowed to create a link to the dragged data.
		public var allowLink : Boolean;
		/// [AIR] A drop target is allowed to move the dragged data.
		public var allowMove : Boolean;

		public function NativeDragOptions ();

		/// [AIR] Returns the string representation of the specified object.
		public function toString () : String;
	}
}
