package flash.display
{
	/// Defines a solid fill.
	public class GraphicsSolidFill
	{
		/// The color of the fill.
		public var color:uint;

		/// Indicates the alpha transparency value of the fill.
		public var alpha:Number;

		/// [FP10] Creates a new GraphicsSolidFill object.
		public function GraphicsSolidFill(color:uint=0, alpha:Number=1.0);

	}

}

