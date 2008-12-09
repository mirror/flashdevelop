package flash.text.engine
{
	/// The TextLineMirrorRegion class represents a portion of a text line wherein events are mirrored to another event dispatcher.
	public class TextLineMirrorRegion
	{
		/// The TextLine containing this mirror region.
		public var textLine:flash.text.engine.TextLine;

		/// The next TextLineMirrorRegion in the set derived from the text element, or null if the current region is the last mirror region in the set.
		public var nextRegion:flash.text.engine.TextLineMirrorRegion;

		/// The previous TextLineMirrorRegion in the set derived from the text element, or null if the current region is the first mirror region in the set.
		public var previousRegion:flash.text.engine.TextLineMirrorRegion;

		/// The EventDispatcher object to which events affecting the mirror region are mirrored.
		public var mirror:flash.events.EventDispatcher;

		/// The ContentElement object from which the mirror region was derived.
		public var element:flash.text.engine.ContentElement;

		/// The bounds of the mirror region, relative to the text line.
		public var bounds:flash.geom.Rectangle;

	}

}

