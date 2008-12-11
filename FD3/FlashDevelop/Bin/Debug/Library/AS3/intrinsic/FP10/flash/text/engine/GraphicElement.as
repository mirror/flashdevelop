package flash.text.engine
{
	/// The GraphicElement class represents a graphic element in a TextBlock or GroupElement object.
	public class GraphicElement extends flash.text.engine.ContentElement
	{
		/// The DisplayObject to be used as a graphic for the GraphicElement.
		public var graphic:flash.display.DisplayObject;

		/// The height in pixels to reserve for the graphic in the line.
		public var elementHeight:Number;

		/// The width in pixels to reserve for the graphic in the line.
		public var elementWidth:Number;

		/// [FP10] Creates a new GraphicElement instance.
		public function GraphicElement(graphic:flash.display.DisplayObject=null, elementWidth:Number=15.0, elementHeight:Number=15.0, elementFormat:flash.text.engine.ElementFormat=null, eventMirror:flash.events.EventDispatcher=null, textRotation:String=rotate0);

	}

}

